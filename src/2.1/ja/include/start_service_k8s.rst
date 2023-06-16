
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
     ita-api-admin-7c78cc475-xt8kh                             1/1     Running     0             47m
     ita-api-organization-f4bccc5c4-8txpj                      1/1     Running     0             47m
     ita-by-ansible-execute-666d5bdf86-bt94w                   1/1     Running     0             47m
     ita-by-ansible-legacy-role-vars-listup-79c5cfdf7c-wntg5   1/1     Running     0             47m
     ita-by-ansible-legacy-vars-listup-7b7f5fb88c-nqzrd        1/1     Running     0             47m
     ita-by-ansible-pioneer-vars-listup-5d5f5b589-d4hn9        1/1     Running     0             47m
     ita-by-ansible-towermaster-sync-548bd8c867-2vp9z          1/1     Running     0             47m
     ita-by-cicd-for-iac-558986b4c5-fk7bh                      1/1     Running     0             47m
     ita-by-collector-59ff796d8c-xc4dx                         1/1     Running     0             47m
     ita-by-conductor-regularly-b5c5dd6dc-7t8km                1/1     Running     0             47m
     ita-by-conductor-synchronize-787f9fd8f7-mxsw6             1/1     Running     0             47m
     ita-by-excel-export-import-66db589589-xv5zz               1/1     Running     0             47m
     ita-by-hostgroup-split-8459fb48fc-ltrtb                   1/1     Running     0             47m
     ita-by-menu-create-5bc6849cd5-xkm6r                       1/1     Running     0             47m
     ita-by-menu-export-import-84ccc5467-9fnb8                 1/1     Running     0             47m
     ita-by-terraform-cli-execute-695ffbd4c-pqkwj              1/1     Running     0             47m
     ita-by-terraform-cli-vars-listup-6dcccf9585-nxbkj         1/1     Running     0             47m
     ita-by-terraform-cloud-ep-execute-7bbfcd6f6c-fkqpd        1/1     Running     0             47m
     ita-by-terraform-cloud-ep-vars-listup-5d4c7c94ff-7gmsk    1/1     Running     0             47m
     ita-migration-1.0.5-iql5                                  0/1     Completed   0             47m
     ita-web-server-75f8c85f7c-vvkp5                           1/1     Running     0             47m
     keycloak-9d464565b-zwq6b                                  1/1     Running     0             47m
     platform-api-57bff76cc-fmdcn                              1/1     Running     0             47m
     platform-auth-54c7f8bcc8-lmgv6                            1/1     Running     0             47m
     platform-migration-1.4.3-gs4x                             0/1     Completed   0             47m
     platform-web-7d74bb98d-srtdp                              1/1     Running     0             47m
