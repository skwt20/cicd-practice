# 5-3. Pull Request 時は apply をスキップする

> **前提**: この課題は [5-2. plan と apply を job 分割する](./5-2-job-split.md) を完了していることを前提とします。

CD では、`push` や `workflow_dispatch` のタイミングで apply を実行したいですが、Pull Request 時は plan だけを確認できれば十分です。apply が PR ごとに実行されてしまうと、意図しないインフラ変更が発生するリスクがあります。

この課題では、Step 3（3-1、3-2）で学んだ `if` とイベント条件を使って、Pull Request イベントのときだけ `apply` job をスキップするようにします。

## プラクティス

`apply` job に、以下の条件を満たすように変更してください。

条件は次のとおりです。

- `apply` job は `pull_request` イベントのときは実行しない
- `push` または `workflow_dispatch` のときだけ実行する

> ヒント:
>
> - job レベルに `if` を指定できます
> - `github.event_name` でイベント種別を参照できます（Step 3（3-2）参照）
> - 「pull_request でないとき」という条件で書くと、push と workflow_dispatch の両方をまとめて扱えます

必要に応じて、次の公式ドキュメントを参照してください。

- [Expressions](https://docs.github.com/en/actions/concepts/workflows-and-actions/expressions)
- [Context variables](https://docs.github.com/en/actions/writing-workflows/choosing-what-your-workflow-does/accessing-contextual-information-about-workflow-runs)

## 確認

- main ブランチへの Pull Request を作成する
  - `plan` job は実行されることを確認する
  - `apply` job はスキップされることを確認する
- Actions から手動実行する（または main ブランチに push する）
  - `plan` job と `apply` job の両方が実行されることを確認する

---

次のプラクティス：[5-4. GitHub Environments で apply 前の承認を設定する](./5-4-environment.md)
