# 解答例：4-7. plan 結果を artifact として保存する

## 解答

`.github/workflows/terraform-ci.yml` を以下のように編集します。

```yaml
name: terraform ci

on:
  pull_request:
    branches:
      - main
  workflow_dispatch:

permissions:
  id-token: write
  contents: read

jobs:
  terraform:
    runs-on: ubuntu-latest
    steps:
      - name: Manual execution notice
        if: github.event_name == 'workflow_dispatch'
        run: echo "manual execution"
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
      - name: Upload plan
        uses: actions/upload-artifact@v4
        with:
          name: tfplan
          path: terraform/tfplan
```

## 解説

- `tfplan` ファイルは `terraform plan` が実行されたランナー上にのみ存在するため、別 job からは直接参照できません。そのため、`terraform plan` と `actions/upload-artifact@v4` を同じ job 内で続けて実行しています。
- artifact の名前は `tfplan` です。保存しておくことで、workflow 実行後でも plan 結果のファイルを確認できます。

このワークフローが Step 4 の完成形です。Step 5 では、保存した plan ファイルを `terraform apply` で利用する方法を扱います。

---

[目次に戻る](../../README.md)
