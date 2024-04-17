
個人設定
------------

個人設定では、自身のアカウント編集、パスワード変更、二要素認証設定、トークン発行が行えます。

#. | 個人設定はログインユーザーのアイコンを選択して表示されるメニューから :menuselection:`アカウント管理` を選択することにより設定できます。

   .. figure:: /images/ja/manuals/platform/login/setting_profile.png
      :alt: 個人設定
      :width: 600px
      :align: left
      :class: with-border-thin

   .. note::
      |  Exastro IT Automation利用中は、メニュー - アカウント管理 は表示されません

アカウント編集
^^^^^^^^^^^^^^^^^^^^^^^

#. | アカウント編集より、Eメール、名、姓を変更することができます。

   .. figure:: /images/ja/manuals/platform/login/setting_profile_account.png
      :alt: 個人設定_アカウント編集
      :width: 600px
      :align: left
      :class: with-border-thin

   .. note::
      |  ※ユーザー名は変更できません。

パスワード変更
^^^^^^^^^^^^^^^^^^^^^^^

#. | パスワード変更より、自身のパスワードを変更することができます。

   .. figure:: /images/ja/manuals/platform/login/setting_profile_password.png
      :alt: 個人設定_パスワード変更
      :width: 600px
      :align: left
      :class: with-border-thin

二要素認証設定
^^^^^^^^^^^^^^^^^^^^^^^

#. | 二要素認証設定より、パスワード＋他の認証方式でのログインが行えるようになります。

   .. figure:: /images/ja/manuals/platform/login/setting_profile_auth.png
      :alt: 個人設定_二要素認証設定
      :width: 600px
      :align: left
      :class: with-border-thin

トークン発行
^^^^^^^^^^^^^^^^^^^^^^^

本システムにおいて、APIを呼び出す際に必要となるアクセストークンがありますが、アクセストークンの発行には、本説明で説明するリフレッシュトークンが必要となります。

.. tip::
   | APIの認証については、:doc:`../../reference/index` - :doc:`../../reference/api/index` - :doc:`../../reference/api/operator/index` - :doc:`../../reference/api/operator/certification` 、 :doc:`../../reference/api/system_manager/index` - :doc:`../../reference/api/system_manager/certification` 参照

#. | トークン発行より、API実行に必要なトークンの発行ならびに発行したトークンの一覧表示を行うことができます。

   .. figure:: /images/ja/manuals/platform/login/setting_profile_token.png
      :alt: 個人設定_トークン一覧
      :width: 600px
      :align: left
      :class: with-border-thin

#. | 初めてトークンを発行する際は、:guilabel:`発行` ボタンを押下して、必要な情報を入力しトークンを発行することができます。

   | 二要素認証を使用している場合は、二要素認証で使用しているアプリケーションのワンタイムパスワードを入力する必要があります。

   .. figure:: /images/ja/manuals/platform/login/setting_profile_token_issue.png
      :alt: 個人設定_トークン発行
      :width: 600px
      :align: left

#. | 発行されたトークンは、再表示できませんので必ず発行結果の画面のトークンを保存する必要があります。

   .. figure:: /images/ja/manuals/platform/login/setting_profile_token_issue_ok.png
      :alt: 個人設定_トークン発行OK
      :width: 600px
      :align: left

#. | 発行したトークンの有効期限は、トークン一覧で確認できます。

   .. figure:: /images/ja/manuals/platform/login/setting_profile_token_list.png
      :alt: 個人設定_トークン一覧
      :width: 600px
      :align: left
      :class: with-border-thin

#. | 発行したトークンが不要となった際は、:guilabel:`削除` ボタンを押下して、トークンを削除することができます。

   .. figure:: /images/ja/manuals/platform/login/setting_profile_token_list_delete.png
      :alt: 個人設定_トークン一覧(削除)
      :width: 600px
      :align: left
      :class: with-border-thin

   | 削除確認で本当に削除する場合は、:kbd:`yes` を入力して、:guilabel:`はい、削除します` ボタンを押下します。 

   .. figure:: /images/ja/manuals/platform/login/setting_profile_token_delete.png
      :alt: 個人設定_トークン削除
      :width: 600px
      :align: left

   .. warning::

      |  削除した際、すべてのトークンが無効となります。