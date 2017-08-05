defmodule SplatoonData.Weapons do
  @moduledoc """
  The boundary for the Ticket system.
  """

  import Ecto.Query, warn: false
  alias SplatoonData.Repo
  alias SplatoonData.Weapons.{Tag, Weapon, TagWeapon}

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_weapons(:all) do
    Repo.all(Weapon)
  end
end