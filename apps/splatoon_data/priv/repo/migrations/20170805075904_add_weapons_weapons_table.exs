defmodule SplatoonData.Repo.Migrations.AddWeaponsWeaponsTable do
  use Ecto.Migration

  def change do
    create table(:weapons_weapons) do
      add :name, :string, null: false
      add :get_rank, :integer, null: false

      timestamps()
    end

    create index(:weapons_weapons, [:name])
    create index(:weapons_weapons, [:get_rank])
  end
end
