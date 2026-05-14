# 4-7. plan 結果を artifact として保存する

> **前提**: この課題は [4-6. Pull Request で CI を実行する](./4-6-pr-trigger.md) を完了していることを前提とします。

4-5 で `terraform plan -out=tfplan` によって plan 結果をファイルに保存しましたが、CI 環境は実行後に破棄されるため、そのままでは後から参照できません。

この課題では、Step 3（3-7）で学んだ `artifact` を使って `tfplan` ファイルを保存します。  
ここでは、CI 実行後でも plan 結果を確認できるようにすることを目的とします。
保存した plan ファイルを `apply` で利用する方法は Step 5 で扱います。

> **補足: job 分割について**  
> `tfplan` ファイルは `plan` step が実行されたランナー上にのみ存在するため、別 job からは直接参照できません。  
> そのため、`terraform plan` と `actions/upload-artifact` は同じ job 内で続けて実行します。

## プラクティス

`terraform.yml` に、以下の step を追加してください。

条件は次のとおりです。

- `terraform plan` の後に以下の step を追加する
- `actions/upload-artifact@v4` を使って `tfplan` ファイルを artifact として保存する
  - artifact の名前は `tfplan` にする
  - 保存するパスは `terraform/tfplan` にする

> ヒント:
>
> - `upload-artifact` の使い方は Step 3（3-7）を参照してください

> 必要に応じて、次の公式ドキュメントを参照してください。
>
> - [Store and share data with workflow artifacts](https://docs.github.com/en/actions/tutorials/store-and-share-data)

## 確認

- 変更を push し、Actions から手動実行する
- `terraform plan` と artifact の保存が順番に実行されることを確認する
- Actions の実行結果画面に `tfplan` という名前の artifact が表示されることを確認する
- artifact をダウンロードして `tfplan` ファイルが含まれていることを確認する

---

[Step 4 トップに戻る](./README.md)
