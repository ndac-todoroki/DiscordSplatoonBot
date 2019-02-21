defmodule Scheduler.Struct.Jobs do
  alias Scheduler.Struct.Job

  @type t :: %__MODULE__{jobs: [Job.t()], nextPageToken: String.t() | nil}
  defstruct jobs: [], nextPageToken: nil

  def to_struct(nil), do: struct!(__MODULE__, %{})

  def to_struct(map),
    do:
      struct(__MODULE__, map |> Enum.reject(&(elem(&1, 1) |> is_nil)))
      |> Map.update(:jobs, [], &Enum.map(&1, to_job))

  defp to_job, do: &Job.to_struct/1
end
