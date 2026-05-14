# 解答例：5-3. Pull Request 時は apply をスキップする

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
    if: github.event_name != 'pull_request'
    steps:
      - run: echo "apply"
```

## 解説

- `if: github.event_name != 'pull_request'` を job レベルに指定することで、`pull_request` イベントのときは `apply` job 全体がスキップされます（Step 3（3-1、3-2）の応用）。
- `push` や `workflow_dispatch` のときは条件が真になるため、`apply` job は実行されます。
- `needs: plan` との組み合わせにより、plan が成功した後かつ pull_request でない場合にのみ apply が実行されます。

---

[目次に戻る](../../README.md)
