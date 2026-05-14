# 解答例：4-4. terraform init / validate で構成を検証する

## 解答

`.github/workflows/terraform.yml` を以下のように編集します。

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
      - name: Terraform fmt
        run: terraform fmt -check
        working-directory: terraform
      - name: Terraform init
        run: terraform init
        working-directory: terraform
      - name: Terraform validate
        run: terraform validate
        working-directory: terraform
```

## 解説

- `terraform init` は provider のダウンロードと初期化を行います。`validate` や `plan` の前に必ず実行が必要です。
- `terraform validate` はコードの構文と整合性を確認します。local backend を使用する場合は AWS API コールが発生しないため、構文ミスを素早く検出できます。なお、S3 などのリモートバックエンドを使用する場合は、`init` の段階で AWS API コールが発生します。
- step は `fmt → init → validate` の順に実行されます。前の step が失敗した場合、後続 step は実行されません。

---

[目次に戻る](../../README.md)
