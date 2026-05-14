# 解答例：5-5. plan 結果をダウンロードして terraform apply を実行する

## 解答

`.github/workflows/terraform.yml` の全体像は以下のとおりです。

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
      - uses: actions/checkout@v4
      - uses: aws-actions/configure-aws-credentials@v4
        with:
          role-to-assume: ${{ secrets.AWS_ROLE_ARN }}
          aws-region: ${{ vars.AWS_REGION }}
      - uses: hashicorp/setup-terraform@v3
        with:
          terraform_version: ${{ vars.TF_VERSION }}
      - name: Terraform init
        run: terraform init
        working-directory: terraform
      - name: Download plan
        uses: actions/download-artifact@v4
        with:
          name: tfplan
          path: terraform
      - name: Terraform apply
        run: terraform apply tfplan
        working-directory: terraform
```

## 解説

- `apply` job は `plan` job とは別のランナーで実行されるため、`actions/download-artifact@v4` を使って `tfplan` artifact を取得しています。
- `path: terraform` を指定することで、`tfplan` ファイルが `terraform/` ディレクトリに配置され、`terraform apply tfplan` でそのまま参照できます。
- `terraform apply tfplan` は plan ファイルを指定して apply するため、`-auto-approve` は不要です。plan した内容だけが apply されます。
- `apply` job でも `terraform init` が必要です。ランナーは毎回クリーンな状態で起動するため、plan job で初期化した `.terraform/` ディレクトリは引き継がれません。
- これが Step 5 の完成形です。

---

[目次に戻る](../../README.md)
