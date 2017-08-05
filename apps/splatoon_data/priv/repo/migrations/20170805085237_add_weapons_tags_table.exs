defmodule SplatoonData.Repo.Migrations.AddWeaponsTagsTable do
  use Ecto.Migration

  def change do
    create table(:weapons_tags) do
      add :name, :string, null: false
      add :genre, :integer, null: false, default: 0

      timestamps()
    end

    create index(:weapons_tags, [:name])
  end
end
