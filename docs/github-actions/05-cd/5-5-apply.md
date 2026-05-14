# 5-5. plan 結果をダウンロードして terraform apply を実行する

> **前提**: この課題は [5-4. GitHub Environments で apply 前の承認を設定する](./5-4-environment.md) を完了していることを前提とします。

`apply` job は `plan` job とは別のランナーで実行されるため、`plan` job で生成した `tfplan` ファイルをそのまま参照することはできません。

Step 4（4-7）では `tfplan` ファイルを artifact として保存しました。この課題では、`actions/download-artifact` を使ってその artifact を取得し、`terraform apply` に渡します。

これにより、**plan した内容だけを apply する**という安全な構成を実現できます。

## プラクティス

`apply` job の steps を、以下の条件を満たすように実装してください。

条件は次のとおりです。

- `actions/checkout@v4` で checkout する
- `aws-actions/configure-aws-credentials@v4` で AWS 認証を設定する（`plan` job と同じ設定でよい）
- `hashicorp/setup-terraform@v3` で Terraform をセットアップする（`plan` job と同じ設定でよい）
- `terraform init` を実行する
  - `working-directory` は `terraform` にする
- `actions/download-artifact@v4` を使って `tfplan` artifact をダウンロードする
  - artifact の名前は `tfplan` にする
  - ダウンロード先は `terraform` ディレクトリにする
- `terraform apply tfplan` を実行する
  - `working-directory` は `terraform` にする

> ヒント:
>
> - `download-artifact` は `upload-artifact` とは逆に、保存した artifact を取得するための Action です
> - `path` にダウンロード先のディレクトリを指定します
> - `terraform apply <planfile>` は、指定した plan ファイルの内容だけを apply します。確認プロンプトは表示されません

必要に応じて、次の公式ドキュメントを参照してください。

- [Store and share data with workflow artifacts](https://docs.github.com/en/actions/tutorials/store-and-share-data)
- [Terraform apply - Passing a plan file](https://developer.hashicorp.com/terraform/cli/commands/apply#passing-a-plan-file)

## 確認

- main ブランチに push する（または Actions から手動実行する）
- `plan` job が正常に完了することを確認する
- `apply` job が承認待ちの状態で止まることを確認する
- 承認を行い、`apply` job が実行されることを確認する
  - artifact のダウンロードが実行されることを確認する
  - `terraform apply` が実行されることを確認する
  - apply が完了し、AWS リソースが作成されることを確認する

---

[Step 5 トップに戻る](./README.md)
