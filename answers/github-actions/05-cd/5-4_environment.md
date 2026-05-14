# 解答例：5-4. GitHub Environments で apply 前の承認を設定する

## 解答

### 1. GitHub Environments の設定

リポジトリの **Settings > Environments > New environment** から Environment を作成します。

- Environment 名: `production`
- **Required reviewers** に自分自身を追加して保存します

### 2. workflow ファイルの編集

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
    environment: production
    steps:
      - run: echo "apply"
```

## 解説

- `environment: production` を job レベルに指定することで、`apply` job が開始される前に Environment の承認フローが実行されます。
- Required reviewers に設定したユーザーが承認するまで、job は待機状態になります。
- GitHub Environments の設定は、GitHub 側の UI での操作が必要です。workflow ファイルだけでは承認フローは完結しません。

---

[目次に戻る](../../README.md)
