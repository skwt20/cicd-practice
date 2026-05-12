# 解答例：4-2. CI から Terraform を実行できるようにする

## 解答

`.github/workflows/terraform-ci.yml` を以下の内容で新規に作成します。

```yaml
name: terraform ci

on:
  workflow_dispatch:

jobs:
  terraform:
    runs-on: ubuntu-latest
    env:
      AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
      AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
    steps:
      - uses: actions/checkout@v4
      - uses: hashicorp/setup-terraform@v3
        with:
          terraform_version: ${{ vars.TF_VERSION }}
      - name: Terraform version
        run: terraform version
```

## 解説

- `actions/checkout@v4` でリポジトリのコードを CI 環境にチェックアウトします。
- `hashicorp/setup-terraform@v3` は HashiCorp 公式の Action で、指定したバージョンの Terraform をインストールします。
- `vars.TF_VERSION` は Step 3（3-4）で学んだ `variables` を利用しています。workflow を変えずに Terraform バージョンを管理できます。
- AWS 認証情報は Step 3（3-5）で学んだ `secrets` を利用しています。job レベルの `env` に設定することで、すべての step で自動的に参照されます。

---

[目次に戻る](../../README.md)
