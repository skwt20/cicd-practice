# 解答例：4-3. terraform fmt でフォーマットを確認する

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
```

## 解説

- `terraform fmt -check` はフォーマットが正しければ終了コード 0、崩れていれば 1 を返します。
- GitHub Actions では終了コードが 0 以外の場合に step が失敗します。これにより、フォーマット崩れを CI で検出できます。
- `working-directory: terraform` を指定することで、`terraform/` ディレクトリで step を実行します。

---

[目次に戻る](../../README.md)
