# 解答例：2-5. 複数の job を作る

## 解答

`.github/workflows/hello.yml` を以下の内容に修正します。

```yaml
name: Hello GitHub Actions

on:
  push:

jobs:
  job1:
    runs-on: ubuntu-latest
    steps:
      - name: Run job1
        run: echo "job1"

  job2:
    runs-on: ubuntu-latest
    steps:
      - name: Run job2
        run: echo "job2"
```

## 解説

- 2-4 で `pull_request` に変更したトリガーを `push` に戻しています。
- `jobs` の下に複数の job を並べることで、複数の job を定義できます。
- 依存関係（`needs`）を指定しない場合、`job1` と `job2` は**並列**に実行されます。
- GitHub の Actions タブから実行結果を開くと、2 つの job が同時に実行されていることを確認できます。
