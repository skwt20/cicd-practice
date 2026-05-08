# 解答例：4-6. Pull Request で CI を実行する

## 解答

`.github/workflows/4-6-pr-trigger.yml` を以下の内容で新規に作成します。

```yaml
name: 4-6 terraform ci pr

on:
  pull_request:
    branches:
      - main
  workflow_dispatch:

jobs:
  terraform:
    runs-on: ubuntu-latest
    env:
      AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
      AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
    steps:
      - name: Manual execution notice
        if: github.event_name == 'workflow_dispatch'
        run: echo "manual execution"
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

- `pull_request` に `branches: [main]` を指定することで、main ブランチへの PR のときだけ CI が実行されます（Step 3（3-3）のブランチ条件の応用）。
- `workflow_dispatch` も残すことで、手動実行でも CI を確認できます。
- `if: github.event_name == 'workflow_dispatch'` によって、手動実行時だけ `manual execution` が表示されます（Step 3（3-2）のイベント条件の応用）。
