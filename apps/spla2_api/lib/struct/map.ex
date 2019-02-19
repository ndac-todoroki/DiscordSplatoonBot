defmodule Spla2API.Struct.Map do
  defstruct [:id, :name, :image, :statink]

  def to_struct(nil), do: to_struct(%{})
  def to_struct(map), do: struct(__MODULE__, map)
end
