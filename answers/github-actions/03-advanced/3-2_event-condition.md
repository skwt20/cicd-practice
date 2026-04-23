# 解答例：3-2. イベントによって実行する step を変える

## 解答

`.github/workflows/hello.yml` を以下の内容に修正します。

```yaml
name: Hello GitHub Actions

on:
  push:
  workflow_dispatch:

jobs:
  job1:
    runs-on: ubuntu-latest
    steps:
      - name: Run first job
        run: echo "first job"

  job2:
    runs-on: ubuntu-latest
    needs: job1
    steps:
      - name: Run second job
        run: echo "second job"
      - name: Conditional step
        if: needs.job1.result == 'success'
        run: echo "conditional step"
      - name: Run on push
        if: github.event_name == 'push'
        run: echo "run on push"
      - name: Run on workflow_dispatch
        if: github.event_name == 'workflow_dispatch'
        run: echo "run on workflow_dispatch"
```

## 解説

- `github.event_name` で、workflow を起動したイベントの名前を参照できます。
- `push` で起動した場合は `github.event_name` が `'push'` になります。
- `workflow_dispatch`（手動実行）で起動した場合は `github.event_name` が `'workflow_dispatch'` になります。
- それぞれの `if` 条件が異なるため、イベントに応じて実行される step が切り替わります。
- `github` は GitHub Actions が提供する context の 1 つで、実行環境に関する情報を持っています。
