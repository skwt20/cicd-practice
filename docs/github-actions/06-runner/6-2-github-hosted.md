# 6-2. GitHub-hosted runner で環境を確認する

> **前提**: この課題は [6-1. Runner とは何か](./6-1-runner.md) を完了していることを前提とします。

GitHub-hosted runner は、workflow が実行されるたびに新しい仮想マシンとして起動します。この課題では、実際に job を実行してその環境を確認します。

`ubuntu-latest` が具体的にどのような環境なのかを把握しておくことで、「なぜ毎回 `actions/checkout` が必要なのか」「なぜ `terraform init` をやり直すのか」といった、これまでの課題で出てきた疑問の背景を理解できます。

## プラクティス

次の条件を満たす workflow を `6-2-runner-check.yml` として新規に作成してください。

条件は次のとおりです。

- `workflow_dispatch` で手動実行できるようにする
- `runs-on` は `ubuntu-latest` にする
- 以下の情報を出力する step を作成する
  - ホスト名（`hostname` コマンド）
  - 実行ユーザー（`whoami` コマンド）
  - OS 情報（`cat /etc/os-release` コマンド）
  - 環境変数 `RUNNER_OS` の値

## 確認

- Actions から手動で 2 回以上実行する
  - 実行ごとにホスト名が変わることを確認する
  - `ubuntu-latest` が具体的にどの Ubuntu バージョンかを確認する
- `RUNNER_OS` の値を確認する

> ヒント:
>
> - 環境変数は `run:` ステップ内で `echo $RUNNER_OS` のように参照できます（`${{ env.RUNNER_OS }}` ではありません）
> - ホスト名が毎回変わることが、「runner はクリーンな環境で起動する」ことを示しています

必要に応じて、次の公式ドキュメントを参照してください。

- [About GitHub-hosted runners](https://docs.github.com/en/actions/using-github-hosted-runners/using-github-hosted-runners/about-github-hosted-runners)
- [Variables - Default environment variables](https://docs.github.com/en/actions/writing-workflows/choosing-what-your-workflow-does/store-information-in-variables#default-environment-variables)

---

次のプラクティス：[6-3. Self-hosted runner とは何か](./6-3-self-hosted-overview.md)
