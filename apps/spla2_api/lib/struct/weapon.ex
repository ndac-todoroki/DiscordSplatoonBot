defmodule Spla2API.Struct.Weapon do
  defstruct [:id, :image, :name]

  @type t :: %__MODULE__{
          id: integer,
          image: String.t(),
          name: String.t()
        }

  @spec to_struct(map) :: t()
  def to_struct(nil), do: to_struct(%{})
  def to_struct(map), do: struct(__MODULE__, map)
end
