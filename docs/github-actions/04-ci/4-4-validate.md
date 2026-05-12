# 4-4. terraform init / validate で構成を検証する

> **前提**: この課題は [4-3. terraform fmt でフォーマットを確認する](./4-3-fmt.md) を完了していることを前提とします。

`terraform init` は Terraform の初期化コマンドです。provider プラグインのダウンロードや backend の設定を行います。CI で `terraform validate` や `terraform plan` を実行する前に必ず必要です。

`terraform validate` はコードの構文や設定の整合性を検証するコマンドです。AWS API コールは行わず、コードレベルの問題を検出できます。

## プラクティス

`terraform-ci.yml` に、以下の step を追加してください。

条件は次のとおりです。

- `terraform init` を実行する step を追加する
  - 実行ディレクトリは `terraform/` にする
- `terraform validate` を実行する step を追加する
  - 実行ディレクトリは `terraform/` にする
- step の順番は `fmt → init → validate` にする

> ヒント:
>
> - `terraform init` は provider のダウンロードと初期化を行います。AWS API コールは行いません（job レベルの `env` に設定した AWS 認証情報は、後続の `plan` などで自動的に参照されます）
> - `terraform validate` は `init` の後に実行してください

> 必要に応じて、次の公式ドキュメントを参照してください。
>
> - [terraform init](https://developer.hashicorp.com/terraform/cli/commands/init)
> - [terraform validate](https://developer.hashicorp.com/terraform/cli/commands/validate)

## 確認

- 変更を push し、Actions から手動実行する
- `terraform init` と `terraform validate` が成功することを確認する
- `terraform/main.tf` に構文エラー（例: `}` を削除）を混入して push し、`validate` で CI が失敗することを確認する
- 確認後、構文エラーを元に戻して push する

---

次のプラクティス：[4-5. terraform plan で変更内容を確認する](./4-5-plan.md)
