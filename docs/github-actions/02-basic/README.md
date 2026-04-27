# Step 2: 基礎編

このステップでは、GitHub Actions の基本構造を理解し、最小の workflow を自分で作成できるようになることを目指します。

GitHub Actions の workflow は、リポジトリ内の `.github/workflows` ディレクトリに置いた YAML ファイルで定義します。workflow には、起動のきっかけとなる `on`、実行単位である `jobs`、job の中で順番に実行される `steps` が含まれます。

このステップでは、次のような基本要素を順番に確認していきます。

- workflow の作成
- workflow の基本構造（`on` / `jobs` / `steps`）
- `runs-on` を用いた実行環境の指定
- `needs` を用いた job の実行順制御

まずは細かな書き方を覚えることよりも、イベントをきっかけに job が動き、その中で step が順番に実行されるという全体像をつかむことを意識してください。

## 2-1. workflow を作成する

GitHub Actions では、YAML ファイルを書いて workflow を定義します。

まずは最小の workflow を作成し、workflow の基本構造を確認します。

この段階では、まだ実行環境の指定は行いません。まずは `on`、`jobs`、`steps` を持つ workflow の骨組みを作ることを目的とします。

### プラクティス

以下のテンプレートを `.github/workflows/hello.yml` として保存し、条件に合わせてカスタマイズしてください。

```yaml
name: <workflow 名>

on: <イベント名>

jobs:
  <job 名>:
    steps:
      - name: <step 名>
        run: <コマンド>
```

条件は次のとおりです。

- ファイル名は `hello.yml` とする
- workflow 名は `Hello workflow` とする
- `push` をきっかけに実行されるようにする
- job を 1 つ定義する
- `echo "Hello, GitHub Actions"` を実行する step を 1 つ定義する

> **Note**
> この時点では `runs-on` を指定していないため、job は失敗します。
> workflow 自体が起動していれば（Actions タブに実行履歴が表示されていれば）正解です。

> 必要に応じて、次の公式ドキュメントを参照してください。
>
> - [Workflows](https://docs.github.com/en/actions/concepts/workflows-and-actions/workflows)
> - [Workflow syntax for GitHub Actions](https://docs.github.com/ja/actions/reference/workflows-and-actions/workflow-syntax)

**確認：**

- `.github/workflows/hello.yml` が作成されていることを確認する
- 変更を push して、GitHub の Actions タブに workflow の実行履歴が表示されることを確認する（job は失敗して良い）

## 2-2. `runs-on` で実行環境を指定する

GitHub Actions の job は、指定した実行環境で動作します。

その実行環境を指定するのが `runs-on` です。
`runs-on` を書くことで、job をどの環境で実行するかを定義できます。

実行環境は大きく「GitHub 管理」と「自己管理」の 2 種類があります。

- **GitHub Hosted Runner**（GitHub 管理）：GitHub が提供・管理する環境です。`ubuntu-latest` や `windows-latest` などから選べます。詳細は [Choosing GitHub-hosted runners](https://docs.github.com/en/actions/using-github-hosted-runners/using-github-hosted-runners/choosing-github-hosted-runners) を参照してください。
- **Self Hosted Runner**（自己管理）：自分で用意・管理する環境です。こちらについては Step 6 にて扱います。

この課題では、まず `runs-on` を使って実行環境を指定し、workflow を実行できる状態にします。

### プラクティス

前の課題で作成した workflow に、以下の変更を加えてください。

- job に `runs-on: ubuntu-latest` を追加する

> ヒント:
> 実行結果は GitHub の Actions タブから確認できます。

> 必要に応じて、次の公式ドキュメントを参照してください。
>
> - [Workflow syntax for GitHub Actions - jobs.<job_id>.runs-on](https://docs.github.com/ja/actions/reference/workflows-and-actions/workflow-syntax#jobsjob_idruns-on)

**確認：**

- 変更を push して、workflow が正常に完了することを確認する
- `Hello, GitHub Actions` が出力されることを確認する

## 2-3. 複数の step を定義する

1 つの job の中には、複数の step を定義できます。

step は上から順番に実行されます。
job は処理のまとまり、step はその中で順番に実行される個々の処理、と考えると整理しやすいです。

### プラクティス

前の課題で作成した workflow に、以下の変更を加えてください。

- `echo "Hello, GitHub Actions"` の step を削除する
- 代わりに以下の 2 つの step を定義する
  - 1 つ目の step で `echo "step1"` を実行する
  - 2 つ目の step で `echo "step2"` を実行する

> 必要に応じて、次の公式ドキュメントを参照してください。
>
> - [Workflow syntax for GitHub Actions](https://docs.github.com/ja/actions/reference/workflows-and-actions/workflow-syntax)

**確認：**

- 変更を push して、workflow が正常に完了することを確認する
- step1 → step2 の順番で実行されることを確認する
- 両方の出力がログに表示されることを確認する

## 2-4. Pull Request をきっかけに workflow を実行する

GitHub Actions はイベント起点で動きます。

ここまでは `push` をきっかけにしていましたが、実際の CI では Pull Request をきっかけに検証を実行することがよくあります。

この課題では、起動条件を `pull_request` に変更し、**イベントを変えると workflow の動くタイミングも変わる**ことを確認します。

### プラクティス

前の課題で作成した workflow に、以下の変更を加えてください。

- `on` のトリガーを `push` から `pull_request` に変更する

> ヒント:
> main 以外のブランチで変更を push し、そのブランチから Pull Request を作成すると確認しやすいです。

> 必要に応じて、次の公式ドキュメントを参照してください。
>
> - [Events that trigger workflows](https://docs.github.com/en/actions/reference/events-that-trigger-workflows)
> - [Workflow syntax for GitHub Actions - on](https://docs.github.com/ja/actions/reference/workflows-and-actions/workflow-syntax#on)

**確認：**

- main 以外のブランチで変更を push する
- push では workflow が実行されないことを確認する
- Pull Request を作成して workflow が実行されることを確認する
- Actions タブでイベントが pull_request になっていることを確認する

## 2-5. 複数の job を作る

workflow は 1 つ以上の job から構成されます。

step は同じ job の中で順番に実行されますが、job は workflow の中の独立した処理単位です。
job を分けることで、処理を役割ごとに分離できます。

GitHub Actions では、job は依存関係を指定しなければ並列に実行されます。
ここではまず、job を分けるとどうなるかを確認します。

### プラクティス

前の課題で作成した workflow に、以下の変更を加えてください。

- `on` のトリガーを `push` に戻す
- job を 2 つに増やす
- 1 つ目の job で `echo "job1"` を実行する
- 2 つ目の job で `echo "job2"` を実行する
- 2 つの job に依存関係は付けない

> ヒント: どちらの job も同じ `runs-on` を使って構いません。

> 必要に応じて、次の公式ドキュメントを参照してください。
>
> - [Workflow syntax for GitHub Actions - jobs](https://docs.github.com/ja/actions/reference/workflows-and-actions/workflow-syntax#jobs)

**確認：**

- 変更を push して、workflow が正常に完了することを確認する
- 2 つの job が並列に（順序指定なしで）実行されることを確認する
- それぞれのログに job1 / job2 が出力されることを確認する

## 2-6. `needs` で job の実行順を制御する

GitHub Actions では、job 同士の依存関係を `needs` で定義できます。

`needs` を使うと、「ある job が終わってから次の job を実行する」という関係を表現できます。
この仕組みを使うと、たとえば「テストが成功したら次の処理を実行する」といった流れを作れます。

この課題では、job の依存関係を定義し、実行順が変わることを確認します。

### プラクティス

前の課題で作成した workflow に、以下の変更を加えてください。

- 2 つ目の job に `needs` を追加し、1 つ目の job の完了後に実行されるようにする
- 1 つ目の job の `echo` を `echo "first job"` に変更する
- 2 つ目の job の `echo` を `echo "second job"` に変更する

> 必要に応じて、次の公式ドキュメントを参照してください。
>
> - [Workflow syntax for GitHub Actions - jobs.<job_id>.needs](https://docs.github.com/ja/actions/reference/workflows-and-actions/workflow-syntax#jobsjob_idneeds)
> - [Contexts reference](https://docs.github.com/en/actions/reference/workflows-and-actions/contexts)

**確認：**

- 変更を push して、workflow が正常に完了することを確認する
- first job が先に実行されることを確認する
- その完了後に second job が実行されることを確認する
- 並列ではなく順番に実行されることを確認する

## このステップで押さえたいこと

このステップでは、GitHub Actions の基本を確認しました。

- workflow は `.github/workflows` 配下の YAML ファイルで定義する
- workflow は `on` で指定したイベントをきっかけに起動する
- workflow は 1 つ以上の `jobs` で構成される
- job の中では `steps` が順番に実行される
- `runs-on` で job の実行環境を指定する
- `needs` で job の実行順を制御する

次のステップでは、条件分岐や変数、artifacts を使って、workflow をもう少し実践的な形にしていきます。
