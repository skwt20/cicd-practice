# 3-6. job 間で値を受け渡す

GitHub Actions では、job の実行結果として値を定義し、後続の job から参照できます。

この仕組みを `job outputs` と呼びます。  
`job outputs` を使うと、ある job で作成した短い文字列や判定結果などを、別の job に引き渡せます。

たとえば、次のような値を後続 job で使いたい場合に利用できます。

- バージョン番号
- 環境名
- 判定結果
- 生成した短い文字列

後続 job では、`needs` context を使って前の job の output を参照します。

この課題では、1 つ目の job で値を作成し、2 つ目の job でその値を参照する workflow を作成します。

## プラクティス

次の条件を満たす workflow を `3-6-job-output.yml` として新規に作成してください。

条件は次のとおりです。

- workflow の起動条件は `workflow_dispatch` にする
- job を 2 つ定義する（`job1`、`job2`）
- `job1` で output を定義する
- output 名は `message` にする
- output の値は `Hello from job1` にする
- `needs` を使って `job1` → `job2` の順に実行されるようにする
- `job2` で `job1` の output を参照する
- `job2` では `echo` を使って、受け取った値をログに出力する

> ヒント:
>
> - step で作成した値は `$GITHUB_OUTPUT` に書き込むことで、step の output として扱えます
> - job の output は `jobs.<job_id>.outputs` で定義します
> - 後続 job では `needs.<job_id>.outputs.<output名>` の形で参照できます

> 必要に応じて、次の公式ドキュメントを参照してください。
>
> - [Passing information between jobs](https://docs.github.com/actions/writing-workflows/choosing-what-your-workflow-does/passing-information-between-jobs)
> - [Workflow syntax for GitHub Actions - jobs.<job_id>.outputs](https://docs.github.com/actions/using-workflows/workflow-syntax-for-github-actions#jobsjob_idoutputs)
> - [Contexts reference](https://docs.github.com/en/actions/reference/workflows-and-actions/contexts)

## 確認

- 変更を push し、Actions 画面から workflow を手動実行する
- `job1` が完了した後に `job2` が実行されることを確認する
- `job2` のログに `Hello from job1` が出力されていることを確認する

---

次のプラクティス：[3-7. artifact を保存する](./3-7-artifact.md)
