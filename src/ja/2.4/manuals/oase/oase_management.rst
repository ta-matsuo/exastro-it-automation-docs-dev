========
OASE管理
========

はじめに
========
| 本書では、OASE管理の機能および操作方法について説明します。

メニュー構成
============

| 本章では、OASE管理で利用するメニュー構成について説明します。

メニュー/画面一覧
-----------------

| OASE管理のメニュー一覧を以下に記述します。

.. table:: OASE管理 メニュー/画面一覧
   :widths: 1 2 2 5 
   :align: left

   +--------+----------------------+--------------------------+----------------------------------------+
   | **No** | **メニューグループ** |    **メニュー・画面**    |                **説明**                |
   +========+======================+==========================+========================================+
   | 1      | OASE管理             | エージェント             | イベント収集対象の情報を管理します。   |
   +--------+                      +--------------------------+----------------------------------------+
   | 2      |                      | 通知テンプレート（共通） | OASEの通知で使用する情報を管理します。 |
   +--------+----------------------+--------------------------+----------------------------------------+


.. _agent_about:

エージェント概要
================

| 本章では、エージェント（Exastro OASE Agent）について説明します。

エージェントについて
--------------------

| エージェントは、Exastro IT Automation（以下、ITA）とは独立しており、ITA OASEと外部サービスの仲介役として機能します。
| エージェントは、対象とする外部サービスのイベント収集設定をITAから取得し、その設定を用いて外部サービスからイベントを取得します。このプロセスを経て、取得したイベントをITAに送信します。

.. figure:: /images/ja/oase/oase_management/agent_overview_v2-4.png
   :width: 800px
   :alt: OASEエージェント概要


エージェント利用手順
====================

| 本章では、エージェント（Exastro OASE Agent）の利用手順について説明します。

作業フロー
----------

| エージェントを利用するための作業を含めた、OASEの作業フローは以下のとおりです。
| エージェント利用のための作業の詳細は次項に記載しています。

.. figure:: /images/ja/oase/oase_management/oase_process_v2-3.png
   :width: 700px
   :alt: OASE作業フロー

-  **作業フロー詳細と参照先**

   #. | **イベント収集設定**
      | OASE管理のエージェントメニュー画面から、イベント収集対象サービスに関する設定を登録します。
      | 詳細は :ref:`agent` を参照してください。

   #. | **ラベル設定**
      | OASEのラベル作成/ラベル付与メニュー画面から、ラベルを付与するための設定を行います。
      | 詳細は :ref:`label_creation` および :ref:`labeling` を参照してください。

   #. | **エージェントのインストール・起動**
      | エージェントを起動し、イベント収集を開始します。
      | 詳細は :ref:`インストールガイド（Docker Compose）<oase_agent_docker compose install>` を参照してください。
      | 詳細は :ref:`インストールガイド（Kubernetes）<oase_agent_kubernetes_install>` を参照してください。


通知テンプレート（共通）概要
=============================

| OASEの通知機能の概要図を以下に示します。

.. figure:: /images/ja/oase/oase_management/notification_template_overview.png
   :width: 800px
   :alt: 通知テンプレート（共通）概要

   通知テンプレート（共通）概要

通知テンプレート（共通）利用手順
=================================

| OASEの通知機能を利用するために必要な作業フローは以下のとおりです。
| 各作業の詳細は次項に記載しています。

.. figure:: /images/ja/oase/oase_management/notification_template_process.png
   :width: 700px
   :alt: 通知テンプレート（共通）作業フロー

   通知テンプレート（共通）作業フロー

-  **作業フロー詳細と参照先**

   #. | **通知テンプレート（共通）のメンテナンス（閲覧/更新）**
      | OASE管理の通知テンプレート（共通）メニュー画面から、OASEの通知で使用するテンプレートをメンテナンス（閲覧/更新）できます。
      | 詳細は :ref:`notification_template_common` を参照してください。
      
   #. | **通知先設定の登録**
      | Exastro システムにオーガナイゼーション管理者でログインし、メニューより :menuselection:`通知管理` から登録します。
      | 詳細は :ref:`notification_management` を参照してください。

   #. | **（通知先がメールの方のみ）メール送信サーバの設定**
      | Exastro システムにオーガナイゼーション管理者でログインし、メニューより :menuselection:`メール送信サーバ設定` から登録します。
      | 詳細は :ref:`email_sending_server_settings` を参照してください。

.. note::
   | 通知テンプレート（共通）は、変更しなくても利用可能です。


機能メニュー操作説明
====================

| 本章では、OASE管理機能のメニュー操作説明について説明します。

メニューについて
----------------

| 本節では、OASE管理をインストールした状態で表示されるメニューの操作について記載します。

.. _agent:

エージェント
-------------

1. | :menuselection:`OASE管理 --> エージェント` では、（エージェントに設定する）イベント収集対象の、接続方式・認証方式・TTL等をメンテナンス（閲覧/登録/更新/廃止）できます。

.. figure:: /images/ja/oase/oase_management/agent_menu.png
   :width: 800px
   :alt: サブメニュー画面（エージェント）

   サブメニュー画面（エージェント）

1. | エージェント※1 画面の入力項目は以下のとおりです。

   .. table:: エージェント画面 入力項目一覧
      :widths: 10 15 60 10 10 20
      :align: left

      +------------------------------------+--------------------------------------------------------+--------------+--------------+-----------------+
      | **項目**                           | **説明**                                               | **入力必須** | **入力方法** | **制約事項**    |
      |                                    |                                                        |              |              |                 |
      +====================================+========================================================+==============+==============+=================+
      | イベント収集設定名                 | 任意のイベント収集設定名を入力します。                 | 〇           | 自動入力     | 最大長255バイト |
      +------------------------------------+--------------------------------------------------------+--------------+--------------+-----------------+
      | 接続方式                           | イベント収集対象への接続方法を選択します。             | 〇           | リスト選択   | ※2              |
      |                                    |                                                        |              |              |                 |
      |                                    | ・Bearer認証                                           |              |              |                 |
      |                                    |                                                        |              |              |                 |
      |                                    | ・パスワード認証                                       |              |              |                 |
      |                                    |                                                        |              |              |                 |
      |                                    | ・任意の認証                                           |              |              |                 |
      |                                    |                                                        |              |              |                 |
      |                                    | ・IMAP パスワード認証                                  |              |              |                 |
      |                                    |                                                        |              |              |                 |
      |                                    | ・エージェント不使用                                   |              |              |                 |
      +------------------------------------+--------------------------------------------------------+--------------+--------------+-----------------+
      | リクエストメソッド                 | イベント収集対象へのリクエストメソッドを選択します。   | ー           | リスト選択   | ※2              |
      |                                    |                                                        |              |              |                 |
      |                                    | ・接続方式がBearer認証、パスワード認証、\              |              |              |                 |
      |                                    | 任意の認証の場合                                       |              |              |                 |
      |                                    |                                                        |              |              |                 |
      |                                    | 　- GET                                                |              |              |                 |
      |                                    |                                                        |              |              |                 |
      |                                    | 　- POST                                               |              |              |                 |
      |                                    |                                                        |              |              |                 |
      |                                    | ・接続方式がIMAP パスワード認証の場合                  |              |              |                 |
      |                                    |                                                        |              |              |                 |
      |                                    | 　- IMAP: Plaintext                                    |              |              |                 |
      +------------------------------------+--------------------------------------------------------+--------------+--------------+-----------------+
      | 接続先                             | イベント収集対象の接続先を入力します。                 | 〇           | 手動入力     | 最大長1024バイト|
      |                                    |                                                        |              |              |                 |
      |                                    | ・メールサーバの場合はホスト名を入力します。           |              |              |                 |
      |                                    |                                                        |              |              |                 |
      |                                    | ・APIの場合はURLを入力します。                         |              |              |                 |
      +------------------------------------+--------------------------------------------------------+--------------+--------------+-----------------+
      | ポート                             | イベント収集対象のポートを入力します。                 | ー           | 手動入力     | 0～65535        |
      +-----------------+------------------+--------------------------------------------------------+--------------+--------------+-----------------+
      | 認証情報        | リクエスト\      | リクエストヘッダーを入力します。                       | ー           | 手動入力     | 最大長4000バイト|
      |                 | ヘッダー         |                                                        |              |              |                 |
      |                 +------------------+--------------------------------------------------------+--------------+--------------+-----------------+
      |                 | プロキシ         | イベント収集対象のプロキシURIを入力します。            | ー           | 手動入力     | 最大長255バイト |
      |                 +------------------+--------------------------------------------------------+--------------+--------------+-----------------+
      |                 | 認証トークン     | Bearer認証の認証トークンを入力します。                 | ー           | 手動入力     | 最大長1024バイト|
      |                 |                  |                                                        |              |              |                 |
      |                 +------------------+--------------------------------------------------------+--------------+--------------+-----------------+
      |                 | ユーザー名       | イベント収集対象へログインするユーザー名を入力します。 | ー           | 手動入力     | 最大長255バイト |
      |                 +------------------+--------------------------------------------------------+--------------+--------------+-----------------+
      |                 | パスワード       | イベント収集対象へログインするパスワードを入力します。 | ー           | 手動入力     | 最大長4000バイト|
      |                 +------------------+--------------------------------------------------------+--------------+--------------+-----------------+
      |                 | メールボックス名 | イベント収集対象のメールボックス名を入力します。       | ー           | 手動入力     | 最大長255バイト |
      |                 |                  |                                                        |              |              |                 |
      |                 |                  | デフォルトでINBOXを参照します。                        |              |              |                 |
      +-----------------+------------------+--------------------------------------------------------+--------------+--------------+-----------------+
      | パラメータ                         | JSON形式で入力します。                                 | ー           | 手動入力     | 最大長255バイト |
      |                                    |                                                        |              |              |                 |
      |                                    |                                                        |              |              |                 |
      |                                    | ・リクエストメソッドがGETの場合、\                     |              |              |                 |
      |                                    | クエリパラメータ(接続先に追加される、"?"以降の値）\    |              |              |                 |
      |                                    | として使用されます。                                   |              |              |                 |
      |                                    |                                                        |              |              |                 |
      |                                    | ・リクエストメソッドがPOSTの場、\                      |              |              |                 |
      |                                    | リクエストのペイロードとして使用されます。             |              |              |                 |
      +------------------------------------+--------------------------------------------------------+--------------+--------------+-----------------+
      | レスポンスキー                     | レスポンスのペイロードから、OASEのイベントとして\      | ー           | 手動入力     | 最大長255バイト |
      |                                    | 受け取るプロパティの、親となるキーを指定します。       |              |              | ※3              |
      |                                    |                                                        |              |              |                 |
      |                                    | レスポンスのペイロードの階層をJSONのクエリ言語\        |              |              |                 |
      |                                    | （JMESPath）で指定します。                             |              |              |                 |
      |                                    |                                                        |              |              |                 |
      +------------------------------------+--------------------------------------------------------+--------------+--------------+-----------------+
      | レスポンスリストフラグ             | レスポンスキーで取得した値が配列かどうかを選択します。 | ー           | リスト選択   | ※3              |
      |                                    |                                                        |              |              |                 |
      |                                    | ・Trueの場合、\                                        |              |              |                 |
      |                                    | レスポンスキーで取得した値を配列に分割し、その単位を\  |              |              |                 |
      |                                    | イベントとして処理します。                             |              |              |                 |
      |                                    |                                                        |              |              |                 |
      +------------------------------------+--------------------------------------------------------+--------------+--------------+-----------------+
      | イベントIDキー                     | 受け取ったイベントをユニークに判別するIDとなるキーが\  | ー           | 手動入力     | 最大長255バイト |
      |                                    | ある場合に入力します。                                 |              |              | ※3              |
      |                                    |                                                        |              |              |                 |
      |                                    | ・レスポンスのペイロードの階層をJSONのクエリ言語\      |              |              |                 |
      |                                    | （JMESPath）で指定します。                             |              |              |                 |
      |                                    |                                                        |              |              |                 |
      |                                    | ・レスポンスキーの指定やレスポンスリストフラグの指定\  |              |              |                 |
      |                                    | を考慮した、それ以下の階層を指定します。               |              |              |                 |
      +------------------------------------+--------------------------------------------------------+--------------+--------------+-----------------+
      | TTL                                | TTL（Time To Live）とは、エージェンが取得した\         | 〇           | 手動入力     | 最小値10（秒）  |
      |                                    | イベントが、ルールの評価対象として扱われる期間（秒）\  |              |              |                 |
      |                                    | のことです。                                           |              |              | 最大値21474836\ |
      |                                    |                                                        |              |              | 47（秒）        |
      |                                    |                                                        |              |              |                 |
      |                                    |                                                        |              |              | デフォルトの値\ |
      |                                    |                                                        |              |              | ：3600（秒）    |
      +-----------------+------------------+--------------------------------------------------------+--------------+--------------+-----------------+
      | 備考                               | 自由記述欄です。                                       | ー           | 手動入力     | 最大長4000バイト|
      +------------------------------------+--------------------------------------------------------+--------------+--------------+-----------------+

| ※1 イベント収集対象への設定です。

| ※2 接続方式・認証情報・リクエストメソッドについて、必要な組み合わせは以下のとおりです。

.. list-table::
   :widths: 1 1 1
   :header-rows: 1
   :align: left

   * - 接続方式
     - リクエストメソッド
     - 認証情報
   * - IMAP パスワード認証
     - ・IMAP: Plaintext
     - | ・ユーザー名
       | ・パスワード
   * - Bearer認証
     - | ・GET
       | ・POST
     - ・認証トークン
   * - パスワード認証
     - | ・GET
       | ・POST
     - | ・ユーザー名
       | ・パスワード
   * - 任意の認証
     - | ・GET
       | ・POST
     - ・パラメータに記述

| ※3 レスポンスキー、レスポンスリストフラグ 、イベントIDキーについては、 :ref:`レスポンスキーとイベントIDキー<oase_agent_respons_key_enevnt_id_key>` を参照してください。

.. warning::
   | 収集先がメールの場合、文字コードの種類によりデコードできない文字を省いて収集イベントを保存する場合があります。
   | 詳細は :ref:`about_decode` を参照してください。

.. _notification_template_common:

通知テンプレート（共通）
------------------------

1. | :menuselection:`OASE管理 --> 通知テンプレート（共通）` では、OASEの通知機能で使用するテンプレートをメンテナンス（閲覧/更新）できます。

.. figure:: /images/ja/oase/oase_management/notification_template_menu.png
   :width: 800px
   :alt: サブメニュー画面（通知テンプレート（共通））

   サブメニュー画面（通知テンプレート（共通））

1. | 通知テンプレート（共通）画面の入力項目は以下のとおりです。

.. list-table::
   :widths: 10 60 10 10 20
   :header-rows: 1
   :align: left

   * - 項目
     - 説明
     - 入力必須
     - 入力方法
     - 制約事項 
   * - テンプレート
     - | 通知で使用するテンプレートを編集できます。下記4種類が存在します。
       | ・新規.j2
       | ・既知（判定済み）.j2
       | ・既知（時間切れ）.j2
       | ・未知.j2
     - 〇
     - 手動入力
     - 最大サイズ2MB
   * - 備考
     - 自由記述欄です。
     - ー
     - 手動入力
     - 最大長4000バイト

| テンプレートの初期設定値は下記のとおりです。

.. code-block:: none
   :name: 新規.j2
   :caption: 新規.j2
   :lineno-start: 1

    [TITLE]
    新規イベントが発生しました。

    [BODY]
    詳細
    　イベントID　　　：{{ _id }}
    　イベント収集設定：{{ labels._exastro_event_collection_settings_id }}
    　イベント取得日時：{{ labels._exastro_fetched_time }}
    　イベント有効日時：{{ labels._exastro_end_time }}
    　イベント種別　　：{{ labels._exastro_type }}

    　再評価
    　　評価ルール名　　：{{ labels._exastro_rule_name }}
    　　利用イベント　　：{{ exastro_events }}

    　ラベル：
    　  {% for key, value in labels.items() %}
    　　・{{ key }}：{{ value }}
    　　{% endfor %}


.. code-block:: none
   :name: 既知（判定済）.j2
   :caption: 既知（判定済）.j2
   :lineno-start: 1

   [TITLE]
   既知（判定済）イベントが発生しました。

   [BODY]
   詳細
   　イベントID　　　：{{ _id }}
   　イベント収集設定：{{ labels._exastro_event_collection_settings_id }}
   　イベント取得日時：{{ labels._exastro_fetched_time }}
   　イベント有効日時：{{ labels._exastro_end_time }}
   　イベント種別　　：{{ labels._exastro_type }}

   　再評価
   　　評価ルール名　　：{{ labels._exastro_rule_name }}
   　　利用イベント　　：{{ exastro_events }}

   　ラベル：
   　  {% for key, value in labels.items() %}
   　　・{{ key }}：{{ value }}
   　　{% endfor %}

.. code-block:: none
   :name: 既知（時間切れ）.j2
   :caption: 既知（時間切れ）.j2
   :lineno-start: 1

   [TITLE]
   既知（時間切れ）イベントが発生しました。

   [BODY]
   詳細
   　イベントID　　　：{{ _id }}
   　イベント収集設定：{{ labels._exastro_event_collection_settings_id }}
   　イベント取得日時：{{ labels._exastro_fetched_time }}
   　イベント有効日時：{{ labels._exastro_end_time }}
   　イベント種別　　：{{ labels._exastro_type }}

   　再評価
   　　評価ルール名　　：{{ labels._exastro_rule_name }}
   　　利用イベント　　：{{ exastro_events }}

   　ラベル：
   　  {% for key, value in labels.items() %}
   　　・{{ key }}：{{ value }}
   　　{% endfor %}

.. code-block:: none
   :name: 未知.j2
   :caption: 未知.j2
   :lineno-start: 1

   [TITLE]
   未知イベントが発生しました。

   [BODY]
   詳細
   　イベントID　　　：{{ _id }}
   　イベント収集設定：{{ labels._exastro_event_collection_settings_id }}
   　イベント取得日時：{{ labels._exastro_fetched_time }}
   　イベント有効日時：{{ labels._exastro_end_time }}
   　イベント種別　　：{{ labels._exastro_type }}

   　再評価
   　　評価ルール名　　：{{ labels._exastro_rule_name }}
   　　利用イベント　　：{{ exastro_events }}

   　ラベル：
   　  {% for key, value in labels.items() %}
   　　・{{ key }}：{{ value }}
   　　{% endfor %}


付録
====

.. _oase_agent_flow:

OASE Agentの処理フローと.envの設定値
------------------------------------

| 本項では、以下について示します。
| - OASE Agentの処理フロー
| - OASE Agentのインストール時、.envに設定した、一部の設定値について

.. figure:: /images/ja/oase/oase_management/agent_detailed_flow_v2-4.png
   :width: 1000px
   :alt: OASE Agent フロー図

   OASE Agent処理フロー図

.. list-table:: 
 :widths: 5, 7
 :header-rows: 1

 * - パラメータ
   - 説明
 * - AGENT_NAME
   - 起動する OASEエージェントの名前および、内部データベースのファイル名として使用されます。
 * - EXASTRO_URL
   - ITAに対してAPIリクエストをする際に、リクエスト先として使用されます。
 * - EXASTRO_ORGANIZATION_ID
   - ITAに対してAPIリクエストをする際に、Organizationを識別するために使用されます。
 * - EXASTRO_WORKSPACE_ID
   - ITAに対してAPIリクエストをする際に、ワークスペースを識別するために使用されます。

     EXASTRO_ORGANIZATION_IDで設定したオーガナイゼーションと紐づいたワークスペースである必要があります。
 * - EXASTRO_USERNAME
   - ITAに対してAPIリクエストをする際に、Basic認証のユーザー名として使用されます。
 * - EXASTRO_PASSWORD
   - ITAに対してAPIリクエストをする際に、Basic認証のパスワードとして使用されます。
 * - EVENT_COLLECTION_SETTINGS_NAMES
   - このパラメータで設定されている値から、イベント収集設定をITAから取得し、設定ファイルを生成します。
 * - ITERATION
   - 上記フロー図にて緑色の矢印で示されているループ処理を、このパラメータで設定している数だけ行います。
 * - EXECUTE_INTERVAL
   - 上記フロー図にて緑色の矢印で示されているループ処理の実行間隔です。


イベント収集設定の即時反映について
----------------------------------
| 本項では、イベント収集設定を変更した際に、OASE Agentに即時反映させる方法について説明します。

1. | OASE Agentのbashシェルを開始します。
   
   .. code-block:: shell
   
      docker exec -it <OASE Agentのコンテナ名> bash

2. | /tmp内の設定ファイル「event_collection_settings.json」を削除します。

   .. code-block:: shell
   
      rm /tmp/event_collection_settings.json

.. tip::
   | OASE Agentでは、設定ファイル「event_collection_settings.json」が存在しない場合、ITAからイベント収集設定を取得し、設定ファイルを作成します。
   | 設定ファイルを削除することで最新の設定を反映させることができます。
   | ※この操作を行わない場合、:ref:`前項<oase_agent_flow>` で示した「ITERATION」の数だけループする処理が終了するまで、変更後の設定が反映されません。

.. _about_decode:

エージェントのデコード処理について
----------------------------------
| 収集先がメールの場合の、収集イベントに対するエージェントのデコード処理に関しては以下のとおりです。

動作確認済み文字コード
^^^^^^^^^^^^^^^^^^^^^^

.. table:: 動作確認済み文字コード
 :widths: 1 1 2 3
 :align: left

 +--------------------------+---------------------------------------------------------------------------+
 | **送信方法**             | **メールのHeader**                                                        |
 +-----------+--------------+-------------------------------+-------------------------------------------+
 | **形式**  | **言語**     | **Content-Transfer-Encoding** | **Content-Type**                          |
 +===========+==============+===============================+===========================================+
 | plaintext | 英語         | 7bit                          | text/plain; charset=US-ASCII              |
 +-----------+--------------+-------------------------------+-------------------------------------------+
 | plaintext | 日本語       | 8bit                          | text/plain; charset=UTF-8                 |
 +-----------+--------------+-------------------------------+-------------------------------------------+
 | plaintext | 英語         | 8bit                          | text/plain; charset="ANSI_X3.4-1968"      |
 +-----------+--------------+-------------------------------+-------------------------------------------+
 | html      | 英語         | ・plaintext: 7bit             | multipart/alternative                     |
 |           |              |                               |                                           |
 |           |              | ・html: quoted-printable      | ・plaintext: text/plain; charset=US-ASCII |
 |           |              |                               |                                           |
 |           |              |                               | ・html: text/html; charset=UTF-8          |
 +-----------+--------------+-------------------------------+-------------------------------------------+
 | html      | 日本語       | ・plaintext: 8bit             | multipart/alternative                     |
 |           |              |                               |                                           |
 |           |              | ・html: quoted-printable      | ・plaintext: text/plain; charset=UTF-8    |
 |           |              |                               |                                           |
 |           |              |                               | ・html: text/html; charset=UTF-8          |
 +-----------+--------------+-------------------------------+-------------------------------------------+

| デコードできない文字を省いて収集イベントを保存する場合の処理の例に関しては、以下のとおりです。

送信するメール
  | 形式：plaintext
  | Content-Transfer-Encoding：8bit
  | Content-Type：text/plain; charset="ANSI_X3.4-1968"
  | 件名：障害
  | 内容：障害：Server01\\r\\n

ITAの画面で見た場合
  | 件名：障害
  | 内容：Server01\\r\\n

.. figure:: /images/ja/oase/oase_management/decode_failed.png
 :width: 800px
 :alt: デコードできない文字を省いて収集イベントを行う例・結果（イベントフロー）

 デコードできない文字を省いて収集イベントを行う例・結果（イベントフロー）
 
 .. _oase_agent_respons_key_enevnt_id_key:

レスポンスキーとイベントIDキー
------------------------------
| 本項では、 下記について説明します。

| ・ :dfn:`レスポンスキー` 
| ・ :dfn:`JMESPath`
| ・ :dfn:`レスポンスリストフラグ` 
| ・ :dfn:`イベントIDキー`


レスポンスキー
^^^^^^^^^^^^^^
| レスポンスのペイロードから、イベントを抽出すためのキーを :dfn:`レスポンスキー` といいます。

.. note::
   | ・監視ソフトは、監視対象マシンで発出されたアラートやメトリックス（状態）をHTTP APIで取得できる機能があり、
   | ・エージェントは、そのHTTP APIを利用して、アラートやメトリックスを取得します。
   | ・但し、監視ソフトが返却するレスポンスのぺーロードが、JSON形式のみ、エージェントは処理対象とします。

|  :dfn:`レスポンスキー` として指定できる項目は、

| 　・レスポンスのペイロードで、イベントとして取り扱う項目を、子要素に格納していること。
| 　・イベントとして取り扱う項目が、複数ある場合、子要素を配列で、格納していること。

| :dfn:`レスポンスキー` は、 :dfn:`JMESPath形式` で指定します。
| :dfn:`JMESPath形式`  については、次項を参照してください。

JMESPath
^^^^^^^^
| :dfn:`JMESPath` は、JSONを対象としたクエリ言語です。
| JSONから、指定した :dfn:`JMESPath` に該当する値を抽出します。
| 書式は、JSONキーを、"."ドットで結合したパスで指定します。
| また、JSONキーの値が配列の場合、"[]"をJSONキーの後ろに付けます。
| 　例） :program:`parent` の値が配列で、配列の子要素のキー :program:`children` の値を抽出する場合、

.. code-block::

   parent[].children

| 　と指定します。

| JMESPathの指定方法について、
| Azure RESET-API `Get Metric for data <https://learn.microsoft.com/ja-jp/rest/api/monitor/metrics/list?view=rest-monitor-2023-10-01&tabs=HTTP>`_ のSample Responseの一部を利用して説明します。

.. code-block:: json
   :linenos: 
   :lineno-start: 1

   {
     "cost": 598,
     "timespan": "2021-04-20T09:00:00Z/2021-04-20T14:00:00Z",
     "interval": "PT1H",
     "value": [
       {
         "id": "/subscriptions/1f3･･･c38/･･･/metrics/BlobCount",
         "type": "Microsoft.Insights/metrics",
         "name": {
           "value": "BlobCount",
           "localizedValue": "Blob Count"
         },
         "displayDescription": "The number of blob objects stored in the storage account.",
         "unit": "Count",
         "timeseries": [
           {
             "metadatavalues": [
               {
                 "name": {
                   "value": "tier",
                   "localizedValue": "tier"
                 },
                 "value": "Hot"
               }
             ]
           },
           {
             "metadatavalues": [
               {
                 "name": {
                   "value": "tier",
                   "localizedValue": "tier"
                 },
                 "value": "Standard"
               }
             ]
           },
           {
             "metadatavalues": [
               {
                 "name": {
                   "value": "tier",
                   "localizedValue": "tier"
                 },
                 "value": "Cool"
               }
             ]
           }
         ],
         "errorCode": "Success"
       }
     ],
     "namespace": "microsoft.storage/storageaccounts/blobservices",
     "resourceregion": "westus2"
   }

.. note::
  | :dfn:`JMESPath` の詳細については、JMESPath  Tutorial https://JMESPath.org/tutorial.html を参照してください。
  | また、上記JSONを、 :dfn:`JMESPath` を試すことのできる、JMESPath Try it Out! https://JMESPath.org/ で試してください。

1. | 配列の値を取得するJMESPath
 
| 上記JSONで、5行目の :program:`value` の値（配列）を取得する :dfn:`JMESPath` を、

.. code-block::

   value

| と指定すると、下記の結果が取得できます。
| （コード中の :program:`"//" : "･･･Sample Responseの14行～49行まで省略･･･"`  はコメントです。実際の結果には含まれません。）

.. code-block:: json

   [
     {
       "id": "/subscriptions/1f3･･･c38/･･･/metrics/BlobCount",
       "type": "Microsoft.Insights/metrics",
       "name": {
         "value": "BlobCount",
         "localizedValue": "Blob Count"
       },
       "displayDescription": "The number of blob objects stored in the storage account.",
       "//" : "･･･Sample Responseの14行～49行まで省略･･･",
       "errorCode": "Success"
     }
   ]

2. | オブジェクトを取得するJMESPath
 
| 上記JSONで、9行目の :program:`value` (配列) の :program:`name` の値を取得する :dfn:`JMESPath` を、

.. code-block::

   value[].name

| と指定すると、下記の結果が取得できます。

.. code-block:: json

  [
    {
      "value": "BlobCount",
      "localizedValue": "Blob Count"
    }
  ]

3. | 深い階層で、複数の値を取得するJMESPath

| :program:`value` (配列)の :program:`timeseries` (配列)の :program:`metadatavalues` (配列)の :program:`name` を取得する :dfn:`JMESPath` を、

.. code-block:: 

   value[].timeseries[].metadatavalues[].name

| と指定すると下記の結果が取得できます。
| （コード中の :program:`"//" : "xx行の metadatavalues.name"`  はコメントです。実際の結果には含まれません。）

.. code-block:: json

   [
     "//" : "19行の metadatavalues.name"
     {
       "value": "tier",
       "localizedValue": "tier"
     },
     "//" : "30行の metadatavalues.name"
     {
       "value": "tier",
       "localizedValue": "tier"
     },
     "//" : "41行の metadatavalues.name"
     {
       "value": "tier",
       "localizedValue": "tier"
     }
   ]

レスポンスリストフラグ
^^^^^^^^^^^^^^^^^^^^^^
| :dfn:`レスポンスリストフラグ` は、 :dfn:`レスポンスキー` で抽出したイベントが、配列で格納されているかを指定します。

| ・:program:`True`  ： :dfn:`レスポンスキー` で抽出したイベントが、配列で格納されている場合
| 　　　　　　上記の 1. 配列の値を取得するJMESPat や、3. 深い階層で、複数の値を取得するJMESPath の様な場合
| ・:program:`False` ： :dfn:`レスポンスキー` で抽出したイベントが、配列以外（値や、子要素を持つオブジェクト）で格納されている場合
| 　　　　　　上記の 2. オブジェクトを取得するJMESPath の様な場合


イベントIDキー
^^^^^^^^^^^^^^
|  :dfn:`レスポンスキー` を利用して抽出したイベントで、イベントをユニークに判別する値を取得するキーを :dfn:`イベントIDキー` で指定します。
|  :dfn:`イベントIDキー` は、 :dfn:`レスポンスキー` で抽出した結果に存在するキーを指定します。

| :dfn:`イベントIDキー` も、 :dfn:`JMESPath形式` で指定します。
| 上記Azure RESET-APIのJSONで、 :dfn:`レスポンスキー` と :dfn:`レスポンスリストフラグ` を、下記の通り指定した場合、

.. list-table:: 
 :widths: 1, 1
 :header-rows: 1

 * - 項目名
   - 設定値
 * - レスポンスキー
   - :program:`value`
 * - レスポンスリストフラグ
   - :program:`True`

| :dfn:`レスポンスキー` で抽出した値は、

.. code-block:: json
   :linenos: 
   :lineno-start: 1

   [
     {
       "id": "/subscriptions/1f3･･･c38/･･･/metrics/BlobCount",
       "type": "Microsoft.Insights/metrics",
       "name": {
         "value": "BlobCount",
         "localizedValue": "Blob Count"
       },
       "displayDescription": "The number of blob objects stored in the storage account.",
       "unit": "Count",
       "timeseries": [
         {
           "metadatavalues": [
             {
               "name": {
                 "value": "tier",
                 "localizedValue": "tier"
               },
               "value": "Hot"
             }
           ]
         },
         "//": "･･･（metadatavaluesの繰り返しなので省略）･･･"
       ],
       "errorCode": "Success"
     }
   ]

| となり、この結果から、イベントとして識別する値は、:program:`id` の値が適しているため、
|  :menuselection:`OASE管理 --> エージェント` での設定値は、下記の設定が適切です。

.. list-table:: 
 :widths: 10, 20
 :header-rows: 1

 * - 項目名
   - 設定値
 * - レスポンスキー
   - :program:`value`
 * - レスポンスリストフラグ
   - :program:`True`
 * - イベントIDキー
   - :program:`id`

.. warning::
   | :dfn:`レスポンスキー` で抽出した値に存在しないキーを指定すると、空の値を取得することになり、正しく動作しません。
   | 例えば、上記 :dfn:`レスポンスキー` で抽出した値に存在しないキー :program:`value` を指定した場合、正しく動作しません。

   .. list-table:: 正しくない、イベントIDキーの設定
      :widths: 10, 20
      :header-rows: 1

      * - 項目名
        - 設定値
      * - レスポンスキー
        - :program:`value`
      * - レスポンスリストフラグ
        - :program:`True`
      * - イベントIDキー
        - :program:`value[].id`

.. _oase_agent_settings:

監視ソフト毎のエージェント設定例
--------------------------------
| 本項では、代表的な監視ソフト :dfn:`Zabbix` と :dfn:`Grafana` をエージェントで利用する場合の、 :menuselection:`OASE管理 --> エージェント` での設定例について説明します。

| また、本項では、まず、各監視ソフトのアラートを、cURLコマンドで取得する例を示し、
| 次に、cURLのパラメータを、 :menuselection:`OASE管理 --> エージェント` に設定する順番で説明します。
 
.. warning::
   | 監視ソフトののバージョンによって、HTTP APIの仕様が異なる場合があります。
   | 利用するバージョンのHTTP APIの仕様を確認し、 :menuselection:`OASE管理 --> エージェント` の設定を行ってください。


Zabbix
^^^^^^
| :dfn:`Zabbix` から、イベントを取得する、 :menuselection:`OASE管理 --> エージェント` での設定例について説明します。

| 以下の説明で使用した、:dfn:`Zabbix` は、
| ・zabbix 6.4.12 

1. | cURLコマンドで、 :dfn:`Zabbix` から、イベント取得

| 下記は、 :dfn:`Zabbix` から、障害（problem）を取得するcURLコマンドの例です。

.. code-block:: shell
   
   curl --request POST \
   --url http://<ZabbixのIP Address か Domain>/zabbix/api_jsonrpc.php \
   --header 'content-type: application/json-rpc' \
   --data "{\"jsonrpc\": \"2.0\",\"method\": \"problem.get\",\"id\": 1,\"params\": {},\"auth\": \"<Zabbix APIトークン>"}"

| （コマンド・パラメータ中の <Zabbix APIトークン> の詳細は、後述します。）

| 上記cURLコマンドで、下記の様なレスポンスが返却されます。

.. _oase_agent_zabbix_responss:

.. code-block:: json
   :linenos: 
   :lineno-start: 1

   {
      "jsonrpc": "2.0",
      "result": [
          {
              "eventid": "89",
              "source": "0",
              "object": "0",
              "objectid": "16046",
              "clock": "1709636653",
              "ns": "906955445",
              "r_eventid": "0",
              "r_clock": "0",
              "r_ns": "0",
              "correlationid": "0",
              "userid": "0",
              "name": "High CPU utilization (over 90% for 5m)",
              "acknowledged": "0",
              "severity": "2",
              "opdata": "Current utilization: 100 %",
              "suppressed": "0",
              "urls": []
          }
      ],
      "id": 1
   }

.. note::
  | :dfn:`Zabbix` の、障害（problem）に関する詳細は下記URLをご参照ください。
  |  https://www.zabbix.com/documentation/current/jp/manual/api/reference/problem/get

2. | :dfn:`Zabbix` からイベントを取得する、エージェントの設定例
  
| 上記のcURLコマンドを参考に、同等な取得を行う、 :menuselection:`OASE管理 --> エージェント` の設定値は、下記の様に設定します。

.. list-table:: Zabbixの設定例
   :widths: 5 15
   :header-rows: 1
   :align: left

   * - 項目名
     - 設定値
   * - イベント収集名
     - <Zabbix障害取得と分かる名称>
   * - 接続方式
     - 任意の認証
   * - リクエストメソッド
     - POST
   * - 接続先
     - | http://<ZabbixのIP Address か Domain>/zabbix/api_jsonrpc.php
   * - リクエストヘッダー
     - .. code-block:: json
      
         { "content-type" : "application/json-rpc" }

   * - パラメータ
     - .. code-block:: json

         {
           "jsonrpc":"2.0",
           "method":"problem.get",
           "id":1,
           "params":{},
           "auth":"<Zabbix APIトークン>"
         }

   * - レスポンスキー
     - result
   * - レスポンスリストフラグ
     - True
   * - イベントIDキー
     - eventid

.. note::
  | :menuselection:`パラメータ` で設定している、<Zabbix APIトークン>は、Zabbixユーザーの認証情報で、
  | 下記のコマンドで、ユーザー情報を指定して取得できます。
  | 但し、下記のコマンドを実行すると、既に存在するユーザーで作成済みの<Zabbix APIトークン>が使用できなる場合があります。
  | 対応として、新しいユーザーを作成し、新しいユーザーで<Zabbix APIトークン>を作成することをお勧めします。

  | 新しいユーザーの作成は、

  1. | ブラウザで、:dfn:`Zabbix` に管理者でサイイン
     | 　初期状態の管理者のログイン情報は、
     | 　　・ユーザー名： Admin
     | 　　・パスワード： zabbix 
  2. | サイドメニュー  > ユーザー > ユーザー を選択
  3. | ユーザーの右端上の :guilabel:`ユーザーの作成` をクリック
  4. | ユーザー名、パスワードなどを入力
  5. | :guilabel:`権限` タブをクリックし
  6. | ユーザーの役割 で、:guilabel:`選択` をクリックし、
     | APIへのアクセスが、有効な役割を持つ、"User role"か、それ以上の役割を選択
  7. | その他の必要な項目を入力し
  8. | :guilabel:`追加` をクリック

  | 以上の操作で、ユーザーが作成できます。

  | 以降は、<APIトークン>を作成するコマンドの例です。
  | :dfn:`Zabbix` へのログイン情報が、下記の場合の例です。
  | 　・ユーザー名 : 上記の操作で作成したユーザーの <ユーザー名>
  | 　・パスワード : 上記の操作で作成したユーザーの <パスワード>
  
  .. code-block:: shell
      
     curl --request POST \
     --url ttp://<ZabbixのIP Address か Domain>/zabbix/api_jsonrpc.php \
     --header "Content-Type: application/json-rpc" \
     --data "{\"auth\":null,\"method\":\"user.login\",\"id\":1,\"params\":{\"user\":\"<ユーザー名>\",\"password\":\"<パスワード>\"},\"jsonrpc\":\"2.0\"}" \
  
  | 上記cURLコマンドで、下記の様なレスポンスが返却されます。
  
  .. code-block:: json
     :linenos:
     :lineno-start: 1
  
     {
         "jsonrpc": "2.0",
          "result": "<Zabbix APIトークン>",
          "id": 1
     }
  
  | <Zabbix APIトークン>を、  :menuselection:`OASE管理 --> エージェント` の :menuselection:`パラメータ` の <Zabbix APIトークン> の箇所に貼り付けます。
  | ※ <Zabbix APIトークン>作成は、ブラウザでもを作成できます。
  | ブラウザでログイン後、サイドメニュー > ユーザー設定 > APIトークン の :guilabel:`APIトークンの作成` で作成できます。

Grafan
^^^^^^
| :dfn:`Grafan` で、イベントを取得するための、 :menuselection:`OASE管理 --> エージェント` での設定例について説明します。

| 以下の説明で使用した、:dfn:`Grafan` は、
| ・Grafan 10.3
| ・データソースに、Prometheus 2.49 を使用

1. | cURLコマンドで、 :dfn:`Grafan` から、イベント取得

| 下記は、:dfn:`Grafan` から、アラート（alerts）を取得するcURLコマンドの例です。

.. code-block:: shell
   
   curl --request GET \
   --url 'http://<GrafanaのIP addres か Domain>:3000/api/prometheus/grafana/api/v1/alerts' \
   --header 'authorization: Bearer <認証トークン>' \
   --header 'Content-Type: application/json' 

| （コマンド・パラメータ中の <認証トークン> の詳細は、後述します。）

| 上記cURLコマンドで、下記の様なレスポンスが返却されます。

.. code-block:: json
   :linenos:
   :lineno-start: 1

   {
       "data": {
           "alerts": [
               {
                   "activeAt": "2018-07-04T20:27:12.60602144+02:00",
                   "annotations": {},
                   "labels": {
                       "alertname": "my-alert"
                   },
                   "state": "firing",
                   "value": "1e+00"
               }
           ]
       },
       "status": "success"
   }

.. note::
  | Grafanaの、アラート（Alert）に関する詳細は下記URLをご参照ください。
  |  https://prometheus.io/docs/prometheus/latest/querying/api/#alerts

2. | :dfn:`Grafana` からイベントを取得する、エージェントの設定例

| 上記cURLコマンドを参考に、同等な取得を行う、 :menuselection:`OASE管理 --> エージェント` の設定値は、下記の様に設定します。

.. list-table:: Grafanaの設定例
   :widths: 5 15
   :header-rows: 1
   :align: left

   * - 項目名
     - 設定値
   * - イベント収集名
     - <Grafanaアラート取得と分かる名称>
   * - 接続方式
     - Bearer認証
   * - リクエストメソッド
     - GET
   * - 接続先
     - | http://<GrafanaのIP addres か Domain>:3000/api/prometheus/grafana/api/v1/rules
   * - リクエストヘッダー
     - .. code-block:: json
      
         { "Content-Type": "application/json" }

   * - 認証トークン
     - <認証トークン>
   * - レスポンスキー
     - data.alerts
   * - レスポンスリストフラグ
     - True
   * - イベントIDキー
     - activeAt

.. note::
  | <認証トークン>は、Grafanaの認証情報です。
  | 下記の手順で取得できます。

  1. | ブラウザで、:dfn:`Grafan` にサインインします。
     | 　初期設定では、
     | 　・username: admin
     | 　・Password: admin （但し、既にログインした場合、変更されている可能性があります）

  2. | Home > Administration > Service accounts を選択

  3. | :guilabel:`service account` をクリックして、サービスアカウントを作成します。  

  4. | サービス名を英数字の小文字で入力します。

  5. | :guilabel:`Add service account token` をクリックして、認証トークンを作成します。

  6. | Expirationで、
     | 　"No expiation"（期限なし　※推奨）または、
     | 　"Set expiation"（期限あり）を選択します。

  7. | :guilabel:`Generate token` をクリックします。

  8. | :guilabel:`Copy to clipboard and close` をクリックし,
     | 認証トークンがクリップボードに貼り付けられます。

  9. | クリップボードの認証トークンを、 :menuselection:`OASE管理 --> エージェント` の :menuselection:`認証トークン` に貼り付けます。

