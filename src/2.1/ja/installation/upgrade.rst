==============
アップグレード
==============

目的
====

| 本書では、Exastro システムのアップグレード方法について紹介します。

前提条件
========

- Exastro システムが導入済みであること
- クライアント要件

  | 動作確認が取れているクライアントアプリケーションのバージョンは下記のとおりです。
  
  .. csv-table:: クライアント要件
   :header: アプリケーション, バージョン
   :widths: 30, 30
  
   Helm, v3.9.x
   kubectl, 1.23


アップグレードの準備
====================

.. warning:: 
  | アップグレード実施前に :doc:`../manuals/maintenance/backup_and_restore` の手順に従い、バックアップを取得しておくことを推奨します。

Helm リポジトリの更新
---------------------

| Exastro システムの Helm リポジトリを更新します。

| 更新前のバージョンを確認します。

.. code-block:: shell
   :linenos:
   :caption: コマンド

   # リポジトリ情報の確認
   helm search repo exastro

.. code-block:: shell
   :linenos:
   :caption: 実行結果
   :emphasize-lines: 3

   helm search repo exastro
   NAME                            CHART VERSION   APP VERSION     DESCRIPTION                                       
   exastro/exastro                 1.0.0           2.0.3           A Helm chart for Exastro. Exastro is an Open So...
   exastro/exastro-it-automation   1.2.0           2.0.3           A Helm chart for Exastro IT Automation. Exastro...
   exastro/exastro-platform        1.5.0           1.4.0           A Helm chart for Exastro Platform. Exastro Plat...

| Helm リポジトリを更新します。

.. code-block:: shell
   :linenos:
   :caption: コマンド

   # リポジトリ情報の更新
   helm repo update

| 更新後のバージョンを確認します。

.. code-block:: shell
   :linenos:
   :caption: コマンド

   # リポジトリ情報の確認
   helm search repo exastro

.. code-block:: shell
   :linenos:
   :caption: 実行結果
   :emphasize-lines: 3

   helm search repo exastro
   NAME                            CHART VERSION   APP VERSION     DESCRIPTION                                       
   exastro/exastro                 1.0.1           2.1.0           A Helm chart for Exastro. Exastro is an Open So...
   exastro/exastro-it-automation   1.2.0           2.0.3           A Helm chart for Exastro IT Automation. Exastro...
   exastro/exastro-platform        1.5.0           1.4.0           A Helm chart for Exastro Platform. Exastro Plat...


デフォルト設定値の更新の確認
----------------------------

| デフォルト値の更新を確認します。
| インストール時に作成した設定ファイル :file:`exastro.yaml` とアップグレード後の設定ファイルを比較します。

.. code-block:: shell
   :caption: コマンド

   diff exastro.yaml <(helm show values exastro/exastro)


.. code-block:: diff
   :caption: 実行結果
    
   exastro-platform:
     platform-api:
       image:
         repository: "exastro/exastro-platform-api"
          tag: ""
    
     platform-auth:
   +    extraEnv:
   +      # Please set the URL to access
   +      EXTERNAL_URL: ""
   +      EXTERNAL_URL_MNG: ""
       ingress:
         enabled: true
         hosts:
           - host: exastro-suite.example.local
             paths:

設定値の更新
------------

| デフォルト設定値の比較結果から、項目の追加などにより設定値の追加が必要な場合は更新をしてください。
| 設定値の更新が不要であればこの手順はスキップしてください。
| 例えば下記の差分確認結果から、:kbd:`exastro-platform.platform-auth.extraEnv` が追加されていますので、必要に応じて、:file:`exastro.yaml` に項目と設定値を追加します。


.. code-block:: diff
   :caption: 実行結果
    
   exastro-platform:
     platform-api:
       image:
         repository: "exastro/exastro-platform-api"
          tag: ""
    
     platform-auth:
   +    extraEnv:
   +      # Please set the URL to access
   +      EXTERNAL_URL: ""
   +      EXTERNAL_URL_MNG: ""
       ingress:
         enabled: true
         hosts:
           - host: exastro-suite.example.local
             paths:

.. _アップグレード-1:

アップグレード
==============

サービス停止
------------

.. include:: ../include/stop_service_k8s.rst

アップグレード実施
------------------

| アップグレードを実施します。

.. code-block:: bash
  :caption: コマンド

  helm upgrade exastro exastro/exastro \
    --namespace exastro \
    --values exastro.yaml

.. code-block:: bash
  :caption: 出力結果

  NAME: exastro
  LAST DEPLOYED: Sat Jan 28 15:00:02 2023
  NAMESPACE: exastro
  STATUS: deployed
  REVISION: 2
  TEST SUITE: None
  NOTES:
  Exastro install completion!

  1. Execute the following command and wait until the pod becomes "Running" or "Completed":

    # NOTE: You can also append "-w" to the command or wait until the state changes with "watch command"

    kubectl get pods --namespace exastro

  2. Get the ENCRYPT_KEY by running these commands:

    # Exastro IT Automation ENCRYPT_KEY
    kubectl get secret ita-secret-ita-global -n exastro -o jsonpath='{.data.ENCRYPT_KEY}' | base64 -d

    # Exastro Platform ENCRYPT_KEY
    kubectl get secret platform-secret-pf-global -n exastro -o jsonpath='{.data.ENCRYPT_KEY}' | base64 -d

    !!! Please save the output ENCRYPT_KEY carefully. !!!

  3. Run the following command to get the application URL and go to the URL or go to the displayed URL:
    *************************
    * Service Console       *
    *************************
    http://exastro-suite.example.local/

    *************************
    * Administrator Console *
    *************************
    http://exastro-suite-mng.example.local/auth/


    # Note: You can display this note again by executing the following command.


サービス再開
------------

.. include:: ../include/start_service_k8s.rst

アップグレード状況確認
----------------------

| コマンドラインから以下のコマンドを入力して、アップグレードが完了していることを確認します。

.. code-block:: bash
   :caption: コマンド

   # Pod の一覧を取得
   kubectl get po -n exastro

| 正常に起動している場合は、ita-migration-xxxとplatform-migration-xxxが “Completed” 、その他すべてが “Running” となります。
| ※正常に起動するまで数分かかる場合があります。

.. code-block:: bash
   :caption: 出力結果bbb

    NAME                                                      READY   STATUS      RESTARTS   AGE
    ita-api-admin-64657656c6-r4s2l                            1/1     Running     0          30m
    ita-api-organization-75ff9d599c-gthvl                     1/1     Running     0          30m
    ita-by-ansible-execute-fdd8dfc57-7676h                    1/1     Running     0          30m
    ita-by-ansible-legacy-role-vars-listup-6cd558d78b-xxl6x   1/1     Running     0          30m
    ita-by-ansible-legacy-vars-listup-5db44d54d8-zxqj7        1/1     Running     0          30m
    ita-by-ansible-pioneer-vars-listup-6bf744f5b6-k8ctx       1/1     Running     0          30m
    ita-by-ansible-towermaster-sync-59594b5d84-phbg7          1/1     Running     0          30m
    ita-by-cicd-for-iac-f6855c588-r6w4k                       1/1     Running     0          30m
    ita-by-collector-6fc8c7b4d4-hjwck                         1/1     Running     0          30m
    ita-by-conductor-regularly-5897dcb9f6-4npz7               1/1     Running     0          30m
    ita-by-conductor-synchronize-6fd6dcd5f4-qgdhx             1/1     Running     0          30m
    ita-by-excel-export-import-df76d77c4-ms4j2                1/1     Running     0          30m
    ita-by-hostgroup-split-86746f758-b796k                    1/1     Running     0          30m
    ita-by-menu-create-8588c9747d-66xwn                       1/1     Running     0          30m
    ita-by-menu-export-import-6b8498f476-zwml7                1/1     Running     0          30m
    ita-by-terraform-cli-execute-8478554d8d-qztbv             1/1     Running     0          30m
    ita-by-terraform-cli-vars-listup-bf688659d-zgh8d          1/1     Running     0          30m
    ita-by-terraform-cloud-ep-execute-5dbbb599b-qh8rc         1/1     Running     0          30m
    ita-by-terraform-cloud-ep-vars-listup-5564fcb5b-nphm7     1/1     Running     0          30m
    ita-migration-1.0.4-0wdt                                  0/1     Completed   0          30m
    ita-web-server-854bcdbbf4-s7fdb                           1/1     Running     0          30m
    keycloak-56d8b4556c-tndnv                                 1/1     Running     0          30m
    platform-api-bddb446db-s9zjh                              1/1     Running     0          30m
    platform-auth-799f57fb6c-wlbtf                            1/1     Running     0          30m
    platform-migration-1.4.2-6sks                             0/1     Completed   0          30m
    platform-web-88db7c489-wkmn9                              1/1     Running     0          30m
