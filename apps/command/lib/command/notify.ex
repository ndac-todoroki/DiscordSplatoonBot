defmodule Command.Notify do
  import Nostrum.Struct.Embed
  alias Nostrum.Api

  def work_starts_batch(opts \\ []) do
    with {:ok, works} <- Spla2API.coop(),
         work = %Spla2API.Struct.Coop{} <-
           works
           |> Enum.take(1)
           |> Enum.filter(&(&1.end_utc > NaiveDateTime.utc_now()))
           |> List.first() do
      embed =
        %Nostrum.Struct.Embed{}
        |> put_title("サーモンラン")
        |> put_timestamp(DateTime.utc_now() |> DateTime.to_iso8601())
        |> put_color(431_948)
        |> put_field(
          format_salmon_time(work.start, work.end),
          """
          **#{work.stage.name}**
          #{work.weapons |> Enum.map_join("\n", fn weapon -> " • #{weapon.name}" end)}
          """
        )

      RegistrationData.Registry.list_subscribing_channel_ids("work:start")
      |> Enum.each(fn channel_id ->
        Api.create_message(
          channel_id,
          content: "バイトの時間ですよ！",
          embed: embed
        )
      end)
    end
  end

  defp format_salmon_time(%NaiveDateTime{} = start, %NaiveDateTime{} = ende),
    do: "#{format_date_time(start)} 〜 #{format_date_time(ende)}"

  defp format_time(hour, minute),
    do:
      [hour, minute]
      |> Enum.map(&to_string/1)
      |> Enum.map(&String.pad_leading(&1, 2, "0"))
      |> Enum.join(":")

  defp format_date(month, day), do: "#{month}月#{day}日"

  defp format_date_time(datetime),
    do:
      "#{format_date(datetime.month, datetime.day)} #{format_time(datetime.hour, datetime.minute)}"
end
