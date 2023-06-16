| コマンドラインから以下のコマンドを入力して、インストールが完了していることを確認します。

.. code-block:: bash
    :caption: コマンド
    
    # Pod の一覧を取得
    kubectl get po -n exastro
    
    | 正常動作している場合は、すべて “Running” もしくは “Completed” となります。
    | ※正常に起動するまで数分かかる場合があります。


.. code-block:: bash
    :caption: 出力結果
    
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
