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

| インターネットに接続できる環境で必要な資材を収集し、記憶媒体等でオフライン環境に持ち込んだ後 インストールを行います。
| 資材を収集する環境とインストールする環境で構築状態(OSのバージョン および インストール済のパッケージ)を一致させる必要があります。

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

| コンテナイメージの取得 及び 実行にはシェルスクリプトを使用します。

| Exastro の起動にはdocker-composeを使用するため、docker-compose-linux-x86_64を事前に準備しておく必要があります。

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
オンライン環境での作業完了後に、オフライン環境にてインストールを実施します。
											
													
▼オンライン環境での手順													
													
1. マウントの設定													
	1-1 設定ファイルを開く												
	1-2 マウント設定を記述する												
	1-3 設定を反映し、マウントを行う												
	1-4 マウント先へのアクセスを確認する												
													
2.コンテナイメージのダウンロード													
	2-1 格納先ディレクトリに移動する												
	2-2 シェルスクリプトを実行する												
													
3.RPMパッケージのダウンロード													
	3-1 RPMパッケージをダウンロードする												
	3-2 createrepoをインストールする												
	3-3 ローカルリポジトリを作成する												
	3-4 ダウンロードしたパッケージを圧縮する												
	3-5 ダウンロードしたRMPパッケージを格納する												
													
4.Exastroリソースのダウンロード													
	4-1 Exastroリソースをダウンロードする												
	4-2 ダウンロードしたExastroリソースを格納する												



▼オフライン環境での手順							
							
1.マウントの設定							
	1-1 設定ファイルを開く						
	1-2 マウント設定を記述する						
	1-3 設定を反映し、マウントを行う						
	1-4 マウント先へのアクセスを確認する						
							
2.docker-compose-linux-x86_64の取得							
	2-1 docker-compose-linux-x86_64を取得する						
							
3.RPMパッケージのダウンロード							
	3-1 RPMパッケージを取得する						
	3-2 リポジトリファイルを作成する						
	3-3 リポジトリ情報を記載する						
	3-4 パッケージをインストールする						
	3-5 エラー対応						
		3-5-1 エラーとなったパッケージを削除する					
		3-5-2 パッケージを再インストールする					
							
4.コンテナイメージのダウンロード							
	4-1 格納先ディレクトリに移動する						
	4-2 シェルスクリプトを実行する						
							
5.Exastroリソースのダウンロード							
	5-1 Exastroリソースを取得する						
	5-2 Exastroリソースをインストールする						
	5-3 Exastroを起動する						




オンライン環境(インターネットに接続できる環境)での作業
======================================================

| まずは資源の収集を行います。
| 以下、ユーザーはalmalinux、ホームディレクトリは/home/almalinuxで実行した例です。
| また、資材の受け渡しはNFSにマウントする方法を用いています。


1. マウントの設定				
1-1 設定ファイルを開く				
	下記コマンドを順に実行し、資材受け渡し用のマウント設定を行います。			
		sudo su -		
		vi /etc/fstab		


1-2 マウント設定を記述する		
	viエディタで開いた/etc/fstabに下記のマウント設定を追記します。	
		マウントするデバイス名 マウントポイント ファイルシステムの種類 オプション dump設定 fsckチェック設定

1-3 設定を反映し、マウントを行う		
	下記コマンドを順に実行し、設定を反映させます。	
		mkdir /mnt/mainte 
		systemctl daemon-reload
		mount -a 
		df
		exit

  1-4 マウント先へのアクセスを確認する
  今回は下記ディレクトリを作成したうえで、作業を行うこととします。
  cd /mnt/mainte/exastro/container-images



2.コンテナイメージのダウンロード		
2-1 格納先ディレクトリに移動する		
		手順1-4で移動済みの場合は実施不要です。

2-2 シェルスクリプトを実行する		
	下記コマンドを実行しコンテナイメージをダウンロードします。	
		sh ./save.sh 2.3.0



3.RPMパッケージのダウンロード					
3-1 RPMパッケージをダウンロードする					
	下記コマンドを実行し、パッケージをダウンロードします。				
		sudo dnf install -y --downloadonly --downloaddir=/tmp/docker-repo-almalinux --installroot=/tmp/docker-installroot-almalinux --releasever=8.9 git			
					
			各オプションの説明		
			=--downloadonly		
				パッケージをインストールせずにダウンロードのみ行います。	
				オフライン環境で使用するためのパッケージのダウンロードのみ行うため、インストールは不要です。	
					
			--downloaddir=<ダウンロード先パス>		
				パッケージをダウンロードするディレクトリを指定します。	
				通常のダウンロードと同様に、ローカルにあるパッケージと依存関係を解決しつつダウンロードされるため、	
				該当パッケージがすでにインストールされている場合は不足分のみダウンロードされます。	
					
			--installroot=<ダウンロード先絶対パス>		
				通常とは別の場所へインストールするために利用します。	
				インストール済みのパッケージも含めてすべてダウンロードするため	
				ダミーディレクトリを指定し、すべての パッケージをダウンロードします。	
					
			--releasever=<バージョン>		
				ディストリビューションのバージョンを指定(9.2など)します。	


3-2 createrepoをインストールする																
		sudo dnf install -y createrepo														
																
																
3-3 ローカルリポジトリを作成する																
	オフライン環境ではインターネット上のリポジトリサーバーを参照できないため、dnfによるパッケージのインストールができません。															
	ローカルリポジトリにパッケージを追加することで、dnfによるパッケージインストールが可能となります。															
		sudo createrepo /tmp/docker-repo-almalinux														
																

3-4 ダウンロードしたパッケージを圧縮する																
		cd /tmp														
		tar zcvf podman-repo.tar.gz docker-repo-almalinux														
																
																
3-5 圧縮したRPMパッケージを格納する																
		cp -ip /tmp/docker-repo-almalinux.tar.gz /mnt/mainte/exastro/almalinux/docker														
																

4.Exastroリソースのダウンロード																
4-1 Exastroリソースをダウンロードする																
	下記コマンドを実行し、docker-compose版Exastroのリソースをダウンロードします。															
		cd /tmp														
		curl -OL https://github.com/exastro-suite/exastro-docker-compose/archive/main.zip														
																
4-2 ダウンロードしたExastroリソースを格納する																
	今回は「  /mnt/mainte/exastro/almalinux/docker 」に格納します。															
		cp -ip /tmp/main.zip  /mnt/mainte/exastro/almalinux/docker														




															
オフライン環境(インターネットに接続できない環境)での作業
======================================================
	オンライン環境での作業完了後、オフライン環境にて下記の手順を実施します。														
															

	1. マウントの設定														
	1-1 設定ファイルを開く														
		下記コマンドを順に実行し、資材受け渡し用のマウント設定を行います。													
			sudo su -												
			vi /etc/fstab												
															
															
	1-2 マウント設定を記述する														
		viエディタで開いた/etc/fstabに下記のマウント設定を追記します。													
		マウントするデバイス名 マウントポイント ファイルシステムの種類 オプション dump設定 fsckチェック設定								
															
															
	1-3 設定を反映し、マウントを行う														
		下記コマンドを順に実行し、設定を反映させます。													
			mkdir /mnt/mainte 												
			systemctl daemon-reload												
			mount -a 												
			df												
			exit												
															
															
	1-4 マウント先へのアクセスを確認する														
			cd /mnt/mainte/exastro/container-images												


2.docker-compose-linux-x86_64の取得								
2-1 docker-compose-linux-x86_64を取得する						
	事前に取得したdocker-compose-linux-x86_64を下記ディレクトリに格納し、パーミッションを変更します。							
		格納先 /usr/local/bin/docker-compose					
		sudo chmod a+x /usr/local/bin/docker-compose						
		sudo shutdown -r now						
		再度オフライン環境に接続						


3.RPMパッケージのダウンロード																
3-1 RPMパッケージを取得する																
	podman-repoのローカルリポジトリを/tmp配下に配置し、解凍します。															
		cd /tmp														
		cp -ip /mnt/mainte/exastro/almalinux/docker/docker-repo-almalinux.tar.gz .														
		tar zxvf docker-repo-almalinux.tar.gz														
																

3-2 リポジトリファイルを作成する																
		sudo touch /etc/yum.repos.d/docker-repo-almalinux.repo														
																
																
3-3 リポジトリ情報を記載する																
	作成したリポジトリファイルに下記の情報を記載します。(※file: の後ろのスラッシュは3つ)															
		sudo vi /etc/yum.repos.d/docker-repo-almalinux.repo														
																
		[docker-repo-almalinux]														
		name=RedHat-$releaserver - podman														
		baseurl=file:///tmp/docker-repo-almalinux														
		enabled=1														
		gpgcheck=0														
		gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release														
																
	リポジトリの有効化を実施し、docker-repoのstatusがenabledになっていることを確認します。(手順3-4をスムーズに行うために実施しています。)															
		sudo dnf config-manager --set-enabled docker-repo-almalinux														
		dnf repolist all														
																
																
3-4 パッケージをインストールする																
		下記コマンドにてパッケージをインストールします。														
		sudo dnf -y --disablerepo=\* --enablerepo=docker-repo-almalinux install git

																

3-5 エラー対応				
3-5-1 エラーとなったパッケージを削除する				
	依存関係によるエラー(conflicting recuests)が起きた場合は、対象のパッケージを削除します。			
	sudo dnf remove -y selinux-policy			

エラーメッセージ参考例
 Error:	
 Problem: package podman-3:4.6.1-8.module+el8.9.0+21243+a586538b.x86_64 requires (container-selinux if selinux-policy), but none of the providers can be installed	
  - conflicting requests	
  - problem with installed package selinux-policy-3.14.3-67.el8.noarch	


 3-5-2 パッケージを再インストールする				
	エラーの原因となった手順(3-4)を再実行します。			
		sudo dnf -y --disablerepo=\* --enablerepo=docker-repo-almalinux install パッケージ名		



4.コンテナイメージのダウンロード									
4-1 格納先ディレクトリに移動する									
		cd /mnt/mainte/exastro/container-images							
									
									
4-2 シェルスクリプトを実行する									
	下記コマンドを実行しコンテナイメージを実行します。								
		sh ./load.sh 2.3.0							


5.Exastroリソースのダウンロード																
5-1 Exastroリソースを取得する																
	docker-compose版Exastroのリソースを、一般ユーザーのホームディレクトリ直下に展開します。															
		cd  /home/＜一般ユーザー名＞														
		cp -ip /mnt/mainte/exastro/almalinux/docker/main.zip .														
		unzip main.zip && mv exastro-docker-compose-main exastro-docker-compose														
																
																
5-2 Exastroリソースをインストールする																
	解凍したディレクトリに移動し、パッケージとExastro source fileのインストールを行います。															
		cd ~/exastro-docker-compose && sh ./setup.sh install -i														
																
			各オプションの説明													
			-i, --install-packages													
				Only install required packages and fetch exastro source files												
																
			-e, --setup  													
				Only generate environment file (.env)												
																
			-r, --regist-service 													
				Only install exastro service												
																
			-c, --check 													
				Check if your system meets the system requirements												
																
																
| 必要なパッケージなどのインストールが完了すると下記のように対話形式で設定値を投入することが可能です。
														
		cd ~/exastro-docker-compose && sh ./setup.sh install -e														
																
		Rgenerate .env file? (y/n) [default: n]												
			→.envについての確認です。yを入力します。				

		Deploy OASE contaners? (y/n) [default: y]														
			→OASE コンテナデプロイ要否の確認です。yを入力します。

		Deploy Gitlab containser URL?   (y/n) [default: n]										
			→GitLab コンテナデプロイ要否の確認です。yを入力します。													
			 													
		Input the Exastro service URL?											
			→ExastroサービスのURLを入力します。ポートの30080は固定です。													
			例) http://192.168.181.xx:30080					

		Input the Exastro management URL?													
			→Exastro管理用サービスのURLを入力します。ポートの30081は固定です。													
			例) http://192.168.181.xx:30080													

		Input the external URL of Gitlab container  [default: (nothing)]											
			→GitlabコンテナのURLを入力します。指定がない場合は空欄のままEnterを押下します。

		
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
			→入力した内容で.envを作成してよいかの確認です。入力内容に間違いがない場合はyを入力します。			
																
                
	セットアップ完了後、、Exastro Serviceのインストールを実行します。															
		cd ~/exastro-docker-compose && sh ./setup.sh install -r 														
																
										
5-3 Exastroを起動する																
		cd ~/exastro-docker-compose && docker-compose up -d 														

| Exastro システムのデプロイには数分～数十分程度の時間が掛かります。(通信環境やサーバースペックによって状況は異なります。)

											
エラー対応
==========
発生する可能性のあるエラーと対処方法は下記の通りです。																				
																						
																						
	■オフライン環境 手順5-2 Exastroリソースをインストールする																					
		インストール済みパッケージ(container-selinux)のバージョンが原因で発生したもの。																				
		「rpm -q パッケージ名」で対象パッケージのバージョンを確認し、下記の手順を実行する。																				
																						
			Error:																			
			 Problem 1: cannot install the best candidate for the job																			
			  - nothing provides container-selinux >= 2:2.74 needed by docker-ce-3:26.1.0-1.el8.x86_64 from docker-ce-stable																			
			 Problem 2: cannot install the best candidate for the job																			
			  - nothing provides container-selinux >= 2:2.74 needed by containerd.io-1.6.31-3.1.el8.x86_64 from docker-ce-stable																			
			(try to add '--skip-broken' to skip uninstallable packages or '--nobest' to use not only best candidate packages)																			
																						
																						
		オンライン環境での手順																				
		sudo dnf install -y --downloadonly --downloaddir=/tmp/docker-repo-almalinux --installroot=/tmp/docker-installroot-almalinux --releasever=8.9 container-selinux																				
		createrepo --update /tmp/docker-repo-almalinux																				
		cd /tmp																				
		tar zcvf podman-repo.tar.gz docker-repo-almalinux																				
																						
		オフライン環境での手順																				
		cd /tmp																				
		cp -ip /mnt/mainte/exastro/almalinux/docker/docker-repo-almalinux.tar.gz .																				
		tar zxvf docker-repo-almalinux.tar.gz																				
		sudo dnf -y --disablerepo=\* --enablerepo=docker-repo-almalinux install container-selinux																				
		手順5-2を実行																				


