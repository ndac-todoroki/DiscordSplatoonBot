defmodule Spla2API.Struct.Rule do
  defstruct [:key, :name, :statink]

  @rules [:turf_war, :splat_zones, :tower_control, :rainmaker, :clam_blitz]

  # This is for rule atoms including.
  @doc false
  def rules, do: @rules

  @spec to_struct(map) :: %__MODULE__{}
  def to_struct(nil), do: to_struct(%{})

  def to_struct(map),
    do: struct(__MODULE__, map) |> Map.update!(:key, &String.to_existing_atom/1)
end
