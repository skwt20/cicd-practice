# 解答例：4-2. CI から Terraform を実行できるようにする

## 解答

`.github/workflows/terraform-ci.yml` を以下の内容で新規に作成します。

```yaml
name: terraform ci

on:
  workflow_dispatch:

permissions:
  id-token: write
  contents: read

jobs:
  terraform:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: aws-actions/configure-aws-credentials@v4
        with:
          role-to-assume: ${{ secrets.AWS_ROLE_ARN }}
          aws-region: ${{ vars.AWS_REGION }}
      - uses: hashicorp/setup-terraform@v3
        with:
          terraform_version: ${{ vars.TF_VERSION }}
      - name: Terraform version
        run: terraform version
```

## 解説

- `permissions` で `id-token: write` を設定することで、OIDC トークンを取得できるようになります。Step 1 と同じ設定です。
- `aws-actions/configure-aws-credentials` で OIDC 認証を行います。`secrets.AWS_ROLE_ARN` には Step 1 で作成した IAM ロールの ARN を設定します。
- `hashicorp/setup-terraform@v3` は HashiCorp 公式の Action で、指定したバージョンの Terraform をインストールします。
- `vars.TF_VERSION` は Step 3（3-4）で学んだ `variables` を利用しています。workflow を変えずに Terraform バージョンを管理できます。

---

[目次に戻る](../../README.md)
