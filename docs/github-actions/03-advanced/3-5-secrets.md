# 3-5. secrets を使って機密情報を扱う

secrets は、パスワードやトークンのような機密情報を安全に扱うための仕組みです。

GitHub Actions で secret を利用するには、GitHub 上で secret を作成し、workflow の中で `secrets` context から参照します。GitHub は secrets をそのままログに表示しないようマスクします。

この課題では、値を直接 YAML に書かずに secret から参照する書き方を試します。また、secret の値はログにそのまま表示されないことも確認します。

## プラクティス

次の条件を満たす workflow を `3-5-secrets.yml` として新規に作成してください。

条件は次のとおりです。

- workflow の起動条件は `workflow_dispatch` にする
- リポジトリの Actions secrets に `SAMPLE_SECRET` という名前の secret を作成する
- workflow の step でその secret を環境変数として受け取る
- 受け取った環境変数を `echo` で出力する

> ヒント:
>
> - secret は GitHub のリポジトリ設定画面から追加できます
> - workflow の中では `secrets` context を使って参照します

> 必要に応じて、次の公式ドキュメントを参照してください。
>
> - [Using secrets in GitHub Actions](https://docs.github.com/actions/security-guides/using-secrets-in-github-actions)
> - [Secrets](https://docs.github.com/en/actions/concepts/security/secrets)

## 確認

- 変更を push し、Actions から手動実行する
- 実行ログに secret の値が `***` としてマスクされて表示されることを確認する

---

次のプラクティス：[3-6. artifact を保存する](./3-6-artifact.md)
