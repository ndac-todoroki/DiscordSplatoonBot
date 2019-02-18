defmodule SplatoonData.Weapons.TagWeapon do
  use Ecto.Schema
  import Ecto.Changeset
  alias SplatoonData.Weapons.{Tag, Weapon, TagWeapon}

  schema "weapons_tags_weapons" do
    timestamps()

    belongs_to(:tag, Tag)
    belongs_to(:weapon, Weapon)
  end

  @doc false
  def changeset(%TagWeapon{} = tag_weapon, attrs) do
    tag_weapon
    |> put_assoc(:tag, attrs.tag)
    |> put_assoc(:weapon, attrs.weapon)
  end
end
