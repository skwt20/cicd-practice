# Step 1: 環境準備

このステップでは、GitHub Actions の学習を始める前に必要な環境を準備します。

ここでは細かなインストール手順までは扱いません。各ツールの導入や設定は公式ドキュメントを参照し、まずは **ローカルでコードを編集して GitHub に push できること**、**GitHub Actions から AWS に接続できること** を確認してください。

## GitHub リポジトリの作成

このプラクティスでは、GitHub Actions の workflow を作成するための GitHub リポジトリが必要です。

Step 2 以降では、このリポジトリに workflow ファイルを追加し、push や Pull Request をきっかけに GitHub Actions を実行します。

このステップでは、作業用のリポジトリを 1 つ用意してください。

- [GitHub で新しいリポジトリを作成する](https://docs.github.com/en/repositories/creating-and-managing-repositories/creating-a-new-repository)

## GitHub への接続

このプラクティスでは、ローカルで作成したコードを GitHub に push できることを前提とします。

接続方法は HTTPS でも SSH でも構いませんが、継続して利用するなら SSH 接続を設定しておくと扱いやすいです。GitHub Docs には SSH 接続の設定や、ローカルのコードを GitHub に追加する方法がまとまっています。

- [GitHub へ SSH 接続する](https://docs.github.com/en/authentication/connecting-to-github-with-ssh)
- [SSH 接続を確認する](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/testing-your-ssh-connection)
- [ローカルのコードを GitHub に追加する](https://docs.github.com/en/migrations/importing-source-code/using-the-command-line-to-import-source-code/adding-locally-hosted-code-to-github)

## AWS 側の準備

このプラクティスでは、GitHub Actions から AWS に接続するために、IAM ユーザーのアクセスキーではなく OIDC を利用します。  
AWS 側では、まず GitHub の OIDC プロバイダーを IAM に登録し、その後、GitHub Actions から引き受けるための IAM ロールを作成してください。

### OIDC プロバイダーの作成

AWS マネジメントコンソールで IAM を開き、OIDC プロバイダーを作成してください。

設定する値は次のとおりです。

- プロバイダー URL: `https://token.actions.githubusercontent.com`
- Audience: `sts.amazonaws.com`

参考:

- [Create an OpenID Connect (OIDC) identity provider in IAM](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_providers_create_oidc.html)
- [Configuring OpenID Connect in Amazon Web Services](https://docs.github.com/actions/deployment/security-hardening-your-deployments/configuring-openid-connect-in-amazon-web-services)

### 作成する IAM ロール

このステップでは、学習用リポジトリから AWS に接続するための IAM ロールを 1 つ作成してください。

ロール作成時は、**信頼されたエンティティタイプ** で **Web identity** を選択します。  
そのうえで、GitHub の OIDC プロバイダーと Audience を指定し、GitHub Actions から引き受けられるように設定してください。

想定するロールは次のようなものです。

- ロール名の例: `github-actions-oidc-role`
- 用途: 学習用 GitHub リポジトリから AWS に接続するためのロール
- 利用範囲: 少なくとも対象のリポジトリに限定する
- 必要に応じて、対象ブランチまで絞る

### 信頼ポリシーの考え方

信頼ポリシーでは、GitHub の OIDC プロバイダーを信頼し、少なくとも対象リポジトリだけがロールを引き受けられるように制限してください。GitHub の公式ドキュメントでも、少なくとも 1 つ条件を付けて利用範囲を制限することが推奨されています。

信頼ポリシーの例:

```json
{
  "Version":"2012-10-17",
  "Statement": [
    {
      "Effect":"Allow",
      "Principal": {
        "Federated":"arn:aws:iam::YOUR_AWS_ACCOUNT_ID:oidc-provider/token.actions.githubusercontent.com"
      },
      "Action":"sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "token.actions.githubusercontent.com:aud":"sts.amazonaws.com"
        },
        "StringLike": {
          "token.actions.githubusercontent.com:sub":"repo:YOUR_GITHUB_USER_OR_ORG/YOUR_REPOSITORY_NAME:*"
        }
      }
    }
  ]
}
```

main ブランチだけに制限したい場合は、`sub` を次のように絞れます。

```
repo:YOUR_GITHUB_USER_OR_ORG/YOUR_REPOSITORY_NAME:ref:refs/heads/main
```

### ロールに付与する権限

Step 1 では、GitHub Actions から AWS に認証できることを確認するために `aws sts get-caller-identity` を実行します。

このステップでは、まず AWS に接続できることを確認できれば十分です。  
Terraform の実行に必要な権限は、後続のステップで必要に応じて追加してください。

参考:

- [Configuring OpenID Connect in Amazon Web Services](https://docs.github.com/actions/deployment/security-hardening-your-deployments/configuring-openid-connect-in-amazon-web-services)
- [Create an OpenID Connect (OIDC) identity provider in IAM](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_providers_create_oidc.html)
- [Create a role for OpenID Connect federation (console)](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_create_for-idp_oidc.html)

## サンプル workflow の実行確認

環境準備ができたら、この章で作成した学習用リポジトリにサンプル workflow を追加し、GitHub Actions から AWS に接続できることを確認してください。

ここで確認したいのは、次の 2 点です。

- GitHub に workflow ファイルを配置して Actions を実行できること
- GitHub Actions から AWS に OIDC で認証できること

### 手順

1. 学習用リポジトリをローカルに clone する
2. リポジトリ内に `.github/workflows/` ディレクトリを作成する
3. その配下にサンプル workflow を YAML ファイルとして作成する
4. workflow 内のプレースホルダを書き換える
    - `ROLE_TO_ASSUME`: 作成した IAM ロールの ARN
    - `AWS_REGION`: 利用する AWS リージョン
5. ファイルを commit して push する
6. GitHub の Actions 画面で workflow が成功していることを確認する
7. 実行ログで `aws sts get-caller-identity` の結果を確認する

### サンプル workflow

以下の内容で、たとえば `.github/workflows/check-aws-oidc.yml` を作成してください。

```yaml
name: check-aws-oidc

on:
  push:

permissions:
  id-token: write
  contents: read

jobs:
  check-aws-oidc:
    runs-on: ubuntu-latest
    env:
      AWS_REGION: <AWS_REGION>
    steps:
      - name: Checkout repository
        uses: actions/checkout@v5

      - name: Configure AWS credentials
        uses: aws-actions/configure-aws-credentials@v6.1.0
        with:
          role-to-assume: <ROLE_TO_ASSUME>
          aws-region: ${{ env.AWS_REGION }}

      - name: Verify AWS identity
        run: aws sts get-caller-identity
```

### 書き換える箇所

少なくとも次の 2 つを書き換えてください。

- `<AWS_REGION>`
  - 例: `ap-northeast-1`
- `<ROLE_TO_ASSUME>`
  - 例: `arn:aws:iam::123456789012:role/github-actions-oidc-role`

## 確認事項

サンプル workflow を push し、GitHub Actions が正常に実行されることを確認してください。

この workflow が成功していれば、少なくとも次の前提が整っていることを確認できます。

- 学習用リポジトリを利用できる
- ローカルから GitHub に push できる
- GitHub Actions を実行できる
- AWS 側の OIDC ロール設定が正しい
- GitHub Actions から AWS に接続できる

## このステップのゴール

このステップのゴールは、GitHub Actions の workflow を作成する前提となる GitHub リポジトリと AWS 側の認証設定が整っていることです。

以降のステップでは、ここで準備した GitHub リポジトリと AWS 連携設定を使って workflow を作成し、GitHub Actions 上で CI/CD を実装していきます。

---

次のステップ：[Step 2: 基礎編](../02-basic/README.md)
