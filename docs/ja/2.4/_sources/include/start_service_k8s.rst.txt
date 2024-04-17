
1. サービス再開

   | サービス停止時に取得した各 Deployment の Pod 起動数を元に戻します。

   .. code-block::
     :caption: コマンド

     kubectl scale deployment ita-by-ansible-execute -n exastro --replicas=${RS_AE}
     kubectl scale deployment ita-by-ansible-legacy-role-vars-listup -n exastro --replicas=${RS_ALRV}
     kubectl scale deployment ita-by-ansible-towermaster-sync -n exastro --replicas=${RS_ATS}
     kubectl scale deployment ita-by-conductor-synchronize -n exastro --replicas=${RS_CS}
     kubectl scale deployment ita-by-menu-create -n exastro --replicas=${RS_MC}
     kubectl scale deployment platform-auth -n exastro --replicas=${RS_PA}

   | 以下はITA2.1.0以降からITA2.1.1以降にバージョンアップする際に実行してください。

   .. code-block::

     kubectl scale deployment ita-by-ansible-legacy-vars-listup -n exastro --replicas=${RS_ALV}
     kubectl scale deployment ita-by-ansible-pioneer-vars-listup -n exastro --replicas=${RS_APV}
     kubectl scale deployment ita-by-cicd-for-iac -n exastro --replicas=${RS_CFI}
     kubectl scale deployment ita-by-conductor-regularly -n exastro --replicas=${RS_CR}
     kubectl scale deployment ita-by-collector -n exastro --replicas=${RS_COL}
     kubectl scale deployment ita-by-excel-export-import -n exastro --replicas=${RS_EEI}
     kubectl scale deployment ita-by-hostgroup-split -n exastro --replicas=${RS_HS}
     kubectl scale deployment ita-by-menu-export-import -n exastro --replicas=${RS_MEI}
     kubectl scale deployment ita-by-terraform-cli-execute -n exastro --replicas=${RS_TCE}
     kubectl scale deployment ita-by-terraform-cli-vars-listup -n exastro --replicas=${RS_TCV}
     kubectl scale deployment ita-by-terraform-cloud-ep-execute -n exastro --replicas=${RS_TCEE}
     kubectl scale deployment ita-by-terraform-cloud-ep-vars-listup -n exastro --replicas=${RS_TCEV}

2. Pod 起動数の確認

   | 上記で起動した対象の Pod 数が元に戻りすべて :kbd:`READY` になっていることを確認

   .. code-block:: bash
     :caption: コマンド

     kubectl get deployment -n exastro

   .. code-block:: bash
     :caption: 実行結果

     NAME                                     READY   UP-TO-DATE   AVAILABLE   AGE
     ita-api-admin                            1/1     1            1           7h46m
     ita-api-oase-receiver                    1/1     1            1           7h46m
     ita-api-organization                     1/1     1            1           7h46m
     ita-by-ansible-execute                   1/1     1            1           7h46m
     ita-by-ansible-legacy-role-vars-listup   1/1     1            1           7h46m
     ita-by-ansible-legacy-vars-listup        1/1     1            1           7h46m
     ita-by-ansible-pioneer-vars-listup       1/1     1            1           7h46m
     ita-by-ansible-towermaster-sync          1/1     1            1           7h46m
     ita-by-cicd-for-iac                      1/1     1            1           7h46m
     ita-by-collector                         1/1     1            1           7h46m
     ita-by-conductor-regularly               1/1     1            1           7h46m
     ita-by-conductor-synchronize             1/1     1            1           7h46m
     ita-by-excel-export-import               1/1     1            1           7h46m
     ita-by-hostgroup-split                   1/1     1            1           7h46m
     ita-by-menu-create                       1/1     1            1           7h46m
     ita-by-menu-export-import                1/1     1            1           7h46m
     ita-by-oase-conclusion                   1/1     1            1           7h46m
     ita-by-terraform-cli-execute             1/1     1            1           7h46m
     ita-by-terraform-cli-vars-listup         1/1     1            1           7h46m
     ita-by-terraform-cloud-ep-execute        1/1     1            1           7h46m
     ita-by-terraform-cloud-ep-vars-listup    1/1     1            1           7h46m
     ita-web-server                           1/1     1            1           7h46m
     mariadb                                  1/1     1            1           7h46m
     platform-api                             1/1     1            1           7h46m
     platform-auth                            1/1     1            1           7h46m
     platform-job                             1/1     1            1           7h46m
     platform-web                             1/1     1            1           7h46m
