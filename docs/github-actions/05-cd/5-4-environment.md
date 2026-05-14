# 5-4. GitHub Environments で apply 前の承認を設定する

> **前提**: この課題は [5-3. Pull Request 時は apply をスキップする](./5-3-skip-on-pr.md) を完了していることを前提とします。

インフラへの変更は、意図したタイミングでのみ実行されるべきです。`push` をきっかけに自動で apply が走ると、想定外の変更がすぐに本番環境に反映されるリスクがあります。

GitHub Environments を使うと、特定の job が実行される前に**承認者による手動確認**を必須にできます。この仕組みを apply job に設定することで、「plan は自動で実行するが、apply は承認されたときだけ実行する」という構成を実現できます。

この課題は、**GitHub の Settings 画面での操作と workflow ファイルの編集の両方**が必要です。

## プラクティス

以下の手順で、apply 前の承認フローを設定してください。

### 1. GitHub Environments の設定

リポジトリの Settings > Environments から Environment を作成してください。

条件は次のとおりです。

- Environment 名は `production` にする
- Required reviewers に自分自身を追加する

### 2. workflow ファイルの編集

`apply` job に、作成した Environment を使用する設定を追加してください。

条件は次のとおりです。

- `apply` job に `environment` を指定する
  - Environment 名は `production` にする

> ヒント:
>
> - `environment` は job レベルのキーです
> - Environments の承認フローが有効になると、job の開始前に承認待ちの状態になります

必要に応じて、次の公式ドキュメントを参照してください。

- [Using environments for deployment](https://docs.github.com/en/actions/managing-workflow-runs-and-deployments/managing-deployments/managing-environments-for-deployment)
- [Workflow syntax - jobs.<job_id>.environment](https://docs.github.com/en/actions/writing-workflows/workflow-syntax-for-github-actions#jobsjob_idenvironment)

## 確認

- main ブランチに push する（または Actions から手動実行する）
- `plan` job が完了した後、`apply` job が承認待ちの状態で止まることを確認する
- GitHub の Environments 画面から承認を行い、`apply` job が実行されることを確認する

---

次のプラクティス：[5-5. plan 結果をダウンロードして terraform apply を実行する](./5-5-apply.md)
