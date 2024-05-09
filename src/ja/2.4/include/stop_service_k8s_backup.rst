
1. Pod 起動数の確認

   | 作業前の Pod 起動数の確認をし、状態を記録します。

   .. code-block:: bash
     :caption: コマンド

     RS_AE=`kubectl get deploy ita-by-ansible-execute -o jsonpath='{@.spec.replicas}{"\n"}' --namespace exastro`
     RS_ALRV=`kubectl get deploy ita-by-ansible-legacy-role-vars-listup -o jsonpath='{@.spec.replicas}{"\n"}' --namespace exastro`
     RS_ATS=`kubectl get deploy ita-by-ansible-towermaster-sync -o jsonpath='{@.spec.replicas}{"\n"}' --namespace exastro`
     RS_CS=`kubectl get deploy ita-by-conductor-synchronize -o jsonpath='{@.spec.replicas}{"\n"}' --namespace exastro`
     RS_MC=`kubectl get deploy ita-by-menu-create -o jsonpath='{@.spec.replicas}{"\n"}' --namespace exastro`
     RS_PA=`kubectl get deploy platform-auth -o jsonpath='{@.spec.replicas}{"\n"}' --namespace exastro`

   | 以下はITA2.1.0以降の場合に実行してください。

   .. code-block:: bash

     RS_ALV=`kubectl get deploy ita-by-ansible-legacy-vars-listup -o jsonpath='{@.spec.replicas}{"\n"}' --namespace exastro`
     RS_APV=`kubectl get deploy ita-by-ansible-pioneer-vars-listup -o jsonpath='{@.spec.replicas}{"\n"}' --namespace exastro`
     RS_CFI=`kubectl get deploy ita-by-cicd-for-iac -o jsonpath='{@.spec.replicas}{"\n"}' --namespace exastro`
     RS_CR=`kubectl get deploy ita-by-conductor-regularly -o jsonpath='{@.spec.replicas}{"\n"}' --namespace exastro`
     RS_COL=`kubectl get deploy ita-by-collector -o jsonpath='{@.spec.replicas}{"\n"}' --namespace exastro`
     RS_EEI=`kubectl get deploy ita-by-excel-export-import -o jsonpath='{@.spec.replicas}{"\n"}' --namespace exastro`
     RS_HS=`kubectl get deploy ita-by-hostgroup-split -o jsonpath='{@.spec.replicas}{"\n"}' --namespace exastro`
     RS_MEI=`kubectl get deploy ita-by-menu-export-import -o jsonpath='{@.spec.replicas}{"\n"}' --namespace exastro`
     RS_TCE=`kubectl get deploy ita-by-terraform-cli-execute -o jsonpath='{@.spec.replicas}{"\n"}' --namespace exastro`
     RS_TCV=`kubectl get deploy ita-by-terraform-cli-vars-listup -o jsonpath='{@.spec.replicas}{"\n"}' --namespace exastro`
     RS_TCEE=`kubectl get deploy ita-by-terraform-cloud-ep-execute -o jsonpath='{@.spec.replicas}{"\n"}' --namespace exastro`
     RS_TCEV=`kubectl get deploy ita-by-terraform-cloud-ep-vars-listup -o jsonpath='{@.spec.replicas}{"\n"}' --namespace exastro`
 
   | 以下はITA2.3.0以降の場合に実行してください。

   .. code-block:: bash 

     RS_OC=`kubectl get deploy ita-by-oase-conclusion -o jsonpath='{@.spec.replicas}{"\n"}' --namespace exastro`

2. リバースプロキシの停止

   | リバースプロキシ (platform-auth) の Pod 起動数を 0 に変更し、エンドユーザーからのアクセスを制限します。

   .. code-block:: bash
     :caption: コマンド

     kubectl scale deployment platform-auth --namespace exastro --replicas=0

3. バックヤード処理の停止

   | バックヤード処理 (ita-by-\*\*\*) の Pod 起動数を 0 に変更し、データベースの更新を停止します。

   .. code-block:: bash
     :caption: コマンド

     kubectl scale deployment ita-by-ansible-execute --namespace exastro --replicas=0
     kubectl scale deployment ita-by-ansible-legacy-role-vars-listup --namespace exastro --replicas=0
     kubectl scale deployment ita-by-ansible-towermaster-sync --namespace exastro --replicas=0
     kubectl scale deployment ita-by-conductor-synchronize --namespace exastro --replicas=0
     kubectl scale deployment ita-by-menu-create --namespace exastro --replicas=0

   | 以下はITA2.1.0以降の場合に実行してください。

   .. code-block:: bash

     kubectl scale deployment ita-by-ansible-legacy-vars-listup --namespace exastro --replicas=0
     kubectl scale deployment ita-by-ansible-pioneer-vars-listup --namespace exastro --replicas=0
     kubectl scale deployment ita-by-cicd-for-iac --namespace exastro --replicas=0
     kubectl scale deployment ita-by-collector --namespace exastro --replicas=0
     kubectl scale deployment ita-by-conductor-regularly --namespace exastro --replicas=0
     kubectl scale deployment ita-by-excel-export-import --namespace exastro --replicas=0
     kubectl scale deployment ita-by-hostgroup-split --namespace exastro --replicas=0
     kubectl scale deployment ita-by-menu-export-import --namespace exastro --replicas=0
     kubectl scale deployment ita-by-terraform-cli-execute --namespace exastro --replicas=0
     kubectl scale deployment ita-by-terraform-cli-vars-listup --namespace exastro --replicas=0
     kubectl scale deployment ita-by-terraform-cloud-ep-execute --namespace exastro --replicas=0
     kubectl scale deployment ita-by-terraform-cloud-ep-vars-listup --namespace exastro --replicas=0

   | 以下はITA2.3.0以降の場合に実行してください。

   .. code-block:: bash 

     kubectl scale deployment ita-by-oase-conclusion --namespace exastro --replicas=0

4. Pod 起動数の確認

   | 上記で停止した対象の Pod 数が 0 になっていることを確認

   .. code-block:: bash
     :caption: コマンド

     kubectl get deployment --namespace exastro

   .. code-block:: bash
     :caption: 実行結果

     NAME                                     READY   UP-TO-DATE   AVAILABLE   AGE
     mariadb                                  1/1     1            1           3h41m
     ita-web-server                           1/1     1            1           3h41m
     platform-web                             1/1     1            1           3h41m
     ita-api-admin                            1/1     1            1           3h41m
     ita-api-organization                     1/1     1            1           3h41m
     platform-api                             1/1     1            1           3h41m
     keycloak                                 1/1     1            1           3h41m
     ita-by-menu-create                       0/0     0            0           3h41m
     ita-by-ansible-execute                   0/0     0            0           3h41m
     ita-by-ansible-legacy-role-vars-listup   0/0     0            0           3h41m
     ita-by-ansible-towermaster-sync          0/0     0            0           3h41m
     ita-by-conductor-synchronize             0/0     0            0           3h41m
     platform-auth                            0/0     0            0           3h41m

   | 以下はITA2.1.0以降の場合に確認してください。

   .. code-block:: bash

     NAME                                     READY   UP-TO-DATE   AVAILABLE   AGE
     ita-by-ansible-legacy-vars-listup        0/0     0            0           3h41m
     ita-by-ansible-pioneer-vars-listup       0/0     0            0           3h41m
     ita-by-cicd-for-iac                      0/0     0            0           3h41m
     ita-by-collector                         0/0     0            0           3h41m
     ita-by-conductor-regularly               0/0     0            0           3h41m
     ita-by-excel-export-import               0/0     0            0           3h41m
     ita-by-hostgroup-split                   0/0     0            0           3h41m
     ita-by-menu-export-import                0/0     0            0           3h41m
     ita-by-terraform-cli-execute             0/0     0            0           3h41m
     ita-by-terraform-cli-vars-listup         0/0     0            0           3h41m
     ita-by-terraform-cloud-ep-execute        0/0     0            0           3h41m
     ita-by-terraform-cloud-ep-vars-listup    0/0     0            0           3h41m

   | 以下はITA2.3.0以降の場合に確認してください。

   .. code-block:: bash

     NAME                                     READY   UP-TO-DATE   AVAILABLE   AGE
     ita-api-oase-receiver                    1/1     1            1           3h41m
     ita-by-oase-conclusion                   0/0     0            0           3h41m
