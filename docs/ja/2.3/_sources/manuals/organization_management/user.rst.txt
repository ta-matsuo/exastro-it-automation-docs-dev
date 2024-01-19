========
ユーザー
========

はじめに
========

| 本書では、Exastro システム におけるユーザーについて説明します。


ユーザーの登録
==============
| Exastro システムで使用するユーザーを登録出来ます。
| ユーザーは、付与されているロールでユーザーの役割を区別します。
| ユーザーに割り当てられるロールの詳細につきましては :doc:`../organization_management/role` をご参照ください。

ユーザーの作成
--------------

| ユーザーは、下記の手順で作成します。

#. | Exastro システムにオーガナイゼーション管理者でログインします。

#. | メニューより :menuselection:`ユーザー管理` をクリックします。

   .. image:: /images/ja/manuals/platform/platform_menu.png
      :width: 200px
      :align: left

#. | :menuselection:`ユーザー一覧` 画面が表示されるので、 :guilabel:`作成` をクリックします。

   .. figure:: /images/ja/manuals/platform/user/ユーザー一覧画面.png
      :width: 600px
      :align: left

   .. note:: | ユーザー管理権限を有するロールに紐づくユーザー以外でログインしている時は、メニューに :menuselection:`ユーザー管理` は表示されません。
      | ユーザー管理権限を有するロールは以下の3つとなります。
      | _orgnization-manager,_orgnization-user-manager,_orgnization-user-role-manager

#. | :menuselection:`新規ユーザー` 画面が表示されるので、ユーザーの情報を入力し、 :guilabel:`登録` をクリックします。

   .. figure:: /images/ja/manuals/platform/user/新規ユーザー作成画面.png
      :width: 600px
      :align: left

   .. list-table:: 新規ユーザー登録
      :widths: 40 200
      :header-rows: 1
      :align: left
   
      * - 項目名
        - 説明
      * - ユーザーID
        - | ユーザーに割り当てる一意のIDを自動で付与します。
      * - ユーザー名
        - | ログイン時に使用するユーザー名を入力します。
      * - パスワード
        - | アカウントにログインするためのパスワードを設定します。
          | ONに設定した際、次回ログイン時にパスワード変更画面が表示されます。
          | 通常はONのまま、ご利用ください。
      * - email
        - | 追加するユーザーのE-mailアドレスを入力します。
      * - 名
        - | 追加するユーザーの名を入力します。
      * - 姓
        - | 追加するユーザーの姓を入力します。
      * - 有効
        - | 追加するユーザーの使用できる状態を有効・無効で選択します。
      * - 所属
        - | 追加するユーザーの所属を入力します。
      * - 説明
        - | ユーザーの説明を入力します。

ユーザーの編集
---------------

| ユーザーの編集は、下記の手順で行ないます。

#. | Exastro システムにオーガナイゼーション管理者でログインします。

#. | メニューより :menuselection:`ユーザー管理` をクリックします。

   .. image:: /images/ja/manuals/platform/platform_menu.png
      :width: 200px
      :align: left

#. | :menuselection:`ユーザー一覧` 画面が表示されるので、 :guilabel:`編集` をクリックします。

   .. figure:: /images/ja/manuals/platform/user/ユーザー一覧画面_edit.png
      :width: 600px
      :align: left

#. | :menuselection:`ユーザー編集` 画面が表示されるので、ユーザーの情報を編集し、 :guilabel:`登録` をクリックします。

   .. figure:: /images/ja/manuals/platform/user/ユーザー編集画面.png
      :width: 600px
      :align: left

   .. list-table:: ユーザー編集
      :widths: 40 200
      :header-rows: 1
      :align: left
   
      * - 項目名
        - 説明
      * - ユーザーID
        - | ユーザーIDの変更は出来ません。
      * - ユーザー名
        - | ユーザー名の変更は出来ません。
      * - パスワード
        - | アカウントにログインするためのパスワードを設定します。
          | ONに設定した際、次回ログイン時にパスワード変更画面が表示されます。
          | 通常はONのまま、ご利用ください。
      * - email
        - | 追加するユーザーのE-mailアドレスを入力します。
      * - 名
        - | 追加するユーザーの名を入力します。
      * - 姓
        - | 追加するユーザーの姓を入力します。
      * - 有効
        - | 追加するユーザーの使用できる状態を有効・無効で選択します。
      * - 所属
        - | 追加するユーザーの所属を入力します。
      * - 説明
        - | ユーザーの説明を入力します。

ユーザーの削除
--------------

| ユーザーの削除は、下記の手順で行ないます。

#. | Exastro システムにオーガナイゼーション管理者でログインします。

#. | メニューより :menuselection:`ユーザー管理` をクリックします。

   .. image:: /images/ja/manuals/platform/platform_menu.png
      :width: 200px
      :align: left

#. | :menuselection:`ユーザー一覧` 画面が表示されるので、 :guilabel:`削除` をクリックします。

   .. figure:: /images/ja/manuals/platform/user/ユーザー一覧画面_delete.png
      :width: 600px
      :align: left

#. | 確認メッセージが表示されるので、:kbd:`オーガナイゼーションID/ユーザー名` を入力し、 :guilabel:`はい、削除します` をクリックします。

   .. figure:: /images/ja/manuals/platform/user/ユーザー削除実行確認画面.png
      :width: 600px
      :align: left

   .. tip::
      | 一度削除したユーザーを復元することは出来ません。
      | オーガナイゼーション管理者を削除することは出来ません。
