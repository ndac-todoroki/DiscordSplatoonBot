# DiscordSplatoonBot

Splatoon2を便利にするイカしたBot！ …を目指しています。Discordで動きます。  
主にプラベを便利にする機能を追加していきます。

## 招待 / Invite
[このリンクをクリックするとDiscordの招待ページが開きます。](https://discordapp.com/oauth2/authorize?client_id=343587911540670474&scope=bot&permissions=36789312)  
目的のサーバー(ギルド)が選べない場合は、あなたに招待権限がないことが考えられます。  
サーバー(ギルド)の管理者に連絡してみてください！Botを動かすのに管理者権限はいらないので、招待してもらうだけで大丈夫です。

## 例 / Example
![ブキランダム](https://image.ibb.co/kA4vUv/Shutter_20170807_0001b.png)

## 使い方 / How To Use in Discord?
`？ヘルプ` コマンドで簡易なヘルプを見ることができます。
詳細はWikiで↓
[Wiki#コマンド一覧](https://github.com/ndac-todoroki/DiscordSplatoonBot/wiki/%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89---Commands)

## インストール / Installation

このBotはオープンソースで、MITライセンスに基づいて再利用可能です。手元に動作環境を用意すれば、別のAPIキーを用意して動かすことが可能です。  
This bot is MIT-licenced.

- Install Erlang and Elixir. Since one of the libraries require old runtimes, I recommend using [asdf](https://github.com/asdf-vm/asdf).
  - Erlang 19.x and Elixir 1.4.4 must be used for this application. If you use asdf, there's a [.tool_versions](.tool_versions) file that specifies that.
- Inside [apps/discord_splatoon_bot/config](apps/discord_splatoon_bot/config), copy [_sample.exs](apps/discord_splatoon_bot/config/_sample.exs) to `dev.exs` and/or `prod.exs`, and fill in the values.
- Go back to the project root, and execute these commands:
  - `mix deps.get`
 - Go into [apps/splatoon_data][apps/splatoon_data] and execute these commands (prefix each with `MIX_ENV=prod` if prod mode):
   - `mix ecto.create`
   - `mix ecto.reset`  this will insert seed data
 - Go back to project root, and this command will run the bot with Elixir console.
   - `iex -S mix`
 - Do `mix run --no-halt` to keep run it as daemon.
 
 ## Contribution
 
 Feel free to post issues or Pull Requests, but please check if there are no previously posted same problems.  
 If you're not shure, then post it!  
 Both English and 日本語 is OK!
