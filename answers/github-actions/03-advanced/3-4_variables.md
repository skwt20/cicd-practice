# 解答例：3-4. variables を使って値を外出しする

## 解答

### 1. リポジトリに variable を作成する

GitHub のリポジトリページから **Settings > Secrets and variables > Actions > Variables タブ** を開き、以下の variable を作成します。

| Name             | Value                                     |
| ---------------- | ----------------------------------------- |
| `SAMPLE_MESSAGE` | 任意の文字列（例：`Hello from variable`） |

### 2. workflow を修正する

`.github/workflows/hello.yml` を以下の内容に書き換えます。

```yaml
name: Hello GitHub Actions

on:
  push:
  workflow_dispatch:

jobs:
  hello:
    runs-on: ubuntu-latest
    steps:
      - name: Print variable
        run: echo "${{ vars.SAMPLE_MESSAGE }}"
```

## 解説

- `vars` context を使うと、リポジトリに設定した Actions variables を参照できます。
- `${{ vars.SAMPLE_MESSAGE }}` のように書くことで、variable の値を workflow 内で利用できます。
- variable の値は機密情報ではないため、ログにそのまま表示されます。
- 環境ごとに値を変えたい場合や、YAML に直接書きたくない設定値を管理するのに向いています。
