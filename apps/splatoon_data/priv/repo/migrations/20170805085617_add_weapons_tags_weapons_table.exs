defmodule SplatoonData.Repo.Migrations.AddWeaponsTagsWeaponsTable do
  use Ecto.Migration

  def change do
    create table(:weapons_tags_weapons) do
      add :weapon_id, references(:weapons_weapons, on_delete: :nothing)
      add :tag_id, references(:weapons_tags, on_delete: :nothing)

      timestamps()
    end

    create index(:weapons_tags_weapons, [:weapon_id])
    create index(:weapons_tags_weapons, [:tag_id])
    create index(:weapons_tags_weapons, [:tag_id, :weapon_id])
  end
end
