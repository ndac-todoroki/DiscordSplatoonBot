defmodule RegistrationData.Repo.Migrations.AddSchedules do
  use Ecto.Migration

  def change do
    create table(:schedules) do
      add :type, :string, null: false

      timestamps()
    end

    create unique_index(:schedules, [:type])
  end
end
