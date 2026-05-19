# 5-1. CD workflow のトリガーを設定する

> **前提**: この課題は [Step 4: 実践編（CI）](../04-ci/README.md) を完了していることを前提とします。

Step 4 では、Pull Request をきっかけに CI を実行する workflow を構築しました。

CD では、CI を通過したコードが main ブランチにマージされたタイミングで apply を実行できるようにします。そのために、**main ブランチへの `push` イベント**をトリガーに追加します。

この課題では、既存の `terraform.yml` のトリガー設定を変更します。

> 補足:
>
> apply のタイミングはプロジェクトによって異なります。たとえばマージ前に apply するフローもあり、plan は通っても apply で失敗するケース（例: S3 バケット名の重複）を main に取り込む前に検出できます。一方、main ブランチと実インフラの状態が一時的に乖離するリスクもあります。
>
> このプラクティスでは「マージ = apply」というシンプルな構成にしています。実運用ではプロジェクトの方針に合わせてフローを設計してください。

## プラクティス

`terraform.yml` のトリガーを、以下の条件を満たすように更新してください。

条件は次のとおりです。

- 既存のトリガー（`pull_request`、`workflow_dispatch`）はそのまま残す
- トリガーに `push` を追加する
  - `push` は `main` ブランチへの push のときだけ実行する

> ヒント:
>
> - `on` には複数のイベントを並べて指定できます
> - ブランチ条件の指定方法は Step 3（3-3）を参照してください

> 必要に応じて、次の公式ドキュメントを参照してください。
>
> - [Events that trigger workflows](https://docs.github.com/en/actions/using-workflows/events-that-trigger-workflows)

## 確認

- 変更を feature ブランチに push し、main ブランチへの Pull Request を作成する
  - `pull_request` イベントによって workflow が実行されることを確認する
- Pull Request を main ブランチにマージする
  - `push` イベントによって workflow が実行されることを確認する
- Actions 画面から手動実行できることを確認する

---

次のプラクティス：[5-2. plan と apply を job 分割する](./5-2-job-split.md)
