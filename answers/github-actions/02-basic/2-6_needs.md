# 解答例：2-6. `needs` で job の実行順を制御する

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
      - name: Run first job
        run: echo "first job"

  job2:
    runs-on: ubuntu-latest
    needs: job1
    steps:
      - name: Run second job
        run: echo "second job"
```

## 解説

- `job2` に `needs: job1` を追加することで、`job1` が完了してから `job2` が実行されるようになります。
- `needs` を指定しない場合は並列実行ですが、`needs` を指定することで順序が保証されます。
- `job1` が失敗した場合、`job2` は実行されません。
- GitHub の Actions タブから実行結果を開くと、`job1` → `job2` の順に実行されていることを確認できます。
