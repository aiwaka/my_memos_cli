# 簡易コマンドラインメモツール

Vim を使用してターミナルから簡単なメモ書ける.

## インストール

1. 適当なディレクトリで`git clone git@github.com:littleIkawa/my_memos_cli.git memos`を実行（`(dir)`とする）.
1. `~/.zshrc`などに`alias memos=(dir)/memos.sh`を追加
1. `memos.sh`の`MEMOS_STORAGE_DIR`変数を`(dir)`に書き換える. 最後に`/`を付けなければならない.
1. `source ~/.zshrc`（など）
1. `memos`コマンドで使えるようになる.

## 仕様

`-h`でヘルプ表示. 書いてあるとおり.
`-e`での表示には`less`, 編集には`vi`を使っているのでインストールされていないと使えない.
