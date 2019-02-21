defmodule Scheduler do
  @moduledoc """
  Documentation for Scheduler.
  """

  alias Goth.Token
  alias Scheduler.Struct.{Job, Jobs}

  @project "discordsplatoonbot"
  @location "us-west2"
  @api_version "v1beta1"
  @base_uri "https://cloudscheduler.googleapis.com/"

  def list_schedules,
    do:
      [@api_version, "projects", @project, "locations", @location, "jobs"]
      |> Enum.join("/")
      |> request(
        :get,
        &Jobs.to_struct/1
      )

  def get_schedule(name),
    do:
      request(
        "v1beta1/projects/discordsplatoonbot/locations/us-west2/jobs/#{name}",
        :get,
        &Job.to_struct/1
      )

  def create_schedule(%Job.Generator{} = job),
    do:
      [@api_version, "projects", @project, "locations", @location, "jobs"]
      |> Enum.join("/")
      |> request(:post, job |> Jason.encode!(), &Job.to_struct/1)

  def delete_schedule(name),
    do:
      [@api_version, "projects", @project, "locations", @location, "jobs", name]
      |> Enum.join("/")
      |> request(:delete, & &1)

  defp request(url, method, body \\ <<>>, parser) when parser |> is_function(1) do
    url = URI.merge(@base_uri, url) |> URI.to_string()

    with {:ok, token} <- get_token(),
         {:ok, status_code, _headers, ref} when div(status_code, 100) == 2 <-
           :hackney.request(method, url, headers(token), body, []),
         {:ok, body} <- :hackney.body(ref),
         {:ok, map} <- Jason.decode(body, keys: :atoms!) do
      IO.inspect(map)
      result = map |> parser.()

      :hackney.close(ref)
      {:ok, result}
    else
      {:ok, status_code, _, ref} ->
        :hackney.close(ref)
        {:error, {:status_code, status_code}}

      {:error, reason} ->
        {:error, reason}
    end
  end

  @spec get_token :: {:ok, %Goth.Token{}}
  def get_token, do: Token.for_scope("https://www.googleapis.com/auth/cloud-scheduler")

  def headers(%{token: token, type: type}) do
    [
      {"Content-Type", "application/json"},
      {"Authorization", "#{type} #{token}"}
    ]
  end
end
