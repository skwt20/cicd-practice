# 解答例 目次

## GitHub Actions 編

### Step 2: 基礎編

| プラクティス                                       | 解答                                                                                 |
| -------------------------------------------------- | ------------------------------------------------------------------------------------ |
| 2-1. workflow を作成する                           | [2-1_create-workflow.md](./github-actions/02-basic/2-1_create-workflow.md)           |
| 2-2. `runs-on` で実行環境を指定する                | [2-2_runs-on.md](./github-actions/02-basic/2-2_runs-on.md)                           |
| 2-3. 複数の step を定義する                        | [2-3_multiple-steps.md](./github-actions/02-basic/2-3_multiple-steps.md)             |
| 2-4. Pull Request をきっかけに workflow を実行する | [2-4_pull-request-trigger.md](./github-actions/02-basic/2-4_pull-request-trigger.md) |
| 2-5. 複数の job を作る                             | [2-5_multiple-jobs.md](./github-actions/02-basic/2-5_multiple-jobs.md)               |
| 2-6. `needs` で job の実行順を制御する             | [2-6_needs.md](./github-actions/02-basic/2-6_needs.md)                               |

### Step 3: 応用編

| プラクティス                                | 解答                                                                            |
| ------------------------------------------- | ------------------------------------------------------------------------------- |
| 3-1. `if` で step の実行条件を分ける        | [3-1_if.md](./github-actions/03-advanced/3-1_if.md)                             |
| 3-2. イベントによって実行する step を変える | [3-2_event-condition.md](./github-actions/03-advanced/3-2_event-condition.md)   |
| 3-3. ブランチによって実行する step を変える | [3-3_branch-condition.md](./github-actions/03-advanced/3-3_branch-condition.md) |
| 3-4. variables を使って値を外部で管理する   | [3-4_variables.md](./github-actions/03-advanced/3-4_variables.md)               |
| 3-5. secrets を使って機密情報を扱う         | [3-5_secrets.md](./github-actions/03-advanced/3-5_secrets.md)                   |
| 3-6. job 間で値を受け渡す                   | [3-6_job-output.md](./github-actions/03-advanced/3-6_job-output.md)             |
| 3-7. artifact を保存する                    | [3-7_artifact.md](./github-actions/03-advanced/3-7_artifact.md)                 |
