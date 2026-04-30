# 3-2. イベントによって実行する step を変える

> **前提**: この課題は [3-1. `if` で step の実行条件を分ける](./3-1-if.md) を完了していることを前提とします。

GitHub Actions では、workflow を起動したイベントの情報を参照できます。

3-1 では job の実行結果を `if` の条件にしましたが、`if` の条件にはイベント種別も設定できます。起動したイベントの種別（`pull_request` なのか `workflow_dispatch` なのかなど）を条件にして、実行する step を分けることができます。イベント種別は `github.event_name` で参照できます。

この課題では、イベントによって異なる step が実行されるようにします。

## プラクティス

次の条件を満たす workflow を `3-2-event-condition.yml` として新規に作成してください。

条件は次のとおりです。

- workflow の起動条件に `pull_request` と `workflow_dispatch` の両方を設定する
- `pull_request` のときだけ実行される step を 1 つ定義する
- その step では `echo "run on pull_request"` を実行する
- `workflow_dispatch` のときだけ実行される step を 1 つ定義する
- その step では `echo "run on workflow_dispatch"` を実行する

> ヒント:
>
> - イベント名は `github` context から参照できます

> 必要に応じて、次の公式ドキュメントを参照してください。
>
> - [Events that trigger workflows](https://docs.github.com/actions/using-workflows/events-that-trigger-workflows)
> - [Contexts reference](https://docs.github.com/en/actions/reference/workflows-and-actions/contexts)

## 確認

- 変更を push し、Actions 画面から workflow を手動実行する
- `run on workflow_dispatch` だけが実行されることを確認する
- Pull Request を作成して workflow を実行する
- `run on pull_request` だけが実行されることを確認する

---

次のプラクティス：[3-3. ブランチによって実行する step を変える](./3-3-branch-condition.md)
