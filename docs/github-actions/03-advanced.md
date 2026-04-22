# Step 3: 応用編

このステップでは、Step 2 で作成した workflow をベースに進めます。
途中から取り組む場合は、`answers/github-actions/02-intro/2-6_needs.md`を利用してください。

このステップでは、GitHub Actions の workflow をもう少し実践的な形にしていきます。

Step 2 では workflow の基本構造を扱いましたが、このステップでは **条件に応じて実行を変えること**、**値を安全に扱うこと**、**job の成果物を残すこと** を学びます。GitHub Actions では、条件式に `if` を使い、イベント情報やブランチ名などの context を参照して挙動を変えられます。

ここで扱うのは、次の要素です。

- 条件分岐
  - `if`
  - イベント条件
  - ブランチ条件
- Actions secrets / variables の利用
- artifacts の利用

## 3-1. `if` で step の実行条件を分ける

GitHub Actions では、`if` を使って step や job の実行条件を定義できます。

`if` には式を書き、条件が真のときだけその step や job が実行されます。式の中では `github` context などを参照できます。

まずは、単純な条件分岐として、特定の条件でだけ step が実行される形を作ります。

### プラクティス

Step 2 で作成した workflow を修正し、`if` を使った step の条件分岐を追加してください。

条件は次のとおりです。

- 同じ job の中に step を 2 つ定義する
- 1 つ目の step は常に実行する
- 2 つ目の step は `if` を使って条件付きで実行する
- 条件付き step では `echo "conditional step"` を実行する
- 実行ログを見て、条件付き step の実行有無を確認する

> ヒント:
> 
> - `if` は step に対して指定できます
> - 最初は `if: ${{ true }}` のような単純な条件で試すと確認しやすいです

必要に応じて、次の公式ドキュメントを参照してください。

- [Expressions](https://docs.github.com/en/actions/concepts/workflows-and-actions/expressions)
- [Workflow syntax for GitHub Actions](https://docs.github.com/ja/actions/reference/workflows-and-actions/workflow-syntax?utm_source=chatgpt.com)

## 3-2. イベントによって実行する step を変える

GitHub Actions では、workflow を起動したイベントの情報を参照できます。

たとえば `pull_request` で起動したのか、`workflow_dispatch` で起動したのかを使って、実行する step を分けることができます。イベント種別は `github.event_name` で参照できます。

この課題では、イベントによって異なる step が実行されるようにします。

### プラクティス

workflow を修正し、イベント種別に応じて実行する step を切り替えてください。

条件は次のとおりです。

- workflow の起動条件に `pull_request` と `workflow_dispatch` の両方を設定する
- `pull_request` のときだけ実行される step を 1 つ定義する
- その step では `echo "run on pull_request"` を実行する
- `workflow_dispatch` のときだけ実行される step を 1 つ定義する
- その step では `echo "run on workflow_dispatch"` を実行する

> ヒント:
> 
> - `if` の中でイベント名を参照します
> - イベント名は `github` context に含まれています

必要に応じて、次の公式ドキュメントを参照してください。

- [Events that trigger workflows](https://docs.github.com/actions/using-workflows/events-that-trigger-workflows?utm_source=chatgpt.com)
- [Contexts reference](https://docs.github.com/en/actions/reference/workflows-and-actions/contexts?utm_source=chatgpt.com)

## 3-3. ブランチによって実行する step を変える

GitHub Actions では、どのブランチで workflow が動いているかも参照できます。

これを使うと、main ブランチのときだけ特定の処理を実行するといった制御ができます。実際の CI/CD でも、ブランチによって処理を分けることはよくあります。context ではブランチや ref の情報を参照できます。

### プラクティス

workflow を修正し、main ブランチのときだけ実行される step を追加してください。

条件は次のとおりです。

- `if` を使ってブランチ条件を定義する
- main ブランチのときだけ実行される step を 1 つ追加する
- その step では `echo "run on main"` を実行する
- main 以外のブランチでは実行されないことを確認する

> ヒント:
> 
> - ブランチ名そのものではなく、ref の形で入っている場合があります
> - 実行ログから、期待した条件で step が動いているかを確認してください

必要に応じて、次の公式ドキュメントを参照してください。

- [Contexts reference](https://docs.github.com/en/actions/reference/workflows-and-actions/contexts?utm_source=chatgpt.com)
- [Workflow syntax for GitHub Actions](https://docs.github.com/ja/actions/reference/workflows-and-actions/workflow-syntax?utm_source=chatgpt.com)

## 3-4. variables を使って値を外出しする

GitHub Actions では、workflow 内で使う値を変数として管理できます。

variables は機密情報ではない設定値を扱う用途に向いており、`vars` context から参照できます。GitHub の公式ドキュメントでも、機密性が必要な場合は variables ではなく secrets を使うよう案内されています。

この課題では、workflow 内に直接文字列を書くのではなく、variable として参照する形にします。

### プラクティス

リポジトリに GitHub Actions 用の variable を 1 つ作成し、workflow から参照してください。

条件は次のとおりです。

- リポジトリの Actions variables に `SAMPLE_MESSAGE` という名前の variable を作成する
- workflow の step でその variable を参照する
- `echo` で variable の値を出力する
- workflow が正常に実行される

> ヒント:
> 
> - variable は GitHub のリポジトリ設定画面から追加できます
> - workflow の中では `vars` context を使って参照します

必要に応じて、次の公式ドキュメントを参照してください。

- [Store information in variables](https://docs.github.com/actions/learn-github-actions/variables?utm_source=chatgpt.com)
- [Variables reference](https://docs.github.com/en/actions/reference/workflows-and-actions/variables?utm_source=chatgpt.com)

## 3-5. secrets を使って機密情報を扱う

secrets は、パスワードやトークンのような機密情報を安全に扱うための仕組みです。

GitHub Actions で secret を利用するには、GitHub 上で secret を作成し、workflow の中で `secrets` context から参照します。GitHub は secrets をそのままログに表示しないようマスクします。

この課題では、値を直接 YAML に書かずに secret から参照する形を試します。

### プラクティス

リポジトリに GitHub Actions 用の secret を 1 つ作成し、workflow から参照してください。

条件は次のとおりです。

- リポジトリの Actions secrets に `SAMPLE_SECRET` という名前の secret を作成する
- workflow の step でその secret を環境変数として受け取る
- 受け取った値を直接表示しない
- `echo "secret is set"` を実行する step を追加する

> ヒント:
> 
> - secret の値そのものを `echo` しないようにしてください
> - workflow の中では `secrets` context を使って参照します

必要に応じて、次の公式ドキュメントを参照してください。

- [Using secrets in GitHub Actions](https://docs.github.com/actions/security-guides/using-secrets-in-github-actions?utm_source=chatgpt.com)
- [Secrets](https://docs.github.com/en/actions/concepts/security/secrets?utm_source=chatgpt.com)

## 3-6. artifact を保存する

artifact は、workflow 実行中に作成したファイルを保存するための仕組みです。

artifact を使うと、workflow 実行後にファイルをダウンロードしたり、別の job に引き渡したりできます。GitHub は artifact の保存と取得のために `upload-artifact` と `download-artifact` の action を提供しています。

この課題では、workflow の中でファイルを 1 つ作成し、それを artifact として保存します。

### プラクティス

workflow を修正し、作成したファイルを artifact として保存してください。

条件は次のとおりです。

- step の中で `result.txt` というファイルを作成する
- `result.txt` の中に任意の文字列を書き込む
- `upload-artifact` を使って `result.txt` を保存する
- Actions の実行結果から artifact が確認できる

> ヒント:
> 
> - artifact には名前を付けられます
> - まずは 1 ファイルだけ保存できれば十分です

必要に応じて、次の公式ドキュメントを参照してください。

- [About workflow artifacts](https://docs.github.com/en/actions/concepts/workflows-and-actions/workflow-artifacts)
- [Store and share data with workflow artifacts](https://docs.github.com/en/actions/tutorials/store-and-share-data?utm_source=chatgpt.com)
- [Downloading workflow artifacts](https://docs.github.com/actions/managing-workflow-runs/downloading-workflow-artifacts?utm_source=chatgpt.com)

## このステップで押さえたいこと

このステップでは、GitHub Actions の workflow を実践的にするための要素を確認しました。

- `if` を使うと、step や job の実行条件を制御できる
- イベント条件やブランチ条件を使うと、状況に応じて処理を分けられる
- variables は機密ではない設定値を扱うために使う
- secrets は機密情報を安全に扱うために使う
- artifact を使うと、workflow の成果物を保存できる

次のステップでは、これらを踏まえて Terraform を GitHub Actions 上で実行し、CI の形に近づけていきます。
