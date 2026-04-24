# 解答例：3-5. secrets を使って機密情報を扱う

## 解答

### 1. リポジトリに secret を作成する

GitHub のリポジトリページから **Settings > Secrets and variables > Actions > Secrets タブ** を開き、以下の secret を作成します。

- Name: `SAMPLE_SECRET`
- Value: 任意の文字列（例：`my-secret-value`）

### 2. workflow を新規に作成する

`.github/workflows/3-5-secrets.yml` を以下の内容で新規に作成します。

```yaml
name: 3-5 secrets

on:
  workflow_dispatch:

jobs:
  hello:
    runs-on: ubuntu-latest
    steps:
      - name: Use secret
        env:
          MY_SECRET: ${{ secrets.SAMPLE_SECRET }}
        run: echo "secret is set"
```

## 解説

- `secrets` context を使うと、リポジトリに設定した Actions secrets を参照できます。
- secret の値を `env` で環境変数として受け取り、step の中で利用します。
- secret の値を直接 `echo` するとマスクされますが、意図しない漏洩を防ぐために値そのものを出力しないようにしてください。
- `echo "secret is set"` のように、値を使ったことを示すメッセージを出力するのが一般的なパターンです。
