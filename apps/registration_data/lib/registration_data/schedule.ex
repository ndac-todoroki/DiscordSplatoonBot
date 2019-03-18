defmodule RegistrationData.Schedule do
  use Ecto.Schema
  import Ecto.Changeset

  alias RegistrationData.{Channel, Subscribe}

  schema "schedules" do
    field :type, :string

    timestamps()

    many_to_many(:channels, Channel, join_through: Subscribe)
  end

  @doc false
  def changeset(%__MODULE__{} = data, attrs) do
    data
    |> cast(attrs, [:type])
    |> validate_required([:type])
    |> unique_constraint(:type)
  end
end
