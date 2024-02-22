.. _ita_maintenance_mode:

==================
メンテナンスモード
==================

はじめに
========

| 本書では、ITAにおける メンテナンスモード について説明します。
| メンテナンスモードの設定はシステム管理者のみ可能です（オーガナイゼーションユーザーからはアクセス出来ません）。

メンテナンスモードとは
======================

| データの閲覧は可能な状態で、データベースに対する登録・更新やバックヤード処理を止め、データベースのバックアップやバージョンアップをより安全に行うための機能です。
| メンテナンスモードは、システム上の全オーガナイゼーション・ワークスペースに対して適用されます。

.. _ita_maintenance_mode_purpose_of_use:

メンテナンスモードの利用用途
----------------------------

| メンテナンスモードには「BACKYARD_EXECUTE_STOP」と「DATA_UPDATE_STOP」の2つの種類があります。
| 「BACKYARD_EXECUTE_STOP」を有効にすると、作業実行などを行うバックヤード機能が、新たに処理を実行しなくなります。
| ただし「BACKYARD_EXECUTE_STOP」を有効にした時点ですでに動作している処理（ステータスが「準備中」「実行中」「実行中(遅延)」のもの）については、ステータスが「完了」「完了(異常)」「想定外エラー」となるまで処理が継続されます。
| 「DATA_UPDATE_STOP」を有効にすると、データベースに対する登録・更新を行うすべての機能が利用できなくなります。（各メニューからのデータの閲覧は可能です。）
| 詳細は「:ref:`ita_maintenance_mode_setting_value`」を参照してください。
|
| また「:ref:`ita_maintenance_mode_get_backyard_execute_check`」APIを利用し、ステータスが「準備中」「実行中」「実行中(遅延)」のバックヤード処理を一括で取得することができます。
| これらを利用し

- | 「BACKYARD_EXECUTE_STOP」を有効にする。
- | 「バックヤード起動状態一括取得」でステータスが「準備中」「実行中」「実行中(遅延)」の処理を確認し、無くなるまで待機する。
- | 「DATA_UPDATE_STOP」を有効にする。

| という手順を踏むことで、データベースのバックアップやバージョンアップを実行する前に、動作中のバックヤード処理を無くすことができます。

.. figure:: /images/ja/maintenance_mode/purpose_of_use.png
   :width: 600px
   :alt: メンテナンスモードの利用用途

   メンテナンスモードの利用用途

| メンテナンスモードを有効にすると、Web画面の上部にメンテナンス中である旨のメッセージが表示されます。

.. figure:: /images/ja/maintenance_mode/mode_message.png
   :width: 600px
   :alt: メンテナンスモード中のWeb画面

   メンテナンスモード中のWeb画面

.. _ita_maintenance_mode_setting_value:

メンテナンスモードの種類と設定値について
----------------------------------------

| メンテナンスモードの種類と設定値は以下です。

.. list-table:: メンテナンスモードの種類と設定値について
    :widths: 2 2 6
    :header-rows: 1
    :align: left

    * - 種類
      - 設定値
      - 説明
    * - BACKYARD_EXECUTE_STOP
      - 0(無効)もしくは1(有効)
      - | 以下のバックヤードが行う処理について、BACKYARD_EXECUTE_STOPが1(有効)である場合はステータスが「未実行」の状態で停止し、処理が行われないようになります。（作業実行などの登録自体は可能です。）
        | BACKYARD_EXECUTE_STOPを1(有効)にする前にステータスが「準備中」「実行中」「実行中(遅延)」となっている対象については「完了」「完了(異常)」「想定外エラー」となるまで処理が行われます。
        | - ita-by-ansible-execute(Ansible作業実行)
        | - ita-by-terraform-cloud-ep-execute(Terraform Cloud/EP作業実行)
        | - ita-by-terraform-cli-execute(Terraform CLI作業実行)
        | - ita-by-menu-create(パラメータシート作成)
        | - ita-by-menu-export-import(メニューエクスポート・インポート)
        | - ita-by-excel-export-import(Excel一括エクスポート・インポート)
    * - DATA_UPDATE_STOP
      - 0(無効)もしくは1(有効)
      - | データの登録/更新が発生するすべての機能が利用できなくなり、すべてのバックヤードが行う処理についても停止されます。
        | **各メニューからのデータの閲覧は可能となります。**
        | 利用できなくなる主な機能は以下です。
        | - 各メニューからのデータ登録/更新
        | - Conductor作成および作業実行
        | - 各ドライバーの作業実行
        | - パラメータシート定義・作成の実行
        | - メニューエクスポート・インポートの実行
        | - Excel一括エクスポート・インポートの実行
        | - ログレベルの変更
        | - オーガナイゼーションの作成
        | - ワークスペースの作成・更新・削除


メンテナンスモードの確認、設定変更について
==========================================

前提条件
--------

| 本作業には下記のコマンドが必要となるため、事前にインストールをしてください。

- 作業クライアントに必要なアプリケーション

  - :kbd:`curl`
  - :kbd:`git`
  - :kbd:`jq`

メンテナンスモード設定の流れ
----------------------------

| メンテナンスモードの設定を変更する流れは以下の通りとなります。

- | 事前準備
- | 現状のメンテナンスモードの確認
- | メンテナンスモードの設定を作成
- | メンテナンスモードの変更を設定


メンテナンスモード設定確認、設定手順
====================================

.. _ita_maintenance_mode_preparation:

事前準備
--------

| GitHub リポジトリから取得した資材の中にある、シェルスクリプトを実行しオーガナイゼーションを作成します。
| confファイルは、各種設定・取得シェルで使用します。

#. メンテナンスモードの確認、設定のシェルスクリプトを、リポジトリから :kbd:`git clone` により取得します。

   .. code-block:: bash

      # Exastro Platform の資材を入手
      git clone https://github.com/exastro-suite/exastro-platform.git


#. 取得した資材のtoolsフォルダに移動し、API設定ファイル（ :file:`api-auth.conf` ）のAPI実行先URLを、システム管理者用サイトアドレスに変更します。

   .. code-block:: bash

      vi api-auth.conf

   | 変更箇所

   - api-auth.conf

     .. code-block:: bash

        CONF_BASE_URL={システム管理者用サイトアドレス}
        CURL_OPT=-svk

   .. tip::
       | 自己証明書を利用している場合、証明書エラーが発生します。
       | 設定ファイル内の :kbd:`CURL_OPT=-sv` を :kbd:`CURL_OPT=-svk` に変更することで証明書エラーを回避できますが、認証機関から発行された正しい証明書をインストールすることを推奨します。


.. _ita_maintenance_mode_confirm:

メンテナンスモードの確認
------------------------

| メンテナンスモードの設定変更にあたって、現在のメンテナンスモードの状態を確認します。

- コマンド

  .. code-block:: bash

     ./get-maintenance-mode-setting.sh


- コマンド実行後に入力（入力例）

  .. code-block:: bash

     your username : システム管理者自身のユーザー名を入力します
     your password : システム管理者自身のパスワードを入力します

- 成功時の結果表示

  | `"result": "000-00000"` が、成功したことを示しています。

  .. code-block:: bash

      < HTTP/1.1 200 OK
      < Date: Tue, 10 Oct 2023 05:19:39 GMT
      < Content-Type: application/json
      < Content-Length: 135
      < Connection: keep-alive
      <
      { [data not shown]
      * Connection #0 to host platform-auth left intact
      {
        "data": {
          "backyard_execute_stop": "0",
          "data_update_stop": "0"
        },
        "message": "SUCCESS",
        "result": "000-00000",
        "ts": "2023-10-10T05:19:39.837Z"
      }


- RestAPIを直接呼び出す場合は以下の内容で呼び出すことが出来ます。

  .. code-block:: bash

      BASE64_BASIC=$(echo -n "システム管理者のユーザー名を設定してください:システム管理者のパスワードを設定してください" | base64)
      BASE_URL=システム管理者用サイトアドレスを設定してください

      curl -k -X GET \
          -H "Content-Type: application/json" \
          -H "Authorization: basic ${BASE64_BASIC}" \
          "${BASE_URL}/api/platform/maintenance-mode-setting"


.. _ita_maintenance_mode_create_json:

メンテナンスモードの設定を作成
------------------------------

- 変更するメンテナンスモードのjsonファイルを設定

  | 取得した toolsフォルダ配下にある、 `update-maintenance-mode-setting.sample.json` を コピーして使用してください。
  | 「:ref:`ita_maintenance_mode_setting_value`」を参考に、変更する種類の設定値に0(無効)もしくは1(有効)を指定してください。


- 変更するメンテナンスモードの設定

  | update-maintenance-mode-setting.jsonにコピーした例

  .. code-block:: bash

      vi update-maintenance-mode-setting.json


  | 変更前

  .. code-block:: bash

      {
          "backyard_execute_stop": "0",
          "data_update_stop": "0"
      }


  | 変更後

  .. code-block:: bash
     :caption: 例:「backyard_execute_stop」を「1(有効)」へ変更

      {
          "backyard_execute_stop": "1",
          "data_update_stop": "0"
      }

.. _ita_maintenance_mode_change_settings:

メンテナンスモードの設定を変更
------------------------------

- コマンド

  .. code-block:: bash

      ./update-maintenance-mode-setting.sh update-maintenance-mode-setting.json


- コマンド実行後に入力（入力例）

  .. code-block:: bash

      your username : システム管理者自身のユーザー名を入力します
      your password : システム管理者自身のパスワードを入力します
      Update setting, are you sure? (Y/other) : 実行する場合は"Y"を入力します

- 成功時の結果表示

  | `"result": "000-00000"` が、成功したことを示しています。

  .. code-block:: bash

      < HTTP/1.1 200 OK
      < Date: Tue, 10 Oct 2023 07:36:26 GMT
      < Content-Type: application/json
      < Content-Length: 87
      < Connection: keep-alive
      <
      { [data not shown]
      * Connection #0 to host platform-auth left intact
      {
        "data": null,
        "message": "SUCCESS",
        "result": "000-00000",
        "ts": "2023-10-10T07:36:26.127Z"
      }

- 失敗時の結果表示イメージ

  .. code-block:: bash

      < HTTP/1.1 400 BAD REQUEST
      < Date: Tue, 10 Oct 2023 07:40:37 GMT
      < Content-Type: application/json
      < Content-Length: 217
      < Connection: keep-alive
      <
      { [data not shown]
      * Connection #0 to host platform-auth left intact
      {
        "data": null,
        "message": "設定値に「0/1」以外が指定されています。(backyard_execute_stop:3) ",
        "result": "400-00027",
        "ts": "2023-10-10T07:40:37.679Z"
      }

- RestAPIを直接呼び出す場合は以下の内容で呼び出すことができます。

  .. code-block:: bash

    BASE64_BASIC=$(echo -n "システム管理者のユーザー名を設定してください:システム管理者のパスワードを設定してください" | base64)
    BASE_URL=システム管理者用サイトアドレスを設定してください

    curl -k -X PATCH \
        -H "Content-Type: application/json" \
        -H "Authorization: basic ${BASE64_BASIC}" \
        -d  @- \
        "${BASE_URL}/api/platform/maintenance-mode-setting" \
        << EOF
        {
            "backyard_execute_stop": "1",
            "data_update_stop": "0"
        }
        EOF

| 設定変更後の確認は、「:ref:`ita_maintenance_mode_confirm`」を参照してください。

.. _ita_maintenance_mode_get_backyard_execute_check:

バックヤード起動状態一括取得
============================

| システム上のすべてのオーガナイゼーションおよびワークスペースにおける、以下のバックヤードが行う処理についてステータスが「準備中」「実行中」「実行中(遅延)」である対象を取得します。

- | ita-by-conductor-synchronize(Conductor作業実行)
- | ita-by-ansible-execute(Ansible作業実行)
- | ita-by-terraform-cloud-ep-execute(Terraform Cloud/EP作業実行)
- | ita-by-terraform-cli-execute(Terraform CLI作業実行)
- | ita-by-menu-create(パラメータシート作成)
- | ita-by-menu-export-import(メニューエクスポート・インポート)
- | ita-by-excel-export-import(Excel一括エクスポート・インポート)

| また、システム単位/各オーガナイゼーション単位/各ワークスペース単位でステータス「準備中」「実行中」「実行中(遅延)」である処理のカウントを取得できます。
| \ **※このカウントについては「ita-by-conductor-synchronize(Conductor作業実行)」のステータスが「準備中」「実行中」「実行中(遅延)」であるものは含まれません。**\
| （Conductor内で実行される各ドライバの処理はカウントされます。）


バックヤード起動状態一括取得の実行
----------------------------------

| 利用前に必要な準備として「:ref:`ita_maintenance_mode_preparation`」を参照してください。

- コマンド

  .. code-block:: bash

      ./get-backyard-execute-check.sh


- コマンド実行後に入力（入力例）

  .. code-block:: bash

      your username : システム管理者自身のユーザー名を入力します
      your password : システム管理者自身のパスワードを入力します


- 成功時の結果表示

  | `"result": "000-00000"` が、成功したことを示しています。

  .. code-block:: bash

      < HTTP/1.1 200 OK
      < Date: Tue, 10 Oct 2023 07:59:09 GMT
      < Content-Type: application/json
      < Content-Length: 2449
      < Connection: keep-alive
      <
      { [data not shown]
      * Connection #0 to host platform-auth left intact
      {
        "data": {
          "execute_count": 3,  # システム全体でのステータス「準備中」「実行中」「実行中(遅延)」対象のカウント（ita-by-conductor-synchronizeを含まない）
          "organizations": [
            {
              "id": "Organization_01",# システム上のオーガナイゼーション
              "execute_count": 2,  # オーガナイゼーション単位でのステータス「準備中」「実行中」「実行中(遅延)」対象のカウント（ita-by-conductor-synchronizeを含まない）
              "workspaces": [
                {
                  "id": "Workspace_01",  # オーガナイゼーション上のワークスペース
                  "execute_count": 2,  # ワークスペース単位でのステータス「準備中」「実行中」「実行中(遅延)」対象のカウント（ita-by-conductor-synchronizeを含まない）
                  "backyards": {  # 各バックヤード機能でステータスが「準備中」「実行中」「実行中(遅延)」の対象がある場合、対象のID, 最終更新日時, ステータスID, ステータス名称が格納されます
                    "ita-by-ansible-execute": [
                      {
                        "id": "965dfd15-b741-4dd8-9136-00e505b14c44",
                        "last_update_timestamp": "2023-10-10T16:58:18.748121Z",
                        "status_id": "3",
                        "status_name": "実行中"
                      },
                      {
                        "id": "f3d52038-cb76-470f-ab7e-1898df107a87",
                        "last_update_timestamp": "2023-10-10T16:58:39.247824Z",
                        "status_id": "3",
                        "status_name": "実行中"
                      }
                    ],
                    "ita-by-conductor-synchronize": [
                      {
                        "id": "6b9743ab-73fd-49e9-b20b-910f00546827",
                        "last_update_timestamp": "2023-10-10T16:55:04.053156Z",
                        "status_id": "3",
                        "status_name": "実行中"
                      },
                      {
                        "id": "9b8ab1d7-b2f7-4e78-8529-e79b63ce495b",
                        "last_update_timestamp": "2023-10-10T16:50:02.175727Z",
                        "status_id": "3",
                        "status_name": "実行中"
                      }
                    ],
                    "ita-by-excel-export-import": [],
                    "ita-by-menu-create": [],
                    "ita-by-menu-export-import": [],
                    "ita-by-terraform-cli-execute": [],
                    "ita-by-terraform-cloud-ep-execute": []
                  }
                }
              ]
            },
            {
              "id": "Organization_02",  # システム上のオーガナイゼーション
              "execute_count": 1,  # オーガナイゼーション単位でのステータス「準備中」「実行中」「実行中(遅延)」対象のカウント（ita-by-conductor-synchronizeを含まない）
              "workspaces": [
                {
                  "id": "Workspace_01",  # オーガナイゼーション上のワークスペース
                  "execute_count": 0,  # ワークスペース単位でのステータス「準備中」「実行中」「実行中(遅延)」対象のカウント（ita-by-conductor-synchronizeを含まない）
                  "backyards": {
                    "ita-by-ansible-execute": [],
                    "ita-by-conductor-synchronize": [],
                    "ita-by-excel-export-import": [],
                    "ita-by-menu-create": [],
                    "ita-by-menu-export-import": [],
                    "ita-by-terraform-cli-execute": [],
                    "ita-by-terraform-cloud-ep-execute": []
                  }
                },
                {
                  "id": "Workspace_02",  # オーガナイゼーション上のワークスペース
                  "execute_count": 1,  # ワークスペース単位でのステータス「準備中」「実行中」「実行中(遅延)」対象のカウント（ita-by-conductor-synchronizeを含まない）
                  "backyards": {  # 各バックヤード機能でステータスが「準備中」「実行中」「実行中(遅延)」の対象がある場合、対象のID, 最終更新日時, ステータスID, ステータス名称が格納されます
                    "ita-by-ansible-execute": [],
                    "ita-by-conductor-synchronize": [],
                    "ita-by-excel-export-import": [],
                    "ita-by-menu-create": [],
                    "ita-by-menu-export-import": [],
                    "ita-by-terraform-cli-execute": [],
                    "ita-by-terraform-cloud-ep-execute": [
                      {
                        "id": "da1ac029-5e2d-45d7-8516-3c54edbad45d",
                        "last_update_timestamp": "2023-10-10T17:13:58.744328Z",
                        "status_id": "3",
                        "status_name": "実行中"
                      }
                    ]
                  }
                }
              ]
            }
          ]
        },
        "message": "SUCCESS",
        "result": "000-00000",
        "ts": "2023-10-10T07:59:05.079Z"
      }

  | 以下の例のように、execute_countが0になった後に「DATA_UPDATE_STOP」を1(有効)に設定することを推奨します。

  .. code-block:: bash

      < HTTP/1.1 200 OK
      < Date: Tue, 10 Oct 2023 07:59:09 GMT
      < Content-Type: application/json
      < Content-Length: 2449
      < Connection: keep-alive
      <
      { [data not shown]
      * Connection #0 to host platform-auth left intact
      {
        "data": {
          "execute_count": 0,  # システム全体でのステータス「準備中」「実行中」「実行中(遅延)」対象のカウント（ita-by-conductor-synchronizeを含まない）
          "organizations": [
            {
              "id": "Organization_01",  # システム上のオーガナイゼーション
              "execute_count": 0,  # オーガナイゼーション単位でのステータス「準備中」「実行中」「実行中(遅延)」対象のカウント（ita-by-conductor-synchronizeを含まない）
              "workspaces": [
                {
                  "id": "Workspace_01",  # オーガナイゼーション上のワークスペース
                  "execute_count": 0,  # ワークスペース単位でのステータス「準備中」「実行中」「実行中(遅延)」対象のカウント（ita-by-conductor-synchronizeを含まない）
                  "backyards": {  # 各バックヤード機能でステータスが「準備中」「実行中」「実行中(遅延)」の対象がある場合、対象のID, 最終更新日時, ステータスID, ステータス名称が格納されます
                    "ita-by-ansible-execute": [],
                    "ita-by-conductor-synchronize": [
                      {
                        "id": "6b9743ab-73fd-49e9-b20b-910f00546827",
                        "last_update_timestamp": "2023-10-10T16:55:04.053156Z",
                        "status_id": "3",
                        "status_name": "実行中"
                      },
                      {
                        "id": "9b8ab1d7-b2f7-4e78-8529-e79b63ce495b",
                        "last_update_timestamp": "2023-10-10T16:50:02.175727Z",
                        "status_id": "3",
                        "status_name": "実行中"
                      }
                    ],
                    "ita-by-excel-export-import": [],
                    "ita-by-menu-create": [],
                    "ita-by-menu-export-import": [],
                    "ita-by-terraform-cli-execute": [],
                    "ita-by-terraform-cloud-ep-execute": []
                  }
                }
              ]
            },
            {
              "id": "Organization_02",  # システム上のオーガナイゼーション
              "execute_count": 0,  # オーガナイゼーション単位でのステータス「準備中」「実行中」「実行中(遅延)」対象のカウント（ita-by-conductor-synchronizeを含まない）
              "workspaces": [
                {
                  "id": "Workspace_01",  # オーガナイゼーション上のワークスペース
                  "execute_count": 0,  # ワークスペース単位でのステータス「準備中」「実行中」「実行中(遅延)」対象のカウント（ita-by-conductor-synchronizeを含まない）
                  "backyards": {
                    "ita-by-ansible-execute": [],
                    "ita-by-conductor-synchronize": [],
                    "ita-by-excel-export-import": [],
                    "ita-by-menu-create": [],
                    "ita-by-menu-export-import": [],
                    "ita-by-terraform-cli-execute": [],
                    "ita-by-terraform-cloud-ep-execute": []
                  }
                },
                {
                  "id": "Workspace_02",  # オーガナイゼーション上のワークスペース
                  "execute_count": 0,  # ワークスペース単位でのステータス「準備中」「実行中」「実行中(遅延)」対象のカウント（ita-by-conductor-synchronizeを含まない）
                  "backyards": {  # 各バックヤード機能でステータスが「準備中」「実行中」「実行中(遅延)」の対象がある場合、対象のID, 最終更新日時, ステータスID, ステータス名称が格納されます
                    "ita-by-ansible-execute": [],
                    "ita-by-conductor-synchronize": [],
                    "ita-by-excel-export-import": [],
                    "ita-by-menu-create": [],
                    "ita-by-menu-export-import": [],
                    "ita-by-terraform-cli-execute": [],
                    "ita-by-terraform-cloud-ep-execute": []
                  }
                }
              ]
            }
          ]
        },
        "message": "SUCCESS",
        "result": "000-00000",
        "ts": "2023-10-10T07:59:05.079Z"
      }


- RestAPIを直接呼び出す場合は以下の内容で呼び出すことが出来ます。

  .. code-block:: bash

      BASE64_BASIC=$(echo -n "システム管理者のユーザー名を設定してください:システム管理者のパスワードを設定してください" | base64)
      BASE_URL=システム管理者用サイトアドレスを設定してください

      curl -k -X GET \
          -H "Content-Type: application/json" \
          -H "Authorization: basic ${BASE64_BASIC}" \
          "${BASE_URL}/api/ita/backyard-execute-check/"

