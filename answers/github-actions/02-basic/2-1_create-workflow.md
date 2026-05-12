# 解答例：2-1. workflow を作成する

## 解答

`.github/workflows/hello.yml` を以下の内容で作成します。

```yaml
name: Hello GitHub Actions

on:
  push:

jobs:
  hello:
    steps:
      - name: Say hello
        run: echo "Hello, GitHub Actions"
```

## 解説

- `name` で workflow に名前を付けます。
- `on: push` により、push をきっかけに workflow が起動します。
- `jobs` の下に job を定義します。ここでは `hello` という名前の job を 1 つ定義しています。
- `steps` の下に、実行する処理を記述します。`run` に実行するコマンドを書きます。

> この段階では `runs-on` を指定していないため、workflow は正常に実行されません。  
> 実行環境の指定は次の課題（2-2）で行います。

---

[目次に戻る](../../README.md)
