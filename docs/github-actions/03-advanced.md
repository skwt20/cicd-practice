# Step 3: 応用編

このステップでは、Step 2 で作成した workflow をベースに進めます。

Step 2 を実施済みの場合はそのまま続けてください。途中から取り組む場合は、`answers/github-actions/02-intro/2-6_needs.md` を参考に workflow を用意してから始めてください。

このステップでは、GitHub Actions の workflow をもう少し実践的な形にしていきます。

Step 2 では workflow の基本構造を扱いましたが、このステップでは **条件に応じて処理を切り替える方法**、**値を workflow の外に出して扱う方法**、**成果物を保存する方法** を確認します。

このステップでは、次のような要素を扱います。

- `if` を使った条件分岐
- イベントやブランチに応じた実行制御
- Actions secrets / variables の利用
- artifacts の利用

> 進め方：
>
> 各課題では、Step 2 で作成した workflow をベースに進めます。
> 課題に不要な step や job は削除し、その課題で確認したい内容だけが残るように整理してください。

## 3-1. `if` で step の実行条件を分ける

GitHub Actions では、`if` を使って step や job の実行条件を定義できます。

`if` には式を書き、条件が真のときだけその step や job が実行されます。

この課題では、Step 2 で扱った `needs` と組み合わせて、前の job の実行結果を条件に step を実行する形を確認します。

### プラクティス

次の条件を満たす workflow を作成してください。

条件は次のとおりです。

- workflow の起動条件は `push` にする
- `needs` を使って `job1` → `job2` の順に実行されるようにする
- `job2` に `if` を使った条件付き step を定義する
- その step は `job1` が成功したときだけ実行される
- 条件付き step では `echo "conditional step"` を実行する

> ヒント:
>
> - `job1` の実行結果は `needs` context から参照できます
> - 結果が成功のときは `'success'` になります

必要に応じて、次の公式ドキュメントを参照してください。

- [Expressions](https://docs.github.com/en/actions/concepts/workflows-and-actions/expressions)
- [Workflow syntax for GitHub Actions](https://docs.github.com/ja/actions/reference/workflows-and-actions/workflow-syntax)

> 確認：
>
> - 変更を push して workflow を実行する
> - `job2` の中で `conditional step` が実行されていることを確認する

## 3-2. イベントによって実行する step を変える

GitHub Actions では、workflow を起動したイベントの情報を参照できます。

たとえば `push` で起動したのか、`workflow_dispatch` で起動したのかを使って、実行する step を分けることができます。イベント種別は `github.event_name` で参照できます。

この課題では、イベントによって異なる step が実行されるようにします。

### プラクティス

次の条件を満たす workflow を作成してください。

条件は次のとおりです。

- workflow の起動条件に `push` と `workflow_dispatch` の両方を設定する
- `push` のときだけ実行される step を 1 つ定義する
- その step では `echo "run on push"` を実行する
- `workflow_dispatch` のときだけ実行される step を 1 つ定義する
- その step では `echo "run on workflow_dispatch"` を実行する

> ヒント:
>
> - イベント名は `github` context から参照できます

必要に応じて、次の公式ドキュメントを参照してください。

- [Events that trigger workflows](https://docs.github.com/actions/using-workflows/events-that-trigger-workflows?utm_source=chatgpt.com)
- [Contexts reference](https://docs.github.com/en/actions/reference/workflows-and-actions/contexts?utm_source=chatgpt.com)

> 確認：
>
> - 変更を push して workflow を実行する
> - GitHub の Actions 画面から手動実行する
> - push では `run on push` だけが実行されることを確認する
> - 手動実行では `run on workflow_dispatch` だけが実行されることを確認する

## 3-3. ブランチによって実行する step を変える

GitHub Actions では、どのブランチで workflow が動いているかも参照できます。

これを使うと、main ブランチのときだけ特定の処理を実行するといった制御ができます。実際の CI/CD でも、ブランチによって処理を分けることはよくあります。

### プラクティス

次の条件を満たす workflow を作成してください。

条件は次のとおりです。

- `if` を使ってブランチ条件を定義する
- main ブランチのときだけ実行される step を 1 つ定義する
- その step では `echo "run on main"` を実行する

> ヒント:
>
> - ブランチ情報は `github` context から参照できます
> - ブランチ名そのものではなく、ref の形式で格納されています

必要に応じて、次の公式ドキュメントを参照してください。

- [Contexts reference](https://docs.github.com/en/actions/reference/workflows-and-actions/contexts?utm_source=chatgpt.com)
- [Workflow syntax for GitHub Actions](https://docs.github.com/ja/actions/reference/workflows-and-actions/workflow-syntax?utm_source=chatgpt.com)

> 確認：
>
> - main 以外のブランチで push する
> - 必要に応じて main ブランチでも実行する
> - main 以外のブランチでは `run on main` が実行されないことを確認する
> - main ブランチでは `run on main` が実行されることを確認する

## 3-4. variables を使って値を外出しする

GitHub Actions では、workflow 内で使う値を変数として管理できます。

variables は機密情報ではない設定値を扱う用途に向いており、`vars` context から参照できます。

この課題では、workflow 内に直接文字列を書くのではなく、variable として参照する形を試します。

### プラクティス

次の条件を満たす workflow を作成してください。

条件は次のとおりです。

- リポジトリの Actions variables に `SAMPLE_MESSAGE` という名前の variable を作成する
- workflow の step でその variable を参照する
- `echo` で variable の値を出力する

> ヒント:
>
> - variable は GitHub のリポジトリ設定画面から追加できます
> - workflow の中では `vars` context を使って参照します

必要に応じて、次の公式ドキュメントを参照してください。

- [Store information in variables](https://docs.github.com/actions/learn-github-actions/variables?utm_source=chatgpt.com)
- [Variables reference](https://docs.github.com/en/actions/reference/workflows-and-actions/variables?utm_source=chatgpt.com)

> 確認
>
> - 変更を push して workflow を実行する
> - 実行ログに variable の値が表示されることを確認する

## 3-5. secrets を使って機密情報を扱う

secrets は、パスワードやトークンのような機密情報を安全に扱うための仕組みです。

GitHub Actions で secret を利用するには、GitHub 上で secret を作成し、workflow の中で `secrets` context から参照します。GitHub は secrets をそのままログに表示しないようマスクします。

この課題では、値を直接 YAML に書かずに secret から参照する形を試します。

### プラクティス

次の条件を満たす workflow を作成してください。

条件は次のとおりです。

- リポジトリの Actions secrets に `SAMPLE_SECRET` という名前の secret を作成する
- workflow の step でその secret を環境変数として受け取る
- 受け取った値を直接表示しない
- `echo "secret is set"` を実行する step を定義する

> ヒント:
>
> - secret は GitHub のリポジトリ設定画面から追加できます
> - workflow の中では `secrets` context を使って参照します
> - secret の値そのものを `echo` しないようにしてください

必要に応じて、次の公式ドキュメントを参照してください。

- [Using secrets in GitHub Actions](https://docs.github.com/actions/security-guides/using-secrets-in-github-actions?utm_source=chatgpt.com)
- [Secrets](https://docs.github.com/en/actions/concepts/security/secrets?utm_source=chatgpt.com)

> 確認
>
> - 変更を push して workflow を実行する
> - 実行ログに `secret is set` が表示されることを確認する
> - secret の値そのものは表示されないことを確認する

## 3-6. artifact を保存する

artifact は、workflow 実行中に作成したファイルを保存するための仕組みです。

artifact を使うと、workflow 実行後にファイルをダウンロードしたり、別の job に引き渡したりできます。

この課題では、まずファイルを 1 つ保存できるようにするところまでを確認します。

### プラクティス

次の条件を満たす workflow を作成してください。

条件は次のとおりです。

- step の中で `result.txt` というファイルを作成する
- `result.txt` の中に任意の文字列を書き込む
- `upload-artifact` を使って `result.txt` を保存する

> ヒント:
>
> - `upload-artifact` は GitHub が公式に提供する Action です
> - `uses` を使って呼び出し、`with` で保存先などのパラメータを指定します

必要に応じて、次の公式ドキュメントを参照してください。

- [About workflow artifacts](https://docs.github.com/en/actions/concepts/workflows-and-actions/workflow-artifacts)
- [Store and share data with workflow artifacts](https://docs.github.com/en/actions/tutorials/store-and-share-data?utm_source=chatgpt.com)
- [Downloading workflow artifacts](https://docs.github.com/actions/managing-workflow-runs/downloading-workflow-artifacts?utm_source=chatgpt.com)

> 確認
>
> - 変更を push して workflow を実行する
> - Actions の実行結果画面に artifact が表示されることを確認する
> - `result.txt` を artifact として確認できることを確認する

## このステップで押さえたいこと

このステップでは、GitHub Actions の workflow を実践的にするための要素を確認しました。

- `if` を使うと、step や job の実行条件を制御できる
- イベント条件やブランチ条件を使うと、状況に応じて処理を分けられる
- variables は機密ではない設定値を扱うために使う
- secrets は機密情報を安全に扱うために使う
- artifact を使うと、workflow の成果物を保存できる

次のステップでは、これらを踏まえて Terraform を GitHub Actions 上で実行し、CI の形に近づけていきます。
