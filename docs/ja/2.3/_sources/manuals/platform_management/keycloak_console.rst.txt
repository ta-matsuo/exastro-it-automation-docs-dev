===================================
Keycloakコンソール
===================================

はじめに
========

| 本書では、Exastro Suite におけるシステム管理の Keycloakコンソール について説明します。

KeyCloakコンソール
==========================

| システム管理者が、新たなシステム管理者を追加やオーガナイゼーション毎のユーザーパスワード変更やパスワードポリシー、ログイン方法などを変更する際に利用します。
| またユーザーの変更やロールの追加を行った際の監査ログも確認できます。

#. | Keyclaokコンソールの選択

   | メニューより :menuselection:`Keycloakコンソール` を選択することで、Keycloakコンソール画面を表示することができます。

   .. figure:: /images/ja/manuals/platform/keycloak_console/keycloak_console_menu.png
      :width: 200px
      :align: left
      :class: with-border-thin

#. |  レルム（オーガナイゼーション）選択

   | 設定するレルム（オーガナイゼーション）を選択して作業を進めることができます。

   .. figure:: /images/ja/manuals/platform/keycloak_console/keycloak_console_realm_list.png
      :width: 600px
      :align: left
      :class: with-border-thin

   .. danger::

      | 基本的には、設定変更しないようにお願いします。
      | 変更内容によっては、正常にアプリケーションが動作しなくなる可能性があります。  

   .. note:: 

      | 各種ポリシーやログの確認方法などは、 `Keycloakの公式ドキュメント <https://www.keycloak.org/documentation.html>`_ をご参照ください。    

システム管理者の追加
----------------------

#. | システム管理者の追加

   | システム管理者を追加する際に、上述のレルムで `master` を選択し、メニューから :menuselection:`users` を選択後、 :guilabel:`Add User` ボタンを押下して、ユーザーを追加（情報入力）することができます。 


   .. figure:: /images/ja/manuals/platform/keycloak_console/keycloak_console_user_list.png
      :width: 600px
      :align: left
      :class: with-border-thin

#. | システム管理者のユーザー情報入力

   | ユーザー情報入力に新しいユーザー情報を入力します。

   .. figure:: /images/ja/manuals/platform/keycloak_console/keycloak_console_user_add.png
      :width: 600px
      :align: left
      :class: with-border-thin

   .. list-table:: 項目説明
      :widths: 40 200
      :header-rows: 1
      :align: left

      * - 項目名
        - 説明
      * - | Username
        - | ログイン時に使用するユーザー名を入力します
      * - | Email
        - | 追加するユーザーのE-mailアドレスを入力します
      * - | First Name
        - | 追加するユーザーの名を入力します
      * - | Last Name
        - | 追加するユーザーの姓を入力します
      * - | User Enabled
        - | 追加するユーザーの使用できる状態を有効・無効で選択します
      * - | Email Verified
        - | OFFを選択します
          | ※ONを選択してもメール送信用サーバー設定が設定されていないと動作しません
      * - | Groups
        - | Exastro システムでは未対応のため、指定しないでください
      * - | Required User Actions
        - | 次回ログインした際に、どのような情報を設定するか設定できます
          | 詳しい設定値は、`Keycloakの公式ドキュメント <https://www.keycloak.org/documentation.html>`_ をご参照ください

#. | システム管理者のユーザー登録

   | 必要な情報を入力後、 :guilabel:`Save` ボタンを押下して、ユーザーを登録することができます。

   .. figure:: /images/ja/manuals/platform/keycloak_console/keycloak_console_user_add_ok.png
      :width: 600px
      :align: left
      :class: with-border-thin

#. | 追加したユーザーのパスワード設定

   | ユーザーの登録ではパスワードの設定ができていないため、登録後次の画面からパスワードを設定する必要があります。
   | ユーザー詳細の :menuselection:`Credentials` を選択し、パスワードを設定してください。 
   | パスワードを入力後、:guilabel:`Set Password` ボタンを押下してパスワード設定します。 

   .. figure:: /images/ja/manuals/platform/keycloak_console/keycloak_console_user_add_password.png
      :width: 600px
      :align: left
      :class: with-border-thin

   .. list-table:: 項目説明
      :widths: 40 200
      :header-rows: 1
      :align: left

      * - 項目名
        - 説明
      * - | Password
        - | ログイン時に使用するパスワードを入力します
      * - | Password Confimation
        - | 入力したパスワードと同じ内容を入力します
      * - | Temporary
        - | ONに設定した際、次回ログイン時にパスワード変更画面が表示されます
          | 通常はONのまま、ご利用ください

#. | 追加したユーザーのロール設定

   | 追加したユーザーに必要なRoleを割り当てすることで、システム管理者と同等の設定が行えるようになります。
   | ユーザー詳細の :menuselection:`Role Mappings` を選択し、ロールを設定してください。 

   .. figure:: /images/ja/manuals/platform/keycloak_console/keycloak_console_user_add_role.png
      :width: 600px
      :align: left
      :class: with-border-thin

   .. list-table:: 項目説明
      :widths: 40 200
      :header-rows: 1
      :align: left

      * - 項目名
        - 説明
      * - | Realm Roles
        - | :menuselection:`Available Roles` から :menuselection:`admin` を選択して、:guilabel:`Add selected` ボタンを押下します

   | これで、追加したユーザーがシステム管理者として、作業できるようになりました。