defmodule Spla2API.Struct.Stage do
  alias Spla2API.Struct.Map, as: SMap
  alias Spla2API.Struct.Rule, as: SRule

  defstruct rule: nil,
            rule_ex: nil,
            maps: [],
            maps_ex: [],
            start: nil,
            start_utc: nil,
            start_t: nil,
            end: nil,
            end_utc: nil,
            end_t: nil

  @type t :: %__MODULE__{
          rule: String.t(),
          rule_ex: SRule.t(),
          maps: [String.t()],
          maps_ex: [SMap.t()],
          start: NaiveDateTime.t(),
          start_utc: NaiveDateTime.t(),
          start_t: integer,
          end: NaiveDateTime.t(),
          end_utc: NaiveDateTime.t(),
          end_t: integer
        }

  @spec to_struct(map) :: __MODULE__.t()
  def to_struct(nil), do: to_struct(%{})

  def to_struct(map) do
    struct(__MODULE__, map |> Enum.reject(&(elem(&1, 1) |> is_nil)))
    |> Map.update(:maps_ex, [], fn maps -> Enum.map(maps, &SMap.to_struct/1) end)
    |> Map.update(:rule_ex, nil, &SRule.to_struct(&1))
    |> Map.update(:start, nil, &NaiveDateTime.from_iso8601!(&1))
    |> Map.update(:start_utc, nil, &NaiveDateTime.from_iso8601!(&1))
    |> Map.update(:end, nil, &NaiveDateTime.from_iso8601!(&1))
    |> Map.update(:end_utc, nil, &NaiveDateTime.from_iso8601!(&1))
  end
end
