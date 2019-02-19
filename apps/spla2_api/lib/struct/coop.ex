defmodule Spla2API.Struct.Coop do
  alias Spla2API.Struct.Weapon
  alias Spla2API.Struct.Map, as: SMap

  defstruct start: nil,
            start_utc: nil,
            start_t: nil,
            end: nil,
            end_utc: nil,
            end_t: nil,
            stage: %{},
            weapons: []

  @type t :: %__MODULE__{
          stage: SMap.t(),
          weapons: [Weapon.t()],
          start: NaiveDateTime.t(),
          start_utc: NaiveDateTime.t(),
          start_t: integer,
          end: NaiveDateTime.t(),
          end_utc: NaiveDateTime.t(),
          end_t: integer
        }

  @spec to_struct(map) :: t()
  def to_struct(nil), do: to_struct(%{})

  def to_struct(map),
    do:
      struct(__MODULE__, map |> Enum.reject(&(elem(&1, 1) |> is_nil)))
      |> Map.update!(:stage, &SMap.to_struct/1)
      |> Map.update!(:weapons, fn list -> Enum.map(list, &Weapon.to_struct/1) end)
      |> Map.update(:start, nil, &NaiveDateTime.from_iso8601!(&1))
      |> Map.update(:start_utc, nil, &NaiveDateTime.from_iso8601!(&1))
      |> Map.update(:end, nil, &NaiveDateTime.from_iso8601!(&1))
      |> Map.update(:end_utc, nil, &NaiveDateTime.from_iso8601!(&1))
end
