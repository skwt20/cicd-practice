# 解答例：3-2. イベントによって実行する step を変える

## 解答

`.github/workflows/3-2-event-condition.yml` を以下の内容で新規に作成します。

```yaml
name: 3-2 event condition

on:
  pull_request:
  workflow_dispatch:

jobs:
  hello:
    runs-on: ubuntu-latest
    steps:
      - name: Run on pull_request
        if: github.event_name == 'pull_request'
        run: echo "run on pull_request"
      - name: Run on workflow_dispatch
        if: github.event_name == 'workflow_dispatch'
        run: echo "run on workflow_dispatch"
```

## 解説

- `on` に `pull_request` と `workflow_dispatch` を両方書くことで、Pull Request と手動実行の両方をトリガーにできます。
- `github.event_name` で、workflow を起動したイベントの名前を参照できます。
- `pull_request` で起動した場合は `github.event_name` が `'pull_request'` になります。
- `workflow_dispatch`（手動実行）で起動した場合は `github.event_name` が `'workflow_dispatch'` になります。
- それぞれの `if` 条件が異なるため、イベントに応じて実行される step が切り替わります。

---

[目次に戻る](../../README.md)
