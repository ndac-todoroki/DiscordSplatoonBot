defmodule SplatoonData.Repo.Factories.Weapons do
  defmacro __using__(_opts) do
    quote do
      def weapon_factory do
        %SplatoonData.Weapons.Weapon{
          name: nil,   # 何か入れないとエラー
          get_rank: 0  # これもエラー
        }
      end
    end
  end
end