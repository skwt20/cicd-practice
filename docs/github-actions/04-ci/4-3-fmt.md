# 4-3. terraform fmt でフォーマットを確認する

> **前提**: この課題は [4-2. CI から Terraform を実行できるようにする](./4-2-run-terraform.md) を完了していることを前提とします。

`terraform fmt` は Terraform コードを標準的なフォーマットに整形するコマンドです。  
`-check` オプションを付けると、フォーマットが崩れている場合にゼロ以外の終了コードを返すため、CI でコードスタイルを強制できます。

フォーマット確認を CI に組み込むことで、レビュー前に「フォーマットが崩れたまま」のコードがメインブランチに混入するのを防げます。

## プラクティス

4-2 で作成した workflow をベースに、`4-3-fmt.yml` として新規に作成してください。

条件は次のとおりです。

- 4-2 の構成に加えて、以下の step を追加する
- `terraform fmt -check` を実行する step を追加する
  - 実行ディレクトリは `terraform/` にする

> ヒント:
>
> - `working-directory` を指定すると、そのディレクトリで step を実行できます
> - `terraform fmt -check` はフォーマットが正しければ終了コード 0、崩れていれば 1 を返します

> 必要に応じて、次の公式ドキュメントを参照してください。
>
> - [terraform fmt](https://developer.hashicorp.com/terraform/cli/commands/fmt)

## 確認

- 変更を push し、Actions から手動実行する
- `terraform fmt -check` が成功（終了コード 0）することを確認する
- `terraform/main.tf` のインデントを意図的に崩して push し、CI が失敗することを確認する
- 確認後、フォーマットを元に戻して push する

---

次のプラクティス：[4-4. terraform init / validate で構成を検証する](./4-4-validate.md)
