======
VM作成
======

| 本書では、VM作成の機能の例と意味を以下に記載します。

概要
====
VMWareを介してVM（仮想マシン）を作成する機能です。

メニュー項目
============
サーバー作成
------------
VM作成を行うためのメニュー項目です。

.. figure:: /images/ja/templates/vmware/menuCS_v2-4.png
   :width: 800px
   :alt: サーバー作成メニュー画面

.. list-table:: メニュー項目一覧（サーバー作成）
   :widths: 18 18 12 12 12
   :header-rows: 1
   :align: left

   * -  項目
     -  説明
     -  入力必須
     -  入力方法
     -  制約事項
   * -  vCenter表示名
     -  vCenter内に作成されるVMの表示名を指定します。
     -  〇
     -  プルダウン選択
     -  ー
   * -  IPアドレス
     -  作成するVMに配布されるIPアドレスを指定します。
     -  〇
     -  プルダウン選択
     -  ー
   * -  フォルダ
     -  作成するVMを格納するフォルダ名を指定します。
     -  〇
     -  プルダウン選択
     -  ー
   * -  テンプレート
     -  作成するVMのテンプレート名を指定します。
     -  〇
     -  プルダウン選択
     -  ー
   * -  CPU
     -  作成するVMのCPU数を指定します。
     -  〇
     -  プルダウン選択
     -  ー
   * -  メモリ(MB)
     -  作成するVMのメモリ容量をMBで指定します。
     -  〇
     -  プルダウン選択
     -  ー
   * -  ディスク(GB)
     -  作成するVMのディスク容量をGBで指定します。
     -  〇
     -  プルダウン選択
     -  ー
   * -  申請者
     -  VM作成の申請者を入力します。
     -  〇
     -  手動入力
     -  最大長32バイト
   * -  用途
     -  作成するVMの用途を入力します。
     -  ー
     -  手動入力
     -  最大長128バイト


vCenter接続情報
---------------
vCenterに接続する情報を入力するためのメニュー項目です。

.. figure:: /images/ja/templates/vmware/menuVC_v2-4.png
   :width: 800px
   :alt: vCenter接続情報メニュー画面

.. list-table:: メニュー項目一覧（vCenter接続情報）
   :widths: 18 18 12 12 12
   :header-rows: 1
   :align: left

   * -  項目
     -  説明
     -  入力必須
     -  入力方法
     -  制約事項
   * -  vCenterホスト名
     -  vCenterに接続するホスト名を入力します。
     -  〇
     -  手動入力
     -  最大長64バイト
   * -  ユーザー名
     -  vCenterに接続するユーザー名を入力します。
     -  〇
     -  手動入力
     -  最大長32バイト
   * -  パスワード
     -  vCenterに接続するパスワードを入力します。
     -  〇
     -  手動入力
     -  パスワード形式
   * -  vCenterクラスター名
     -  vCenterに接続するvCenterのクラスター名を入力します。
     -  〇
     -  手動入力
     -  最大長64バイト


IPアドレス
----------
vCenter内に作成されるIPアドレスを入力するためのメニュー項目です。

.. figure:: /images/ja/templates/vmware/menuIP_v2-4.png
   :width: 800px
   :alt: IPアドレスメニュー画面

.. list-table:: メニュー項目一覧（IPアドレス）
   :widths: 8 18 12 12 12
   :header-rows: 1
   :align: left

   * -  項目
     -  説明
     -  入力必須
     -  入力方法
     -  制約事項
   * -  IPアドレス
     -  作成するVMに配布されるIPアドレスを入力します。
     -  〇
     -  手動入力
     -  最大長64バイト
   * -  サブネットマスク
     -  入力するIPアドレスに関係するサブネットマスクを入力します。
     -  〇
     -  手動入力
     -  最大長64バイト
   * -  デフォルトゲートウェイ
     -  入力するIPアドレスに関係するデフォルトゲートウェイを入力します。
     -  〇
     -  手動入力
     -  最大長64バイト
   * -  DNS名①
     -  入力するIPアドレスに関係する1つ目のDNS名を入力します。
     -  ー
     -  手動入力
     -  最大長64バイト
   * -  DNS名②
     -  入力するIPアドレスに関係する2つ目のDNS名を入力します。
     -  ー
     -  手動入力
     -  最大長64バイト


フォルダ名
----------
vCenter内に作成されるフォルダ名を入力するためのメニュー項目です。

.. figure:: /images/ja/templates/vmware/menuFN_v2-4.png
   :width: 800px
   :alt: フォルダ名メニュー画面

.. list-table:: メニュー項目一覧（フォルダ）
   :widths: 18 18 12 12 12
   :header-rows: 1
   :align: left

   * -  項目
     -  説明
     -  入力必須
     -  入力方法
     -  制約事項
   * -  フォルダ名
     -  作成するVMを格納するフォルダ名を入力します。
     -  〇
     -  手動入力
     -  最大長64バイト


テンプレート
------------
vCenter内に作成されるテンプレートを入力するためのメニュー項目です。

.. figure:: /images/ja/templates/vmware/menuTE_v2-4.png
   :width: 800px
   :alt: テンプレートメニュー画面

.. list-table:: メニュー項目一覧（テンプレート）
   :widths: 18 18 12 12 12
   :header-rows: 1
   :align: left

   * -  項目
     -  説明
     -  入力必須
     -  入力方法
     -  制約事項
   * -  テンプレート名
     -  作成するVMのテンプレート名を入力します。
     -  〇
     -  手動入力
     -  最大長64バイト
   * -  ルートディスク
     -  入力するテンプレートに関係するルートディスクを入力します。
     -  ー
     -  手動入力
     -  最大長32バイト
   * -  ボリュームグループ
     -  入力するテンプレートに関係するボリュームグループを入力します。
     -  ー
     -  手動入力
     -  最大長32バイト
   * -  ユーザー
     -  入力するテンプレートにログインするユーザーを入力します。
     -  〇
     -  手動入力
     -  最大長32バイト
   * -  パスワード
     -  入力するテンプレートにログインするパスワードを入力します。
     -  〇
     -  手動入力
     -  パスワード形式
   * -  ssh秘密鍵ファイル
     -  入力するテンプレートにログインするためのssh秘密鍵ファイルを指定します。
     -  ー
     -  ファイル選択
     -  最大サイズ100Mバイト
   * -  データストア
     -  接続するvCenter内のデータストア名を入力します。
     -  〇
     -  手動入力
     -  最大長64バイト
   * -  ネットワーク名
     -  接続するvCenter内のネットワーク名を入力します。
     -  〇
     -  手動入力
     -  最大長64バイト


CPU
---
vCenter内に作成されるVMのCPU数を入力するためのメニュー項目です。

.. figure:: /images/ja/templates/vmware/menuCPU_v2-4.png
   :width: 800px
   :alt: CPUメニュー画面

.. list-table:: メニュー項目一覧（CPU）
   :widths: 18 18 12 12 12
   :header-rows: 1
   :align: left

   * -  項目
     -  説明
     -  入力必須
     -  入力方法
     -  制約事項
   * -  CPU
     -  作成するVMのCPU数を入力します。
     -  〇
     -  手動入力
     -  最大長32バイト


メモリ(MB)
----------
vCenter内に作成されるVMのメモリ容量を入力するためのメニュー項目です。

.. figure:: /images/ja/templates/vmware/menuME_v2-4.png
   :width: 800px
   :alt: メモリメニュー画面

.. list-table:: メニュー項目一覧（メモリ(MB)）
   :widths: 18 18 12 12 12
   :header-rows: 1
   :align: left

   * -  項目
     -  説明
     -  入力必須
     -  入力方法
     -  制約事項
   * -  メモリ(MB)
     -  作成するVMのメモリ容量をMBで入力します。
     -  〇
     -  手動入力
     -  最大長32バイト


ディスク(GB)
------------
vCenter内に作成されるVMのディスク容量を入力するためのメニュー項目です。

.. figure:: /images/ja/templates/vmware/menuDC_v2-4.png
   :width: 800px
   :alt: ディスクメニュー画面

.. list-table:: メニュー項目一覧（ディスク(GB)）
   :widths: 18 18 12 12 12
   :header-rows: 1
   :align: left

   * -  項目
     -  説明
     -  入力必須
     -  入力方法
     -  制約事項
   * -  ディスク(GB)
     -  作成するVMのディスク容量をGBで入力します。
     -  〇
     -  手動入力
     -  最大長32バイト


操作方法
========
1.VMWareのメニューを選択します。

.. figure:: /images/ja/templates/vmware/mainmenu_v2-4.png
   :width: 800px
   :alt: メインメニュー画面

2.サーバー作成のメニューを選択します。

3.サーバー作成では、サーバー作成のメンテナンス(閲覧/登録/更新/廃止)ができます。サーバー作成の入力画面の項目は以下の通りです。

.. figure:: /images/ja/templates/vmware/createserver_v2-4.png
   :width: 800px
   :alt: サーバー作成入力画面
 
.. list-table:: 入力画面項目一覧（サーバー作成）
   :widths: 18 18 12 12 12
   :header-rows: 1
   :align: left

   * -  項目
     -  説明
     -  入力必須
     -  入力方法
     -  制約事項
   * -  vCenter表示名
     -  vCenter内に作成されるVMの表示名を指定します。
     -  〇
     -  プルダウン選択
     -  ー
   * -  IPアドレス
     -  作成するVMに配布されるIPアドレスを指定します。
     -  〇
     -  プルダウン選択
     -  ー
   * -  フォルダ
     -  作成するVMを格納するフォルダ名を指定します。
     -  〇
     -  プルダウン選択
     -  ー
   * -  テンプレート
     -  作成するVMのテンプレート名を指定します。
     -  〇
     -  プルダウン選択
     -  ー
   * -  CPU
     -  作成するVMのCPU数を指定します。
     -  〇
     -  プルダウン選択
     -  ー
   * -  メモリ(MB)
     -  作成するVMのメモリ容量をMBで指定します。
     -  〇
     -  プルダウン選択
     -  ー
   * -  ディスク(GB)
     -  作成するVMのディスク容量をGBで指定します。
     -  〇
     -  プルダウン選択
     -  ー
   * -  申請者
     -  VM作成の申請者を入力します。
     -  〇
     -  手動入力
     -  最大長32バイト
   * -  用途
     -  作成するVMの用途を入力します。
     -  ー
     -  手動入力
     -  最大長128バイト

4.メインメニューからConductorのメニューを選択します。

5.Condutor一覧のメニューを選択します。

6.詳細ボタンより、サーバー作成を選択します。

.. figure:: /images/ja/templates/vmware/conductorlist_v2-4.png
   :width: 800px
   :alt: Conductor一覧画面

7.作業実行ボタンをクリックします。

.. figure:: /images/ja/templates/vmware/conductorCS_v2-4.png
   :width: 800px
   :alt: Conductorサーバー作成画面

8.オペレーション選択ボタンより、サーバー作成を行うオペレーションを選択します。

9.スケジュールボタンより、サーバー作成を行う日時を選択します。

10.作業実行ボタンより、サーバー作成の作業を実行します。

.. figure:: /images/ja/templates/vmware/executeCS_v2-4.png
   :width: 800px
   :alt: サーバー作成作業実行画面


付録
====
モジュールを追加する必要があります。

1.RHEL環境に接続します。

2.以下のコマンドを入力し、クローンを作成します。

.. code-block:: 
   :caption: 形式

   sudo su -
   git clone https://github.com/exastro-suite/exastro-it-automation.git -b 2.2.0

3.クローン作成後、以下のコマンドを入力し、Dockerファイルのあるフォルダに移動し、Dockerファイルを開きます。

.. code-block:: 
   :caption: 形式

   cd exastro-it-automation
   vim ita_root/ita_by_ansible_execute/ita_ansible_agent/Dockerfile

4.Dockerファイル内の「useradd -m -s /bin/bash -g $GROUPNAME $USERNAME \」の記述がある行の下に、以下のコマンドを入力します。

.. code-block:: 
   :caption: 形式

   && ansible-galaxy collection install community.vmware

5.入力後、Dockerファイルの上書きを行います。

6.以下のコマンドを入力し、ビルドを行います。

.. code-block:: 
   :caption: 形式

   build --format=docker -f ita_root/ita_by_ansible_execute/ita_ansible_agent/Dockerfile -t exastro/ita-ansible-agent:2.3.0 .

7.以下のコマンドを入力し、ビルド後にできたtarファイルをITAに反映させます。

.. code-block:: 
   :caption: 形式

   podman save localhost/exastro/ita-ansible-agent:2.3.0 > /var/ita-agent1.tar
