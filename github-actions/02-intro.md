# Step 2: 基礎編

このステップでは、GitHub Actions の基本構造を理解し、最小の workflow を自分で作成できるようになることを目指します。

ここで扱うのは、GitHub Actions を使ううえでまず押さえたい要素です。

- `runs-on` を用いた実行環境の指定
- workflow の基本構造
  - `on`
  - `jobs`
  - `steps`
- workflow の作成
- job の実行順制御
  - `needs`

GitHub Actions の workflow は、リポジトリ内の `.github/workflows` ディレクトリに置いた YAML ファイルで定義します。  
workflow には、起動のきっかけとなる `on`、実行単位である `jobs`、job の中で順番に実行される `steps` が含まれます。

まずは細かな書き方を覚えることよりも、**イベントをきっかけに job が動き、その中で step が順番に実行される**という全体像をつかむことを意識してください。

## 2-1. workflow を作成する

GitHub Actions では、YAML ファイルを書いて workflow を定義します。

まずは最小の workflow を作成し、workflow の基本構造を確認します。

この段階では、まだ実行環境の指定は行いません。まずは `on`、`jobs`、`steps` を持つ workflow の骨組みを作ることを目的とします。

### プラクティス

`<リポジトリ>/.github/workflows` ディレクトリを作成し、その中に workflow ファイルを 1 つ追加してください。

条件は次のとおりです。

- workflow ファイルを `.github/workflows` 配下に YAML ファイルとして作成する
- workflow 名を設定する
- `push` をきっかけに実行されるようにする
- 1 つ以上の job を持つ
- `echo "Hello, GitHub Actions"` を実行する step を定義する

必要に応じて、次の公式ドキュメントを参照してください。

- [Workflows](https://docs.github.com/en/actions/concepts/workflows-and-actions/workflows?utm_source=chatgpt.com)
- [Workflow syntax for GitHub Actions](https://docs.github.com/ja/actions/reference/workflows-and-actions/workflow-syntax)

## 2-2. `runs-on` で実行環境を指定する

GitHub Actions の job は、指定した実行環境で動作します。

その実行環境を指定するのが `runs-on` です。
`runs-on` を書くことで、job をどの環境で実行するかを定義できます。

このステップでは、まず `runs-on` を使って実行環境を指定し、workflow を実行できる状態にします。

### プラクティス

前の課題で作成した workflow を修正し、job の実行環境を指定してください。

条件は次のとおりです。

- `runs-on` を使う
- `ubuntu-latest` を指定する
- workflow を push し、Actions が正常に実行されることを確認する

> ヒント:
> 実行結果は GitHub の Actions タブから確認できます。

必要に応じて、次の公式ドキュメントを参照してください。

- [Workflow syntax for GitHub Actions - jobs.<job_id>.runs-on](https://docs.github.com/ja/actions/reference/workflows-and-actions/workflow-syntax#jobsjob_idruns-on)

## 2-3. 複数の step を定義する

1 つの job の中には、複数の step を定義できます。

step は上から順番に実行されます。
job は処理のまとまり、step はその中で順番に実行される個々の処理、と考えると整理しやすいです。

### プラクティス

作成済みの workflow を修正し、1 つの job の中に step を 2 つ追加してください。

条件は次のとおりです。

- 同じ job の中に step を 2 つ定義する
- 1 つ目の step で `echo "step1"` を実行する
- 2 つ目の step で `echo "step2"` を実行する
- step が順番に実行されることを確認する

必要に応じて、次の公式ドキュメントを参照してください。

- [Workflow syntax for GitHub Actions](https://docs.github.com/ja/actions/reference/workflows-and-actions/workflow-syntax)

## 2-4. Pull Request をきっかけに workflow を実行する

GitHub Actions はイベント起点で動きます。

ここまでは `push` をきっかけにしていましたが、実際の CI では Pull Request をきっかけに検証を実行することがよくあります。

この課題では、起動条件を `pull_request` に変更し、**イベントを変えると workflow の動くタイミングも変わる**ことを確認します。

### プラクティス

作成済みの workflow を修正し、Pull Request をきっかけに実行されるように変更してください。

条件は次のとおりです。

- `on` に `pull_request` を指定する
- `push` では実行されないようにする
- Pull Request を作成したときに workflow が実行されることを確認する

> ヒント:
> main 以外のブランチで変更を push し、そのブランチから Pull Request を作成すると確認しやすいです。

必要に応じて、次の公式ドキュメントを参照してください。

- [Events that trigger workflows](https://docs.github.com/en/actions/reference/events-that-trigger-workflows)
- [Workflow syntax for GitHub Actions - on](https://docs.github.com/ja/actions/reference/workflows-and-actions/workflow-syntax#on)

## 2-5. 複数の job を作る

workflow は 1 つ以上の job から構成されます。

step は同じ job の中で順番に実行されますが、job は workflow の中の独立した処理単位です。
job を分けることで、処理を役割ごとに分離できます。

GitHub Actions では、job は依存関係を指定しなければ並列に実行されます。
ここではまず、job を分けるとどうなるかを確認します。

### プラクティス

workflow に job を 2 つ定義してください。

条件は次のとおりです。

- 2 つの job を持つ workflow にする
- 1 つ目の job で `echo "job1"` を実行する
- 2 つ目の job で `echo "job2"` を実行する
- 2 つの job に依存関係は付けない

> ヒント: どちらの job も同じ `runs-on` を使って構いません。

必要に応じて、次の公式ドキュメントを参照してください。

- [Workflow syntax for GitHub Actions - jobs](https://docs.github.com/ja/actions/reference/workflows-and-actions/workflow-syntax#jobs)

## 2-6. `needs` で job の実行順を制御する

GitHub Actions では、job 同士の依存関係を `needs` で定義できます。

`needs` を使うと、「ある job が終わってから次の job を実行する」という関係を表現できます。
この仕組みを使うと、たとえば「テストが成功したら次の処理を実行する」といった流れを作れます。

この課題では、job の依存関係を定義し、実行順が変わることを確認します。

### プラクティス

前の課題で作成した 2 つの job に依存関係を追加してください。

条件は次のとおりです。

- 2 つ目の job が、1 つ目の job の完了後に実行される
- 2 つ目の job に `needs` を設定する
- 1 つ目の job で `echo "first job"` を実行する
- 2 つ目の job で `echo "second job"` を実行する
- job の実行順が変わることを確認する

必要に応じて、次の公式ドキュメントを参照してください。

- [Workflow syntax for GitHub Actions - jobs.<job_id>.needs](https://docs.github.com/ja/actions/reference/workflows-and-actions/workflow-syntax#jobsjob_idneeds)
- [Contexts reference](https://docs.github.com/en/actions/reference/workflows-and-actions/contexts?utm_source=chatgpt.com)

## このステップで押さえたいこと

このステップでは、GitHub Actions の基本を確認しました。

- workflow は `.github/workflows` 配下の YAML ファイルで定義する
- workflow は `on` で指定したイベントをきっかけに起動する
- workflow は 1 つ以上の `jobs` で構成される
- job の中では `steps` が順番に実行される
- `runs-on` で job の実行環境を指定する
- `needs` で job の実行順を制御する

次のステップでは、条件分岐や変数、artifacts を使って、workflow をもう少し実践的な形にしていきます。
