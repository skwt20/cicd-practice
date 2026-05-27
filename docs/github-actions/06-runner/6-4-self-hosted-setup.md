# 6-4. Self-hosted runner を導入する

> **前提**: この課題は [6-3. Self-hosted runner とは何か](./6-3-self-hosted-overview.md) を完了していることを前提とします。また、学習用リポジトリを **Private に変更済み**であることを確認してください。

この課題では、自分のマシンを Self-hosted runner として GitHub リポジトリに登録します。

## 事前準備：Runner を動かすマシンを用意する

Runner を登録するマシンを事前に用意してください。利用できる環境であれば何でも構いません。

例:

- ローカル PC（Linux / macOS / Windows）
- AWS EC2 インスタンス（例: Amazon Linux 2023 / Ubuntu）

EC2 を使う場合は、GitHub への**アウトバウンド通信（HTTPS / ポート 443）**が許可されていることを確認してください。runner は GitHub に対してポーリングして job を受け取るため、インバウンドの穴あけは不要です。

## 導入手順

### 1. GitHub の設定画面を開く

学習用リポジトリの **Settings > Actions > Runners** を開き、**New self-hosted runner** をクリックしてください。

### 2. OS を選択する

Runner を登録するマシンの OS を選択してください。このプラクティスでは **Linux** を前提とします。Linux 以外を使用する場合は、GitHub の画面で該当する OS を選択してください。

### 3. 表示されたコマンドを実行する

GitHub の画面に、Runner のダウンロード・設定・起動に必要なコマンドが表示されます。表示されたコマンドをそのまま順に実行してください。

設定の途中で次の項目を入力するプロンプトが表示されます。

- **Runner group**: そのまま Enter（デフォルト）
- **Runner name**: 任意の名前（省略時はホスト名が使われます）
- **Additional labels**: そのまま Enter（デフォルト）
- **Work folder**: そのまま Enter（デフォルト）

> **Additional labels について**: ラベルを指定しない場合、runner には `self-hosted` ラベルのみが付与されます。複数の runner を管理する場合は、ここで任意のラベル（例: `linux`、`prod`）を追加し、workflow の `runs-on` でそのラベルを指定することで、実行先の runner を区別できます。

### 4. Runner を起動する

設定完了後、次のコマンドで Runner を起動してください。

```bash
./run.sh
```

起動すると、ターミナルに `Listening for Jobs` と表示されます。この状態で workflow を受け付けられるようになります。

## 確認

- GitHub の **Settings > Actions > Runners** を開く
- 登録した runner が **Idle** 状態で表示されていることを確認する

> ヒント:
>
> - runner の起動中はターミナルを閉じないでください。ターミナルを閉じると runner が停止します
> - EC2 に SSH 1 セッションしか使えない場合は、別セッションで SSH 接続するか、runner をサービスとして登録することを検討してください
> - runner をバックグラウンドで常時起動したい場合は、サービスとして登録する方法があります（このプラクティスでは任意）

必要に応じて、次の公式ドキュメントを参照してください。

- [Adding self-hosted runners](https://docs.github.com/en/actions/hosting-your-own-runners/managing-self-hosted-runners/adding-self-hosted-runners)
- [Configuring the self-hosted runner application as a service](https://docs.github.com/en/actions/hosting-your-own-runners/managing-self-hosted-runners/configuring-the-self-hosted-runner-application-as-a-service)

---

次のプラクティス：[6-5. Self-hosted runner で workflow を実行する](./6-5-self-hosted-run.md)
