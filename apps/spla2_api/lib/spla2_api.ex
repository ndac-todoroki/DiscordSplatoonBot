defmodule Spla2API do
  @moduledoc """
  Wrapper for Spla2 API.
  @see https://spla2.yuu26.com/
  """

  alias __MODULE__.Struct.{Coop, Stages, Stage}

  defstruct [:result]

  @rules [:regular, :gachi, :league]
  @type rules :: :regular | :gachi | :league

  @options [:now, :next, :next_all, :schedule]
  @type options :: :now | :next | :next_all | :schedule

  @base_uri "https://spla2.yuu26.com/"

  @spec schedule() :: {:ok, Stages.t()} | {:error, any()}
  def schedule, do: request("schedule", &Stages.to_struct/1)

  @doc "指定した時間帯のナワバリバトルのステージ情報を返します。"
  @spec regular(options) :: {:error, any()} | {:ok, [Stage.t()]}
  def regular(option) when option in @options, do: particular_rule(:regular, option)

  @doc "指定した時間帯のガチマッチのステージ情報を返します。"
  @spec gachi(options) :: {:error, any()} | {:ok, [Stage.t()]}
  def gachi(option) when option in @options, do: particular_rule(:gachi, option)

  @doc "指定した時間帯のリーグマッチのステージ情報を返します。"
  @spec league(options) :: {:error, any()} | {:ok, [Stage.t()]}
  def league(option) when option in @options, do: particular_rule(:league, option)

  @doc """
  指定した時間帯のステージ情報を返します。

  |option|document|
  |--|--|
  |now|現在のステージ情報|
  |next|次のステージ情報|
  |next_all|次～最大24時間先までのステージ情報 (next を含む)|
  |schedule|現在～最大24時間先までのステージ情報 (now + next_all)|
  """
  @spec particular_rule(atom, atom) :: {:ok, [Stage.t()]} | {:error, any()}
  def particular_rule(rule, option) when rule in @rules and option in @options,
    do:
      request("#{rule}/#{option}", fn res ->
        res |> Enum.map(&Stage.to_struct/1)
      end)

  @spec coop :: {:ok, [Coop.t()]} | {:error, any()}
  def coop, do: coop(all: false)

  @spec coop(all: true | false) :: {:ok, [Coop.t()] | {:error, any()}}
  def coop(all: false),
    do: request("coop/schedule", fn list -> Enum.map(list, &Coop.to_struct/1) end)

  def coop(all: true), do: request("coop", fn list -> Enum.map(list, &Coop.to_struct/1) end)

  defp request(url, parser) when parser |> is_function(1) do
    with {:ok, 200, _headers, ref} <- :hackney.request(@base_uri <> url),
         {:ok, body} <- :hackney.body(ref),
         {:ok, map} <- Jason.decode(body, keys: :atoms!) do
      result = map.result |> parser.()

      :hackney.close(ref)
      {:ok, result}
    else
      {:ok, status_code, _, ref} ->
        :hackney.close(ref)
        {:error, {:status_code, status_code}}

      {:error, reason} ->
        {:error, reason}
    end
  end
end
