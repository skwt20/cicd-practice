# 4-6. Pull Request で CI を実行する

> **前提**: この課題は [4-5. terraform plan で変更内容を確認する](./4-5-plan.md) を完了していることを前提とします。

ここまでは `workflow_dispatch`（手動実行）をトリガーにしてきました。実際の CI では、Pull Request をきっかけに自動で CI が実行されるのが一般的です。

この課題では、Step 3 で学んだ知識を組み合わせます。

- **3-2（イベント条件）**: `pull_request` イベントで CI を実行する
- **3-3（ブランチ条件）**: main ブランチへの PR のときだけ実行する
- **3-1（`if` 条件）**: `workflow_dispatch` で実行した場合だけ、確認メッセージを表示する

## プラクティス

4-5 で作成した workflow をベースに、`4-6-pr-trigger.yml` として新規に作成してください。

条件は次のとおりです。

- トリガーに `pull_request` を追加する（`workflow_dispatch` と両方）
  - `pull_request` は `main` ブランチへの PR のときだけ実行する（`branches: [main]`）
- `if` を使い、`workflow_dispatch` で実行された場合だけ実行される step を 1 つ追加する
  - その step では `echo "manual execution"` を実行する

> ヒント:
>
> - `on` に複数のトリガーを指定するには次のように書きます
>   ```yaml
>   on:
>     pull_request:
>       branches:
>         - main
>     workflow_dispatch:
>   ```
> - イベント種別は `github.event_name` で参照できます（3-2 参照）

> 必要に応じて、次の公式ドキュメントを参照してください。
>
> - [Events that trigger workflows](https://docs.github.com/actions/using-workflows/events-that-trigger-workflows)

## 確認

- 変更を push し、Actions から手動実行する
  - `manual execution` の step が実行されることを確認する
  - Terraform CI の全 step が成功することを確認する
- main ブランチへの Pull Request を作成する
  - CI が自動で実行されることを確認する
  - `manual execution` の step がスキップされることを確認する

---

次のプラクティス：[4-7. plan 結果を artifact として保存する](./4-7-artifact.md)
