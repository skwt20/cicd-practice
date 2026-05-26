# 6-3. Self-hosted runner とは何か

> **前提**: この課題は [6-2. GitHub-hosted runner で環境を確認する](./6-2-github-hosted.md) を完了していることを前提とします。

GitHub-hosted runner は手軽に使える反面、環境のカスタマイズに制限があります。Self-hosted runner を使うと、自分で用意した環境を runner として登録し、workflow を実行できます。

## GitHub-hosted runner との比較

| 項目         | GitHub-hosted runner       | Self-hosted runner              |
| ------------ | -------------------------- | ------------------------------- |
| 環境の用意   | GitHub が管理              | 自分で用意・管理                |
| 実行環境     | 毎回クリーンな VM          | 自分で用意したマシン            |
| OS           | Ubuntu / Windows / macOS   | 任意（Linux / Windows / macOS） |
| カスタマイズ | 制限あり                   | 自由                            |
| コスト       | 無料枠あり、超過で従量課金 | マシンの維持コストが発生        |
| 管理コスト   | 不要                       | 利用者が負担                    |

## Self-hosted runner の主な利用シーン

Self-hosted runner は、次のような場合に使用されます。

- 社内ネットワーク内のリソースにアクセスする必要がある
- GPU など特定のハードウェアが必要
- 独自のソフトウェアや設定が必要な環境で実行したい
- コスト面で GitHub-hosted runner の無料枠では足りない

なお、実際のプロジェクトでは物理マシンや VM のほかに、Kubernetes 上で runner を管理する [Actions Runner Controller (ARC)](https://docs.github.com/en/actions/concepts/runners/actions-runner-controller) や、[AWS CodeBuild との連携](https://docs.aws.amazon.com/ja_jp/codebuild/latest/userguide/action-runner-overview.html) が採用されることもあります。大規模な環境や AWS を中心に構成されたプロジェクトでは、こうした選択肢も検討してみてください。

## セキュリティ上の注意点

**Self-hosted runner を public リポジトリに登録することは推奨されません。**

public リポジトリでは、誰でも Pull Request を送ることができます。悪意のある PR が Self-hosted runner 上で実行されると、そのマシンや社内ネットワークに意図しないコードが実行されるリスクがあります。

Self-hosted runner を使う場合は、次の点を意識してください。

- **private リポジトリでの利用を基本とする**
- runner を動かすマシンの権限を必要最小限にする
- 不要になった runner はすぐに削除する

このプラクティスでは、Step 1 で作成した学習用リポジトリを **Private に変更したうえで** Self-hosted runner を導入します。

## 事前準備：リポジトリを Private に変更する

次の課題（6-4）に進む前に、学習用リポジトリを Private に変更してください。

- [リポジトリの公開範囲を変更する](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/managing-repository-settings/setting-repository-visibility)

必要に応じて、次の公式ドキュメントを参照してください。

- [About self-hosted runners](https://docs.github.com/en/actions/hosting-your-own-runners/managing-self-hosted-runners/about-self-hosted-runners)
- [Security hardening for GitHub Actions](https://docs.github.com/en/actions/security-for-github-actions/security-guides/security-hardening-for-github-actions#hardening-for-self-hosted-runners)

---

次のプラクティス：[6-4. Self-hosted runner を導入する](./6-4-self-hosted-setup.md)
