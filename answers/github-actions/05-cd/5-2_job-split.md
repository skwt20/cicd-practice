# 解答例：5-2. plan と apply を job 分割する

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
  plan:
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

  apply:
    runs-on: ubuntu-latest
    needs: plan
    steps:
      - run: echo "apply"
```

## 解説

- 既存の `terraform` job を `plan` に名前変更しました。内容は Step 4 の完成形と同じです。
- `apply` job を新たに追加し、`needs: plan` で plan の完了後に実行されるようにしました（Step 2（2-6）の応用）。
- `apply` job の steps は現時点では `echo "apply"` のみです。実際の apply 処理は 5-5 で実装します。

---

[目次に戻る](../../README.md)
