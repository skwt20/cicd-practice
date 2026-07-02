# Step 5: 実践編（CD）

> **前提**: このステップは [Step 4: 実践編（CI）](../04-ci/README.md) を完了していることを前提とします。

このステップでは、Step 4 で構築した CI をもとに、**Terraform の CD（継続的デリバリー）を実装**します。

CD（継続的デリバリー）とは、検証済みのコードを本番環境などに自動またはワンクリックでデプロイできる仕組みです。Terraform においては、`terraform apply` を自動化することがこれにあたります。

ただし、インフラへの変更は影響範囲が大きいため、**誰でも・いつでも実行できる**構成にはしません。このステップでは、次の観点を重視します。

- **手動承認を挟む**：意図したタイミングでのみ apply を実行できるようにする
- **実行ブランチを絞る**：main ブランチからのみ apply を許可する
- **CI の成果物を使う**：Step 4 で保存した plan 結果（artifact）を apply に活用する

このステップでは、次のような要素を扱います。

- **`workflow_dispatch` / `push` トリガー**：手動実行と main ブランチへの push を起点に workflow を起動します
- **plan / apply の 2-job 構成**：Step 2 で学んだ `needs` を活用し、plan が成功した場合のみ apply を実行します
- **job レベルの条件分岐**：`github.event_name` を使って PR 時は apply をスキップします
- **GitHub Environments**：apply 前に承認フローを挟む仕組みを設定します
- **`actions/download-artifact`**：plan job が保存した `tfplan` を apply job で取得し、`terraform apply` に渡します

> 進め方：
>
> このステップでは、Step 4 で作成した `terraform.yml` を拡張しながら進めてください。  
> 5-1 以降は、既存の workflow にトリガー・job・step を追加・編集していく形で進めます。  
> 最終的に、plan と apply が1つの workflow にまとまった構成になります。
>
> **Step 4 をスキップした場合：**
>
> Step 5 から始める場合は、模範解答の [4-7. plan 結果を artifact として保存する](../04-ci/README.md) の完成形 workflow を `.github/workflows/terraform.yml` としてコピーして、そこから 5-1 の課題に取り組んでください。

> **注意**: この教材では Step 4-1 のとおり local backend を前提にしています。GitHub-hosted runner では state ファイルが実行環境に残らないため、5-5 まで完了したあとに同じ構成を再実行すると、2回目以降の `terraform apply` が失敗する場合があります。
>
> 2回目以降を試す場合は、事前に作成済みリソース（例: S3 バケット）を手動で削除してから再実行してください。継続的に再実行する運用を想定する場合は、remote backend の利用を検討してください（この教材のスコープ外）。

## プラクティス一覧

| #   | タイトル                                                                 |
| --- | ------------------------------------------------------------------------ |
| 5-1 | [CD workflow のトリガーを設定する](./5-1-trigger.md)                     |
| 5-2 | [plan と apply を job 分割する](./5-2-job-split.md)                      |
| 5-3 | [apply の実行条件を制御する](./5-3-skip-on-pr.md)                        |
| 5-4 | [GitHub Environments で apply 前の承認を設定する](./5-4-environment.md)  |
| 5-5 | [plan 結果をダウンロードして terraform apply を実行する](./5-5-apply.md) |
