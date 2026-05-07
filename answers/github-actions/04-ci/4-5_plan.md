````markdown
# 解答例：4-5. terraform plan で変更内容を確認する

## 解答

`.github/workflows/4-5-plan.yml` を以下の内容で新規に作成します。

```yaml
name: 4-5 terraform plan

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
- `-var="bucket_name=..."` で変数を渡しています。`vars.BUCKET_NAME` は Step 3（3-4）の `variables` です。
- `-out=tfplan` で plan 結果をファイルに保存します。このファイルは 4-7 で artifact として保存し、Step 5 の `apply` で使います。
````
