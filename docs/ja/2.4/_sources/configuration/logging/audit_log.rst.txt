========
監査ログ
========

はじめに
--------

| Exastroシステムでは、APIベースで処理しているため、誰がいつどこで何をしたかを特定するためのログを監査ログとして出力しております。
| 本説明は、その監査ログについての設定値等を記載する内容となっております。

.. _security_audit_log:

監査ログの出力先
----------------

| 監査ログは、platform-auth コンテナ内の"/var/log/exastro"ディレクトリに、ファイル名"exastro-audio.log"(デフォルト)で出力されます。
| 
| Kubernetes環境においては、永続ボリュームを指定することにより、永続ボリューム側のディレクトリに出力されます。
| ※永続ボリュームについては、インストール編 :doc:`../../installation/helm_on_kubernetes` を参照してください。

監査ログの設定項目
------------------

| 設定可能項目は、Exastro Platform 認証機能のオプションパラメータの :kbd:`AUDIT_LOG` 項目となります。 

.. include:: ../../include/helm_option_platform-auth.rst

監査ログの内容
--------------

| 監査ログは、:kbd:`Json形式` で出力されています。
| １つのイベント(API呼び出し)が、改行を区切りとした１明細 となっており、以下の内容で構成されております。

.. list-table:: 監査ログ内容
   :widths: 15 20 30 20
   :header-rows: 1
   :align: left

   * - 項目名
     - 説明
     - ログの例
     - 備考
   * - ts
     - イベント呼び出し日時
     - "2024-03-11T01:15:58.147Z"
     - 
   * - user_id
     - ユーザーID
     - "155427e2-c154-49d8-a2b7-9496bb0e6b25"
     -
   * - username
     - ユーザー名
     - "admin_user"
     -
   * - org_id
     - オーガナイゼーションID
     - "org1"
     - システム管理者側の操作の場合は"-"が出力されます。
   * - ws_id
     - ワークスペースID
     - "ws1"
     - ワークスペース外の操作の場合は"-"が出力されます。
   * - level
     - メッセージレベル
     - "INFO"
     - "INFO":APIの呼び出し結果が正常、"ERROR":APIの呼び出し結果が異常
   * - full_path
     - 呼び出されたエンドポイントとパラメータ
     - "/api/org1/platform/workspaces?"
     - 
   * - access_route
     - アクセスルートのIPアドレス
     - ["0.0.0.0"]
     - ルートが複数ある場合は、カンマ区切りで複数出力される
   * - remote_addr
     - リモートアクセスのIPアドレス
     - "0.0.0.0"
     - 
   * - request_headers
     - APIが呼び出された際のリクエストヘッダー
     - 
     - 
   * - request_user_headers
     - APIを呼び出す際のリクエストヘッダー
     - 
        | {
        |   "User-Id": "4c5c8c11-d7fa-4963-9dc5-5a7c3d923ad6",
        |   "Roles": "",
        |   "Org-Roles": "X29yZ2FuaXphdGlvbi1tYW5hZ2Vy",
        |   "Language": null
        | }
     - Roles, Org-Roles情報はBase64エンコードされた値となります。
   * - request_body
     - APIの呼び出し時のリクエストボディ
     - null
     - 内容が無い場合は、nullが出力されます。
   * - request_form
     - APIの呼び出し時のリクエストfrom
     - null
     - 内容が無い場合は、nullが出力されます。
   * - request_files
     - APIの呼び出し時のリクエストfiles
     - null
     - 内容が無い場合は、nullが出力されます。
   * - status_code
     - API呼び出し時のステータスコード
     - 200
     - 
   * - name
     - "audit"固定
     - "audit"
     - 
   * - message
     - 応答メッセージ
     - "audit: response. 200"
     - 
   * - message_id
     - APIの応答メッセージID
     - "-"
     - API呼び出し結果の応答メッセージがある場合は、メッセージIDが出力されます。
   * - message_text
     - APIの応答メッセージ
     - "-"
     - API呼び出し結果の応答メッセージがある場合は、メッセージが出力されます。
   * - stack_info
     - APIエラーじのスタック情報
     - null
     - APIエラーが発生した際のスタック情報が出力されます。エラーが無い場合はnullが出力されます。
   * - process
     - プロセスID
     - 7
     - 処理のProcess ID
   * - log_ts
     - ログの出力日時
     - "2024-03-12T01:29:36.357Z"
     - 
   * - userid
     - プロセス処理ユーザーID
     - "76541d8f-6de4-4b49-8fe6-58640c15a965"
     - 
   * - method
     - API呼び出し時のmethod
     - "GET"
     - "GET","POST","PUT","PATCH","DELETE"などの呼び出し時のmethod
   * - content_type
     - API呼び出し時のメディアタイプ
     - "application/json"
     - 

