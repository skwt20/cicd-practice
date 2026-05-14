# 解答例：5-3. apply の実行条件を制御する

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
    if: github.event_name != 'pull_request' && github.ref_name == 'main'
    steps:
      - run: echo "apply"
```

## 解説

- `if: github.event_name != 'pull_request' && github.ref_name == 'main'` により、以下の場合に apply が実行されます：
  - イベントが `pull_request` ではない（つまり `push` または `workflow_dispatch`）
  - かつ現在のブランチが `main`
- この条件により、main 以外のブランチからの `workflow_dispatch` での実行時にも apply はスキップされます。
- `needs: plan` との組み合わせにより、plan が成功した後かつ条件を満たす場合にのみ apply が実行されます。

---

[目次に戻る](../../README.md)
