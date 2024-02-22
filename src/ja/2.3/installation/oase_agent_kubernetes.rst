.. raw:: html

   <script>
   $(window).on('load', function () {
      setTimeout(function(){
        for (var i = 0; i < $("table.filter-table").length; i++) {
          $("[id^='ft-data-" + i + "-2-r']").removeAttr("checked");
          $("[id^='select-all-" + i + "-2']").removeAttr("checked");
          $("[id^='ft-data-" + i + "-2-r'][value^='可']").prop('checked', true);
          $("[id^='ft-data-" + i + "-2-r'][value*='必須']").prop('checked', true);
          tFilterGo(i);
        }
      },200);
   });
   </script>

.. _oase_agent_kubernetes_install:

=======================
OASE Agent (Kubernetes)
=======================

目的
====

| 本書では、Exastro IT AutomationにおいてOASEを利用する際に、外部との連携に必要となる、Exastro OASE Agentを導入する手順について説明します。

特徴
====

| OASEを利用するための絶対条件である、Exastro OASE Agentの高い可用性やサービスレベルを必要とされる際の、Exastro IT Automation の導入方法となります。
| 評価や一時的な利用など、簡単に利用を開始したい場合には、:doc:`Docker Compose 版 OASE Agent<oase_agent_docker_compose>` の利用を推奨します。
| Exastro OASE Agentの設定や運用については、:ref:`エージェント概要<agent_about>` をご参照ください。

前提条件
========

- Exastro IT Automationについて

  | Exastro OASE Agentの運用には、Exastro OASE AgentとExastro IT Automationのバージョンが一致している必要があります。

- クライアント要件

  | 動作確認が取れているクライアントアプリケーションのバージョンは下記のとおりです。

  .. list-table:: クライアント要件
   :widths: 20, 20
   :header-rows: 1

   * - アプリケーション
     - バージョン
   * - Helm
     - v3.9.x
   * - kubectl
     - 1.23

- デプロイ環境

  | 動作確認が取れているコンテナ環境の最小要求リソースとバージョンは下記のとおりです。

  .. list-table:: ハードウェア要件(最小構成)
   :widths: 1, 1
   :header-rows: 1
  
   * - リソース種別
     - 要求リソース
   * - CPU
     - 2 Cores (3.0 GHz, x86_64)
   * - Memory
     - 4GB
   * - Storage (Container image size)
     - 10GB
   * - Kubernetes (Container image size)
     - 1.23 以上

- 通信要件

  - OASE Agentから収集対象サーバにアクセスできる必要があります。
  - コンテナ環境からコンテナイメージの取得のために、Docker Hub に接続できる必要があります。

.. warning::
    | :doc:`Helm chart (Kubernetes) 版<helm_on_kubernetes>` で構築した環境にデプロイする場合、
    | OASE Agentに対応する最小要件を追加で容易する必要があります。


インストールの準備
==================

Helm リポジトリの登録
---------------------

| Exastro OASE AgentはExastro システムと同一の Helm リポジトリ上に存在しています。

- Exastro OASE Agent

.. csv-table::
 :header: リポジトリ
 :widths: 50

 https://exastro-suite.github.io/exastro-helm/

.. code-block:: shell
   :linenos:
   :caption: コマンド

   # Exastro システムの Helm リポジトリを登録
   helm repo add exastro https://exastro-suite.github.io/exastro-helm/ -n exastro
   # リポジトリ情報の更新
   helm repo update

デフォルト設定値の取得
----------------------

| 投入するパラメータを管理しやすくするために、下記のコマンドから共通基盤 values.yaml のデフォルト値を出力します。

.. code-block:: shell
   :caption: コマンド

   helm show values exastro/exastro-agent > exastro-agent.yaml

.. raw:: html

   <details>
     <summary>exastro-agent.yaml</summary>

.. code-block:: yaml
   :linenos:

   # Default values for exastro-agent.
   # This is a YAML-formatted file.
   # Declare variables to be passed into your templates.
   global:
     agentGlobalDefinition:
       name: agent-global
       enabled: true
       image:
         registry: "docker.io"
         organization: exastro
         package: exastro-it-automation

   ita-ag-oase:
     agents:
       - image:
           repository: ""
           # Overrides the image tag whose default is the chart appVersion.
           tag: ""
           pullPolicy: IfNotPresent
         extraEnv:
           TZ: Asia/Tokyo
           DEFAULT_LANGUAGE: ja
           LANGUAGE: "en"
           ITERATION: "500"
           EXECUTE_INTERVAL: "10"
           LOG_LEVEL: INFO
           AGENT_NAME: "oase-agent"
           EXASTRO_URL: "http://platform-auth:8000"
           EXASTRO_ORGANIZATION_ID: "org001"
           EXASTRO_WORKSPACE_ID: "ws01"
           # ROLES: "_ws_admin"
           EVENT_COLLECTION_SETTINGS_NAMES: "id0001"
         secret:
           EXASTRO_USERNAME: "admin"
           EXASTRO_PASSWORD: "sample-password"
           # USER_ID: "user01"
         resources: {}
           # requests:
           #   memory: "64Mi"
           #   cpu: "250m"
           # limits:
           #   memory: "64Mi"
           #   cpu: "250m"

     imagePullSecrets: []
     nameOverride: ""
     fullnameOverride: ""

     initContainerImage:
       repository: "registry.access.redhat.com/ubi8/ubi-init"
       pullPolicy: IfNotPresent
       # Overrides the image tag whose default is the chart appVersion.
       tag: ""

     serviceAccount:
       # Specifies whether a service account should be created
       create: false
       # Annotations to add to the service account
       annotations: {}
       # The name of the service account to use.
       # If not set and create is true, a name is generated using the fullname template
       name: ""

     persistence:
       enabled: true
       reinstall: false
       accessMode: ReadWriteMany
       size: 10Gi
       volumeType: hostPath # e.g.) hostPath or AKS
       storageClass: "-" # e.g.) azurefile or - (None)
       # matchLabels:
       #   release: "stable"
       # matchExpressions:
       #   - {key: environment, operator: In, values: [dev]}
       mountPath:
         storage: /storage
         homeDir: /home/app_user
         pid:
           path: /var/run_app_user/httpd/pid
           subPath: httpd-pid
         socket:
           path: /var/run_app_user/httpd/socket
           subPath: httpd-socket
         tmp: /tmp

     podAnnotations: {}

     podSecurityContext: {}
       # fsGroup: 2000

     securityContext:
       allowPrivilegeEscalation: false
       readOnlyRootFilesystem: true
       runAsUser: 1000
       runAsGroup: 1000
       runAsNonRoot: true

     service: {}

     ingress:
       enabled: false
       className: ""
       annotations: {}
         # kubernetes.io/ingress.class: nginx
         # kubernetes.io/tls-acme: "true"
       hosts:
         - host: chart-example.local
           paths:
             - path: /
               pathType: ImplementationSpecific
       tls: []
     #  - secretName: chart-example-tls
       #    hosts:
       #      - chart-example.local

     nodeSelector: {}

     tolerations: []

     affinity: {}

.. raw:: html

   </details>


| 以降の手順では、この :file:`exastro-agent.yaml` に対してインストールに必要なパラメータを設定してきいます。

OASE Agentの設定
----------------

| OASE Agentを立ち上げる際の代表的な設定方法について紹介します。
| 下記の例では、永続ボリュームはhostPathで設定してます。

- シンプル構成
- 複数エージェント（同一Pod）
- 複数エージェント（別Pod）

パラメータ
^^^^^^^^^^

| 利用可能なパラメータについては下記を参照してください。

.. include:: ../include/helm_option_ita-ag-oase.rst

OASE Agentのパラメータ設定例
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

| Agentの設定例を下記に記載します。

.. tabs::

   .. group-tab:: シンプル構成

      - 特徴

      | 1Podに1コンテナのシンプルな構成


      - 設定例

      1.  OASE Agentの設定
  
          | OASE Agentの設定します。

          .. code-block:: diff
           :caption: exastro-agent.yaml
           :linenos:
           :lineno-start: 13

           ita-ag-oase:
             agents:
               - image:
                   repository: ""
                   # Overrides the image tag whose default is the chart appVersion.
                   tag: "alpha.4ccca4.20240124-110529"
                   pullPolicy: IfNotPresent
                 extraEnv:
                   TZ: Asia/Tokyo
                   DEFAULT_LANGUAGE: ja
                   LANGUAGE: "en"
                   ITERATION: "500"
                   EXECUTE_INTERVAL: "10"
                   LOG_LEVEL: INFO
                   AGENT_NAME: "oase-agent"
           -       EXASTRO_URL: "http://platform-auth:8000"
           +       EXASTRO_URL: "http://your-exastro-url"                                   # Exastro IT Automation の Service URL
           -       EXASTRO_ORGANIZATION_ID: "org001"
           +       EXASTRO_ORGANIZATION_ID: "your-organization-id"                          # Exastro IT Automation で作成した OrganizationID 
           -       EXASTRO_WORKSPACE_ID: "ws01"
           +       EXASTRO_WORKSPACE_ID: "your-workspace-id"                                # Exastro IT Automation で作成した WorkspaceID
                   # ROLES: "_ws_admin"
           -       EVENT_COLLECTION_SETTINGS_NAMES: "id0001"
           +       EVENT_COLLECTION_SETTINGS_NAMES: "your-event-collection-settigs-names"   # OASE管理 エージェント で作成した イベント収集設定名
                 secret:
           -       EXASTRO_USERNAME: "admin"          
           -       EXASTRO_PASSWORD: "sample-password"
           +       EXASTRO_USERNAME: "your-ita-user-name"                                   # Exastro IT Automation で作成した ユーザー名
           +       EXASTRO_PASSWORD: "your-ita-user-password"                               # Exastro IT Automation で作成した パスワード

   .. group-tab:: 複数エージェント（同一Pod）

      - 特徴

      | 1Podに複数コンテナを立てる構成。
      | image以下を増やしていくことで複数構築可能だが、その分リソースは増やす必要があります。


      - 設定例

      1.  OASE Agentの設定
  
          | OASE Agentの設定します。

          .. code-block:: diff
           :caption: exastro-agent.yaml
           :linenos:
           :lineno-start: 13

           ita-ag-oase:
             agents:
               - image:
                   repository: ""
                   # Overrides the image tag whose default is the chart appVersion.
                   tag: "alpha.4ccca4.20240124-110529"
                   pullPolicy: IfNotPresent
                 extraEnv:
                   TZ: Asia/Tokyo
                   DEFAULT_LANGUAGE: ja
                   LANGUAGE: "en"
                   ITERATION: "500"
                   EXECUTE_INTERVAL: "10"
                   LOG_LEVEL: INFO
                   AGENT_NAME: "oase-agent"
           +       AGENT_NAME: "oase-agent-1"                                               # 起動する OASEエージェントの名前
           -       EXASTRO_URL: "http://platform-auth:8000"
           +       EXASTRO_URL: "http://your-exastro-url"                                   # Exastro IT Automation の Service URL
           -       EXASTRO_ORGANIZATION_ID: "org001"
           +       EXASTRO_ORGANIZATION_ID: "your-organization-id"                          # Exastro IT Automation で作成した OrganizationID 
           -       EXASTRO_WORKSPACE_ID: "ws01"
           +       EXASTRO_WORKSPACE_ID: "your-workspace-id-1"                                # Exastro IT Automation で作成した WorkspaceID
                   # ROLES: "_ws_admin"
           -       EVENT_COLLECTION_SETTINGS_NAMES: "id0001"
           +       EVENT_COLLECTION_SETTINGS_NAMES: "your-event-collection-settigs-names-1"   # OASE管理 エージェント で作成した イベント収集設定名
                 secret:
           -       EXASTRO_USERNAME: "admin"          
           -       EXASTRO_PASSWORD: "sample-password"
           +       EXASTRO_USERNAME: "your-ita-user-name"                                   # Exastro IT Automation で作成した ユーザー名
           +       EXASTRO_PASSWORD: "your-ita-user-password"                               # Exastro IT Automation で作成した パスワード
           +   - image:
           +       repository: ""
           +       # Overrides the image tag whose default is the chart appVersion.
           +       tag: "alpha.4ccca4.20240124-110529"
           +       pullPolicy: IfNotPresent
           +     extraEnv:
           +       TZ: Asia/Tokyo
           +       DEFAULT_LANGUAGE: ja
           +       LANGUAGE: "en"
           +       ITERATION: "500"
           +       EXECUTE_INTERVAL: "10"
           +       LOG_LEVEL: INFO
           +       AGENT_NAME: "oase-agent-2"                                               # 起動する OASEエージェントの名前
           +       EXASTRO_URL: "http://your-exastro-url"                                   # Exastro IT Automation の Service URL
           +       EXASTRO_ORGANIZATION_ID: "your-organization-id"                          # Exastro IT Automation で作成した OrganizationID 
           +       EXASTRO_WORKSPACE_ID: "your-workspace-id-2"                                # Exastro IT Automation で作成した WorkspaceID
           +       # ROLES: "_ws_admin"
           +       EVENT_COLLECTION_SETTINGS_NAMES: "your-event-collection-settigs-names-2"   # OASE管理 エージェント で作成した イベント収集設定名
           +     secret:
           +       EXASTRO_USERNAME: "your-ita-user-name"                                   # Exastro IT Automation で作成した ユーザー名
           +       EXASTRO_PASSWORD: "your-ita-user-password"                               # Exastro IT Automation で作成した パスワード


   .. group-tab:: 複数エージェント（別Pod）

      - 特徴

      | 複数のPodを立てる構成。
      | 不要エージェントを個別に停止できる利点がありますが、
      | それぞれのPodに対して永続化ボリュームを作成する必要があります。

      - 設定例

      1.  設定値ファイルを用意

          | exastro-agent.yamlをコピーして、exastro-agent-1.yamlを用意してください。
          | exastro-agent.yamlをコピーして、exastro-agent-2.yamlを用意してください。

      2.  一つ目のOASE Agentの設定

          .. code-block:: diff
           :caption: exastro-agent-1.yaml
           :linenos:
           :lineno-start: 13

           ita-ag-oase:
             agents:
               - image:
                   repository: ""
                   # Overrides the image tag whose default is the chart appVersion.
                   tag: ""
                   pullPolicy: IfNotPresent
                 extraEnv:
                   TZ: Asia/Tokyo
                   DEFAULT_LANGUAGE: ja
                   LANGUAGE: "en"
                   ITERATION: "500"
                   EXECUTE_INTERVAL: "10"
                   LOG_LEVEL: INFO
                   AGENT_NAME: "oase-agent"
           -       EXASTRO_URL: "http://platform-auth:8000"
           +       EXASTRO_URL: "http://your-exastro-url"                                   # Exastro IT Automation の Service URL
           -       EXASTRO_ORGANIZATION_ID: "org001"
           +       EXASTRO_ORGANIZATION_ID: "your-organization-id"                          # Exastro IT Automation で作成した OrganizationID 
           -       EXASTRO_WORKSPACE_ID: "ws01"
           +       EXASTRO_WORKSPACE_ID: "your-workspace-id-1"                                # Exastro IT Automation で作成した WorkspaceID
                   # ROLES: "_ws_admin"
           -       EVENT_COLLECTION_SETTINGS_NAMES: "id0001"
           +       EVENT_COLLECTION_SETTINGS_NAMES: "your-event-collection-settigs-names-1"   # OASE管理 エージェント で作成した イベント収集設定名
                 secret:
           -       EXASTRO_USERNAME: "admin"          
           -       EXASTRO_PASSWORD: "sample-password"
           +       EXASTRO_USERNAME: "your-ita-user-name"                                   # Exastro IT Automation で作成した ユーザー名
           +       EXASTRO_PASSWORD: "your-ita-user-password"                               # Exastro IT Automation で作成した パスワード

      3.  一つ目のOASE Agentの定義名を設定

          .. code-block:: diff
           :caption: exastro-agent-1.yaml
           :linenos:
           :lineno-start: 45

             imagePullSecrets: []
           - nameOverride: ""
           + nameOverride: "ita-ag-oase-1"    # Exastro OASE Agent の定義名
             fullnameOverride: ""

      5.  一つ目のOASE AgentのmatchLabelsを設定

          .. code-block:: diff
           :caption: exastro-agent-1.yaml
           :linenos:
           :lineno-start: 64

             persistence:
               enabled: true
               reinstall: false
               accessMode: ReadWriteMany
               size: 10Gi
               volumeType: hostPath # e.g.) hostPath or AKS
               storageClass: "-" # e.g.) azurefile or - (None)
           -   # matchLabels:
           -   #   release: "stable"
           +   matchLabels:
           +     release: "pv-ita-ag-oase-1"    # 利用する永続ボリューム名を指定

      6.  二つ目のOASE Agentの設定

          .. code-block:: diff
           :caption: exastro-agent-2.yaml
           :linenos:
           :lineno-start: 13

           ita-ag-oase:
             agents:
               - image:
                   repository: ""
                   # Overrides the image tag whose default is the chart appVersion.
                   tag: ""
                   pullPolicy: IfNotPresent
                 extraEnv:
                   TZ: Asia/Tokyo
                   DEFAULT_LANGUAGE: ja
                   LANGUAGE: "en"
                   ITERATION: "500"
                   EXECUTE_INTERVAL: "10"
                   LOG_LEVEL: INFO
                   AGENT_NAME: "oase-agent"
           -       EXASTRO_URL: "http://platform-auth:8000"
           +       EXASTRO_URL: "http://your-exastro-url"                                     # Exastro IT Automation の Service URL
           -       EXASTRO_ORGANIZATION_ID: "org001"
           +       EXASTRO_ORGANIZATION_ID: "your-organization-id"                            # Exastro IT Automation で作成した OrganizationID 
           -       EXASTRO_WORKSPACE_ID: "ws01"
           +       EXASTRO_WORKSPACE_ID: "your-workspace-id-2"                                # Exastro IT Automation で作成した WorkspaceID
                   # ROLES: "_ws_admin"
           -       EVENT_COLLECTION_SETTINGS_NAMES: "id0001"
           +       EVENT_COLLECTION_SETTINGS_NAMES: "your-event-collection-settigs-names-2"   # OASE管理 エージェント で作成した イベント収集設定名
                 secret:
           -       EXASTRO_USERNAME: "admin"          
           -       EXASTRO_PASSWORD: "sample-password"
           +       EXASTRO_USERNAME: "your-ita-user-name"                                     # Exastro IT Automation で作成した ユーザー名
           +       EXASTRO_PASSWORD: "your-ita-user-password"                                 # Exastro IT Automation で作成した パスワード

      7.  二つ目のOASE Agentの定義名を設定します。

          .. code-block:: diff
           :caption: exastro-agent-2.yaml
           :linenos:
           :lineno-start: 45

             imagePullSecrets: []
           - nameOverride: ""
           + nameOverride: "ita-ag-oase-2"    # Exastro OASE Agent の定義名
             fullnameOverride: ""

      8.  二つ目のOASE AgentのmatchLabelsを設定

          .. code-block:: diff
           :caption: exastro-agent-2.yaml
           :linenos:
           :lineno-start: 64

             persistence:
               enabled: true
               reinstall: false
               accessMode: ReadWriteMany
               size: 10Gi
               volumeType: hostPath # e.g.) hostPath or AKS
               storageClass: "-" # e.g.) azurefile or - (None)
           -   # matchLabels:
           -   #   release: "stable"
           +   matchLabels:
           +     release: "pv-ita-ag-oase-2"    # 利用する永続ボリューム名を指定

.. _persistent_volume:

永続ボリュームの設定
--------------------

| データベースのデータ永続化 (クラスタ内コンテナがある場合)、および、ファイルの永続化のために、永続ボリュームを設定する必要があります。
| 永続ボリュームの詳細については、 `永続ボリューム - Kubernetes <https://kubernetes.io/ja/docs/concepts/storage/persistent-volumes/#%E6%B0%B8%E7%B6%9A%E3%83%9C%E3%83%AA%E3%83%A5%E3%83%BC%E3%83%A0>`_ を参照してください。

.. tabs::

   .. group-tab:: Kubernetes ノードのディレクトリ

      - 特徴

      | Kubernetes のノード上のストレージ領域を利用するため、別途ストレージを調達する必要はありませんが、この方法は非推奨のため検証や開発時のみの利用

      .. danger::
          | データの永続化自体は可能ですが、コンピュートノードの増減や変更によりデータが消えてしまう可能性があるため本番環境では使用しないでください。
          | また、Azure で構築した AKS クラスタは、クラスタを停止すると AKS クラスターの Node が解放されるため、保存していた情報は消えてしまいます。そのため、Node が停止しないように注意が必要となります。

      - 利用例

      | hostPath を使用した例を記載します。

      .. tabs::

         .. group-tab:: シンプル構成 & 複数エージェント（同一Pod）

            .. code-block:: diff
              :caption: pv-ita-ag-oase.yaml
              :linenos:

              # pv-ita-ag-oase.yaml
              apiVersion: v1
              kind: PersistentVolume
              metadata:
                name: pv-ita-ag-oase
              spec:
                capacity:
                  storage: 10Gi
                accessModes:
                  - ReadWriteMany
                persistentVolumeReclaimPolicy: Retain
                hostPath:
                  path: /var/data/exastro-suite/exastro-agent/ita-ag-oase
                  type: DirectoryOrCreate


         .. group-tab:: 複数エージェント（別Pod）

            .. code-block:: diff
              :caption: pv-ita-ag-oase-1.yaml
              :linenos:

              # pv-ita-ag-oase-1.yaml
              apiVersion: v1
              kind: PersistentVolume
              metadata:
                name: pv-ita-ag-oase-1
              spec:
                capacity:
                  storage: 10Gi
                accessModes:
                  - ReadWriteMany
                persistentVolumeReclaimPolicy: Retain
                hostPath:
                  path: /var/data/exastro-suite/exastro-agent/ita-ag-oase-1
                  type: DirectoryOrCreate

            .. code-block:: diff
              :caption: pv-ita-ag-oase-2.yaml
              :linenos:

              # pv-ita-ag-oase-2.yaml
              apiVersion: v1
              kind: PersistentVolume
              metadata:
                name: pv-ita-ag-oase-2
              spec:
                capacity:
                  storage: 10Gi
                accessModes:
                  - ReadWriteMany
                persistentVolumeReclaimPolicy: Retain
                hostPath:
                  path: /var/data/exastro-suite/exastro-agent/ita-ag-oase-2
                  type: DirectoryOrCreate

.. _インストール-1:

インストール
============

永続ボリュームの作成
--------------------

| :ref:`persistent_volume` で作成したマニフェストファイルを適用し、ボリュームを作成します。

.. code-block:: bash

    # pv-ita-ag-oase.yaml
    kubectl apply -f pv-ita-ag-oase.yaml

    # 複数エージェント（別Pod）の場合は下記を実施
    # pv-ita-ag-oase-1.yaml 
    kubectl apply -f pv-ita-ag-oase-1.yaml

    # pv-ita-ag-oase-2.yaml
    kubectl apply -f pv-ita-ag-oase-2.yaml


.. code-block:: bash

    # 確認
    kubectl get pv

.. code-block:: bash

    NAME              CAPACITY   ACCESS MODES   RECLAIM POLICY    STATUS      CLAIM     STORAGECLASS   REASON   AGE
    pv-ita-ag-oase     10Gi       RWX            Retain           Available                                     6s

.. code-block:: bash

    NAME              CAPACITY   ACCESS MODES   RECLAIM POLICY    STATUS      CLAIM     STORAGECLASS   REASON   AGE
    pv-ita-ag-oase-1   10Gi       RWX            Retain           Available                                     5s
    pv-ita-ag-oase-2   10Gi       RWX            Retain           Available                                     6s

インストール
------------

| Helm バージョンとアプリケーションのバージョンについては下記を確認してください。

.. tabs::

   .. group-tab:: シンプル構成 & 複数エージェント（同一Pod）

      1. Helm コマンドを使い Kubernetes 環境にインストールを行います。

         .. code-block:: bash
            :caption: コマンド

            helm install exastro-agent exastro/exastro-agent \
              --namespace exastro --create-namespace \
              --values exastro-agent.yaml

         .. code-block:: bash
            :caption: 出力結果

            NAME: exastro-agent
            LAST DEPLOYED: Wed Feb 14 14:36:27 2024
            NAMESPACE: exastro
            STATUS: deployed
            REVISION: 1
            TEST SUITE: None

      2. インストール状況確認

         .. code-block:: bash
             :caption: コマンド
             
             # Pod の一覧を取得
             kubectl get po -n exastro
             
             | 正常に起動している場合は、“Running” となります。
             | ※正常に起動するまで数分かかる場合があります。

         .. code-block:: bash
             :caption: 出力結果
             
              NAME                             READY   STATUS    RESTARTS   AGE
              ita-ag-oase-66cb7669c6-m2q8c     1/1     Running   0          16m

   .. group-tab:: 複数エージェント（別Pod）

      1. Helm コマンドを使い Kubernetes 環境にインストールを行います。

         .. code-block:: bash
            :caption: コマンド

            helm install exastro-agent-1 exastro/exastro-agent \
              --namespace exastro --create-namespace \
              --values exastro-agent-1.yaml

         .. code-block:: bash
            :caption: 出力結果

            NAME: exastro-agent-1
            LAST DEPLOYED: Wed Feb 14 14:36:27 2024
            NAMESPACE: exastro
            STATUS: deployed
            REVISION: 1
            TEST SUITE: None

         .. code-block:: bash
            :caption: コマンド

            helm install exastro-agent-2 exastro/exastro-agent \
              --namespace exastro --create-namespace \
              --values exastro-agent-2.yaml
         
         .. code-block:: bash
            :caption: 出力結果

            NAME: exastro-agent-2
            LAST DEPLOYED: Wed Feb 14 14:36:27 2024
            NAMESPACE: exastro
            STATUS: deployed
            REVISION: 1
            TEST SUITE: None

      2. インストール状況確認
           
         .. code-block:: bash
             :caption: コマンド
             
             # Pod の一覧を取得
             kubectl get po -n exastro
             
             | 正常に起動している場合は、“Running” となります。
             | ※正常に起動するまで数分かかる場合があります。

         .. code-block:: bash
             :caption: 出力結果
             
              NAME                             READY   STATUS    RESTARTS   AGE
              ita-ag-oase-1-66cb7669c6-m2q8c   1/1     Running   0          16m
              ita-ag-oase-2-787fb97f75-9s7xj   1/1     Running   0          13m
