# 4-1. Terraform コードを確認する

Step 4 では Terraform コードを CI で検証します。まず、このリポジトリに用意されている Terraform サンプルコードを、Step 1 で作成した学習用リポジトリにコピーします。

## プラクティス

`cicd-practice/terraform/` ディレクトリを、学習用リポジトリにコピーしてください。

コピー後の学習用リポジトリのディレクトリ構成は次のようになります。

```text
(学習用リポジトリ)/
├── .github/
│   └── workflows/    # Step 2 以降で作成した workflow ファイル
└── terraform/
    ├── main.tf
    ├── variables.tf
    └── .gitignore
```

> **補足: .terraform.lock.hcl について**
>
> `terraform init` を実行すると `.terraform.lock.hcl` が生成されます。
> このファイルは provider のバージョンを固定するためのものなので、Git 管理に含める（コミットする）ことが推奨されています。

## 確認

- `terraform/main.tf` が学習用リポジトリに配置されていることを確認する
- `terraform/.gitignore` により `.terraform/` と `*.tfplan` が Git 管理対象外になっていることを確認する
- 変更を push する

---

次のプラクティス：[4-2. CI から Terraform を実行できるようにする](./4-2-run-terraform.md)
