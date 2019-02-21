defmodule Scheduler.Struct.Job do
  @moduledoc """

  {
    "name": string,
    "description": string,
    "schedule": string,
    "timeZone": string,
    "userUpdateTime": string,
    "state": enum(State),
    "status": {
      object(Status)
    },
    "scheduleTime": string,
    "lastAttemptTime": string,
    "retryConfig": {
      object(RetryConfig)
    },

    // Union field target can be only one of the following:
    "pubsubTarget": {
      object(PubsubTarget)
    },
    "appEngineHttpTarget": {
      object(AppEngineHttpTarget)
    },
    "httpTarget": {
      object(HttpTarget)
    }
    // End of list of possible types for union field target.
  }

  %{
    "description" => "BotTestServer毎時お知らせ",
    "lastAttemptTime" => "2019-02-21T06:00:00.119839Z",
    "name" => "projects/discordsplatoonbot/locations/us-west2/jobs/sample-schedule",
    "pubsubTarget" => %{
      "data" => "eyJjaGFubmVsX2lkIjoyNjAyOTEzNTY1NjI0MjM4MDksImNvbW1hbmQiOiJuZXdzOmxhdGVzdCIsIm9wdHMiOltdfQ==",
      "topicName" => "projects/discordsplatoonbot/topics/schedules"
    },
    "schedule" => "0 */1 * * *",
    "scheduleTime" => "2019-02-21T07:00:00.231478Z",
    "state" => "ENABLED",
    "status" => %{},
    "timeZone" => "Asia/Tokyo",
    "userUpdateTime" => "2019-02-21T04:57:16Z"
  }
  """

  alias Scheduler.Struct.PubsubTarget

  @name_prefix "projects/discordsplatoonbot/locations/us-west2/jobs/"

  @type t :: %__MODULE__{
          description: String.t(),
          lastAttemptTime: NaiveDateTime.t(),
          name: String.t(),
          pubsubTarget: PubsubTarget.t(),
          schedule: String.t(),
          scheduleTime: NaiveDateTime.t(),
          state: String.t(),
          timeZone: String.t(),
          userUpdateTime: String.t()
        }
  @derive {Jason.Encoder, only: [:name, :schedule, :timeZone, :description, :pubsubTarget]}
  defstruct description: nil,
            lastAttemptTime: nil,
            name: nil,
            pubsubTarget: nil,
            schedule: nil,
            scheduleTime: nil,
            state: nil,
            status: %{},
            timeZone: nil,
            userUpdateTime: nil

  @spec new(
          data :: String.t(),
          name :: String.t(),
          schedule :: String.t(),
          timezone :: String.t(),
          description :: String.t()
        ) :: t()
  @doc """
  new Job made for Tokyo.
  """
  def new(data, name, schedule, timezone \\ "Asia/Tokyo", description \\ "") do
    %__MODULE__{
      name: @name_prefix <> name,
      schedule: schedule,
      timeZone: timezone,
      description: description,
      pubsubTarget: PubsubTarget.new(data)
    }
  end

  def id(%__MODULE__{
        name: @name_prefix <> id
      }),
      do: id

  @spec to_struct(map) :: t()
  def to_struct(nil), do: to_struct(%{})

  def to_struct(map) do
    map =
      map
      |> Enum.reject(&(elem(&1, 1) |> is_nil))
      |> Enum.into(%{})
      |> Map.update!(:pubsubTarget, &PubsubTarget.to_struct/1)
      |> Map.update(:lastAttemptTime, nil, &NaiveDateTime.from_iso8601!(&1))
      |> Map.update(:scheduleTime, nil, &NaiveDateTime.from_iso8601!(&1))
      |> Map.update(:userUpdateTime, nil, &NaiveDateTime.from_iso8601!(&1))

    struct(__MODULE__, map)
  end

  defmodule Generator do
    alias Scheduler.Struct.Job

    @derive Jason.Encoder
    defstruct description: nil,
              name: nil,
              pubsubTarget: nil,
              schedule: nil,
              timeZone: nil

    def to_struct(%Job{} = job), do: struct(__MODULE__, job |> Map.from_struct())
  end
end
