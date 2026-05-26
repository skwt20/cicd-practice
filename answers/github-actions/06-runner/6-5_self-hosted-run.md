# 解答例：6-5. Self-hosted runner で workflow を実行する

## 解答

6-2 で作成した `.github/workflows/6-2-runner-check.yml` の `runs-on` を変更します。

```yaml
name: runner-check

on:
  workflow_dispatch:

jobs:
  runner-check:
    runs-on: self-hosted
    steps:
      - name: Show hostname
        run: hostname

      - name: Show user
        run: whoami

      - name: Show OS info
        run: cat /etc/os-release

      - name: Show RUNNER_OS
        run: echo $RUNNER_OS
```

## 解説

- `runs-on: ubuntu-latest` を `runs-on: self-hosted` に変更するだけで、登録した Self-hosted runner 上で job が実行されます
- `hostname` の出力が登録したマシンのホスト名になっていることで、GitHub-hosted runner ではなく Self-hosted runner で実行されていることを確認できます
- `RUNNER_OS` の値は Self-hosted runner のOSに応じた値（例: `Linux`）が出力されます。6-2 の結果と比較してみてください
- `cat /etc/os-release` は、多くの Linux ディストリビューションで OS 名やバージョンを確認するために使用できます。macOS や Windows など Linux 以外のOSを使用する場合は、利用するOSに応じたコマンドに読み替えてください

---

[目次に戻る](../../README.md)
