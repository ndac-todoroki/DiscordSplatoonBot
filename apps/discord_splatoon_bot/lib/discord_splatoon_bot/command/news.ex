defmodule DiscordSplatoonBot.Command.News do
  alias Nostrum.Api, as: API
  import Nostrum.Struct.Embed

  def latest(message, opts \\ []) when is_list(opts) do
    with {:ok, stages} = Spla2API.schedule(),
         {:ok, salmons} = Spla2API.coop() do
      stages =
        stages
        |> Map.update!(:regular, &List.first/1)
        |> Map.update!(:gachi, &List.first/1)
        |> Map.update!(:league, &List.first/1)

      salmon = salmons |> List.first()

      embed =
        %Nostrum.Struct.Embed{}
        |> put_title("ハイカラニュース")
        |> put_timestamp(DateTime.utc_now() |> DateTime.to_iso8601())
        |> put_color(431_948)
        |> put_field("ナワバリバトル", stages.regular.maps_ex |> Enum.map_join("、", & &1.name))
        |> put_field("ガチマッチ", stages.gachi.maps_ex |> Enum.map_join("、", & &1.name))
        |> put_field("リーグマッチ", stages.league.maps_ex |> Enum.map_join("、", & &1.name))
        |> put_field("サーモンラン", if(salmon, do: salmon.stage.name, else: "（なし）"))

      API.create_message(message.channel_id, embed: embed)
    else
      {:error, _some} ->
        nil
    end
  end

  def regular(message, opts \\ []) when is_list(opts) do
    with {:ok, stages} = Spla2API.regular(:schedule) do
      stages = stages |> Enum.take(3)

      embed =
        %Nostrum.Struct.Embed{}
        |> put_title("ナワバリバトル")
        |> put_timestamp(DateTime.utc_now() |> DateTime.to_iso8601())
        |> put_color(431_948)

      embed =
        stages
        |> Enum.reduce(embed, &put_field(&2, &1 |> format_stage_time, &1 |> format_stage_maps))

      API.create_message(message.channel_id, embed: embed)
    else
      {:error, _some} ->
        nil
    end
  end

  def gachi(message, opts \\ []) when is_list(opts) do
    with {:ok, stages} = Spla2API.gachi(:schedule) do
      stages = stages |> Enum.take(3)

      embed =
        %Nostrum.Struct.Embed{}
        |> put_title("ガチマッチ")
        |> put_timestamp(DateTime.utc_now() |> DateTime.to_iso8601())
        |> put_color(431_948)

      embed =
        stages
        |> Enum.reduce(embed, &put_field(&2, &1 |> format_stage_time, &1 |> format_stage_maps))

      API.create_message(message.channel_id, embed: embed)
    else
      {:error, _some} ->
        nil
    end
  end

  def league(message, opts \\ []) when is_list(opts) do
    with {:ok, stages} = Spla2API.league(:schedule) do
      stages = stages |> Enum.take(3)

      embed =
        %Nostrum.Struct.Embed{}
        |> put_title("リーグマッチ")
        |> put_timestamp(DateTime.utc_now() |> DateTime.to_iso8601())
        |> put_color(431_948)

      embed =
        stages
        |> Enum.reduce(embed, &put_field(&2, &1 |> format_stage_time, &1 |> format_stage_maps))

      API.create_message(message.channel_id, embed: embed)
    else
      {:error, _some} ->
        nil
    end
  end

  def salmon(message, opts \\ []) when is_list(opts) do
    with {:ok, works} = Spla2API.coop() do
      works = works |> Enum.take(2)

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
            to_string(&1.start.month) <>
              "月" <> to_string(&1.start.day) <> "日 " <> (&1 |> format_stage_time),
            """
            **#{&1.stage.name}**
            #{&1.weapons |> Enum.map_join("\n", fn weapon -> "- #{weapon.name}" end)}
            """
          )
        )

      API.create_message(message.channel_id, embed: embed)
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

  defp format_time(hour, minute),
    do:
      [hour, minute]
      |> Enum.map(&to_string/1)
      |> Enum.map(&String.pad_leading(&1, 2, "0"))
      |> Enum.join(":")

  defp format_stage_maps(%{maps_ex: maps}), do: maps |> Enum.map_join("、", & &1.name)
end
