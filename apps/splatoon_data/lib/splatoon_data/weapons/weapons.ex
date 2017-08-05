defmodule SplatoonData.Weapons do
  @moduledoc """
  The boundary for the Ticket system.
  """

  import Ecto.Query, warn: false
  alias SplatoonData.Repo
  alias SplatoonData.Weapons.{Tag, Weapon, TagWeapon}

  defmodule SearchQuery do
    defstruct [:only, :except, :under, :over]
    @type t :: %SearchQuery{
      only: list | nil,
      except: list | nil,
      under: integer | nil,
      over: integer | nil
    }
  end

  @keys ~w(のみ　以外　以下　以上)

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_weapons(:all) do
    Repo.all(Weapon)
  end

  # TODO: このコード最悪なのでなんとかしたい、SQLよくわからん
  def list_weapons(sq = %SearchQuery{}) do
    only = sq.only || []
    except = sq.except || []
    under = sq.under || 100
    over = sq.over || 0

    only_tw_ids =
      from(tw in TagWeapon,
        join: t in assoc(tw, :tag),
        join: w in assoc(tw, :weapon),
        where: t.name in ^only,
        select: w.id)
      |> Repo.all
    only_w_ids =
      from(w in Weapon,
        where: w.name in ^only,
        select: w.id)
      |> Repo.all
    except_tw_ids =
      from(tw in TagWeapon,
        join: t in assoc(tw, :tag),
        join: w in assoc(tw, :weapon),
        where: t.name in ^except,
        select: w.id)
      |> Repo.all
    except_w_ids =
      from(w in Weapon,
        where: w.name in ^except,
        select: w.id)
      |> Repo.all

    query = 
      if (only_tw_ids ++ only_w_ids) == [] do
        from w in Weapon,
          where: not(w.id in ^(except_tw_ids ++ except_w_ids)),
          where: w.get_rank <= ^under,
          where: w.get_rank >= ^over
      else
        from w in Weapon,
          where: w.id in ^(only_tw_ids ++ only_w_ids),
          where: not(w.id in ^(except_tw_ids ++ except_w_ids)),
          where: w.get_rank <= ^under,
          where: w.get_rank >= ^over
      end
    
    Repo.all(query)
  end

  def list_weapons(opts) do
    opts |> options_to_query |> list_weapons
  end

  @doc """
  `"20　以下　スロッシャー　以外"` のような文字列を`SearchQuery`構造体に変換する""

  ## Example

      iex> "20　以下　スロッシャー　以外" |> options_to_query
      iex> ["20", "以下", "スロッシャー", "以外"] |> options_to_query
      %SearchQuery{
        over: nil,
        under: 20,
        except: ["スロッシャー"],
        only: nil
      }

  """
  @spec options_to_query(String.t | list(String.t)) :: SearchQuery.t
  def options_to_query(opts) when is_binary(opts) do
    opts
    |> String.split
    |> options_to_query()
  end

  def options_to_query(opts) when is_list(opts) do
    opts |> parse_opts
  end

  defp parse_opts(opts) when is_list(opts) do
    parse_opts(opts, [], [])
  end

  defp parse_opts([val | tail], tmp_list, result)
  when is_list(tmp_list) and is_list(result) do
    if Enum.member?(@keys, val) do
      # [{"a", 1}, {"b", 2}, {"a", 3}...] に変換
      parse_opts(tail, [], [{val, tmp_list} | result])
    else
      parse_opts(tail, [val | tmp_list], result)
    end
  end

  defp parse_opts([], tmp_list, result)
  when is_list(tmp_list) and is_list(result) do
    # tmp_listの残りがあったらエラーで終了
    unless tmp_list == [] do
      IO.inspect tmp_list
      raise "tmp_listに余りがあります。コマンドミスの可能性が高いです"
    end
    # resultを同一キーで結合
    map =
      result
      |> Enum.group_by(fn {w, _} -> w end, fn {_, v} -> v end)
      |> Enum.map(fn
        {k, v} when is_list(v) -> {k, v |> List.flatten |> Enum.uniq}
        {k, v} -> {k, v}
      end)
      |> Enum.into(%{})

    %SearchQuery{
      only: Map.get(map, "のみ"),
      except: Map.get(map, "以外"),
      under: Map.get(map, "以下") |> integerize_under(),
      over: Map.get(map, "以上") |> integerize_over()
    }
  end

  defp integerize_under(str) do
    if str do
      str |> Enum.map(&String.to_integer/1) |> Enum.min
    else
      nil
    end
  end

  defp integerize_over(str) do
    if str do
      str |> Enum.map(&String.to_integer/1) |> Enum.max
    else
      nil
    end
  end
end