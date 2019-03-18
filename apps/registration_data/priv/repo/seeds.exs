import Ecto.Query, warn: false
alias RegistrationData.Repo
alias RegistrationData.{Channel, Schedule, Subscribe}

# Schedules

~w(work:start)
|> Enum.each(fn type ->
  case Repo.get_by(Schedule, type: type) do
    nil ->
      %Schedule{}
      |> Schedule.changeset(%{type: type})
      |> Repo.insert!()

    schedule ->
      schedule
  end
end)
