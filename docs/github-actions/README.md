# GitHub Actions 編

このセクションでは、GitHub Actions を使った CI/CD の構築を学びます。

まず workflow の基本構造を理解し、実行条件の制御や variables・secrets による値の管理方法を確認したうえで、実際に Terraform を使った CI/CD パイプラインを構築していきます。

各ステップは順番に進めることを前提としていますが、Step 6（Runner 編）は Step 2 完了後であれば独立して取り組めます。

## ステップ一覧

| ステップ | タイトル                           | 内容                                                  |
| -------- | ---------------------------------- | ----------------------------------------------------- |
| Step 1   | [環境準備](./01-setup/README.md)   | GitHub リポジトリの作成・OIDC 設定                    |
| Step 2   | [基礎編](./02-basic/README.md)     | workflow の基本構造・`on` / `jobs` / `steps`          |
| Step 3   | [応用編](./03-advanced/README.md)  | 条件分岐・variables・secrets・artifact                |
| Step 4   | [実践編（CI）](./04-ci/README.md)  | Terraform の fmt / validate / plan を CI で自動化する |
| Step 5   | [実践編（CD）](./05-cd/README.md)  | Terraform apply を CD で実装する                      |
| Step 6   | [Runner 編](./06-runner/README.md) | GitHub-hosted runner / Self-hosted runner             |

---

まずは [Step 1: 環境準備](./01-setup/README.md) から始めてください。
