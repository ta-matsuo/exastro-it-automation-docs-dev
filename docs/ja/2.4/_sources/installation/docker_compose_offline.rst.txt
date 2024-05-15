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

==================================
Docker Compose on Docker - Offline
==================================

目的
====

| 本書では、Exastro IT Automation を利用する際に必要となる、Exastro Platform および Exastro IT Automation を Docker もしくは Podman 上に導入する手順について説明します。

特徴
====

| 最も簡単に Exastro IT Automation の利用を開始するための導入方法となります。
| 高い可用性やサービスレベルを必要とする場合には、:doc:`Kubernetes 版<helm_on_kubernetes>` の利用を推奨します。

前提条件
========

| インターネットに接続できる環境で必要な資材を収集し、記憶媒体等でオフライン環境に持ち込んだ後、インストールを行います。
| 資材を収集する環境とインストールする環境では、構築状態(OSのバージョン及びインストール済のパッケージ)を一致させる必要があります。

- デプロイ環境

  | 動作確認が取れているコンテナ環境の最小要求リソースとバージョンは下記のとおりです。

  .. list-table:: ハードウェア要件(最小構成)
   :widths: 20, 20
   :header-rows: 1
  
   * - リソース種別
     - 要求リソース
   * - CPU
     - 2 Cores (3.0 GHz, x86_64)
   * - Memory
     - 4GB
   * - Storage (Container image size)
     - 40GB

  .. list-table:: ハードウェア要件(推奨構成)
   :widths: 20, 20
   :header-rows: 1
  
   * - リソース種別
     - 要求リソース
   * - CPU
     - 4 Cores (3.0 GHz, x86_64)
   * - Memory
     - 16GB
   * - Storage (Container image size)
     - 120GB

  .. warning::
    | 最小構成における要求リソースは Exastro IT Automation のコア機能に対する値です。GitLab や Ansible Automation Platform などの外部システムをデプロイする場合は、その分のリソースが別途必要となります。
    | データベースおよびファイルの永続化のために、別途ストレージ領域を用意する必要があります。
    | Storage サイズは、ユーザーの利用状況によるためあくまで目安となります。必要に応じて容量を確保してください。
    
- 通信要件

  .. list-table:: 通信要件
   :widths: 15, 20, 10, 10, 5
   :header-rows: 1
  
   * - 用途
     - 説明
     - 通信元
     - 通信先
     - デフォルト
   * - Exastro サービス用
     - Exastro サービスとの接続に利用
     - クライアント
     - Exastro システム
     - 30080/tcp
   * - Exastro システム管理用
     - Exastro システム管理機能に利用
     - クライアント
     - Exastro システム
     - 30081/tcp
   * - GitLab サービス用(オプション)
     - AAP連携時の GitLab サービス接続に利用
     - Ansible Automation Platform
     - Exastro システム
     - 40080/tcp
   * - GitLab サービス用(オプション)
     - GitLab サービス監視用
     - Exastro システム
     - Exastro システム
     - 40080/tcp
   * - 資材取得
     - GitHub、コンテナイメージ、導入パッケージなど
     - Exastro システム
     - インターネット
     - 443/tcp

- 動作確認済みオペレーティングシステム

  以下は、動作確認済のバージョンとなります。

  .. list-table:: オペレーティングシステム
   :widths: 20, 20
   :header-rows: 1

   * - 種別
     - バージョン
   * - Red Hat Enterprise Linux
     - バージョン	8
   * - AlmaLinux
     - バージョン	8
   * - Ubuntu
     - バージョン	22.04

- 動作確認済みコンテナプラットフォーム

  手動でインストールする際には、下記のコンテナプラットフォームを準備してください。
  以下は、動作確認済のバージョンとなります。

  .. list-table:: コンテナプラットフォーム
   :widths: 20, 10
   :header-rows: 1

   * - ソフトウェア
     - バージョン
   * - Podman Engine ※Podman 利用時
     - バージョン	4.4
   * - Docker Compose ※Podman 利用時
     - バージョン	2.20
   * - Docker Engine ※Docker 利用時
     - バージョン	24


- アプリケーション

  | :command:`curl` と :command:`sudo` コマンドが実行できる必要があります。

.. warning::
   | Exastro のプロセスは一般ユーザ権限で起動する必要があります。(rootユーザーでのインストールはできません)
   | また、利用する一般ユーザは sudoer で、全操作権限を持っている必要があります。


.. _docker_prep:

事前準備
========

| Exastro の起動にはdocker-composeを使用するため、docker-compose-linux-x86_64を下記URLからダウンロードします。
| https://github.com/docker/compose/releases/download/v2.20.3/docker-compose-linux-x86_64
| サービス公開用の URL を準備しておく必要があります。

.. list-table:: 例1) IPアドレスによるサービス公開
 :widths: 15, 20
 :header-rows: 1

 * - サービス
   - URL
 * - Exastro サービス
   - http://172.16.0.1:30080
 * - Exastro 管理用サービス
   - http://172.16.0.1:30081
 * - GitLab サービス
   - http://172.16.0.1:40080

.. list-table:: 例2) ドメインによるサービス公開
 :widths: 15, 20
 :header-rows: 1

 * - サービス
   - URL
 * - Exastro サービス
   - http://ita.example.com:30080
 * - Exastro 管理用サービス
   - http://ita.example.com:30081
 * - GitLab サービス
   - http://ita.example.com:40080

.. list-table:: 例3) LoadBalancer を経由したサービス公開
 :widths: 15, 20
 :header-rows: 1

 * - サービス
   - URL
 * - Exastro サービス
   - https://ita.example.com
 * - Exastro 管理用サービス
   - https://ita-mng.example.com
 * - GitLab サービス
   - https://gitlab.example.com

.. tip::
   | HTTPSを利用する場合には、 LoadBalancer または、リバースプロキシを利用する必要があります。
   | LoadBalancer または、リバースプロキシを利用する場合は、別途準備をする必要があります。

.. _install_docker_compose:



全体の流れ
==========
| オンライン環境での作業完了後に、オフライン環境にてインストールを実施します。
											
													
オンライン環境での手順
^^^^^^^^^^^^^^^^^^^^^^
													
| 1.マウントの設定 				
| 1-1 設定ファイルを開く												
| 1-2 マウント設定を記述する												
| 1-3 設定を反映し、マウントを行う																							
													
| 2.コンテナイメージのダウンロード													
| 2-1 シェルスクリプトを作成する												
| 2-2 シェルスクリプトを実行する												
												
| 3.RPMパッケージのダウンロード													
| 3-1 RPMパッケージをダウンロードする												
| 3-2 createrepoをインストールする												
| 3-3 ローカルリポジトリを作成する																							
| 3-4 ダウンロードしたRMPパッケージを格納する												
													
| 4.Exastroリソースのダウンロード													
| 4-1 Exastroリソースをダウンロードする												
| 4-2 ダウンロードしたExastroリソースを格納する												


オフライン環境での手順			
^^^^^^^^^^^^^^^^^^^^^^
       
| 1.マウントの設定							
| 1-1 設定ファイルを開く						
| 1-2 マウント設定を記述する						
| 1-3 設定を反映し、マウントを行う									
       
| 2.docker-compose-linux-x86_64の取得							
| 2-1 docker-compose-linux-x86_64を取得する						
       
| 3.RPMパッケージのダウンロード							
| 3-1 RPMパッケージを取得する						
| 3-2 リポジトリファイルを作成する						
| 3-3 リポジトリ情報を記載する						
| 3-4 パッケージをインストールする						
| 3-5 エラー対応						
| 3-5-1 エラーとなったパッケージを削除する					
| 3-5-2 パッケージを再インストールする					
       
| 4.コンテナイメージのダウンロード							
| 4-1 シェルスクリプトを作成する					
| 4-2 シェルスクリプトを実行する						
       
| 5.Exastroリソースのインストール						
| 5-1 Exastroリソースを取得する						
| 5-2 Exastroリソースをインストールする						
| 5-3 Exastroを起動する						



オンライン環境(インターネットに接続できる環境)での作業
======================================================

| 資材の収集を行います。
| ここではNFSにマウントする方法で資材の受け渡しを実施しています。
| 以下、ユーザーはtestuser、ホームディレクトリは/home/testuserで実行した例です。


マウントの設定
^^^^^^^^^^^^^^^^

設定ファイルを開く
----------------------

| 下記を順に実行し、資材受け渡し用のマウント設定を行います。	

.. code-block:: shell
   :linenos:
   :caption: コマンド	

   sudo su -		
   vi /etc/fstab		


マウント設定を記述する		
--------------------------

| viエディタで開いた/etc/fstabに下記のマウント設定を追記します。	

.. code-block:: shell
   :caption: 記載例

   /dev/sda1 /mnt/mainte nfs defaults 0 0


設定を反映し、マウントを行う
--------------------------------

|	下記を順に実行し、設定を反映します。	

.. code-block:: shell
   :linenos:
   :caption: コマンド

   mkdir /mnt/mainte 
   systemctl daemon-reload
   mount -a 
   df
   exit


コンテナイメージのダウンロード		
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

シェルスクリプトを作成する		
--------------------------
| コンテナイメージをダウンロードするシェルスクリプトを作成します。

.. code-block:: shell
   :caption: コマンド

   cd /mnt/mainte/exastro/container-images
   touch image.list
   vi image.list

.. code-block:: shell
   :caption: 下記のコードをコピー＆ペーストする

   docker.io/mariadb:10.9.8
   docker.io/mariadb:10.11.4
   docker.io/gitlab/gitlab-ce:15.11.13-ce.0
   docker.io/mongo:6.0.7
   docker.io/exastro/keycloak:#__PF_VERSION__#
   docker.io/exastro/exastro-platform-auth:#__PF_VERSION__#
   docker.io/exastro/exastro-platform-web:#__PF_VERSION__#
   docker.io/exastro/exastro-platform-api:#__PF_VERSION__#
   docker.io/exastro/exastro-platform-job:#__PF_VERSION__#
   docker.io/exastro/exastro-platform-migration:#__PF_VERSION__#
   docker.io/exastro/exastro-platform-migration:#__PF_VERSION__#
   docker.io/exastro/exastro-it-automation-api-organization:#__ITA_VERSION__#
   docker.io/exastro/exastro-it-automation-api-admin:#__ITA_VERSION__#
   docker.io/exastro/exastro-it-automation-api-oase-receiver:#__ITA_VERSION__#
   docker.io/exastro/exastro-it-automation-web-server:#__ITA_VERSION__#
   docker.io/exastro/exastro-it-automation-by-ansible-agent:#__ITA_VERSION__#
   docker.io/exastro/exastro-it-automation-by-ansible-execute:#__ITA_VERSION__#
   docker.io/exastro/exastro-it-automation-by-ansible-execute-onpremises:#__ITA_VERSION__#
   docker.io/exastro/exastro-it-automation-by-ansible-legacy-role-vars-listup:#__ITA_VERSION__#
   docker.io/exastro/exastro-it-automation-by-ansible-legacy-vars-listup:#__ITA_VERSION__#
   docker.io/exastro/exastro-it-automation-by-ansible-pioneer-vars-listup:#__ITA_VERSION__#
   docker.io/exastro/exastro-it-automation-by-ansible-towermaster-sync:#__ITA_VERSION__#
   docker.io/exastro/exastro-it-automation-by-collector:#__ITA_VERSION__#
   docker.io/exastro/exastro-it-automation-by-conductor-synchronize:#__ITA_VERSION__#
   docker.io/exastro/exastro-it-automation-by-conductor-regularly:#__ITA_VERSION__#
   docker.io/exastro/exastro-it-automation-by-menu-create:#__ITA_VERSION__#
   docker.io/exastro/exastro-it-automation-by-menu-export-import:#__ITA_VERSION__#
   docker.io/exastro/exastro-it-automation-by-excel-export-import:#__ITA_VERSION__#
   docker.io/exastro/exastro-it-automation-by-terraform-cloud-ep-execute:#__ITA_VERSION__#
   docker.io/exastro/exastro-it-automation-by-terraform-cloud-ep-vars-listup:#__ITA_VERSION__#
   docker.io/exastro/exastro-it-automation-by-terraform-cli-execute:#__ITA_VERSION__#
   docker.io/exastro/exastro-it-automation-by-terraform-cli-vars-listup:#__ITA_VERSION__#
   docker.io/exastro/exastro-it-automation-by-hostgroup-split:#__ITA_VERSION__#
   docker.io/exastro/exastro-it-automation-by-cicd-for-iac:#__ITA_VERSION__#
   docker.io/exastro/exastro-it-automation-by-oase-conclusion:#__ITA_VERSION__#
   docker.io/exastro/exastro-it-automation-by-execinstance-dataautoclean:#__ITA_VERSION__#
   docker.io/exastro/exastro-it-automation-by-file-autoclean:#__ITA_VERSION__#
   docker.io/exastro/exastro-it-automation-migration:#__ITA_VERSION__#
   docker.io/exastro/exastro-it-automation-by-ansible-agent:#__ITA_VERSION__#


.. code-block:: shell
   :caption: コマンド

   touch save.sh
   vi save.sh

.. code-block:: shell
   :caption: 下記のコードをコピー＆ペーストする

   #!/bin/bash

   ITA_VERSION=$1
   declare -A PF_VERSION=(
     ["2.2.0"]="1.6.0"
     ["2.2.1"]="1.6.0"
     ["2.3.0"]="1.7.0"
     ["2.4.0"]="1.8.0"
     ["alpha.2499a9.20240328-232349"]="alpha.d718ac.20240325-152726"
     ["alpha.545f6a.20240403-232818"]="alpha.d718ac.20240325-152726"
     ["alpha.03f9ca.20240406-214252"]="alpha.d718ac.20240325-152726"
   )
   if [ ! -d $1 ]; then
     mkdir $ITA_VERSION
   fi
    
   readarray -t image_list < "./image.list"
   for image in ${image_list[@]}
   do
     image_fullname=$(echo ${image} | sed -e "s/#__ITA_VERSION__#/${ITA_VERSION}/" -e "s/#__PF_VERSION__#/${PF_VERSION[$ITA_VERSION]}/")
     image_name=$(basename ${image_fullname} | sed -e "s/:/-/")
     if [ ! -e ${ITA_VERSION}/${image_name}.tar.gz ]; then
       echo $image_fullname $image_name
       docker pull ${image_fullname}
       if [ $? -eq 0 ]; then
         docker save ${image_fullname} | gzip -c > ${ITA_VERSION}/${image_name}.tar.gz
       fi
     fi
   done
 

シェルスクリプトを実行する	
--------------------------

|	シェルスクリプトを実行しコンテナイメージをダウンロードします。	

.. code-block:: shell
   :caption: コマンド

   sh ./save.sh 2.4.0


RPMパッケージのダウンロード				
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

RPMパッケージをダウンロードする					
-------------------------------

|	パッケージをダウンロードします。		

.. tabs::

   .. group-tab:: docker
    
      | ダウンロード先ディレクトリを/tmp/docker-repo-almalinux、インストール先ディレクトリを/tmp/docker-installroot-almalinuxとしています。

      .. code-block:: shell
         :caption: コマンド

         sudo dnf install -y --downloadonly --downloaddir=/tmp/docker-repo-almalinux --installroot=/tmp/docker-installroot-almalinux --releasever=8.9 git			
           
      .. note::
         | 各オプションの説明		

         | =--downloadonly		
         | パッケージをインストールせずにダウンロードのみ行います。	
         | オフライン環境で使用するためのパッケージのダウンロードのみ行うため、インストールは不要です。	
            
         | --downloaddir=<ダウンロード先パス>		
         | パッケージをダウンロードするディレクトリを指定します。	
         | 通常のダウンロードと同様に、ローカルにあるパッケージと依存関係を解決しつつダウンロードされるため、	
         | 該当パッケージがすでにインストールされている場合は不足分のみダウンロードされます。	
            
         | --installroot=<ダウンロード先絶対パス>		
         | 通常とは別の場所へインストールするために利用します。	
         | インストール済みのパッケージも含めてすべてダウンロードするため	
         | ダミーディレクトリを指定し、すべての パッケージをダウンロードします。	
            
         | --releasever=<バージョン>		
         | ディストリビューションのバージョンを指定(8.9など)します。	


      | createrepoをインストールします。

      .. code-block:: shell
         :caption: コマンド

         sudo dnf install -y createrepo														
                      
                      
      | ローカルリポジトリを作成します。
      |	オフライン環境ではインターネット上のリポジトリサーバーを参照できないため、dnfによるパッケージのインストールができません。															
      |	ローカルリポジトリにパッケージを追加することで、dnfによるパッケージインストールが可能となります。			

      .. code-block:: shell
         :caption: コマンド

         sudo createrepo /tmp/docker-repo-almalinux														
                           
                      
      | RPMパッケージを受け渡し用のディレクトリに格納します。

      .. code-block:: shell
         :linenos:
         :caption: コマンド

         cd /tmp
         cp -irp /tmp/docker-repo-almalinux <受け渡し用ディレクトリ>
         #/mnt/mainte/exastro/almalinux/dockerを受け渡し用ディレクトリとする場合	
         cp -irp /tmp/docker-repo-almalinux /mnt/mainte/exastro/almalinux/docker														


   .. group-tab:: podman


      | ダウンロード先ディレクトリを/tmp/podman-repo、インストール先ディレクトリを/tmp/podman-installrootとしています。

      .. code-block:: shell
         :caption: コマンド
	
         sudo dnf install -y --downloadonly --downloaddir=/tmp/podman-repo --installroot=/tmp/podman-installroot --releasever=9.4 git
         sudo dnf install -y --downloadonly --downloaddir=/tmp/podman-repo --installroot=/tmp/podman-installroot --releasever=9.4 podman
         sudo dnf install -y --downloadonly --downloaddir=/tmp/podman-repo --installroot=/tmp/podman-installroot --releasever=9.4 podman-docker
  
      .. note::
         | 各オプションの説明		

         | =--downloadonly		
         | パッケージをインストールせずにダウンロードのみ行います。	
         | オフライン環境で使用するためのパッケージのダウンロードのみ行うため、インストールは不要です。	
            
         | --downloaddir=<ダウンロード先パス>		
         | パッケージをダウンロードするディレクトリを指定します。	
         | 通常のダウンロードと同様に、ローカルにあるパッケージと依存関係を解決しつつダウンロードされるため、	
         | 該当パッケージがすでにインストールされている場合は不足分のみダウンロードされます。	
            
         | --installroot=<ダウンロード先絶対パス>		
         | 通常とは別の場所へインストールするために利用します。	
         | インストール済みのパッケージも含めてすべてダウンロードするため	
         | ダミーディレクトリを指定し、すべての パッケージをダウンロードします。	
            
         | --releasever=<バージョン>		
         | ディストリビューションのバージョンを指定(9.4など)します。	


      | createrepoをインストールします。

      .. code-block:: shell
         :caption: コマンド

         sudo dnf install -y createrepo														
                      
                      
      | ローカルリポジトリを作成します。
      |	オフライン環境ではインターネット上のリポジトリサーバーを参照できないため、dnfによるパッケージのインストールができません。															
      |	ローカルリポジトリにパッケージを追加することで、dnfによるパッケージインストールが可能となります。			

      .. code-block:: shell
         :caption: コマンド

         sudo createrepo /tmp/podman-repo														
                           
                      
      | RPMパッケージを受け渡し用のディレクトリに格納します。

      .. code-block:: shell
         :linenos:
         :caption: コマンド

         cd /tmp
         cp -irp /tmp/podman-repo <受け渡し用ディレクトリ>
         #/mnt/mainte/exastro/rhel9/podmanを受け渡し用ディレクトリとする場合	
         cp -irp /tmp/podman-repo /mnt/mainte/exastro/rhel9/podman				

Exastroリソースのダウンロード																
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Exastroリソースをダウンロードする
---------------------------------

|	docker-compose版Exastroのリソースをダウンロードします。	

.. tabs::

   .. group-tab:: docker

      .. code-block:: shell
         :linenos:
         :caption: コマンド

         cd /tmp														
         curl -OL https://github.com/exastro-suite/exastro-docker-compose/archive/main.zip	
                    
                      
      | ダウンロードしたExastroリソースを受け渡し用ディレクトリに格納します。

      .. code-block:: shell
         :linenos:
         :caption: コマンド
         
         unzip main.zip && mv exastro-docker-compose-main exastro-docker-compose	
         #受け渡し用ディレクトリを/mnt/mainte/exastro/almalinux/dockerとする場合
         cp -irp /tmp/exastro-docker-compose  /mnt/mainte/exastro/almalinux/docker														


   .. group-tab:: podman

      .. code-block:: shell
         :linenos:
         :caption: コマンド

         cd /tmp														
         curl -OL https://github.com/exastro-suite/exastro-docker-compose/archive/main.zip	
                    
                      
      | ダウンロードしたExastroリソースを受け渡し用ディレクトリに格納します。

      .. code-block:: shell
         :linenos:
         :caption: コマンド
         
         unzip main.zip && mv exastro-docker-compose-main exastro-docker-compose	
         #受け渡し用ディレクトリを/mnt/mainte/exastro/rhel9/podmanとする場合
         cp -irp /tmp/exastro-docker-compose  /mnt/mainte/exastro/rhel9/podman		
															


オフライン環境(インターネットに接続できない環境)での作業
========================================================

| オンライン環境での作業完了後、オフライン環境にて下記の手順を実施します。														
															

マウントの設定
^^^^^^^^^^^^^^^^

設定ファイルを開く			
------------------

| 下記を順に実行し、資材受け渡し用のマウント設定を行います。					

.. code-block:: shell
   :linenos:
   :caption: コマンド			

   sudo su -												
   vi /etc/fstab												
              
              
マウント設定を記述する		
----------------------

| viエディタで開いた/etc/fstabに下記のマウント設定を追記します。

.. code-block:: shell
   :caption: 記載例

   /dev/sda1 /mnt/mainte nfs defaults 0 0				
              
              
設定を反映し、マウントを行う		
----------------------------

| 下記を順に実行し、設定を反映します。			

.. code-block:: shell
   :linenos:
   :caption: コマンド	

   mkdir /mnt/mainte 												
   systemctl daemon-reload												
   mount -a 												
   df												
   exit												
              
              
docker-compose-linux-x86_64の取得	
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

docker-compose-linux-x86_64を取得する						
-------------------------------------

| 事前に取得したdocker-compose-linux-x86_64を下記ディレクトリに格納し、パーミッションを変更します。							
| 格納先 /usr/local/bin/docker-compose					

.. code-block:: shell
   :caption: コマンド	

   sudo chmod a+x /usr/local/bin/docker-compose								
			

RPMパッケージのインストール			
^^^^^^^^^^^^^^^^^^^^^^^^^^^

RPMパッケージを取得する			
------------------------

.. tabs::

   .. group-tab:: docker

      .. code-block:: shell
         :linenos:
         :caption: コマンド	

         cd /tmp
         cp -irp /mnt/mainte/exastro/almalinux/docker/docker-repo-almalinux .


      | ローカルリポジトリの設定ファイルを作成します。								

      .. code-block:: shell
         :caption: コマンド		

         sudo touch /etc/yum.repos.d/docker-repo-almalinux.repo														
                      

      |	作成した設定ファイルに下記の情報を記載します。(※file: の後ろのスラッシュは3つ)				

      .. code-block:: shell
         :caption: コマンド

         sudo vi /etc/yum.repos.d/docker-repo-almalinux.repo														
                      
         [docker-repo-almalinux]														
         name=RedHat-$releaserver - docker														
         baseurl=file:///tmp/docker-repo-almalinux														
         enabled=1														
         gpgcheck=0														
         gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release														
                      
      | docker-repo-almalinuxのstatusがenabledになっていることを確認します。

      .. code-block:: shell
         :caption: コマンド			
                  
         dnf repolist all														
                                

      | パッケージをインストールします。										

      .. code-block:: shell
         :caption: コマンド

         sudo dnf -y --disablerepo=\* --enablerepo=docker-repo-almalinux install git
           

   .. group-tab:: podman

      .. code-block:: shell
         :linenos:
         :caption: コマンド	

         cd /tmp
         cp -irp /mnt/mainte/exastro/rhel9/podman/podman-repo .


      | ローカルリポジトリの設定ファイルを作成します。								

      .. code-block:: shell
         :caption: コマンド		

         sudo touch /etc/yum.repos.d/podman-repo.repo														
                      

      |	作成した設定ファイルに下記の情報を記載します。(※file: の後ろのスラッシュは3つ)				

      .. code-block:: shell
         :caption: コマンド

         sudo vi /etc/yum.repos.d/podman-repo.repo													
                      
         [podman-repo]														
         name=RedHat-$releaserver - podman														
         baseurl=file:///tmp/podman-repo													
         enabled=1														
         gpgcheck=0														
         gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release														
                      
      | podman-repoのstatusがenabledになっていることを確認します。

      .. code-block:: shell
         :caption: コマンド			
                  
         dnf repolist all														
                                

      | パッケージをインストールします。										

      .. code-block:: shell
         :caption: コマンド

         sudo dnf -y --disablerepo=\* --enablerepo=podman-repo install git
         sudo dnf -y --disablerepo=\* --enablerepo=podman-repo install podman
         sudo dnf -y --disablerepo=\* --enablerepo=podman-repo install podman-docker

           

      |	依存関係によるエラー(conflicting recuests)が起きた場合は、対象のパッケージを削除します。		

      .. code-block:: shell
         :caption: selinux-policyが原因の場合			

         sudo dnf remove -y selinux-policy			

      .. code-block:: shell
         :caption: エラーメッセージ参考例

         Error:	
         Problem: package podman-3:4.6.1-8.module+el8.9.0+21243+a586538b.x86_64 requires (container-selinux if selinux-policy), but none of the providers can be installed	
          - conflicting requests	
          - problem with installed package selinux-policy-3.14.3-67.el8.noarch	


      |	エラーの原因となった手順を再実行します。		

      .. code-block:: shell
         :linenos:
         :caption: コマンド		

         sudo dnf -y --disablerepo=\* --enablerepo=podman-repo install パッケージ名		
         #podmanをインストールする際に依存関係のエラーが起きた場合
         sudo dnf -y --disablerepo=\* --enablerepo=podman-repo install podman         


コンテナイメージの実行	
^^^^^^^^^^^^^^^^^^^^^^

シェルスクリプトを作成する						
--------------------------

| コンテナイメージを実行するシェルスクリプトを作成します。

.. code-block:: shell
   :linenos:
   :caption: コマンド		
   		
   cd /mnt/mainte/exastro/container-images
   touch load.sh
   vi load.sh

.. code-block:: shell
   :caption: 下記のコードをコピー＆ペースト

   ITA_VERSION=$1
   declare -A PF_VERSION=(
     ["2.2.0"]="1.6.0"
     ["2.2.1"]="1.6.0"
     ["2.3.0"]="1.7.0"
     ["2.4.0"]="1.8.0"
     ["alpha.2499a9.20240328-232349"]="alpha.d718ac.20240325-152726"
     ["alpha.03f9ca.20240406-214252"]="alpha.d718ac.20240325-152726"
   )
    
   readarray -t image_list < "./image.list"
   for image in ${image_list[@]}
   do
     image_fullname=$(echo ${image} | sed -e "s/#__ITA_VERSION__#/${ITA_VERSION}/" -e "s/#__PF_VERSION__#/${PF_VERSION[$ITA_VERSION]}/")
     image_name=$(basename ${image_fullname} | sed -e "s/:/-/")
     if [ -e ${ITA_VERSION}/${image_name}.tar.gz ]; then
       docker load < ${ITA_VERSION}/${image_name}.tar.gz &&
       docker tag ${image_fullname/docker.io/localhost} ${image_fullname} &&
       docker rmi ${image_fullname/docker.io/localhost} &
     fi
   done

   wait						

									
シェルスクリプトを実行する						
--------------------------

|	コンテナイメージを実行します。			

.. code-block:: shell
   :caption: コマンド		

   sh ./load.sh 2.4.0							


Exastroリソースのインストール		
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Exastroリソースを取得する		
-------------------------

| docker-compose版Exastroのリソースを、一般ユーザーのホームディレクトリ直下に格納します。				
| エラーが起きた際の対応については後述します。	

.. tabs::

   .. group-tab:: docker

      .. code-block:: shell
         :linenos:
         :caption: コマンド		

         #一般ユーザーのホームディレクトリを/home/testuser、受け渡し用ディレクトリを/mnt/mainte/exastro/almalinux/dockerとする場合
         cd  /home/testuser													
         cp -irp /mnt/mainte/exastro/almalinux/docker/exastro-docker-compose .																										
                      
                      	

      | Exastro ServiceのパッケージとExastro source fileのインストールを行います。				

      .. code-block:: shell
         :caption: コマンド

         cd ~/exastro-docker-compose && sh ./setup.sh install -i														
                      
      .. note::
         | 各オプションの説明	
                     
         | -i, --install-packages												
         | Only install required packages and fetch exastro source files												
                      
         | -e, --setup  													
         | Only generate environment file (.env)												
                      
         | -r, --regist-service 													
         | Only install exastro service												
                      
         | -c, --check 													
         |	Check if your system meets the system requirements												
                      
                      
      | 必要なパッケージなどのインストールが完了すると下記のように対話形式で設定値を投入することが可能です。

      .. code-block:: shell
         :caption: Exastro Serviceのセットアップ		

         cd ~/exastro-docker-compose && sh ./setup.sh install -e														

      .. code-block:: shell
         :caption: OASE コンテナデプロイ要否の確認

         Deploy OASE container ? (y/n) [default: y]:

      .. code-block:: shell
         :caption: Gitlab コンテナデプロイ要否の確認

         Deploy Gitlab containser? (y/n) [default: n]:         
                       
      .. code-block:: shell
         :caption: Exastro サービスのURL

         Input the Exastro service URL?	 [default: http://127.0.0.1:30080]: http://ita.example.com:30080

      .. code-block:: shell
         :caption:  Exastro 管理用サービスのURL

         Input the Exastro management URL?	 [default: http://127.0.0.1:30081]: http://ita.example.com:30081									

      .. code-block:: shell
         :caption: Gitlab コンテナのURL(Gitlab コンテナをデプロイする場合は入力が必要です。) 

         Input the external URL of Gitlab container  [default: (nothing)]: 

      .. code-block:: shell
         :caption: 設定ファイルの生成の確認

         System parametes are bellow.

         System administrator password:    ********
         Database password:                ********
         OASE deployment                   true
         MongoDB password                  ********
         Service URL:                      http://ita.example.com:30080
         Manegement URL:                   http://ita.example.com:30081
         Docker GID:                       985
         Docker Socket path:               /var/run/docker.sock
         GitLab deployment:                false
       
         Generate .env file with these settings? (y/n) [default: n]														
       
                      
      | セットアップ完了後、Exastro Serviceのインストールを実行します。		

      .. code-block:: shell
         :caption: コマンド
         
         cd ~/exastro-docker-compose && sh ./setup.sh install -r 														
                      
      | /var/run/docker.sockのパーミッションを変更します。

      .. code-block:: shell
         :caption: コマンド

         sudo chmod 666 /var/run/docker.sock
	
      | Exastro Serviceを起動します。
     
      .. code-block:: shell
         :caption: コマンド

         cd ~/exastro-docker-compose && docker-compose up -d 														

      | 詳細な設定を編集する場合は、:command:`n` もしくは :command:`no` と入力し、以降の処理をスキップします。
      | そのまま Exastro システムのコンテナ群を起動する場合は、:command:`y` もしくは :command:`yes` と入力します。
      | Exastro システムのデプロイには数分～数十分程度の時間が掛かります。(通信環境やサーバースペックによって状況は異なります。)
																			

   .. group-tab:: podman

      .. code-block:: shell
         :linenos:
         :caption: コマンド		

         #一般ユーザーのホームディレクトリを/home/testuser、受け渡し用ディレクトリを/mnt/mainte/exastro/rhel9/podmanとする場合
         cd  /home/testuser													
         cp -irp /mnt/mainte/exastro/rhel9/podman/exastro-docker-compose .																										
                      
      | SELinuxの動作モードを変更します。

      .. code-block:: shell
         :linenos:
         :caption: コマンド                     
                         
         sudo vi /etc/selinux/config

      .. code-block:: shell
         :caption: /etc/selinux/config記載例

         # This file controls the state of SELinux on the system.
         # SELINUX= can take one of these three values:
         #     enforcing - SELinux security policy is enforced.
         #     permissive - SELinux prints warnings instead of enforcing.
         #     disabled - No SELinux policy is loaded.
         # See also:
         # https://docs.fedoraproject.org/en-US/quick-docs/getting-started-with-selinux/#getting-started-with-selinux-selinux-states-and-modes
         #
         # NOTE: In earlier Fedora kernel builds, SELINUX=disabled would also
         # fully disable SELinux during boot. If you need a system with SELinux
         # fully disabled instead of SELinux running with no policy loaded, you
         # need to pass selinux=0 to the kernel command line. You can use grubby
         # to persistently set the bootloader to boot with selinux=0:
         #
         #    grubby --update-kernel ALL --args selinux=0
         #
         # To revert back to SELinux enabled:
         #
         #    grubby --update-kernel ALL --remove-args selinux
         #
         SELINUX=permissive
         # SELINUXTYPE= can take one of these three values:
         #     targeted - Targeted processes are protected,
         #     minimum - Modification of targeted policy. Only selected processes are protected.
         #     mls - Multi Level Security protection.
         SELINUXTYPE=targeted

      .. code-block:: shell
         :caption: コマンド

         sudo reboot			

      | 再度オフライン環境に接続し、SELinuxの動作モードがPermissiveになっていることを確認します。

      .. code-block:: shell
         :caption: コマンド

         getenforce


      | Exastro ServiceのパッケージとExastro source fileのインストールを行います。				

      .. code-block:: shell
         :caption: コマンド

         cd ~/exastro-docker-compose && sh ./setup.sh install -i														
                      
      .. note::
         | 各オプションの説明	
                     
         | -i, --install-packages												
         | Only install required packages and fetch exastro source files												
                      
         | -e, --setup  													
         | Only generate environment file (.env)												
                      
         | -r, --regist-service 													
         | Only install exastro service												
                      
         | -c, --check 													
         |	Check if your system meets the system requirements												
                      
                      
      | 必要なパッケージなどのインストールが完了すると下記のように対話形式で設定値を投入することが可能です。

      .. code-block:: shell
         :caption: Exastro Serviceのセットアップ		

         cd ~/exastro-docker-compose && sh ./setup.sh install 														

      .. code-block:: shell
         :caption: OASE コンテナデプロイ要否の確認

         Deploy OASE container URL? (y/n) [default: y]:
                       
      .. code-block:: shell
         :caption: Gitlab コンテナデプロイ要否の確認(Gitlab コンテナをデプロイする場合は入力が必要です。) 

         Deploy Gitlab containser? (y/n) [default: n]:                          
               
      .. code-block:: shell
         :caption: Exastro サービスのURL

         Input the Exastro service URL?	 [default: http://127.0.0.1:30080]: http://ita.example.com:30080

      .. code-block:: shell
         :caption:  Exastro 管理用サービスのURL

         Input the Exastro management URL?	 [default: http://127.0.0.1:30081]: http://ita.example.com:30081									

      .. code-block:: shell
         :caption: GitLab コンテナデプロイ要否の確認 

         Input the external URL of Gitlab container  [default: (nothing)]: 

      .. code-block:: shell
         :caption: 設定ファイルの生成の確認

         System parametes are bellow.

         System administrator password:    ********
         Database password:                ********
         OASE deployment                   true
         MongoDB password                  ********
         Service URL:                      http://ita.example.com:30080
         Manegement URL:                   http://ita.example.com:30081
         Docker GID:                       1000
         Docker Socket path:               /run/user/1000/podman/podman.sock
         GitLab deployment:                false
       
         Generate .env file with these settings? (y/n) [default: n]														
       
                      
      | セットアップ完了後、Exastro Serviceのインストールを実行します。		

      .. code-block:: shell
         :caption: コマンド
         
         cd ~/exastro-docker-compose && sh ./setup.sh install -r 														
                      
      | /var/run/docker.sockのパーミッションを変更します。

      .. code-block:: shell
         :caption: コマンド

         sudo chmod 666 /var/run/docker.sock                

      | Exastro Serviceを起動します。
     
      .. code-block:: shell
         :caption: コマンド

         cd ~/exastro-docker-compose && docker-compose up -d 														

      | 詳細な設定を編集する場合は、:command:`n` もしくは :command:`no` と入力し、以降の処理をスキップします。
      | そのまま Exastro システムのコンテナ群を起動する場合は、:command:`y` もしくは :command:`yes` と入力します。
      | Exastro システムのデプロイには数分～数十分程度の時間が掛かります。(通信環境やサーバースペックによって状況は異なります。) 


エラー対応
^^^^^^^^^^^

エラー対応
----------
			
| Exastroのインストール時にエラーが起きた際の対応についてです。	

.. tabs::

   .. group-tab:: docker

      | setup.sh実行時に発生する可能性のあるエラーと対処方法です。		
      | 下記エラーはインストール済みパッケージ(container-selinux)のバージョンが原因で発生したものです。																				
      | rpm -q パッケージ名 で対象パッケージのバージョンを確認し、オンライン環境とオフライン環境でそれぞれの手順を実行します。																				

      .. code-block:: shell					
         :caption: エラーメッセージ

         Error:																			
         Problem 1: cannot install the best candidate for the job																			
          - nothing provides container-selinux >= 2:2.74 needed by docker-ce-3:26.1.0-1.el8.x86_64 from docker-ce-stable																			
         Problem 2: cannot install the best candidate for the job																			
          - nothing provides container-selinux >= 2:2.74 needed by containerd.io-1.6.31-3.1.el8.x86_64 from docker-ce-stable																			
         (try to add '--skip-broken' to skip uninstallable packages or '--nobest' to use not only best candidate packages)																			
                            
                            
      .. code-block:: shell
         :linenos:
         :caption: オンライン環境での手順	                     
                         
         sudo dnf install -y --downloadonly --downloaddir=/tmp/docker-repo-almalinux --installroot=/tmp/docker-installroot-almalinux --releasever=8.9 container-selinux																				
         createrepo --update /tmp/docker-repo-almalinux																				
         cd /tmp
         cp -irp /tmp/docker-repo-almalinux /mnt/mainte/exastro/almalinux/docker																						
                        

      .. code-block:: shell					
         :linenos:	
         :caption: オフライン環境での手順		

         cd /tmp
         cp -irp /mnt/mainte/exastro/almalinux/docker/docker-repo-almalinux .																																																					
         sudo dnf -y --disablerepo=\* --enablerepo=docker-repo-almalinux install container-selinux	


   .. group-tab:: podman

      | Exastroインストール時に発生する可能性のあるエラーと対処方法です。		
      | 下記エラーはSELinuxの動作モードが原因で発生したものです。																				
      | オフライン環境にて下記手順を実行し、SELinuxの動作モードをPermissiveに変更します。	


      .. code-block:: shell					
         :caption: エラーメッセージ
																	
         [ERROR]: In Rootless Podman environment, SELinux only supports Permissive mode.
                            
      .. code-block:: shell
         :linenos:
         :caption: コマンド                     
                         
         sudo vi /etc/selinux/config

      .. code-block:: shell
         :caption: /etc/selinux/config記載例

         # This file controls the state of SELinux on the system.
         # SELINUX= can take one of these three values:
         #     enforcing - SELinux security policy is enforced.
         #     permissive - SELinux prints warnings instead of enforcing.
         #     disabled - No SELinux policy is loaded.
         # See also:
         # https://docs.fedoraproject.org/en-US/quick-docs/getting-started-with-selinux/#getting-started-with-selinux-selinux-states-and-modes
         #
         # NOTE: In earlier Fedora kernel builds, SELINUX=disabled would also
         # fully disable SELinux during boot. If you need a system with SELinux
         # fully disabled instead of SELinux running with no policy loaded, you
         # need to pass selinux=0 to the kernel command line. You can use grubby
         # to persistently set the bootloader to boot with selinux=0:
         #
         #    grubby --update-kernel ALL --args selinux=0
         #
         # To revert back to SELinux enabled:
         #
         #    grubby --update-kernel ALL --remove-args selinux
         #
         SELINUX=permissive
         # SELINUXTYPE= can take one of these three values:
         #     targeted - Targeted processes are protected,
         #     minimum - Modification of targeted policy. Only selected processes are protected.
         #     mls - Multi Level Security protection.
         SELINUXTYPE=targeted

      .. code-block:: shell
         :caption: コマンド

         sudo reboot			

      | 再度オフライン環境に接続します。
      | SELinuxの動作モードがPermissiveになっていることを確認し、エラーとなった手順を再度実行します。

      .. code-block:: shell
         :caption: コマンド

         getenforce


ログイン
========

| ログインに使用するユーザ名とパスワードの確認方法です。

.. code-block:: shell					
   :linenos:	
   :caption: コマンド

   cd ~/exastro-docker-compose
   cat .env


.. code-block:: shell
   :linenos:
   :caption: ログイン情報

   ### Initial account information for creating system administrators
   #### Specify the username and password
   # SYSTEM_ADMIN=<ユーザー名>
   SYSTEM_ADMIN_PASSWORD=<パスワード> 


オーガナイゼーションの作成
==========================

| 再起動後に再度ログインをしたら、オーガナイゼーションの作成を行います。
| オーガナイゼーションの詳細については、 :doc:`../manuals/platform_management/organization` を参照してください。


ワークスペースの作成
====================

| 作成したオーガナイゼーションにログインをしたら、ワークスペースを作成する必要があります。
| ワークスペースの作成については、:doc:`../manuals/organization_management/workspace` を参照してください。