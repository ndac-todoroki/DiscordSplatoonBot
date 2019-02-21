defmodule Command.Schedule do
  alias Nostrum.Api, as: API
  alias Scheduler
  alias Scheduler.Struct.Job
  import Nostrum.Struct.Embed

  # schedule: "2-59/10 * * * *"
  # とりあえずIDは登録時のメッセージIDを使うことにする
  # 最悪デベロッパーモードになれば削除IDがわかる（もっとも反応に書いてあるけど）
  def latest_news(channel_id, message_id, guild_id, opts \\ []) when is_list(opts) do
    job_id = "#{guild_id}-#{channel_id}-#{message_id}"
    schedule = opts |> Enum.take(5) |> Enum.join(" ")

    job_creation =
      %{channel_id: channel_id, command: "news:latest"}
      |> Jason.encode!()
      |> Base.encode64()
      |> Job.new(job_id, schedule)
      |> Job.Generator.to_struct()
      |> Scheduler.create_schedule()

    with {:ok, _job} <- job_creation do
      API.create_message(channel_id, "登録しました！（ID: `#{message_id}`）")
    else
      _ ->
        API.create_message(channel_id, "登録できませんでした… コマンドを見直してください。")
    end
  end

  def delete(channel_id, message_id, guild_id) do
    job_id = "#{guild_id}-#{channel_id}-#{message_id}"

    with {:ok, _} <- Scheduler.delete_schedule(job_id) do
      API.create_message(channel_id, "スケジュール `#{message_id}` を削除しました。")
    else
      _ ->
        API.create_message(channel_id, "削除できませんでした。IDは間違っていませんか？")
    end
  end

  def not_yet_error(channel_id),
    do: API.create_message(channel_id, "そのコマンドは現在予定作成非対応です :sweat_drops:")
end
