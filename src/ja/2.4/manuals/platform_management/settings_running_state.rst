================
システム状態設定
================


はじめに
========

| 本書では、Exastro システム における システム状態設定  について説明します。

システム状態設定
================

| システム状態設定では、メンテナンスモードの切替と、ログレベルの変更を行うことが出来ます。

メンテナンスモードの切替
------------------------

| メンテナンスモードの切り替えは、下記の手順で行ないます。

#. | Exastro システムにシステム管理者でログインします。

#. | メニューより :menuselection:`システム状態設定` をクリックします。

   .. image:: /images/ja/manuals/platform/settings_running_state/settings_running_state_menu.png
      :width: 200px
      :align: left

#. | :menuselection:`システム状態一覧` 画面が表示されるので、変更したいメンテナンスモードを切り替え、 :guilabel:`登録` をクリックします。

   .. figure:: /images/ja/manuals/platform/settings_running_state/settings_running_state_maintenancemode.png
      :width: 600px
      :align: left

   .. list-table:: 
      :widths: 40 200
      :header-rows: 1
      :align: left
   
      * - 項目名
        - 説明
      * - バックヤード
        - | ONにするとバックヤード停止します。
      * - データ更新
        - | ONにするとデータの書き込みが停止します。
        - | ONの場合、ログレベルの変更は反映されません。
 

   .. note:: | メンテナンスモードについて
      | メンテナンスモードの詳細につきましては :doc:`../maintenance/maintenance_mode` をご参照ください。

     
ログレベルの変更
----------------

| ログレベルの変更は、下記の手順で行ないます。

#. | Exastro システムにシステム管理者でログインします。

#. | メニューより :menuselection:`システム状態設定` をクリックします。

   .. image:: /images/ja/manuals/platform/settings_running_state/settings_running_state_menu.png
      :width: 200px
      :align: left

#. | :menuselection:`システム状態一覧` 画面が表示されるので、 ログレベルを変更し、 :guilabel:`登録` をクリックします。

   .. figure:: /images/ja/manuals/platform/settings_running_state/settings_running_state_loglevel.png
      :width: 600px
      :align: left

   .. note:: | ログレベルについて
      | ログレベルの詳細につきましては :doc:`../maintenance/log_level` をご参照ください。

サービスの実行状態確認
----------------------

| サービス毎の実行状態を確認出来ます。