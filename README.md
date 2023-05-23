# exastro-it-automation-docs

[![RST2HTML](../../actions/workflows/rst2html.yaml/badge.svg?branch=main)](../../actions/workflows/rst2html.yaml) 
[![pages-build-deployment](../../actions/workflows/pages/pages-build-deployment/badge.svg)](../../actions/workflows/pages/pages-build-deployment) 

## ドキュメント開発

## 前提条件

1. 自身の開発PC上にVSCodeがインストール済みであること
1. VSCodeから開発サーバに対して拡張機能「Remote - SSH」を使ってログインできること
1. 開発サーバは、CentOS 7もしくはAlmaLinuxであること
1. 開発サーバ上にDocker環境が構築済みであること
1. 開発サーバは個人用に設定済みの環境であること
1. `~/.gitconfig` の設定が個人のものとなっていること

### 各リポジトリをフォーク

下記の exastro-suite にある各リポジトリを自身のアカウントのリポジトリにフォークする。
- [exastro-it-automation-docs-dev をフォーク](https://github.com/exastro-suite/exastro-it-automation-docs-dev/fork)

### 各リポジトリのクローン

1. 作業用のサーバにログインする
2. 下記のコマンドを実行し、exastro-it-automation-docs-dev リポジトリをクローンする
   ```bash
   # 自身のGitHubアカウントを変数に格納
   # your-github-account を自身のGitHubアカウント名に変更
   MY_GITHUB_ACCOUNT="your-github-account"
   
   # 作業用のディレクトリを作成
   mkdir ~/${MY_GITHUB_ACCOUNT}
   
   # exastro-it-automation-docs-dev のフォークリポジトリをクローンする
   cd ~/${MY_GITHUB_ACCOUNT}
   git clone https://github.com/${MY_GITHUB_ACCOUNT}/exastro-it-automation-docs-dev.git
   ```

### ドキュメントの作成・更新

1. VSCode の拡張機能の"Remote - SSH"を使って、開発サーバにログインする
2. 「ファイル」-「ファイルでワークスペースを開く」から上記でクローンしたexastro-it-automation-docs内にある「exastro-it-automation-docs.code-workspace」を開く。
3. 左下のRemote接続用の「><」アイコンをクリックし、「Reopen in Container」を開く。
4. あとはexastro-it-automation-docs配下のファイルを編集する。

### 編集中のドキュメントの確認
下記の拡張機能をインストールし、プレビュー画面で確認する。

- lextudio.restructuredtext
- lextudio.restructuredtext-pack
- trond-snekvik.simple-rst
- searKing.preview-vscode

### 画面確認

http://127.0.0.1:8000


## ドキュメント公開

### コンテンツ公開

GitHub Pages の設定を行い、コンテンツを公開状態にします。

1. GitHub の自身のリポジトリを開きます。

   例) https://github.com/your-github-account/exastro-it-automation-docs-dev/settings

2. 左メニューから `Pages` をクリックし、`Branch` 項目に `Main` ブランチと `/docs` ディレクトリを選択し、 `Save` ボタンを押下します。

![image](https://user-images.githubusercontent.com/83527822/222101080-539bfe17-8814-48b1-b624-0f99ef4bbc8d.png)

### コンテンツ自動生成

Exastro IT Automation のドキュメントは reStructuredText 形式で記述されています。
通常、reStructuredText はビルドをすることで HTML 形式に変換をしますが、本プロジェクトでは GitHub Actions を利用することで自動的にビルドを行っています。
以下は、自動ビルドをするにあたり必要となる公開鍵と秘密鍵の登録方法について紹介します。

#### Deploy keys の作成

GitHub Actionsで自動生成したファイルをコミットするためにプロジェクトの Deploy keys を設定します。
以下のコマンドにより公開鍵と秘密鍵のペアを生成します。

```
ssh-keygen -t rsa -b 4096 -C "$(git config user.email)" -f my-repo -N ""
```

- my-repo.pub (公開鍵)
- my-repo (秘密鍵)

#### Deploy keys (公開鍵)の登録
公開鍵は、プロジェクトの `Settings -> Deploy Keys` の `Add deploy key` で登録します。 \
Title は `My Deploy Key` とします。 \
また、このとき `Allow write access` にチェックを入れます。

![image](https://user-images.githubusercontent.com/83527822/207450456-abc28de9-fc5e-4c16-afe7-ee6d12c20211.png)

![image](https://user-images.githubusercontent.com/83527822/207450638-c5e90050-acc5-485f-8011-733b3cceff59.png)

##### Secrets (秘密鍵)の登録

秘密鍵は `Settings -> Secret and variables -> Actions` の `New repository secret` で登録します。 \
Secret は `MY_ACTIONS_DEPLOY_KEY` という名前で登録します。

![image](https://user-images.githubusercontent.com/83527822/207450910-d48a2843-2c92-4e20-a0f7-db3290a98d93.png)

![image](https://user-images.githubusercontent.com/83527822/207450979-5ed43396-7882-4571-8dc0-cc0b996fbded.png)
