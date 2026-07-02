# Step 6: Runner 編

これまでのステップでは、`runs-on: ubuntu-latest` を指定して workflow を実行してきました。このステップでは、job の実行基盤である **Runner** に焦点を当てます。

Runner には GitHub が管理する **GitHub-hosted runner** と、自分で用意する **Self-hosted runner** の 2 種類があります。このステップでは、それぞれの特徴を理解したうえで、Self-hosted runner を実際に導入して workflow を実行します。

このステップでは、次のような要素を扱います。

- **Runner の概念**：job がどこで実行されるかを理解します
- **GitHub-hosted runner**：GitHub が提供する runner の環境を実際に確認します
- **Self-hosted runner**：自分で用意した環境を runner として登録し、workflow を実行します

> **注意**: Self-hosted runner は public リポジトリへの登録が推奨されません。6-3 以降の課題に進む前に、Step 1 で作成したリポジトリを **Private に変更**してください。変更方法は 6-3 で案内します。

## プラクティス一覧

| #   | タイトル                                                              |
| --- | --------------------------------------------------------------------- |
| 6-1 | [Runner とは何か](./6-1-runner.md)                                    |
| 6-2 | [GitHub-hosted runner で環境を確認する](./6-2-github-hosted.md)       |
| 6-3 | [Self-hosted runner とは何か](./6-3-self-hosted-overview.md)          |
| 6-4 | [Self-hosted runner を導入する](./6-4-self-hosted-setup.md)           |
| 6-5 | [Self-hosted runner で workflow を実行する](./6-5-self-hosted-run.md) |
