# 解答例：3-6. artifact を保存する

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
      - name: Run on main
        if: github.ref == 'refs/heads/main'
        run: echo "run on main"
      - name: Print variable
        run: echo "${{ vars.SAMPLE_MESSAGE }}"
      - name: Use secret
        env:
          MY_SECRET: ${{ secrets.SAMPLE_SECRET }}
        run: echo "secret is set"
      - name: Create result file
        run: echo "workflow completed" > result.txt
      - name: Upload artifact
        uses: actions/upload-artifact@v4
        with:
          name: result
          path: result.txt
```

## 解説

- `echo "workflow completed" > result.txt` で `result.txt` を作成し、文字列を書き込んでいます。
- `actions/upload-artifact@v4` は GitHub が公式に提供する Action で、ファイルを artifact として保存できます。
- `uses` を使うと、GitHub Marketplace に公開された Action を workflow の中で利用できます。
- `name` に artifact の表示名、`path` に保存するファイルのパスを指定します。
- 保存した artifact は GitHub の Actions 実行結果画面の **Artifacts** セクションからダウンロードできます。
