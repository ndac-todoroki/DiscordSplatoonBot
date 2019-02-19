defmodule Spla2API.Struct.Stages do
  alias Spla2API.Struct.Stage

  defstruct regular: [], gachi: [], league: []

  @type t :: %__MODULE__{
          regular: [Stage.t()],
          gachi: [Stage.t()],
          league: [Stage.t()]
        }

  @spec to_struct(map) :: t()
  def to_struct(nil), do: to_struct(%{})

  def to_struct(map) do
    struct(__MODULE__, map |> Enum.reject(&(elem(&1, 1) |> is_nil)))
    |> Map.update(:regular, [], fn maps -> Enum.map(maps, &Stage.to_struct(&1)) end)
    |> Map.update(:gachi, [], fn maps -> Enum.map(maps, &Stage.to_struct(&1)) end)
    |> Map.update(:league, [], fn maps -> Enum.map(maps, &Stage.to_struct(&1)) end)
  end
end
