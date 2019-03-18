defmodule RegistrationData.Subscribe do
  use Ecto.Schema
  import Ecto.Changeset

  alias RegistrationData.{Channel, Schedule}

  schema "subscribes" do
    timestamps()

    belongs_to(:channel, Channel)
    belongs_to(:schedule, Schedule)
  end

  @doc false
  def changeset(%__MODULE__{} = data, attrs) do
    data
    |> cast(attrs, [])
    |> put_assoc(:channel, attrs.channel)
    |> put_assoc(:schedule, attrs.schedule)
    |> unique_constraint(:channel, name: :channel_schedule_unique)
  end
end
