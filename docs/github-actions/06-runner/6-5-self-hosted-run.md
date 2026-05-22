# 6-5. Self-hosted runner で workflow を実行する

> **前提**: この課題は [6-4. Self-hosted runner を導入する](./6-4-self-hosted-setup.md) を完了していることを前提とします。また、Runner が起動中（`Listening for Jobs` の状態）であることを確認してください。

Self-hosted runner の登録が完了したら、実際に workflow を実行して動作を確認します。

## プラクティス

6-2 で作成した `6-2-runner-check.yml` を修正して、Self-hosted runner で実行されるようにしてください。

条件は次のとおりです。

- `runs-on` を `self-hosted` に変更する
- それ以外の内容は変更しない

## 確認

- Actions から手動実行する
- runner を起動しているターミナルに job を受け取ったログが出力されることを確認する
- workflow が正常に完了することを確認する
- `hostname` の出力が、登録したマシンのホスト名であることを確認する
- 6-2 の実行結果と比較して、`RUNNER_OS` や OS 情報の違いを確認する

> ヒント:
>
> - runner が起動していない状態で workflow を実行すると、job はキューに入ったまま待機します。runner を起動すると自動的に実行が始まります

## 後片付け

プラクティスが完了したら、次の順番で後片付けを行ってください。

### 1. Runner の停止

runner を起動しているターミナルで `Ctrl+C` を押して停止してください。

### 2. Runner のアンインストール

runner を停止した後、runner をインストールしたディレクトリで次のコマンドを実行してください。GitHub への登録解除も同時に行われます。

```bash
./config.sh remove
```

### 3. GitHub 上での確認

**Settings > Actions > Runners** を開き、Runner が削除されていることを確認してください。残っている場合は画面から手動で削除してください。

- [Removing self-hosted runners](https://docs.github.com/en/actions/hosting-your-own-runners/managing-self-hosted-runners/removing-self-hosted-runners)

### 4. リポジトリの公開範囲

引き続きリポジトリを利用する場合は、必要に応じて Public に戻しても構いません。利用が完了したリポジトリは削除するか Private のままにしておくことを検討してください。

必要に応じて、次の公式ドキュメントを参照してください。

- [Using self-hosted runners in a workflow](https://docs.github.com/en/actions/hosting-your-own-runners/managing-self-hosted-runners/using-self-hosted-runners-in-a-workflow)
- [Removing self-hosted runners](https://docs.github.com/en/actions/hosting-your-own-runners/managing-self-hosted-runners/removing-self-hosted-runners)

---

[Step 6 トップに戻る](./README.md)
