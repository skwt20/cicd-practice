# 解答例：2-2. `runs-on` で実行環境を指定する

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
      - name: Say hello
        run: echo "Hello, GitHub Actions"
```

## 解説

- `runs-on: ubuntu-latest` を job に追加することで、Ubuntu の最新環境で job が実行されます。
- `runs-on` は job ごとに指定が必要です。
- push 後に GitHub の Actions タブを開くと、workflow の実行結果を確認できます。

---

[目次に戻る](../../README.md)
