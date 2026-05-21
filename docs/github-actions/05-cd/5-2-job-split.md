# 5-2. plan と apply を job 分割する

> **前提**: この課題は [5-1. CD workflow のトリガーを設定する](./5-1-trigger.md) を完了していることを前提とします。

Step 4 では `terraform plan` までを 1 つの job にまとめていました。CD では `apply` を別の job として分離します。

job を分けることで、plan の後に承認フローを挟んだり、apply だけをスキップしたりといった制御が可能になります。この課題では、まずその土台となる **job の分割だけ**を行います。承認フローや実行条件の制御は後続の課題で実装します。

この課題では、Step 2（2-5、2-6）で学んだ複数 job と `needs` の知識を活かして、既存の job を `plan` と `apply` に分割します。

## プラクティス

`terraform.yml` の job 構成を、以下の条件を満たすように変更してください。

条件は次のとおりです。

- 既存の `terraform` job を `plan` job に名前を変更する
  - 内容はそのまま変更しない
- `apply` job を新たに追加する
  - `needs` を使って `plan` job が成功した後に実行されるようにする
  - `runs-on` は `ubuntu-latest` にする
  - steps には `echo "apply"` を実行する step を 1 つだけ定義する（後の課題で実装する）

> ヒント:
>
> - job の分割と `needs` の使い方は Step 2（2-5、2-6）を参照してください

> 必要に応じて、次の公式ドキュメントを参照してください。
>
> - [Using jobs in a workflow](https://docs.github.com/en/actions/using-jobs/using-jobs-in-a-workflow)

## 確認

- 変更を push し、Actions から手動実行する
- `plan` job が完了した後に `apply` job が実行されることを確認する
- `plan` job の内容（fmt / validate / plan）が正常に完了することを確認する
- `apply` job で `echo "apply"` が実行されることを確認する

---

次のプラクティス：[5-3. apply の実行条件を制御する](./5-3-skip-on-pr.md)
