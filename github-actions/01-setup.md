# Step 1: 環境準備

このステップでは、GitHub Actions の学習を始める前に必要な環境を準備します。

ここでは細かなインストール手順までは扱いません。各ツールの導入や設定は公式ドキュメントを参照し、まずはローカルでコードを編集し、GitHub に push できる状態を整えることを目指してください。

## アカウント作成

このプラクティスでは、GitHub と AWS のアカウントが必要です。

GitHub はリポジトリ管理と GitHub Actions の実行に、AWS は Terraform の検証・デプロイ先として使用します。

- [GitHub アカウント作成](https://docs.github.com/en/get-started/start-your-journey/creating-an-account-on-github?utm_source=chatgpt.com)
- [AWS アカウント作成](https://docs.aws.amazon.com/accounts/latest/reference/manage-acct-creating.html?utm_source=chatgpt.com)

## 作業環境準備

ローカルでコードを編集し、GitHub に push できる環境を用意します。

最低限、Git クライアントとシェル環境が必要です。Git は公式ドキュメントに従ってインストールしてください。

- [Git のインストール](https://git-scm.com/install/?utm_source=chatgpt.com)

シェル環境は、普段使っているもので問題ありません。たとえば、Windows であれば Git Bash や WSL、macOS / Linux であれば標準のターミナルを利用できます。

## GitHub リポジトリの作成

このプラクティスでは、GitHub Actions の workflow を作成するための GitHub リポジトリが必要です。

Step 2 以降では、このリポジトリに workflow ファイルを追加し、push や Pull Request をきっかけに GitHub Actions を実行します。

このステップでは、作業用のリポジトリを 1 つ用意してください。

- [GitHub で新しいリポジトリを作成する](https://docs.github.com/en/repositories/creating-and-managing-repositories/creating-a-new-repository)

## GitHub への接続

このプラクティスでは、ローカルで作成したコードを GitHub に push できることを前提とします。

接続方法は HTTPS でも SSH でも構いませんが、継続して利用するなら SSH 接続を設定しておくと扱いやすいです。GitHub Docs には SSH 接続の設定や、ローカルのコードを GitHub に追加する方法がまとまっています。

- [GitHub へ SSH 接続する](https://docs.github.com/en/authentication/connecting-to-github-with-ssh?utm_source=chatgpt.com)
- [SSH 接続を確認する](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/testing-your-ssh-connection?utm_source=chatgpt.com)
- [ローカルのコードを GitHub に追加する](https://docs.github.com/en/migrations/importing-source-code/using-the-command-line-to-import-source-code/adding-locally-hosted-code-to-github?utm_source=chatgpt.com)

## 確認事項

次の状態になっていることを確認してください。

- GitHub アカウントを利用できる
- AWS アカウントを利用できる
- ローカルで Git を利用できる
- 使用するシェル環境を用意できている
- GitHub 上にこのプラクティス用のリポジトリを用意できている

## このステップのゴール

このステップのゴールは、GitHub Actions の workflow を作成する前提となるローカル環境と GitHub リポジトリが整っていることです。

以降のステップでは、ここで準備した GitHub 環境を使って workflow を作成し、GitHub Actions の Runner 上で Terraform を実行していきます。
