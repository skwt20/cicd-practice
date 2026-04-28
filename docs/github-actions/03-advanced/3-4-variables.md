# 3-4. variables を使って値を外部で管理する

GitHub Actions では、workflow 内で使う値を変数として管理できます。

variables は機密情報ではない設定値を扱う用途に向いており、`vars` context から参照できます。

この課題では、workflow 内に直接文字列を書くのではなく、variable として参照する形を試します。

## プラクティス

次の条件を満たす workflow を `3-4-variables.yml` として新規に作成してください。

条件は次のとおりです。

- workflow の起動条件は `workflow_dispatch` にする
- リポジトリの Actions variables に `SAMPLE_MESSAGE` という名前の variable を作成する
- workflow の step でその variable を参照する
- `echo` で variable の値を出力する

> ヒント:
>
> - variable は GitHub のリポジトリ設定画面から追加できます
> - workflow の中では `vars` context を使って参照します

> 必要に応じて、次の公式ドキュメントを参照してください。
>
> - [Store information in variables](https://docs.github.com/actions/learn-github-actions/variables)
> - [Variables reference](https://docs.github.com/en/actions/reference/workflows-and-actions/variables)

## 確認

- 変更を push し、Actions から手動実行する
- 実行ログに variable の値が表示されることを確認する

---

次のプラクティス：[3-5. secrets を使って機密情報を扱う](./3-5-secrets.md)
