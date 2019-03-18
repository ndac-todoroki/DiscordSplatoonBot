defmodule RegistrationData.Repo.Migrations.AddChannels do
  use Ecto.Migration

  def change do
    create table(:channels) do
      add :identifier, :bigint, null: false

      timestamps()
    end

    create unique_index(:channels, [:identifier])
  end
end
