# 解答例：4-5. terraform plan で変更内容を確認する

## 解答

`.github/workflows/terraform-ci.yml` を以下のように編集します。

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
      - name: Terraform plan
        run: terraform plan -var="bucket_name=${{ vars.BUCKET_NAME }}" -out=tfplan
        working-directory: terraform
```

## 解説

- `terraform plan` は実際にはリソースを作成・変更せず、変更内容を事前に確認できます。
- `-var="bucket_name=..."` で変数を渡しています。`vars.BUCKET_NAME` は Step 3（3-4）の `variables` です。S3 バケット名はグローバルで一意である必要があるため、`20240101-yamada-cicd-practice` のように日付と作業者名を含めた値を設定してください。
- `-out=tfplan` で plan 結果をファイルに保存します。このファイルは 4-7 で artifact として保存し、Step 5 の `apply` で使います。

---

[目次に戻る](../../README.md)
