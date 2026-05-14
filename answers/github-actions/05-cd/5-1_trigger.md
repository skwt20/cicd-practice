# 解答例：5-1. CD workflow のトリガーを設定する

## 解答

`.github/workflows/terraform.yml` を以下のように編集します。

```yaml
name: terraform ci/cd

on:
  push:
    branches:
      - main
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

- `push: branches: [main]` を追加することで、main ブランチへのマージ（push）をきっかけに workflow が実行されるようになります。
- `pull_request` と `workflow_dispatch` はそのまま残します。これにより、PR 時の CI と手動実行の両方も引き続き動作します。
- この時点ではトリガーの追加のみで、job の内容は Step 4 の完成形と同じです。

---

[目次に戻る](../../README.md)
