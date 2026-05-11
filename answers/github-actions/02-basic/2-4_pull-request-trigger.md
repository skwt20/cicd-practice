# 解答例：2-4. Pull Request をきっかけに workflow を実行する

## 解答

`.github/workflows/hello.yml` を以下の内容に修正します。

```yaml
name: Hello GitHub Actions

on:
  pull_request:

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

- `on` を `push` から `pull_request` に変更することで、Pull Request の作成・更新をきっかけに workflow が実行されるようになります。
- `push` の記述を削除しているため、単純な push では workflow は実行されません。
- 動作確認は、新しいブランチを作成して push し、Pull Request を作成することで行えます。

---

[目次に戻る](../../README.md)
