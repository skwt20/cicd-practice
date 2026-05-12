# 解答例：3-3. ブランチによって実行する step を変える

## 解答

`.github/workflows/3-3-branch-condition.yml` を以下の内容で新規に作成します。

```yaml
name: 3-3 branch condition

on:
  workflow_dispatch:

jobs:
  hello:
    runs-on: ubuntu-latest
    steps:
      - name: Run on main
        if: github.ref == 'refs/heads/main'
        run: echo "run on main"
```

## 解説

- `github.ref` で、workflow が動いているブランチやタグの参照名を取得できます。
- ブランチの場合、`refs/heads/<ブランチ名>` という形式になります。
- main ブランチの場合は `github.ref == 'refs/heads/main'` という条件になります。
- main 以外のブランチで手動実行すると `Run on main` の step はスキップされます。
- main ブランチで手動実行すると `Run on main` の step が実行されます。

---

[目次に戻る](../../README.md)
