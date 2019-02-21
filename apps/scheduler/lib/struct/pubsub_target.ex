defmodule Scheduler.Struct.PubsubTarget do
  @moduledoc """
   %{
      "data" => "eyJjaGFubmVsX2lkIjoyNjAyOTEzNTY1NjI0MjM4MDksImNvbW1hbmQiOiJuZXdzOmxhdGVzdCIsIm9wdHMiOltdfQ==",
      "topicName" => "projects/discordsplatoonbot/topics/schedules"
    }
  """

  @topic "projects/discordsplatoonbot/topics/" <>
           Application.fetch_env!(:scheduler, :pubsub_topic)

  @type t :: %__MODULE__{data: String.t(), topicName: String.t()}
  @derive Jason.Encoder
  defstruct data: nil, topicName: @topic

  def new(data) when data |> is_binary, do: %__MODULE__{data: data}

  @spec to_struct(map) :: t()
  def to_struct(nil), do: to_struct(%{})

  def to_struct(map),
    do: struct(__MODULE__, map |> Enum.reject(&(elem(&1, 1) |> is_nil)))
end
