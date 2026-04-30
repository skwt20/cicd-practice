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
        run: echo "$MY_SECRET"
```

## 解説

- `secrets` context を使うと、リポジトリに設定した Actions secrets を参照できます。
- secret の値を `env` で環境変数として受け取り、`echo` で出力します。
- GitHub Actions は secret の値をログ上で自動的にマスクするため、実行ログには `***` と表示されます。
- secret の値そのものがログに残らないことを、この動作で確認できます。
