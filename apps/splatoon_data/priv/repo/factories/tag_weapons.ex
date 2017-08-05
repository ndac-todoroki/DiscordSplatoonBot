defmodule SplatoonData.Repo.Factories.TagWeapons do
  defmacro __using__(_opts) do
    quote do
      def tag_weapon_factory do
        %SplatoonData.Weapons.TagWeapon{
          weapon: nil,
          tag: nil
        }
      end
    end
  end
end