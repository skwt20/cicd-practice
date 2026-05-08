# Step 4: 実践編（CI）

このステップでは、Step 2・Step 3 で学んだ GitHub Actions の知識を活かして、**Terraform の CI を実際に構築**します。

CI（継続的インテグレーション）とは、コードの変更をリポジトリに取り込む前に自動で検証を行う仕組みです。Terraform においては、コードのフォーマット確認・構成の検証・変更内容の確認を自動化することで、誤ったインフラ変更をメインブランチに混入させるリスクを下げられます。

このステップでは、次のような要素を扱います。

- **Terraform のセットアップ**：CI 環境に Terraform をインストールし、AWS に接続できるようにします
- **コードの検証**：`terraform fmt`・`terraform validate` でコードの品質を確認します
- **変更内容の確認**：`terraform plan` でインフラへの変更内容を事前に確認します
- **Pull Request 連携**：PR をきっかけに CI を自動実行し、マージ前に検証を完了させます
- **plan 結果の保存**：`artifact` を使って plan 結果を保存し、後から参照できるようにします

> 進め方：
>
> 各課題では、その課題で確認したい内容だけを含む workflow を新しいファイルとして作成してください。
> Terraform コードは、このリポジトリの `terraform/` ディレクトリを使います。

このプラクティスでは、Terraform backend は local backend を使用します。  
S3 backend などの remote backend は扱わず、CI 上で Terraform の `fmt` / `validate` / `plan` を実行する流れを確認することに集中します。

## プラクティス一覧

| #   | タイトル                                                           |
| --- | ------------------------------------------------------------------ |
| 4-1 | [Terraform コードを準備する](./4-1-setup-terraform.md)             |
| 4-2 | [CI から Terraform を実行できるようにする](./4-2-run-terraform.md) |
| 4-3 | [terraform fmt でフォーマットを確認する](./4-3-fmt.md)             |
| 4-4 | [terraform init / validate で構成を検証する](./4-4-validate.md)    |
| 4-5 | [terraform plan で変更内容を確認する](./4-5-plan.md)               |
| 4-6 | [Pull Request で CI を実行する](./4-6-pr-trigger.md)               |
| 4-7 | [plan 結果を artifact として保存する](./4-7-artifact.md)           |
