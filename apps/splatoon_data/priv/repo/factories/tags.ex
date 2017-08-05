defmodule SplatoonData.Repo.Factories.Tags do
  defmacro __using__(_opts) do
    quote do
      def tag_factory do
        %SplatoonData.Weapons.Tag{
          name: nil,   # 何か入れないとエラー
          genre: :undefined
        }
      end

      def weapon_genre_factory do
        %SplatoonData.Weapons.Tag{
          name: nil,   # 何か入れないとエラー
          genre: :weapon_genre
        }
      end

      def sub_weapon_factory do
        %SplatoonData.Weapons.Tag{
          name: nil,   # 何か入れないとエラー
          genre: :sub_weapon
        }
      end

      def special_weapon_factory do
        %SplatoonData.Weapons.Tag{
          name: nil,   # 何か入れないとエラー
          genre: :special_weapon
        }
      end
    end
  end
end