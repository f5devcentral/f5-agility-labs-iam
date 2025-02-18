Lab 1: Deploy PUA with Client Certificate Authentication
===============================================================

Solution Design
---------------------------------------------------------------

|image_pua_sol_design|

#. The User logs into the APM Virtual Server using their Smartcard or with another credential method 

#. The APM policy checks the provided credentials against AD, OCSP, CRL and retrieves their AD/LDAP group membership information 

#. An APM iRule event generates the ephemeral password, and inserts the username and password hash into the ephemeral auth table 

#. When the user selects a resource the APM Policy makes a connection to the WebSSH Virtual Sever and inserts the Ephemeral Auth credentials using the APM SSO profile 

#. The WebSSH Virtual Server, using the WebSSH ILX app, makes an SSH connection to the Router/Server with Ephemeral Auth credentials 

#. Upon receiving the login information, the Router/Server will make an authentication request to the remote login resource (RADIUS/LDAP)

  * RADIUS Auth Requests are sent to the BIG-IP RADIUS Virtual Server (ILX RADIUS server) 
  * LDAP(S) Auth Requests are sent to the BIG-IP LDAP or LDAPS Virtual Server (ILX LDAP or LDAPS server)

7. Both the RADIUS ILX server and the LDAP(S) ILX server check the Ephemeral auth table and compare the hash of the provided password with the hash of the stored password 

#. The ILX server will return a result to the Router/Server (Access-Accept / Access-Reject) a. Optional authorization attribute, if defined, will be pull directly from the RADIUS/LDAP server (The ILX Virtual Servers will have Pools with the real RADIUS/LDAP servers configured as pool members for pass through attribute checking and verification [only attributes not authentication]) 

#. The SSH session is established or denied depending on outcome of step 8 


Ressources
---------------------------------------------------------------

The following resources will be defined for the lab environment:

+-------------------------+------------------------------------------------------------------+-------------+
| **Resource**            | **Description**                                                  | **Value**   |
+=========================+==================================================================+=============+
| WebSSH\_proxy\_vs\_IP   | Virtual server IP Address of WebSSH2 service.                    | 10.1.10.104 |
+-------------------------+------------------------------------------------------------------+-------------+
| APM\_Portal\_vs\_IP     | Virtual server IP Address of APM portal for authentication       | 10.1.20.104 |
+-------------------------+------------------------------------------------------------------+-------------+
| RADIUS\_proxy\_vs\_IP   | Virtual server IP address of RADIUS proxy service                | 10.1.20.104 |
+-------------------------+------------------------------------------------------------------+-------------+
| LDAP\_proxy\_vs\_IP     | Virtual server IP address of LDAP proxy service                  | 10.1.20.104 |
+-------------------------+------------------------------------------------------------------+-------------+
| LDAPS\_proxy\_vs\_IP    | Virtual server IP address of LDAPS proxy service                 | 10.1.20.104 |
+-------------------------+------------------------------------------------------------------+-------------+
| LDAP\_server\_IP        | IP Address of site LDAP or AD server (required for LDAP use)     | 10.1.20.7   |
+-------------------------+------------------------------------------------------------------+-------------+
| RADIUS\_server\_IP      | IP Address of site RADIUS server (if RADIUS bypass is used)      | 10.1.20.7   |
+-------------------------+------------------------------------------------------------------+-------------+

Expected time to complete: **30 minutes**

Access the Environment
---------------------------------------------------------------

To access your dedicated student lab environment, you will need a web browser and Remote Desktop Protocol (RDP) client software. The web browser will be used to access the Unified Demo Framework (UDF) Training Portal. The RDP client will be used to connect to the jumphost, where you will be able to access the BIG-IP management interfaces (HTTPS, SSH).

#. Click **Deployment** located on the top left corner to display the environment

   |image_udf_doc|

.. _Start PUA:

Task 1 - Start PUA
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. 
   TODO Describe a little bit the PUA docker-compose.yaml

**Access PUA Deploy Agent**

#. Click **ACCESS** next to **PUA Deploy Agent**

#. Select **Web Shell** from the lists

   |image_udf_dep_pua_access|

#. In the new browser Tab, execute the flowing shell commands to launch the PUA containers and it dependencies :

   .. code-block:: console

      cd /opt/puav3.0

   |image_pua_webshell_cd|

   .. code-block:: console

      docker compose up --detach

   |image_pua_webshell_docker_up|

   .. code-block:: console

      docker logs --follow pua

   |image_pua_webshell_docker_logs|

   .. note:: **docker logs --follow pua**  command will continuously display the log output for the container named **pua**. This is particularly useful for monitoring the container's activity and debugging issues, as you can see log messages in real-time as they occur.

   .. important:: Please ensure that the commands were executed without generating any errors before moving to the next task.


Task 2 - Access Lab Environment
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


.. note:: Many corporate environments restrict access to open RDP connections to enhance network security and prevent unauthorized remote access; therefore if the next method doesn't work, we include an alternate method for secure remote access. 

**RDP Access to the Lab Environment**

#. Click **ACCESS** next to jumpbox.f5lab.local

   |image_udf_dep_jh_access|

#. Select your RDP resolution.  

#. The RDP client on your local host establishes a RDP connection to the Jump Host.

#. Login with the following credentials:

  * User: **f5lab\\user1**

  * Password: **user1**

**Alternate Access Method to the Lab Environment**

.. note:: If you have successfully connected to the lab environment using RDP, you may proceed with :ref:`Access PUA`.

#. Click **ACCESS** next to superjump

   |image_udf_dep_sj_access|

#. Select **Guacamole** from the lists

#. In the new browser Tab, Login with the following credentials:

   * User: **guacadmin**
   
   * Password: **guacadmin**

   |image_guacamole_login|

#. Click **jumphost.f5lab.local_Windows Server 2016 Base**

#. Select **jumphost.f5lab.local_Windows Server 2016 Base_RDP** from the list

   |image_guacamole_jh_rdp|

After successful logon the Chrome browser will auto launch opening the site **about:blank**.  This process usually takes 30 seconds after logon.

|image_chrome_blank|

.. _Access PUA:

Task 3 - Access PUA
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. In Chrome browser, Click the bookmark **PUA UI** 

#. This should launch the PUA Web UI http://10.1.1.14:8080/ui

   |image_chrome_pua_ui|
  
.. warning:: If your not seeing the PUA Web UI as shown, Please review :ref:`Start PUA`


Deploy PUA Smart Card
---------------------------------------------------------------

Task 1 - Add Deployment
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. In PUA UI, Click **Deployments** in left hand navigation bar and in the main panel, Click **Add Deployment** button.

   |image_chrome_pua_deployments|

#. In the resulting window,  enter the following data:

  * **Add Deployment**
    
    * **Name** : pua_smartcard

    * **Device IP/Hostname** : 10.1.1.4

    * **Playbook**: PUA (SmartCard)
    
  |image_chrome_pua_add_deployment_smartcard|

.. _Enter Deployment details:

Task 2 - Enter Deployment details
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#.	When the **PUA (SmartCard)** playbook is selected, the editor values are updated to show the following inputs (Enter the associated values as specified below)

  * **Add Deployment**

    *	**LDAP IP**: 10.1.20.104

    *	**LDAPS Proxy IP**: 10.1.20.104

    *	**RADIUS IP**: 10.1.20.104

    *	**Webtop IP**: 10.1.10.104

    *	**LDAP Server IP**: 10.1.20.7

    *	**LDAP Management Password**: admin

    *	**LDAP Record String**: cn=Admin,cn=Users,dc=f5lab,dc=local

    *	**OCSP URL**: https://dc1.f5lab.local

    *	**OCSP Path**: /ocsp

    *	**OCSP Certificate**: ca.f5lab.local

    *	**Client SSL Certificate**: acme.com-wildcard

    *	**Client SSL Key**:	acme.com-wildcard

  |image_chrome_pua_add_deployment_smartcard_details|

.. note:: You can also switch to **Raw JSON** input and paste this JSON object to get the input fields populated.
   
  |image_chrome_pua_add_deployment_raw|

  .. code-block:: json-object

    {
      "name": "pua_smartcard",
      "device_ip": "10.1.1.4",
      "forceDeploy": false,
      "configuration": {
          "playbook": "PUA (SmartCard)",
          "user_input": {
              "LDAP_IP": "10.1.20.104",
              "LDAPS_IP": "10.1.20.104",
              "RADIUS_IP": "10.1.20.104",
              "WEBTOP_IP": "10.1.10.104",
              "LDAP_SRVR_IP": "10.1.20.7",
              "LDAP_SRVR_PASS": "admin",
              "LDAP_SRVR_RECORD": "cn=Admin,cn=Users,dc=f5lab,dc=local",
              "OCSP_URL": "https://dc1.f5lab.local",
              "OCSP_PATH": "/ocsp",
              "OCSP_CERT": "ca.f5lab.local",
              "CLIENTSSL_CERT": "acme.com-wildcard",
              "CLIENTSSL_KEY": "acme.com-wildcard"
          }
      }
    }


Task 3 - Review Deployment details and Deploy
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. Review Deployment details and Click **Deploy**

   |image_chrome_pua_add_deployment_smartcard_raw|


Task 4 - Track Deployment progress 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

If you go back to the **PUA Deploy Agent WebSSH** tab in your local browser, you should see the logs generated by the the deployment of the PUA (SmartCard) Playbook.

#. Confirm that the deployment is successful by looking for **Playbook deployed successfully** log.

   |image_pua_webshell_docker_logs_smartcard_deployment|

#. Confirm that **pua_smartcard** is listed in the PUA UI Deployments.

   |image_chrome_pua_add_deployment_smartcard_success|

.. warning:: If you don't see the **Playbook deployed successfully** in the logs and the **pua_smartcard** does not appear in **PUA UI Deployments** go back to :ref:`Enter Deployment details`.


Test PUA Smart Card
---------------------------------------------------------------

Task 1 - Acces PUA Webtop as user1
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. Right click on the **PUA Webtop** Bookmark and click on **Open in Incognito window**

   |image_chrome_incognito_pua_webtop|

#. Select certificate associated with **User1** in the  **Select a certificate** dialog box and Click **Ok**.

   |image_chrome_incognito_pua_webtop_user1_cert|

#. Click **Click here to continue**

   |image_chrome_incognito_pua_webtop_banner|

#. Webtop should now be available

   |image_chrome_incognito_pua_webtop_links|

Task 2 - Validate user1 Access
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. In the **Applications and Links** section of the Webtop

   * Click on **bigip1** and observe the the username at the bottom left corner

     |image_chrome_incognito_pua_webtop_user1_bigip1|

   * Click on **bigip5** and observe the the username at the bottom left corner

     |image_chrome_incognito_pua_webtop_user1_bigip5|

#. In the **bigip5** tab, Confirm that **user1** received the **admin [All]** role by typing the following command:

   .. code-block:: console

     show auth user

   |image_chrome_incognito_pua_webtop_user1_bigip5_auth|

.. warning:: Close the Incognito window before going to the next task


Task 3 - Acces PUA Webtop as user2
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. Right click on the **PUA Webtop** Bookmark and click on **Open in Incognito window**

   |image_chrome_incognito_pua_webtop|

#. Select certificate associated with **User2** in the  **Select a certificate** dialog box and Click **Ok**.

   |image_chrome_incognito_pua_webtop_user2_cert|

#. Click **Click here to continue**

   |image_chrome_incognito_pua_webtop_banner|

#. Webtop should now be available

   |image_chrome_incognito_pua_webtop_links|


Task 4 - Validate user2 Access
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. In the **Applications and Links** section of the Webtop

   * Click on **bigip1** and observe the the username at the bottom left corner

     |image_chrome_incognito_pua_webtop_user2_bigip1|

   * Click on **bigip5** and observe the the username at the bottom left corner

     |image_chrome_incognito_pua_webtop_user2_bigip5|

#. In the **bigip5** tab, Confirm that **user2** received the **guest [All]** role by typing the following command:

   .. code-block:: console

     show auth user

   |image_chrome_incognito_pua_webtop_user2_bigip5_auth|

.. warning:: Close the Incognito window before going to the next task


Task 5 - Acces PUA Webtop using an invalid certificate
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. Right click on the **PUA Webtop** Bookmark and click on **Open in Incognito window**

   |image_chrome_incognito_pua_webtop|

#. Select certificate associated with **MARTIAN.MARVIN.T.0123456789** in the  **Select a certificate** dialog box and Click **Ok**.

   |image_chrome_incognito_pua_webtop_invalid_cert|

#. Click **Click here to continue**

   |image_chrome_incognito_pua_webtop_banner|

#. Observe that the Webtop access has been denied when invalid certificate is provided.

   |image_chrome_incognito_pua_webtop_denied|

|image_end_of_lab|

.. |image_pua_sol_design| image:: media/lab01/pua_smartcard_solution.png
.. |image_udf_dep_pua_access| image:: media/lab01/udf_pua_deploy_agent_access.png
  :width: 480
.. |image_pua_webshell_cd| image:: media/lab01/pua_webshell_cd.png
  :width: 320
.. |image_pua_webshell_docker_up| image:: media/lab01/pua_webshell_docker_compose_up.png
  :width: 320
.. |image_pua_webshell_docker_logs| image:: media/lab01/pua_webshell_docker_logs.png
  :width: 320
.. |image_udf_doc| image:: media/lab01/udf_documentation.png
  :width: 480
.. |image_udf_dep_jh_access| image:: media/lab01/udf_deployment_jumphost_access.png
.. |image_udf_dep_sj_access| image:: media/lab01/udf_deployment_superjump_access.png
.. |image_guacamole_login| image:: media/lab01/guacamole_login.png
   :width: 320
.. |image_guacamole_jh_rdp| image:: media/lab01/guacamole_connections_jh_rdp.png
   :width: 480
.. |image_chrome_blank| image:: media/lab01/chrome_blank.png
.. |image_chrome_pua_ui| image:: media/lab01/chrome_pua_ui.png
.. |image_chrome_pua_deployments| image:: media/lab01/chrome_pua_deployments.png
.. |image_chrome_pua_add_deployment_smartcard| image:: media/lab01/chrome_pua_add_deployment_smartcard.png
  :width: 480
.. |image_chrome_pua_add_deployment_smartcard_details| image:: media/lab01/chrome_pua_add_deployment_smartcard_details.png
  :width: 320
.. |image_chrome_pua_add_deployment_raw| image:: media/lab01/chrome_pua_add_deployment_raw.png
  :width: 480
.. |image_chrome_pua_add_deployment_smartcard_raw| image:: media/lab01/chrome_pua_add_deployment_smartcard_raw.png
  :width: 480
.. |image_pua_webshell_docker_logs_smartcard_deployment| image:: media/lab01/pua_webshell_docker_logs_deployment_smartcard.png
.. |image_chrome_pua_add_deployment_smartcard_success| image:: media/lab01/chrome_pua_add_deployment_smartcard_success.png
  :width: 800



.. |image_chrome_incognito_pua_webtop| image:: media/lab01/chrome_incognito_pua_webtop.png
  :width: 480
.. |image_chrome_incognito_pua_webtop_user1_cert| image:: media/lab01/chrome_incognito_pua_webtop_user1_cert.png
  :width: 480
.. |image_chrome_incognito_pua_webtop_user2_cert| image:: media/lab01/chrome_incognito_pua_webtop_user2_cert.png
  :width: 480
.. |image_chrome_incognito_pua_webtop_invalid_cert| image:: media/lab01/chrome_incognito_pua_webtop_invalid_cert.png
  :width: 480
.. |image_chrome_incognito_pua_webtop_banner| image:: media/lab01/chrome_incognito_pua_webtop_banner.png
  :width: 320
.. |image_chrome_incognito_pua_webtop_links| image:: media/lab01/chrome_incognito_pua_webtop_links.png
.. |image_chrome_incognito_pua_webtop_denied| image:: media/lab01/chrome_incognito_pua_webtop_denied.png
  :width: 320
.. |image_chrome_incognito_pua_webtop_user1_bigip1| image:: media/lab01/chrome_incognito_pua_webtop_user1_bigip1.png
  :width: 480
.. |image_chrome_incognito_pua_webtop_user1_bigip5| image:: media/lab01/chrome_incognito_pua_webtop_user1_bigip5.png
  :width: 480
.. |image_chrome_incognito_pua_webtop_user1_bigip5_auth| image:: media/lab01/chrome_incognito_pua_webtop_user1_bigip5_auth.png
  :width: 480
.. |image_chrome_incognito_pua_webtop_user2_bigip1| image:: media/lab01/chrome_incognito_pua_webtop_user2_bigip1.png
  :width: 480
.. |image_chrome_incognito_pua_webtop_user2_bigip5| image:: media/lab01/chrome_incognito_pua_webtop_user2_bigip5.png
  :width: 480
.. |image_chrome_incognito_pua_webtop_user2_bigip5_auth| image:: media/lab01/chrome_incognito_pua_webtop_user2_bigip5_auth.png
  :width: 480


.. |image_end_of_lab| image:: media/lab01/end_of_lab.png