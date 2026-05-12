# 4-2. CI から Terraform を実行できるようにする

> **前提**: この課題は [4-1. Terraform コードを準備する](./4-1-setup-terraform.md) を完了していることを前提とします。

CI から Terraform コマンドを実行するには、まず実行環境に Terraform をインストールする必要があります。

`hashicorp/setup-terraform` は HashiCorp が公式に提供する Action で、指定したバージョンの Terraform を CI 環境にセットアップできます。  
これは 3-7 で学んだ `actions/upload-artifact` と同様に、`uses` で呼び出す外部 Action です。

また、AWS に接続するには認証情報が必要です。これは Step 3 で学んだ `secrets` を使って安全に管理します。  
Terraform のバージョンは `variables`（`vars` context）で管理することで、workflow を変更せずに外部から更新できます。

この課題では、AWS 認証情報を workflow に設定しますが、AWS への接続確認までは行いません。  
実際に AWS 認証情報が正しく利用できるかどうかは、後続の `terraform plan` を実行する課題で確認します。

## プラクティス

次の条件を満たす workflow を `terraform-ci.yml` として新規に作成してください。

条件は次のとおりです。

- workflow の起動条件は `workflow_dispatch` にする
- `actions/checkout@v4` でコードをチェックアウトする
- `hashicorp/setup-terraform@v3` で Terraform をセットアップする
  - Terraform のバージョンは `vars.TF_VERSION` から参照する
- `terraform version` を実行してバージョンを確認する
- AWS 認証情報を環境変数としてセットする
  - `AWS_ACCESS_KEY_ID`: `secrets.AWS_ACCESS_KEY_ID` から参照する
  - `AWS_SECRET_ACCESS_KEY`: `secrets.AWS_SECRET_ACCESS_KEY` から参照する

> ヒント:
>
> - `uses` で外部 Action を呼び出し、`with` でパラメータを指定します（3-7 と同様）
> - AWS 認証情報は job レベルの `env` にまとめて書くと、すべての step で参照できます
> - GitHub の Web UI で以下を事前に設定してください（3-4・3-5 参照）
>   - Variables: `TF_VERSION`（例: `1.9.0`）
>   - Secrets: `AWS_ACCESS_KEY_ID`、`AWS_SECRET_ACCESS_KEY`

> 必要に応じて、次の公式ドキュメントを参照してください。
>
> - [hashicorp/setup-terraform](https://github.com/hashicorp/setup-terraform)
> - [actions/checkout](https://github.com/actions/checkout)
> - [Workflow syntax for GitHub Actions - jobs.<job_id>.env](https://docs.github.com/ja/actions/reference/workflows-and-actions/workflow-syntax#jobsjob_idenv)

## 確認

- 変更を push し、Actions から手動実行する
- workflow が正常に完了することを確認する
- `terraform version` の出力に `vars.TF_VERSION` で設定したバージョンが表示されることを確認する

> **補足: `TF_VERSION` を未設定の場合**
>
> `vars.TF_VERSION` が未設定のとき、`hashicorp/setup-terraform` はデフォルトバージョンをインストールするため workflow は成功します。  
> ただし、「設定したバージョンと一致するか」の確認ができなくなるため、この課題では事前に `TF_VERSION` を設定しておくことを推奨します。

---

次のプラクティス：[4-3. terraform fmt でフォーマットを確認する](./4-3-fmt.md)
