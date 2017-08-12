# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     SplatoonData.Repo.insert!(%SplatoonData.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.


import SplatoonData.Repo.Factory

me = self()

# TODO ヒーローブキの取得最低ランクを調べる
## Weapons
wakaba = insert(:weapon, [name: "わかばシューター", get_rank: 1])
splashooter = insert(:weapon, [name: "スプラシューター", get_rank: 2])
splashooter_collabo = insert(:weapon, [name: "スプラシューターコラボ", get_rank: 4])
gallon52 = insert(:weapon, [name: ".52ガロン", get_rank: 14])
sharp_marker = insert(:weapon, [name: "シャープマーカー", get_rank: 25])
nzap85 = insert(:weapon, [name: "N-ZAP85", get_rank: 9])
prime = insert(:weapon, [name: "プライムシューター", get_rank: 10])
bold_marker = insert(:weapon, [name: "ボールドマーカー", get_rank: 12])
dualsweeper = insert(:weapon, [name: "デュアルスイーパー", get_rank: 12])
pro_rg = insert(:weapon, [name: "プロモデラーRG", get_rank: 28])
pro_mg = insert(:weapon, [name: "プロモデラーMG", get_rank: 6])
gallon96 = insert(:weapon, [name: ".96ガロン", get_rank: 21])
l3reel = insert(:weapon, [name: "L3リールガン", get_rank: 18])
h3reel = insert(:weapon, [name: "H3リールガン", get_rank: 29])
jetsweeper = insert(:weapon, [name: "ジェットスイーパー", get_rank: 17])
barrel = insert(:weapon, [name: "バレルスピナー", get_rank: 8])
splaspinner = insert(:weapon, [name: "スプラスピナー", get_rank: 23])
backet = insert(:weapon, [name: "バケットスロッシャー", get_rank: 5])
hissen = insert(:weapon, [name: "ヒッセン", get_rank: 15])
splascope = insert(:weapon, [name: "スプラスコープ", get_rank: 15])
splascope_collabo = insert(:weapon, [name: "スプラスコープコラボ", get_rank: 25])
splacharger = insert(:weapon, [name: "スプラチャージャー", get_rank: 3])
splacharger_collabo = insert(:weapon, [name: "スプラチャージャーコラボ", get_rank: 16])
hoksai = insert(:weapon, [name: "ホクサイ", get_rank: 10])
pablo = insert(:weapon, [name: "パブロ", get_rank: 10])
hot_blaster_cus = insert(:weapon, [name: "ホットブラスターカスタム", get_rank: 27])
nova_blaster = insert(:weapon, [name: "ノヴァブラスター", get_rank: 19])
rapid_blaster = insert(:weapon, [name: "ラピッドブラスター", get_rank: 13])
hot_blaster = insert(:weapon, [name: "ホットブラスター", get_rank: 5])
dynamo = insert(:weapon, [name: "ダイナモローラー", get_rank: 20])
splaroller_collabo = insert(:weapon, [name: "スプラローラーコラボ", get_rank: 12])
splaroller = insert(:weapon, [name: "スプラローラー", get_rank: 3])
carbon = insert(:weapon, [name: "カーボンローラー", get_rank: 7])
splamanuber = insert(:weapon, [name: "スプラマニューバー", get_rank: 4])
variable = insert(:weapon, [name: "ヴァリアブルローラー", get_rank: 24])
crash_blaster = insert(:weapon, [name: "クラッシュブラスター", get_rank: 30])
soy_tuber = insert(:weapon, [name: "ソイチューバー", get_rank: 22])
splamanuber_collabo = insert(:weapon, [name: "スプラマニューバーコラボ", get_rank: 11])
spattery = insert(:weapon, [name: "スパッタリー", get_rank: 26])
litter4k = insert(:weapon, [name: "リッター4K", get_rank: 20])
scoped4k = insert(:weapon, [name: "4Kスコープ", get_rank: 30])
parashelter = insert(:weapon, [name: "パラシェルター", get_rank: 9])

## Sub Weapons
splash_bomb = insert(:sub_weapon, [name: "スプラッシュボム"])
kyuban_bomb = insert(:sub_weapon, [name: "キューバンボム"])
carling_bomb = insert(:sub_weapon, [name: "カーリングボム"])
quick_bomb = insert(:sub_weapon, [name: "クイックボム"])
robot_bomb = insert(:sub_weapon, [name: "ロボットボム"])
point_sensor = insert(:sub_weapon, [name: "ポイントセンサー"])
poison_mist = insert(:sub_weapon, [name: "ポイズンミスト"])
sprinkler = insert(:sub_weapon, [name: "スプリンクラー"])
trap = insert(:sub_weapon, [name: "トラップ"])
beacon = insert(:sub_weapon, [name: "ジャンプビーコン"])
shield = insert(:sub_weapon, [name: "スプラッシュシールド"])

## Special Weapons
multi_missile = insert(:special_weapon, [name: "マルチミサイル"])
hyper_pressure = insert(:special_weapon, [name: "ハイパープレッサー"])
jet_pack = insert(:special_weapon, [name: "ジェットパック"])
super_chakuchi = insert(:special_weapon, [name: "スーパーチャクチ"])
ink_armor = insert(:special_weapon, [name: "インクアーマー"])
bomb_pitcher = insert(:special_weapon, [name: "ボムピッチャー"])
carlingbomb_pitcher = insert(:special_weapon, [name: "カーリングボムピッチャー"])
kyubanbomb_pitcher = insert(:special_weapon, [name: "キューバンボムピッチャー"])
splashbomb_pitcher = insert(:special_weapon, [name: "スプラッシュボムピッチャー"])
rain = insert(:special_weapon, [name: "アメフラシ"])
squid_sphere = insert(:special_weapon, [name: "イカスフィア"])
bubble_launcher = insert(:special_weapon, [name: "バブルランチャー"])

## Weapon Genres
shooters = insert(:weapon_genre, [name: "シューター"])
chargers = insert(:weapon_genre, [name: "チャージャー"])
blasters = insert(:weapon_genre, [name: "ブラスター"])
sloshers = insert(:weapon_genre, [name: "スロッシャー"])
rollers = insert(:weapon_genre, [name: "ローラー"])
brushes = insert(:weapon_genre, [name: "フデ"])
spinners = insert(:weapon_genre, [name: "スピナー"])
manubers = insert(:weapon_genre, [name: "マニューバー"])
shelters = insert(:weapon_genre, [name: "パラシェルター"])
# TODO: 射程のジャンルもここに

## 付与
[
  # {ブキ, [タグ配列]}
  # 順番は http://gamefavo.com/db/splatoon2/splat2-buki-list/ に従う

  # シューター
  {wakaba, [shooters, splash_bomb, ink_armor]},
  {splashooter, [shooters, quick_bomb, super_chakuchi]},
  {splashooter_collabo, [shooters, splash_bomb, jet_pack]},
  {pro_mg, [shooters, kyuban_bomb, carlingbomb_pitcher, bomb_pitcher]},
  {pro_rg, [shooters, sprinkler, squid_sphere]},
  {prime, [shooters, point_sensor, rain]},
  {gallon52, [shooters, point_sensor, squid_sphere]},
  {gallon96, [shooters, sprinkler, ink_armor]},
  {jetsweeper, [shooters, poison_mist, multi_missile]},
  {nzap85, [shooters, kyuban_bomb, ink_armor]},
  {l3reel, [shooters, carling_bomb, squid_sphere]},
  {h3reel, [shooters, point_sensor, multi_missile]},
  {sharp_marker, [shooters, poison_mist, jet_pack]},
  {bold_marker, [shooters, carling_bomb, super_chakuchi]},

  # フデ
  {pablo, [brushes, splash_bomb, super_chakuchi]},
  {hoksai, [brushes, robot_bomb, jet_pack]},

  # ローラー
  {carbon, [rollers, robot_bomb, rain]},
  {splaroller, [rollers, carling_bomb, super_chakuchi]},
  {splaroller_collabo, [rollers, beacon, squid_sphere]},
  {variable, [rollers, shield, splashbomb_pitcher, bomb_pitcher]},
  {dynamo, [rollers, trap, hyper_pressure]},

  # マニューバー
  {splamanuber, [manubers, quick_bomb, multi_missile]},
  {splamanuber_collabo, [manubers, carling_bomb, jet_pack]},
  {spattery, [manubers, beacon, kyubanbomb_pitcher, bomb_pitcher]},
  {dualsweeper, [manubers, point_sensor, multi_missile]},

  # チャージャー
  {splacharger, [chargers, splash_bomb, hyper_pressure]},
  {splacharger_collabo, [chargers, shield, kyubanbomb_pitcher, bomb_pitcher]},
  {splascope, [chargers, splash_bomb, hyper_pressure]},
  {splascope_collabo, [chargers, shield, kyubanbomb_pitcher, bomb_pitcher]},
  {litter4k, [chargers, trap, rain]},
  {scoped4k, [chargers, trap, rain]},
  {soy_tuber, [chargers, kyuban_bomb, super_chakuchi]},

  # シェルター

  # ブラスター
  {nova_blaster, [blasters, splash_bomb, squid_sphere]},
  {hot_blaster, [blasters, poison_mist, super_chakuchi]},
  {hot_blaster_cus, [blasters, robot_bomb, jet_pack]},
  {rapid_blaster, [blasters, trap, splashbomb_pitcher, bomb_pitcher]},
  {crash_blaster, [splash_bomb, hyper_pressure]},

  # スピナー
  {barrel, [spinners, sprinkler, hyper_pressure]},
  {splaspinner, [spinners, quick_bomb, multi_missile]},

  # スロッシャー
  {backet, [sloshers, kyuban_bomb, multi_missile]},
  {hissen, [sloshers, quick_bomb, ink_armor]},

  # シェルター
  {parashelter, [shelters, sprinkler, rain]},
]
|> Enum.each(fn {weapon, tags} ->
  tags |> Enum.each(fn tag ->
    insert(:tag_weapon, weapon: weapon, tag: tag)
  end)
end)
