# 解答例：3-6. job 間で値を受け渡す

## 解答

`.github/workflows/3-6-job-output.yml` を以下の内容で新規に作成します。

```yaml
name: 3-6 job output

on:
  workflow_dispatch:

jobs:
  job1:
    runs-on: ubuntu-latest
    outputs:
      message: ${{ steps.set-message.outputs.message }}
    steps:
      - name: Set output
        id: set-message
        run: echo "message=Hello from job1" >> "$GITHUB_OUTPUT"

  job2:
    runs-on: ubuntu-latest
    needs: job1
    steps:
      - name: Show output
        run: echo "${{ needs.job1.outputs.message }}"
```

## 解説

- job1 では、後続の job に渡す値として message という output を定義しています。
- step の output を job の output として使うために、steps.set-message.outputs.message を参照しています。
- id: set-message は、step の output を参照するために必要です。
- echo "message=Hello from job1" >> "$GITHUB_OUTPUT" により、message という名前の step output を作成しています。
- job2 では、needs: job1 を指定して、job1 の完了後に実行されるようにしています。
- 後続 job では、needs.job1.outputs.message の形で job1 の output を参照できます。
- 実行ログに Hello from job1 が表示されれば、job 間で値を受け渡せています。
