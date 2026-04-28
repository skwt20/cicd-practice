# 3-3. ブランチによって実行する step を変える

GitHub Actions では、どのブランチで workflow が動いているかも参照できます。

これを使うと、main ブランチのときだけ特定の処理を実行するといった制御ができます。実際の CI/CD でも、ブランチによって処理を分けることはよくあります。

## プラクティス

次の条件を満たす workflow を `3-3-branch-condition.yml` として新規に作成してください。

条件は次のとおりです。

- workflow の起動条件は `workflow_dispatch` にする
- `if` を使ってブランチ条件を定義する
- main ブランチのときだけ実行される step を 1 つ定義する
- その step では `echo "run on main"` を実行する

> ヒント:
>
> - ブランチ情報は `github` context から参照できます
> - ブランチ名そのものではなく、ref の形式で格納されています

> 必要に応じて、次の公式ドキュメントを参照してください。
>
> - [Contexts reference](https://docs.github.com/en/actions/reference/workflows-and-actions/contexts)
> - [Workflow syntax for GitHub Actions - jobs.<job_id>.steps[*].if](https://docs.github.com/ja/actions/reference/workflows-and-actions/workflow-syntax#jobsjob_idstepsif)

## 確認

- 変更を push し、main 以外のブランチで Actions から手動実行する
- `run on main` が実行されないことを確認する
- 続けて main ブランチでも手動実行し、`run on main` が実行されることを確認する

---

次のプラクティス：[3-4. variables を使って値を外部で管理する](./3-4-variables.md)
