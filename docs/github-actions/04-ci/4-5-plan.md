# 4-5. terraform plan で変更内容を確認する

> **前提**: この課題は [4-4. terraform init / validate で構成を検証する](./4-4-validate.md) を完了していることを前提とします。

`terraform plan` は、現在のコードを適用した場合にインフラにどのような変更が加わるかを事前に確認するコマンドです。実際にはリソースを作成・変更しません。

CI に `plan` を組み込むことで、変更内容をレビュー前に確認できるようになります。

また、`plan` の結果をファイルに保存（`-out` オプション）しておくと、plan 結果をファイルとして扱えるようになります。  
保存した plan ファイルを `apply` で利用する方法は Step 5 で扱います。

## プラクティス

`terraform-ci.yml` に、以下の step を追加してください。

条件は次のとおりです。

- `terraform plan` を実行する step を追加する
  - 実行ディレクトリは `terraform/` にする
  - `bucket_name` 変数を `-var` で渡す（値は `vars.BUCKET_NAME` から参照する）
  - `BUCKET_NAME` の値は `日付-作業者名-cicd-practice` の形式で設定する（例: `20240101-yamada-cicd-practice`）
  - plan 結果を `-out=tfplan` でファイルに保存する
- step の順番は `fmt → init → validate → plan` にする

> ヒント:
>
> - GitHub の Web UI で `BUCKET_NAME` variable を事前に設定してください
> - `-out` オプションを使うと、plan 結果をファイルとして保存できます

> 必要に応じて、次の公式ドキュメントを参照してください。
>
> - [terraform plan](https://developer.hashicorp.com/terraform/cli/commands/plan)

## 確認

- 変更を push し、Actions から手動実行する
- `terraform plan` が成功することを確認する
- CI のログに作成予定のリソース（S3 バケット）が表示されることを確認する
- `terraform/main.tf` に存在しない引数（例: `invalid_arg = "test"`）を追加して push し、`plan` で CI が失敗することを確認する
- 確認後、追加した引数を元に戻して push する

---

次のプラクティス：[4-6. Pull Request で CI を実行する](./4-6-pr-trigger.md)
