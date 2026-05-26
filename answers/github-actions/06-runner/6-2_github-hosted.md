# 解答例：6-2. GitHub-hosted runner で環境を確認する

## 解答

`.github/workflows/6-2-runner-check.yml` の内容は以下のとおりです。

```yaml
name: runner-check

on:
  workflow_dispatch:

jobs:
  runner-check:
    runs-on: ubuntu-latest
    steps:
      - name: Show hostname
        run: hostname

      - name: Show user
        run: whoami

      - name: Show OS info
        run: cat /etc/os-release

      - name: Show RUNNER_OS
        run: echo $RUNNER_OS
```

## 解説

- `workflow_dispatch` のみを指定しているため、Actions 画面から手動でのみ実行できます
- `cat /etc/os-release` は OS のバージョン情報を出力します。`ubuntu-latest` が実際にどのバージョンにマッピングされているかを確認できます
- `RUNNER_OS` は GitHub Actions が自動的に設定する環境変数です。`run:` ステップ内では `echo $RUNNER_OS` で参照できます（`${{ env.RUNNER_OS }}` ではありません）
- 複数回実行すると `hostname` の出力が毎回変わることを確認できます。これは GitHub-hosted runner が毎回クリーンな仮想マシンとして起動することを示しています

---

[目次に戻る](../../README.md)
