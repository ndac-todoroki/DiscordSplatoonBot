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

# order as of https://wikiwiki.jp/splatoon2mix/%E3%83%96%E3%82%AD/%E3%83%A1%E3%82%A4%E3%83%B3%E3%82%A6%E3%82%A7%E3%83%9D%E3%83%B3
## Weapons
wakaba = insert(:weapon, name: "わかばシューター", get_rank: 1)
momiji = insert(:weapon, name: "もみじシューター", get_rank: 4)
ochiba = insert(:weapon, name: "おちばシューター", get_rank: 9)
splashooter = insert(:weapon, name: "スプラシューター", get_rank: 2)
splashooter_collabo = insert(:weapon, name: "スプラシューターコラボ", get_rank: 4)
splashooter_kensa = insert(:weapon, name: "スプラシューターベッチュー", get_rank: 6)
# hero_shooter = insert(:weapon, name: "ヒーローシューターレプリカ", get_rank: 2)
# octashooter = insert(:weapon, name: "オクタシューターレプリカ", get_rank: 1)
prime = insert(:weapon, name: "プライムシューター", get_rank: 10)
prime_collabo = insert(:weapon, name: "プライムシューターコラボ", get_rank: 20)
prime_kensa = insert(:weapon, name: "プライムシューターベッチュー", get_rank: 23)
gallon52 = insert(:weapon, name: ".52ガロン", get_rank: 14)
gallon52_deco = insert(:weapon, name: ".52ガロンデコ", get_rank: 22)
gallon52_kensa = insert(:weapon, name: ".52ガロンベッチュー", get_rank: 25)
gallon96 = insert(:weapon, name: ".96ガロン", get_rank: 21)
gallon96_deco = insert(:weapon, name: ".96ガロンデコ", get_rank: 26)
jetsweeper = insert(:weapon, name: "ジェットスイーパー", get_rank: 17)
jetsweeper_custom = insert(:weapon, name: "ジェットスイーパーカスタム", get_rank: 27)
bold_marker = insert(:weapon, name: "ボールドマーカー", get_rank: 10)
bold_marker_neo = insert(:weapon, name: "ボールドマーカーネオ", get_rank: 18)
sharp_marker = insert(:weapon, name: "シャープマーカー", get_rank: 25)
sharp_marker_neo = insert(:weapon, name: "シャープマーカーネオ", get_rank: 27)
nzap85 = insert(:weapon, name: "N-ZAP85", get_rank: 9)
nzap89 = insert(:weapon, name: "N-ZAP89", get_rank: 11)
pro_mg = insert(:weapon, name: "プロモデラーMG", get_rank: 6)
pro_rg = insert(:weapon, name: "プロモデラーRG", get_rank: 28)

hot_blaster = insert(:weapon, name: "ホットブラスター", get_rank: 5)
hot_blaster_custom = insert(:weapon, name: "ホットブラスターカスタム", get_rank: 27)
long_blaster = insert(:weapon, name: "ロングブラスター", get_rank: 14)
long_blaster_custom = insert(:weapon, name: "ロングブラスターカスタム", get_rank: 18)
rapid_blaster = insert(:weapon, name: "ラピッドブラスター", get_rank: 13)
rapid_blaster_deco = insert(:weapon, name: "ラピッドブラスターデコ", get_rank: 16)
rapid_blaster_kensa = insert(:weapon, name: "ラピッドブラスターベッチュー", get_rank: 21)
r_blaster_elite = insert(:weapon, name: "Rブラスターエリート", get_rank: 22)
r_blaster_elite_deco = insert(:weapon, name: "Rブラスターエリートデコ", get_rank: 24)
nova_blaster = insert(:weapon, name: "ノヴァブラスター", get_rank: 19)
nova_blaster_neo = insert(:weapon, name: "ノヴァブラスターネオ", get_rank: 24)
nova_blaster_kensa = insert(:weapon, name: "ノヴァブラスターベッチュー", get_rank: 26)
crash_blaster = insert(:weapon, name: "クラッシュブラスター", get_rank: 30)
crash_blaster_neo = insert(:weapon, name: "クラッシュブラスターネオ", get_rank: 30)

l3reel = insert(:weapon, name: "L3リールガン", get_rank: 18)
l3reel_d = insert(:weapon, name: "L3リールガンD", get_rank: 23)
l3reel_kensa = insert(:weapon, name: "L3リールガンベッチュー", get_rank: 27)
h3reel = insert(:weapon, name: "H3リールガン", get_rank: 29)
h3reel_d = insert(:weapon, name: "H3リールガンD", get_rank: 30)

squeezer = insert(:weapon, name: "ボトルガイザー", get_rank: 16)
squeezer_foil = insert(:weapon, name: "ボトルガイザーフォイル", get_rank: 25)

splaroller = insert(:weapon, name: "スプラローラー", get_rank: 3)
splaroller_collabo = insert(:weapon, name: "スプラローラーコラボ", get_rank: 12)
splaroller_kensa = insert(:weapon, name: "スプラローラーベッチュー", get_rank: 14)
carbon = insert(:weapon, name: "カーボンローラー", get_rank: 7)
carbon_deco = insert(:weapon, name: "カーボンローラーデコ", get_rank: 10)
variable = insert(:weapon, name: "ヴァリアブルローラー", get_rank: 24)
variable_foil = insert(:weapon, name: "ヴァリアブルローラーフォイル", get_rank: 28)
dynamo = insert(:weapon, name: "ダイナモローラー", get_rank: 20)
dynamo_tesla = insert(:weapon, name: "ダイナモローラーテスラ", get_rank: 25)
dynamo_kensa = insert(:weapon, name: "ダイナモローラーベッチュー", get_rank: 29)

pablo = insert(:weapon, name: "パブロ", get_rank: 5)
pablo_hue = insert(:weapon, name: "パブロ・ヒュー", get_rank: 7)
hoksai = insert(:weapon, name: "ホクサイ", get_rank: 10)
hoksai_hue = insert(:weapon, name: "ホクサイ・ヒュー", get_rank: 15)
hoksai_kensa = insert(:weapon, name: "ホクサイベッチュー", get_rank: 20)

splacharger = insert(:weapon, name: "スプラチャージャー", get_rank: 3)
splacharger_collabo = insert(:weapon, name: "スプラチャージャーコラボ", get_rank: 16)
splacharger_kensa = insert(:weapon, name: "スプラチャージャーベッチュー", get_rank: 19)
splascope = insert(:weapon, name: "スプラスコープ", get_rank: 15)
splascope_collabo = insert(:weapon, name: "スプラスコープコラボ", get_rank: 25)
splascope_kensa = insert(:weapon, name: "スプラスコープベッチュー", get_rank: 28)
litter4k = insert(:weapon, name: "リッター4K", get_rank: 20)
litter4k_custom = insert(:weapon, name: "リッター4Kカスタム", get_rank: 26)
scoped4k = insert(:weapon, name: "4Kスコープ", get_rank: 30)
scoped4k_custom = insert(:weapon, name: "4Kスコープカスタム", get_rank: 30)
soy_tuber = insert(:weapon, name: "ソイチューバー", get_rank: 22)
soy_tuber_custom = insert(:weapon, name: "ソイチューバーカスタム", get_rank: 28)
squiffer_alpha = insert(:weapon, name: "スクイックリンα", get_rank: 12)
squiffer_beta = insert(:weapon, name: "スクイックリンβ", get_rank: 17)
bamboo_a = insert(:weapon, name: "14式竹筒銃・甲", get_rank: 18)
bamboo_b = insert(:weapon, name: "14式竹筒銃・乙", get_rank: 21)

backet = insert(:weapon, name: "バケットスロッシャー", get_rank: 5)
backet_deco = insert(:weapon, name: "バケットスロッシャーデコ", get_rank: 8)
hissen = insert(:weapon, name: "ヒッセン", get_rank: 15)
hissen_hue = insert(:weapon, name: "ヒッセン・ヒュー", get_rank: 17)
screw = insert(:weapon, name: "スクリュースロッシャー", get_rank: 13)
screw_neo = insert(:weapon, name: "スクリュースロッシャーネオ", get_rank: 19)
screw_kensa = insert(:weapon, name: "スクリュースロッシャーベッチュー", get_rank: 21)
bloblob = insert(:weapon, name: "オーバーフロッシャー", get_rank: 11)
bloblob_deco = insert(:weapon, name: "オーバーフロッシャーデコ", get_rank: 20)
explosh = insert(:weapon, name: "エクスプロッシャー", get_rank: 18)
explosh_custom = insert(:weapon, name: "エクスプロッシャーカスタム", get_rank: 22)

barrel = insert(:weapon, name: "バレルスピナー", get_rank: 8)
barrel_deco = insert(:weapon, name: "バレルスピナーデコ", get_rank: 12)
splaspinner = insert(:weapon, name: "スプラスピナー", get_rank: 23)
splaspinner_collabo = insert(:weapon, name: "スプラスピナーコラボ", get_rank: 26)
splaspinner_kensa = insert(:weapon, name: "スプラスピナーベッチュー", get_rank: 29)
hydrant = insert(:weapon, name: "ハイドラント", get_rank: 27)
hydrant_custom = insert(:weapon, name: "ハイドラントカスタム", get_rank: 29)
ballpoint = insert(:weapon, name: "クーゲルシュライバー", get_rank: 25)
ballpoint_hue = insert(:weapon, name: "クーゲルシュライバー・ヒュー", get_rank: 28)
nautilus47 = insert(:weapon, name: "ノーチラス47", get_rank: 26)
nautilus79 = insert(:weapon, name: "ノーチラス79", get_rank: 30)

splamanuber = insert(:weapon, name: "スプラマニューバー", get_rank: 4)
splamanuber_collabo = insert(:weapon, name: "スプラマニューバーコラボ", get_rank: 11)
splamanuber_kensa = insert(:weapon, name: "スプラマニューバーベッチュー", get_rank: 16)
# hero_manuber = insert(:weapon, name: "ヒーローマニューバーレプリカ", get_rank: 4)
spattery = insert(:weapon, name: "スパッタリー", get_rank: 26)
spattery_hue = insert(:weapon, name: "スパッタリー・ヒュー", get_rank: 29)
dualsweeper = insert(:weapon, name: "デュアルスイーパー", get_rank: 12)
dualsweeper_custom = insert(:weapon, name: "デュアルスイーパーカスタム", get_rank: 16)
kelbin525 = insert(:weapon, name: "ケルビン525", get_rank: 17)
kelbin525_deco = insert(:weapon, name: "ケルビン525デコ", get_rank: 24)
kelbin525_kensa = insert(:weapon, name: "ケルビン525ベッチュー", get_rank: 27)
quad_black = insert(:weapon, name: "クアッドホッパーブラック", get_rank: 15)
quad_white = insert(:weapon, name: "クアッドホッパーホワイト", get_rank: 21)

parashelter = insert(:weapon, name: "パラシェルター", get_rank: 9)
parashelter_sorela = insert(:weapon, name: "パラシェルターソレーラ", get_rank: 15)
campingshelter = insert(:weapon, name: "キャンピングシェルター", get_rank: 9)
campingshelter_sorela = insert(:weapon, name: "キャンピングシェルターソレーラ", get_rank: 23)
spy_gadget = insert(:weapon, name: "スパイガジェット", get_rank: 13)
spy_gadget_sorela = insert(:weapon, name: "スパイガジェットソレーラ", get_rank: 19)
spy_gadget_kensa = insert(:weapon, name: "スパイガジェットベッチュー", get_rank: 24)

## Sub Weapons
splash_bomb = insert(:sub_weapon, name: "スプラッシュボム")
kyuban_bomb = insert(:sub_weapon, name: "キューバンボム")
quick_bomb = insert(:sub_weapon, name: "クイックボム")
carling_bomb = insert(:sub_weapon, name: "カーリングボム")
robot_bomb = insert(:sub_weapon, name: "ロボットボム")
trap = insert(:sub_weapon, name: "トラップ")
poison_mist = insert(:sub_weapon, name: "ポイズンミスト")
point_sensor = insert(:sub_weapon, name: "ポイントセンサー")
shield = insert(:sub_weapon, name: "スプラッシュシールド")
beacon = insert(:sub_weapon, name: "ジャンプビーコン")
sprinkler = insert(:sub_weapon, name: "スプリンクラー")
soda_bomb = insert(:sub_weapon, name: "タンサンボム")
torpedo = insert(:sub_weapon, name: "トーピード")

## Special Weapons
multi_missile = insert(:special_weapon, name: "マルチミサイル")
hyper_pressure = insert(:special_weapon, name: "ハイパープレッサー")
jet_pack = insert(:special_weapon, name: "ジェットパック")
super_chakuchi = insert(:special_weapon, name: "スーパーチャクチ")
ink_armor = insert(:special_weapon, name: "インクアーマー")
bomb_pitcher = insert(:special_weapon, name: "ボムピッチャー")
splash_bomb_pitcher = insert(:special_weapon, name: "スプラッシュボムピッチャー")
carling_bomb_pitcher = insert(:special_weapon, name: "カーリングボムピッチャー")
quick_bomb_pitcher = insert(:special_weapon, name: "クイックボムピッチャー")
kyuban_bomb_pitcher = insert(:special_weapon, name: "キューバンボムピッチャー")
robot_bomb_pitcher = insert(:special_weapon, name: "ロボットボムピッチャー")
rain = insert(:special_weapon, name: "アメフラシ")
squid_sphere = insert(:special_weapon, name: "イカスフィア")
bubble_launcher = insert(:special_weapon, name: "バブルランチャー")
nice_ball = insert(:special_weapon, name: "ナイスダマ")
ultra_stamp = insert(:special_weapon, name: "ウルトラハンコ")

## Weapon Genres
shooters = insert(:weapon_genre, name: "シューター")
blasters = insert(:weapon_genre, name: "ブラスター")
reelguns = insert(:weapon_genre, name: "リールガン")
squeezers = insert(:weapon_genre, name: "ボトルガイザー")
rollers = insert(:weapon_genre, name: "ローラー")
brushes = insert(:weapon_genre, name: "フデ")
chargers = insert(:weapon_genre, name: "チャージャー")
sloshers = insert(:weapon_genre, name: "スロッシャー")
spinners = insert(:weapon_genre, name: "スピナー")
manubers = insert(:weapon_genre, name: "マニューバー")
shelters = insert(:weapon_genre, name: "シェルター")
# TODO: 射程のジャンルもここに

## 付与
[
  # {ブキ, [タグ配列]}
  # 順番は https://wikiwiki.jp/splatoon2mix/%E3%83%96%E3%82%AD/%E3%83%A1%E3%82%A4%E3%83%B3%E3%82%A6%E3%82%A7%E3%83%9D%E3%83%B3 に従う

  # シューター
  {wakaba, [shooters, splash_bomb, ink_armor]},
  {momiji, [shooters, robot_bomb, rain]},
  {ochiba, [torpedo, bubble_launcher]},
  {splashooter, [shooters, quick_bomb, super_chakuchi]},
  {splashooter_collabo, [shooters, splash_bomb, jet_pack]},
  {splashooter_kensa, [shooters, kyuban_bomb, multi_missile]},
  {prime, [shooters, point_sensor, rain]},
  {prime_collabo, [kyuban_bomb, bubble_launcher]},
  {prime_kensa, [splash_bomb, nice_ball]},
  {gallon52, [shooters, point_sensor, squid_sphere]},
  {gallon52_deco, [shooters, carling_bomb, hyper_pressure]},
  {gallon52_kensa, [shooters, shield, nice_ball]},
  {gallon96, [shooters, sprinkler, ink_armor]},
  {gallon96_deco, [shooters, shield, super_chakuchi]},
  {jetsweeper, [shooters, poison_mist, multi_missile]},
  {jetsweeper_custom, [shooters, quick_bomb, hyper_pressure]},
  {bold_marker, [shooters, carling_bomb, super_chakuchi]},
  {bold_marker_neo, [shooters, beacon, multi_missile]},
  {sharp_marker, [shooters, poison_mist, jet_pack]},
  {sharp_marker_neo, [shooters, quick_bomb, kyuban_bomb_pitcher, bomb_pitcher]},
  {pro_mg, [shooters, kyuban_bomb, carling_bomb_pitcher, bomb_pitcher]},
  {pro_rg, [shooters, sprinkler, squid_sphere]},
  {nzap85, [shooters, kyuban_bomb, ink_armor]},
  {nzap89, [shooters, robot_bomb, multi_missile]},

  # ブラスター
  {hot_blaster, [blasters, poison_mist, super_chakuchi]},
  {hot_blaster_custom, [blasters, robot_bomb, jet_pack]},
  {long_blaster, [blasters, kyuban_bomb, rain]},
  {long_blaster_custom, [blasters, carling_bomb, bubble_launcher]},
  {rapid_blaster, [blasters, trap, splash_bomb_pitcher, bomb_pitcher]},
  {rapid_blaster_deco, [blasters, kyuban_bomb, jet_pack]},
  {rapid_blaster_kensa, [blasters, torpedo, squid_sphere]},
  {r_blaster_elite, [blasters, poison_mist, rain]},
  {r_blaster_elite_deco, [blasters, shield, ink_armor]},
  {nova_blaster, [blasters, splash_bomb, squid_sphere]},
  {nova_blaster_neo, [blasters, trap, kyuban_bomb_pitcher, bomb_pitcher]},
  {nova_blaster_kensa, [blasters, soda_bomb, rain]},
  {crash_blaster, [blasters, splash_bomb, hyper_pressure]},
  {crash_blaster_neo, [blasters, carling_bomb, multi_missile]},

  # リールガン
  {l3reel, [shooters, reelguns, carling_bomb, squid_sphere]},
  {l3reel_d, [shooters, reelguns, quick_bomb, jet_pack]},
  {l3reel_kensa, [shooters, reelguns, shield, ultra_stamp]},
  {h3reel, [shooters, reelguns, point_sensor, multi_missile]},
  {h3reel_d, [shooters, reelguns, point_sensor, multi_missile]},

  # ボトルガイザー
  {squeezer, [shooters, squeezers, shield, hyper_pressure]},
  {squeezer_foil, [shooters, squeezers, splash_bomb, bubble_launcher]},

  # ローラー
  {splaroller, [rollers, carling_bomb, super_chakuchi]},
  {splaroller_collabo, [rollers, beacon, squid_sphere]},
  {splaroller_kensa, [rollers, splash_bomb, bubble_launcher]},
  {carbon, [rollers, robot_bomb, rain]},
  {carbon_deco, [rollers, quick_bomb, robot_bomb_pitcher, bomb_pitcher]},
  {variable, [rollers, shield, splash_bomb_pitcher, bomb_pitcher]},
  {variable_foil, [rollers, kyuban_bomb, multi_missile]},
  {dynamo, [rollers, trap, hyper_pressure]},
  {dynamo_tesla, [rollers, splash_bomb, ink_armor]},
  {dynamo_kensa, [rollers, sprinkler, nice_ball]},

  # フデ
  {pablo, [brushes, splash_bomb, super_chakuchi]},
  {pablo_hue, [brushes, trap, squid_sphere]},
  {hoksai, [brushes, robot_bomb, jet_pack]},
  {hoksai_hue, [brushes, beacon, multi_missile]},
  {hoksai_kensa, [brushes, kyuban_bomb, ultra_stamp]},

  # チャージャー
  {splacharger, [chargers, splash_bomb, hyper_pressure]},
  {splacharger_collabo, [chargers, shield, kyuban_bomb_pitcher, bomb_pitcher]},
  {splacharger_kensa, [chargers, shield, sprinkler, squid_sphere]},
  {splascope, [chargers, splash_bomb, hyper_pressure]},
  {splascope_collabo, [chargers, shield, kyuban_bomb_pitcher, bomb_pitcher]},
  {splascope_kensa, [chargers, shield, sprinkler, squid_sphere]},
  {litter4k, [chargers, trap, rain]},
  {litter4k_custom, [chargers, beacon, bubble_launcher]},
  {scoped4k, [chargers, trap, rain]},
  {scoped4k_custom, [chargers, beacon, bubble_launcher]},
  {soy_tuber, [chargers, kyuban_bomb, super_chakuchi]},
  {soy_tuber_custom, [chargers, carling_bomb, jet_pack]},
  {squiffer_alpha, [chargers, point_sensor, ink_armor]},
  {squiffer_beta, [chargers, robot_bomb, squid_sphere]},
  {bamboo_a, [chargers, carling_bomb, multi_missile]},
  {bamboo_b, [chargers, poison_mist, quick_bomb_pitcher, bomb_pitcher]},

  # スロッシャー
  {backet, [sloshers, kyuban_bomb, multi_missile]},
  {backet_deco, [sloshers, sprinkler, squid_sphere]},
  {hissen, [sloshers, quick_bomb, ink_armor]},
  {hissen_hue, [sloshers, splash_bomb, rain]},
  {screw, [sloshers, robot_bomb, hyper_pressure]},
  {screw_neo, [sloshers, point_sensor, splash_bomb_pitcher, bomb_pitcher]},
  {screw_kensa, [sloshers, soda_bomb, super_chakuchi]},
  {bloblob, [sloshers, shield, rain]},
  {bloblob_deco, [sloshers, sprinkler, kyuban_bomb_pitcher, bomb_pitcher]},
  {explosh, [sloshers, sprinkler, bubble_launcher]},
  {explosh_custom, [sloshers, point_sensor, squid_sphere]},

  # スピナー
  {barrel, [spinners, sprinkler, hyper_pressure]},
  {barrel_deco, [spinners, shield, hyper_pressure]},
  {splaspinner, [spinners, quick_bomb, multi_missile]},
  {splaspinner_collabo, [spinners, carling_bomb, rain]},
  {splaspinner_kensa, [spinners, poison_mist, ultra_stamp]},
  {hydrant, [spinners, robot_bomb, super_chakuchi]},
  {hydrant_custom, [spinners, trap, ink_armor]},
  {ballpoint, [spinners, poison_mist, jet_pack]},
  {ballpoint_hue, [spinners, beacon, rain]},
  {nautilus47, [spinners, point_sensor, squid_sphere]},
  {nautilus79, [spinners, kyuban_bomb, jet_pack]},

  # マニューバー
  {splamanuber, [manubers, quick_bomb, multi_missile]},
  {splamanuber_collabo, [manubers, carling_bomb, jet_pack]},
  {splamanuber_kensa, [manubers, kyuban_bomb, squid_sphere]},
  {spattery, [manubers, beacon, kyuban_bomb_pitcher, bomb_pitcher]},
  {spattery_hue, [manubers, poison_mist, rain]},
  {dualsweeper, [manubers, point_sensor, multi_missile]},
  {dualsweeper_custom, [manubers, splash_bomb, rain]},
  {kelbin525, [manubers, trap, jet_pack]},
  {kelbin525_deco, [manubers, shield, squid_sphere]},
  {kelbin525_kensa, [manubers, soda_bomb, ink_armor]},
  {quad_black, [manubers, robot_bomb, super_chakuchi]},
  {quad_white, [manubers, sprinkler, robot_bomb_pitcher, bomb_pitcher]},

  # シェルター
  {parashelter, [shelters, sprinkler, rain]},
  {parashelter_sorela, [shelters, robot_bomb, splash_bomb_pitcher, bomb_pitcher]},
  {campingshelter, [shelters, beacon, bubble_launcher]},
  {campingshelter_sorela, [shelters, shield, carling_bomb_pitcher, bomb_pitcher]},
  {spy_gadget, [shelters, trap, super_chakuchi]},
  {spy_gadget_sorela, [shelters, splash_bomb, squid_sphere]},
  {spy_gadget_kensa, [shelters, torpedo, ink_armor]}
]
|> Enum.each(fn {weapon, tags} ->
  tags
  |> Enum.each(fn tag ->
    insert(:tag_weapon, weapon: weapon, tag: tag)
  end)
end)
