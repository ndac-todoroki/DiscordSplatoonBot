defmodule RegistrationData.Registry do
  @moduledoc """
  Subscribes to channels.
  """

  import Ecto.Query, warn: false
  alias RegistrationData.Repo
  alias RegistrationData.{Channel, Schedule, Subscribe}

  def list_subscribing_channel_ids(schedule_type) do
    schedule_id = get_schedule(schedule_type).id

    Channel
    |> where(id: ^schedule_id)
    |> select([:identifier])
    |> Repo.all()
    |> Enum.map(& &1.identifier)
  end

  @doc """
  Subscribe a Channel to a Schedule.
  """
  def subscribe_to(channel, schedule)

  def subscribe_to(%Channel{} = channel, schedule_type) when schedule_type |> is_binary(),
    do: subscribe_to(channel, get_schedule(schedule_type))

  def subscribe_to(%Channel{} = channel, %Schedule{} = schedule) do
    %Subscribe{}
    |> Subscribe.changeset(%{channel: channel, schedule_id: schedule})
    |> Repo.insert()
  end

  def create_schedule(type),
    do:
      %Schedule{}
      |> Schedule.changeset(%{type: type})
      |> Repo.insert()

  def get_schedule(type), do: Repo.get_by!(Schedule, type: type)

  def create_channel(identifier),
    do:
      %Channel{}
      |> Channel.changeset(%{identifier: identifier})
      |> Repo.insert()

  def get_channel(identifier), do: Repo.get_by!(Channel, identifier: identifier)
end
