# 解答例：4-4. terraform init / validate で構成を検証する

## 解答

`.github/workflows/terraform-ci.yml` を以下のように編集します。

```yaml
name: terraform ci

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
```

## 解説

- `terraform init` は provider のダウンロードと初期化を行います。`validate` や `plan` の前に必ず実行が必要です。
- `terraform validate` はコードの構文と整合性を確認します。AWS API コールは行わないため、構文ミスを素早く検出できます。
- step は `fmt → init → validate` の順に実行されます。前の step が失敗した場合、後続 step は実行されません。

---

[目次に戻る](../../README.md)
