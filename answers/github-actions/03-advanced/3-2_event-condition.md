# 解答例：3-2. イベントによって実行する step を変える

## 解答

`.github/workflows/hello.yml` を以下の内容に書き換えます。

```yaml
name: Hello GitHub Actions

on:
  push:
  workflow_dispatch:

jobs:
  hello:
    runs-on: ubuntu-latest
    steps:
      - name: Run on push
        if: github.event_name == 'push'
        run: echo "run on push"
      - name: Run on workflow_dispatch
        if: github.event_name == 'workflow_dispatch'
        run: echo "run on workflow_dispatch"
```

## 解説

- `on` に `push` と `workflow_dispatch` を両方書くことで、push と手動実行の両方をトリガーにできます。
- `github.event_name` で、workflow を起動したイベントの名前を参照できます。
- `push` で起動した場合は `github.event_name` が `'push'` になります。
- `workflow_dispatch`（手動実行）で起動した場合は `github.event_name` が `'workflow_dispatch'` になります。
- それぞれの `if` 条件が異なるため、イベントに応じて実行される step が切り替わります。
