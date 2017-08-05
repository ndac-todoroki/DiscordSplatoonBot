defmodule SplatoonData.Weapons.Tag do
  use Ecto.Schema
  import Ecto.Changeset
  alias SplatoonData.Weapons.{Tag, Weapon, TagWeapon}
  alias SplatoonData.Weapons.Enum.TagGenreEnum

  schema "weapons_weapons" do
    field :name, :string
    field :genre, TagGenreEnum, default: :undefined

    timestamps()

    many_to_many :weapons, Weapon, join_through: TagWeapon
  end

  @doc false
  def changeset(%Tag{} = tag, attrs) do
    tag
    |> cast(attrs, [:name, :genre])
    |> validate_required([:name, :genre])
  end
end