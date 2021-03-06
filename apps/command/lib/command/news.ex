defmodule Command.News do
  alias Nostrum.Api, as: API
  import Nostrum.Struct.Embed

  def latest(channel_id, opts \\ []) when is_list(opts) do
    with {:ok, stages} <- Spla2API.schedule(),
         {:ok, salmons} <- Spla2API.coop() do
      stages =
        stages
        |> Map.update!(:regular, &List.first/1)
        |> Map.update!(:gachi, &List.first/1)
        |> Map.update!(:league, &List.first/1)

      # これからプレイできる最初のサーモンラン
      # 多少実行時に秒数が遅れるが、内容的に気にならない
      salmon =
        salmons
        |> Enum.take(1)
        |> Enum.filter(
          &(&1.end_utc > NaiveDateTime.utc_now() && &1.start_utc <= NaiveDateTime.utc_now())
        )
        |> List.first()

      embed =
        %Nostrum.Struct.Embed{}
        |> put_title("ハイカラニュース")
        |> put_timestamp(DateTime.utc_now() |> DateTime.to_iso8601())
        |> put_color(431_948)
        |> put_field("ナワバリバトル", stages.regular.maps_ex |> Enum.map_join("、", & &1.name))
        |> put_field(
          "ガチマッチ　#{stages.gachi.rule_ex.name}",
          stages.gachi.maps_ex |> Enum.map_join("、", & &1.name)
        )
        |> put_field(
          "リーグマッチ　#{stages.league.rule_ex.name}",
          stages.league.maps_ex |> Enum.map_join("、", & &1.name)
        )
        |> put_field("サーモンラン", if(salmon, do: salmon.stage.name, else: "（なし）"))

      API.create_message(channel_id, embed: embed)
    else
      {:error, _some} ->
        nil
    end
  end

  def regular(channel_id, opts \\ []) when is_list(opts) do
    with {:ok, stages} <- Spla2API.regular(:schedule) do
      stages = stages |> Enum.take(3)

      embed =
        %Nostrum.Struct.Embed{}
        |> put_title("ナワバリバトル")
        |> put_timestamp(DateTime.utc_now() |> DateTime.to_iso8601())
        |> put_color(431_948)

      embed =
        stages
        |> Enum.reduce(embed, &put_field(&2, &1 |> format_stage_time, &1 |> format_stage_maps))

      API.create_message(channel_id, embed: embed)
    else
      {:error, _some} ->
        nil
    end
  end

  def gachi(channel_id, opts \\ []) when is_list(opts) do
    with {:ok, stages} <- Spla2API.gachi(:schedule) do
      stages = stages |> Enum.take(3)

      embed =
        %Nostrum.Struct.Embed{}
        |> put_title("ガチマッチ")
        |> put_timestamp(DateTime.utc_now() |> DateTime.to_iso8601())
        |> put_color(431_948)

      embed =
        stages
        |> Enum.reduce(
          embed,
          &put_field(&2, "#{&1 |> format_stage_time}　#{&1.rule_ex.name}", &1 |> format_stage_maps)
        )

      API.create_message(channel_id, embed: embed)
    else
      {:error, _some} ->
        nil
    end
  end

  def league(channel_id, opts \\ []) when is_list(opts) do
    with {:ok, stages} <- Spla2API.league(:schedule) do
      stages = stages |> Enum.take(3)

      embed =
        %Nostrum.Struct.Embed{}
        |> put_title("リーグマッチ")
        |> put_timestamp(DateTime.utc_now() |> DateTime.to_iso8601())
        |> put_color(431_948)

      embed =
        stages
        |> Enum.reduce(
          embed,
          &put_field(&2, "#{&1 |> format_stage_time}　#{&1.rule_ex.name}", &1 |> format_stage_maps)
        )

      API.create_message(channel_id, embed: embed)
    else
      {:error, _some} ->
        nil
    end
  end

  def salmon(channel_id, opts \\ []) when is_list(opts) do
    with {:ok, works} <- Spla2API.coop() do
      works =
        if hd(works).end_utc < NaiveDateTime.utc_now() do
          tl(works)
        else
          works
        end
        |> Enum.take(2)

      embed =
        %Nostrum.Struct.Embed{}
        |> put_title("サーモンラン")
        |> put_timestamp(DateTime.utc_now() |> DateTime.to_iso8601())
        |> put_color(431_948)

      embed =
        works
        |> Enum.reduce(
          embed,
          &put_field(
            &2,
            format_salmon_time(&1.start, &1.end),
            if &1.stage.name do
              """
              **#{&1.stage.name}**
              #{&1.weapons |> Enum.map_join("\n", fn weapon -> " • #{weapon.name}" end)}
              """
            else
              "（バイト先・支給ブキ未定）"
            end
          )
        )

      API.create_message(channel_id, embed: embed)
    else
      {:error, _some} ->
        nil
    end
  end

  defp format_stage_time(%{start: %{hour: sh, minute: sm}, end: %{hour: eh, minute: em}}) do
    start = format_time(sh, sm)
    ende = format_time(eh, em)

    "#{start}〜#{ende}"
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

  defp format_stage_maps(%{maps_ex: maps}), do: maps |> Enum.map_join("、", & &1.name)
end
