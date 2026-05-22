# 6-1. Runner とは何か

> **前提**: この課題は [Step 6: Runner 編](./README.md) の導入を読んでいることを前提とします。

これまでのステップでは、`runs-on: ubuntu-latest` と書くだけで workflow が実行されてきました。この課題では、その裏側にある **Runner** の仕組みを整理します。

## Runner とは

Runner とは、GitHub Actions の job を実際に実行するマシンのことです。workflow の各 job は、必ずいずれかの Runner 上で実行されます。

`runs-on` キーは、その job をどの Runner で実行するかを指定するものです。

```yaml
jobs:
  example:
    runs-on: ubuntu-latest  # この Runner 上で job が実行される
    steps:
      - run: echo "hello"
```

## Runner の種類

Runner には大きく 2 種類あります。

### GitHub-hosted runner

GitHub が管理・提供する runner です。workflow が起動するたびに新しい仮想マシンが用意され、job 完了後に破棄されます。

主な特徴は次のとおりです。

- 利用者側でのセットアップは不要
- Ubuntu / Windows / macOS を選択できる
- 毎回クリーンな環境で実行される
- 一定の無料枠があり、超過すると従量課金になる

`ubuntu-latest` / `windows-latest` / `macos-latest` などのラベルで指定します。

### Self-hosted runner

利用者が自分で用意・管理する runner です。自社サーバーやクラウド上の VM など、任意のマシンを runner として登録できます。

主な特徴は次のとおりです。

- 専用のハードウェアや特定の環境が必要な場合に使用する
- 実行環境を自由にカスタマイズできる
- GitHub への通信が必要（アウトバウンド）
- 管理・運用コストは利用者が負担する

`self-hosted` ラベルで指定します。

## このステップで学ぶこと

次の 6-2 では GitHub-hosted runner の実際の環境を確認します。6-3 以降では Self-hosted runner の概念・導入・実行を順に進めます。

必要に応じて、次の公式ドキュメントを参照してください。

- [About GitHub-hosted runners](https://docs.github.com/en/actions/using-github-hosted-runners/using-github-hosted-runners/about-github-hosted-runners)
- [About self-hosted runners](https://docs.github.com/en/actions/hosting-your-own-runners/managing-self-hosted-runners/about-self-hosted-runners)

---

次のプラクティス：[6-2. GitHub-hosted runner で環境を確認する](./6-2-github-hosted.md)
