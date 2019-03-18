defmodule RegistrationData.Channel do
  use Ecto.Schema
  import Ecto.Changeset

  alias RegistrationData.{Schedule, Subscribe}

  schema "channels" do
    field :identifier, :integer

    timestamps()

    many_to_many(:schedules, Schedule, join_through: Subscribe)
  end

  @doc false
  def changeset(%__MODULE__{} = data, attrs) do
    data
    |> cast(attrs, [:identifier])
    |> validate_required([:identifier])
    |> unique_constraint(:identifier)
  end
end
