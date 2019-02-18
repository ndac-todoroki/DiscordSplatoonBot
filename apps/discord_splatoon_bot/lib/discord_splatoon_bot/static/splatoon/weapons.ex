defmodule Static.Splatoon.Weapons do
  @weapons ~w(
    わかばシューター
    スプラシューター
    スプラシューターコラボ
    プロモデラーMG
    プロモデラーRG
    プライムシューター
    .52ガロン
    .96ガロン
    ジェットスイーパー
    N-ZAP85
    L3リールガン
    H3リールガン
    シャープマーカー
    パブロ
    ホクサイ
    カーボンローラー
    スプラローラー
    スプラローラーコラボ
    ダイナモローラー
    ヴァリアブルローラー
    スプラマニューバー
    スプラマニューバーコラボ
    スパッタリー
    ディアルスイーパー
    スプラチャージャー
    スプラチャージャーコラボ
    スプラスコープ
    スプラスコープコラボ
    リッター4K
    4Kスコープ
    ソイチューバー
    ラピッドブラスター
    ノヴァブラスター
    ホットブラスター
    ホットブラスターカスタム
    クラッシュブラスター
    バレルスピナー
    スプラスピナー
    バケットスロッシャー
    ヒッセン
  )

  def list(:all) do
    @weapons
  end
end
