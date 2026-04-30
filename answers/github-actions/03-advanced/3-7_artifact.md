# 解答例：3-7. artifact を保存する

## 解答

`.github/workflows/3-7-artifact.yml` を以下の内容で新規に作成します。

```yaml
name: 3-7 artifact

on:
  workflow_dispatch:

jobs:
  hello:
    runs-on: ubuntu-latest
    steps:
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
