# 4-2. CI から Terraform を実行できるようにする

> **前提**: この課題は [4-1. Terraform コードを準備する](./4-1-setup-terraform.md) を完了していることを前提とします。

CI から Terraform コマンドを実行するには、まず実行環境に Terraform をインストールする必要があります。

`hashicorp/setup-terraform` は HashiCorp が公式に提供する Action で、指定したバージョンの Terraform を CI 環境にセットアップできます。  
これは 3-7 で学んだ `actions/upload-artifact` と同様に、`uses` で呼び出す外部 Action です。

また、AWS に接続するには認証が必要です。Step 1 で設定した OIDC 認証を使います。  
Terraform のバージョンは `variables`（`vars` context）で管理することで、workflow を変更せずに外部から更新できます。

この課題では AWS 認証の設定を workflow に組み込みますが、AWS への接続確認は後続の `terraform plan` で行います。

## プラクティス

次の条件を満たす workflow を `terraform.yml` として新規に作成してください。

条件は次のとおりです。

- workflow の起動条件は `workflow_dispatch` にする
- OIDC 認証に必要な `permissions` を設定する
- `actions/checkout@v4` でコードをチェックアウトする
- `aws-actions/configure-aws-credentials` で AWS 認証を設定する
  - IAM ロールの ARN は `secrets.AWS_ROLE_ARN` から参照する
  - AWS リージョンは `vars.AWS_REGION` から参照する
- `hashicorp/setup-terraform@v3` で Terraform をセットアップする
  - Terraform のバージョンは `vars.TF_VERSION` から参照する
- `terraform version` を実行してバージョンを確認する

> ヒント:
>
> - OIDC 認証には `permissions` で `id-token: write` と `contents: read` が必要です（Step 1 参照）
> - `uses` で外部 Action を呼び出し、`with` でパラメータを指定します（3-7 と同様）
> - GitHub の Web UI で以下を事前に設定してください（3-4・3-5 参照）
>   - Variables: `TF_VERSION`（例: `1.9.0`）、`AWS_REGION`（例: `ap-northeast-1`）
>   - Secrets: `AWS_ROLE_ARN`（Step 1 で作成した IAM ロールの ARN）

> 必要に応じて、次の公式ドキュメントを参照してください。
>
> - [hashicorp/setup-terraform](https://github.com/hashicorp/setup-terraform)
> - [aws-actions/configure-aws-credentials](https://github.com/aws-actions/configure-aws-credentials)
> - [Configuring OpenID Connect in Amazon Web Services](https://docs.github.com/actions/deployment/security-hardening-your-deployments/configuring-openid-connect-in-amazon-web-services)

## 確認

- 変更を push し、Actions から手動実行する
- workflow が正常に完了することを確認する
- `terraform version` の出力に `vars.TF_VERSION` で設定したバージョンが表示されることを確認する

---

次のプラクティス：[4-3. terraform fmt でフォーマットを確認する](./4-3-fmt.md)
