# 解答例：3-4. variables を使って値を外出しする

## 解答

### 1. リポジトリに variable を作成する

GitHub のリポジトリページから **Settings > Secrets and variables > Actions > Variables タブ** を開き、以下の variable を作成します。

| Name             | Value                                     |
| ---------------- | ----------------------------------------- |
| `SAMPLE_MESSAGE` | 任意の文字列（例：`Hello from variable`） |

### 2. workflow を修正する

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
```

## 解説

- `vars` context を使うと、リポジトリに設定した Actions variables を参照できます。
- `${{ vars.SAMPLE_MESSAGE }}` のように書くことで、variable の値を workflow 内で利用できます。
- variable の値は機密情報ではないため、ログにそのまま表示されます。
- 環境ごとに値を変えたい場合や、YAML に直接書きたくない設定値を管理するのに向いています。
