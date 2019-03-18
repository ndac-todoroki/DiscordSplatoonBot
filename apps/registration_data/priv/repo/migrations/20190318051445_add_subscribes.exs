defmodule RegistrationData.Repo.Migrations.AddSubscribes do
  use Ecto.Migration

  def change do
    create table(:subscribes) do
      add :schedule_id, references(:schedules, on_delete: :nothing)
      add :channel_id, references(:channels, on_delete: :nothing)

      timestamps()
    end

    create index(:subscribes, [:schedule_id])
    create index(:subscribes, [:channel_id])
    create unique_index(:subscribes, [:schedule_id, :channel_id], name: :channel_schedule_unique)
  end
end
