# CI/CD プラクティスたたき台

## 概要

### 目的

CI/CD初学者が「自分でCIを構築できる状態」になること

### ゴール

- CI/CDの基本概念を理解している
- GitHub Actions / GitLab CIでCIを動かせる
- TerraformをCIに組み込み、検証からデプロイまで自動化できる

### 前提条件

- Git操作経験あり（git-practice）
- YAMLの基本理解あり
- Linuxコマンド操作が可能
- Terraform理解（terraform-ractice）

## コンテンツ全体像

本コンテンツは以下の3部構成とする

1. CI/CD基礎理解（CI/CDとは何か）
2. GitHub Actions編
3. GitLab CI編

## コンテンツ概要

### 1. CI/CD基礎編（概要理解）

- 目的
  - CI/CDの全体像を理解する
- 内容
  - CI/CDとは何か
  - なぜ必要か
  - 基本的な流れ
  - 実現するツール
- ゴール
  - CI/CDの役割を説明できる

### 2. GitHub Actions編

#### 2.1 目的

- GitHub Actionsを用いてワークフローを構築できるようになる
- CI/CDの基本的な考え方（イベント起点・実行制御・環境分離）を理解する
- Terraformを題材に、CI（検証）とCD（デプロイ）の役割の違いを理解する

#### 2.2 内容

- Step 1：環境準備
  - アカウント作成
    - GitHubアカウント作成
    - AWSアカウント作成
  - 作業環境準備
    - Gitクライアント
    - Terraform
    - シェル環境
  - 動作確認
    - GitHub に push できる
    - AWS 認証情報を設定できる
    - Terraform から AWS に接続できる
- Step 2：基礎編
  - runs-on を用いた実行環境の指定
  - 基本構造の理解
    - on
    - jobs
    - steps
  - workflow作成
  - jobの実行順制御
    - needs
- Step 3：応用編
  - 条件分岐
    - if
    - イベント条件
    - ブランチ条件
  - Actions secrets / variables の利用
  - artifacts の利用
- Step 4：実践編（CI）
  - Terraformとの連携
    - terraform init
    - terraform plan
- Step 5：実践編（CD）
  - Terraformによるデプロイ
    - terraform apply
    - manual実行
      - workflow_dispatch
    - branch制御（mainブランチのみ）
- Step 6：実行基盤（Runner）
  - Runnerの種類
    - GitHub-hosted runner
    - Self-hosted runner
  - Runnerの導入

#### 2.3 ゴール

- Pull Request時にTerraformのinit / planが実行されるworkflowを構築できる
- mainブランチにおいて、Terraform applyを手動実行できるworkflowを構築できる
- 条件分岐や変数を用いて、workflowの実行条件を制御できる

### 3. GitLab CI編

#### 3.1 目的

- GitLab CIを用いてパイプラインを構築できるようになる
- CI/CDの基本的な考え方（処理の流れ・実行制御・環境分離）を理解する
- Terraformを題材に、CI（検証）とCD（デプロイ）の役割の違いを理解する

#### 3.2 内容

- Step 1：環境準備
  - アカウント作成
    - GitLabアカウント作成
    - AWSアカウント作成
  - 作業環境準備
    - Gitクライアント
    - Terraform
    - シェル環境
  - 動作確認
    - GitHub に push できる
    - AWS 認証情報を設定できる
    - Terraform から AWS に接続できる
- Step 2：基礎編
  - imageを用いた実行環境の指定
  - 基本構造の理解
    - stages
    - jobs
    - script
  - pipeline作成
  - stage制御
- Step 3：応用編
  - rulesによる条件分岐
  - CI/CD変数の利用
  - artifactsの利用
- Step 4：実践編（CI）
  - Terraformとの連携
    - terraform init
    - terraform plan
- Step 5：実践編（CD）
  - Terraformによるデプロイ
    - terraform apply
    - manual実行
    - branch制御（mainブランチのみ）
- Step 6：実行基盤（Runner）
  - Runnerの種類
  - Runnerの導入

#### 3.3 ゴール

- Merge Request時にTerraformのinit / planが実行されるpipelineを構築できる
- mainブランチにおいて、Terraform applyを手動実行できるpipelineを構築できる
- rulesや変数を用いて、pipelineの実行条件を制御できる

## リポジトリ構成

```text
cicd-practice/
├── README.md
├── docs/
│   ├── 00-overview.md                      # 基礎編：CI/CDとは
│   ├── 01-setup.md                         # 共通：環境準備
│   ├── github-actions/
│   │   ├── 01-setup/
│   │   │   └── README.md                 # Step 1: 環境準備（GitHub Actions個別）
│   │   ├── 02-basic/
│   │   │   └── README.md                 # Step 2: 基礎編
│   │   ├── 03-advanced/
│   │   │   └── README.md                   # Step 3: 応用編
│   │   ├── 04-ci/
│   │   │   └── README.md                   # Step 4: 実践編（CI）
│   │   ├── 05-cd/
│   │   │   └── README.md                   # Step 5: 実践編（CD）
│   │   └── 06-runner/
│   │       └── README.md                   # Step 6: 実行基盤（Runner）
│   ├── gitlab-ci/
│   │   ├── 01-setup.md                     # Step 1: 環境準備（GitLab CI個別）
│   │   ├── 02-intro.md                     # Step 2: 基礎編
│   │   ├── 03-advanced.md                  # Step 3: 応用編
│   │   ├── 04-ci.md                        # Step 4: 実践編（CI）
│   │   ├── 05-cd.md                        # Step 5: 実践編（CD）
│   │   └── 06-runner.md                    # Step 6: 実行基盤（Runner）
│   └── terraform/
│       ├── sample/                         # Terraformサンプルコード
│       └── exercises/                      # Terraform演習課題
└── answers/
    ├── github-actions/                     # GitHub Actions 解答例
    │   ├── 02-basic/
    │   ├── 03-advanced/
    │   ├── 04-ci/
    │   ├── 05-cd/
    │   └── 06-runner/
    └── gitlab-ci/                          # GitLab CI 解答例
        ├── 02-intro/
        ├── 03-advanced/
        ├── 04-ci/
        ├── 05-cd/
        └── 06-runner/
```
