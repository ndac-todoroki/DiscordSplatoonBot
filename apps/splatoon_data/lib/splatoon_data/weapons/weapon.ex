defmodule SplatoonData.Weapons.Weapon do
  use Ecto.Schema
  import Ecto.Changeset
  alias SplatoonData.Weapons.{Tag, Weapon, TagWeapon}

  schema "weapons_weapons" do
    field :name, :string
    field :get_rank, :integer

    timestamps()

    many_to_many :tags, Tag, join_through: TagWeapon
  end

  @doc false
  def changeset(%Weapon{} = weapon, attrs) do
    weapon
    |> cast(attrs, [:name, :get_rank])
    |> validate_required([:name, :get_rank])
    |> validate_number(:get_rank, greater_than_or_equal_to: 1)
    |> unique_constraint(:name)
  end
end