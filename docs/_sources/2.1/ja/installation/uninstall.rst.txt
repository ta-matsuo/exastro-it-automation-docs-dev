================
アンインストール
================

目的
====

| 本書では、Exastro システムのアンインストール方法について紹介します。

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


アンインストールの準備
======================

.. warning:: 
  | アンインストール実施前に :doc:`../manuals/maintenance/backup_and_restore` の手順に従い、バックアップを取得しておくことを推奨します。

.. _アンインストール-1:

アンインストール
================

アンインストール実施
--------------------

| アンインストールを実施します。

.. code-block:: bash
  :caption: コマンド

  helm uninstall exastro --namespace exastro

.. code-block:: bash
  :caption: 出力結果

  release "exastro" uninstalled


データベースのデータの削除
--------------------------

| Persitent Volume を Kubernetes 上に hostPath で作成した場合の方法を記載します。
| マネージドデータベースを含む外部データベースを利用している場合は、環境にあったデータ削除方法を実施してください。

.. code-block:: bash
  :caption: コマンド

  kubectl delete pv pv-database

.. code-block:: bash
  :caption: 実行結果

  persistentvolume "pv-database" deleted

| Kubernetes のコントロールノードにログインし、データを削除します。
| 下記コマンドは、Persistent Volume 作成時の hostPath に :file:`/var/data/exastro-suite/exastro-platform/database` を指定した場合の例です。

.. code-block:: bash
   :caption: コマンド

   # 永続データがあるコントロールノードにログイン
   ssh user@contol.node.example

   # 永続データの削除
   sudo rm -rf /var/data/exastro-suite/exastro-platform/database


ファイルデータの削除
--------------------

| Persitent Volume を Kubernetes 上に hostPath で作成した場合の方法を記載します。
| マネージドストレージを含む外部ストレージを利用している場合は、環境にあったデータ削除方法を実施してください。

.. code-block:: bash
  :caption: コマンド

  kubectl delete pv pv-ita-common

.. code-block:: bash
  :caption: 実行結果

  persistentvolume "pv-ita-common" deleted

| Kubernetes のコントロールノードにログインし、データを削除します。
| 下記コマンドは、Persistent Volume 作成時の hostPath に :file:`/var/data/exastro-suite/exastro-it-automation/ita-common` を指定した場合の例です。

.. code-block:: bash
   :caption: コマンド

   # 永続データがあるコントロールノードにログイン
   ssh user@contol.node.example

   # 永続データの削除
   sudo rm -rf /var/data/exastro-suite/exastro-it-automation/ita-common