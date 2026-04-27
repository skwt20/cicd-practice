# 解答例：2-3. 複数の step を定義する

## 解答

`.github/workflows/hello.yml` を以下の内容に修正します。

```yaml
name: Hello GitHub Actions

on:
  push:

jobs:
  hello:
    runs-on: ubuntu-latest
    steps:
      - name: Step 1
        run: echo "step1"
      - name: Step 2
        run: echo "step2"
```

## 解説

- `steps` の下に `-` で始まるブロックを並べることで、複数の step を定義できます。
- step は上から順番に実行されます。
- `name` は省略可能ですが、指定しておくと Actions の実行ログで確認しやすくなります。
- GitHub の Actions タブから実行ログを開くと、`step1` → `step2` の順に出力されていることを確認できます。
