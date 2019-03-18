defmodule RegistrationData.Registry do
  @moduledoc """
  Subscribes to channels.
  """

  import Ecto.Query, warn: false
  alias RegistrationData.Repo
  alias RegistrationData.{Channel, Schedule, Subscribe}

  def list_subscribing_channel_ids(schedule_type) do
    query =
      from channel in Channel,
        join: subscription in Subscribe,
        on: subscription.channel_id == channel.id,
        join: schedule in Schedule,
        on: schedule.type == ^schedule_type and subscription.schedule_id == schedule.id,
        select: [:identifier]

    query
    |> Repo.all()
    |> Enum.map(& &1.identifier)
  end

  @doc """
  Subscribe a Channel to a Schedule.
  """
  @spec subscribe(term, term) :: {:ok, %Subscribe{}} | {:error, Ecto.Changeset.t()}
  def subscribe(channel, schedule)

  def subscribe(%Channel{} = channel, schedule_type) when schedule_type |> is_binary(),
    do: subscribe(channel, get_schedule(schedule_type))

  def subscribe(%Channel{} = channel, %Schedule{} = schedule) do
    %Subscribe{}
    |> Subscribe.changeset(%{channel: channel, schedule: schedule})
    |> Repo.insert()
  end

  @doc """
  Unsubscribe from a Schedule.
  """
  @spec unsubscribe(term, term) :: {:ok, %Subscribe{}} | {:error, Ecto.Changeset.t()}
  def unsubscribe(channel, schedule)

  def unsubscribe(%Channel{} = channel, schedule_type) when schedule_type |> is_binary(),
    do: unsubscribe(channel, get_schedule(schedule_type))

  def unsubscribe(%Channel{} = channel, %Schedule{} = schedule) do
    Subscribe
    |> Repo.get_by!(channel_id: channel.id, schedule_id: schedule.id)
    |> Repo.delete()
  end

  def create_schedule(type),
    do:
      %Schedule{}
      |> Schedule.changeset(%{type: type})
      |> Repo.insert()

  def get_schedule(type), do: Repo.get_by!(Schedule, type: type)

  def create_channel(identifier) do
    case(Repo.get_by(Channel, identifier: identifier)) do
      nil ->
        %Channel{}
        |> Channel.changeset(%{identifier: identifier})
        |> Repo.insert!()

      channel ->
        channel
    end
  end

  def get_channel(identifier), do: Repo.get_by!(Channel, identifier: identifier)
end
