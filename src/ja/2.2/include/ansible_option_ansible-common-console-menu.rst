
| Ansible共通のメニュー一覧を以下に記述します。

.. list-table::  Ansible共通 メニュー/画面一覧
   :widths: 2 6 20
   :header-rows: 1
   :align: left

   * - No
     - メニュー・画面
     - 説明
   * - 1
     - 機器一覧
     - 作業対象の機器情報を管理します。
   * - 2
     - インターフェース情報
     - | Ansible Core、Ansible Automation Controllerサーバのどちらを実行エンジンとし構築作業をするか選択をします。
       | 実行エンジンのサーバへの接続インターフェース情報を管理します。
   * - 3
     - Ansible Automation Controllerホスト一覧
     - Ansible Automation ControllerのRestAPI実行に必要な情報、および構築資材をAnsible Automation Controllerにファイル転送するために必要な情報を管理します。
   * - 4
     - グローバル変数管理
     - 各モードのPlaybookや対話ファイルで共通利用する変数と具体値を管理します。
   * - 5
     - ファイル管理
     - 各モードのPlaybookや対話ファイルで共通利用する素材ファイルと埋込変数を管理します。
   * - 6
     - テンプレート管理
     - 各モードのPlaybookや対話ファイルで共通利用するテンプレートファイルと埋込変数を管理します。
   * - 7
     - 管理対象外変数リスト
     - 「 :ref:`ansible_common_var_listup` 」で抜出した変数で、:menuselection:`各モード --> 代入値自動登録設定` の :menuselection:`Movement名:変数名` に表示したくない変数を管理します。
   * - 8
     - 共通変数利用リスト (※1)
     - :menuselection:`Ansible共通 --> グローバル変数管理` ・ :menuselection:`Ansible共通 --> ファイル管理` ・ :menuselection:`Ansible共通 --> テンプレート管理` に登録されている変数が、どの素材( :menuselection:`Ansible-Legacy --> Playbook素材集` ・ :menuselection:`Ansible-Pioneer --> 対話ファイル素材集` ・ :menuselection:`Ansible-LegacyRole --> ロールパッケージ管理` )で使用しているかを閲覧できます。

