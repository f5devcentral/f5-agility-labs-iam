Installation
============

Online Installation Method
--------------------------

This method utilizes the **build\_pua.sh/zip** method to install the PUA
solutions from online resources. This requires a BIG-IP with working
Internet connectivity and DNS resolution to Internet resources.

Run Installation Script
~~~~~~~~~~~~~~~~~~~~~~~

1. SCP **build\_pua.zip** to the BIG-IP (/config will be fine)

   a. If running an Automated or Semi-Automated setup, SCP your
      customized **pua\_config.sh** script to the same folder

2. Unzip **build\_pua.zip**

+----------------------------------------------------------------------------+
| [root@pua131-build:Active:Standalone] config # **unzip build\_pua.zip **   |
|                                                                            |
| Archive:  build\_pua.zip                                                   |
|                                                                            |
|   inflating: build\_pua.sh                                                 |
+============================================================================+
+----------------------------------------------------------------------------+

1. Run **build\_pua.sh**

   a. If running a fully automated script, skip to
      `Validation <#_Validation>`__

2. Answer the questions when prompted

   a. If using the **Semi-Automated** setup, the defaults will be
      inserted for you, to accept them just hit **<ENTER>**

+-----------------------------------------------------------------------------------------------------------+
| [root@pua131-build:Active:Standalone] config # **bash build\_pua.sh **                                    |
|                                                                                                           |
| Introduction                                                                                              |
|                                                                                                           |
| ============                                                                                              |
|                                                                                                           |
| | ...                                                                                                     |
| | Press any key to continue, or CTRL-C to cancel.                                                         |
|                                                                                                           |
| Preparing environment... [OK]                                                                             |
|                                                                                                           |
| Changing to /tmp/pua.ciIVBvwwpN... [OK]                                                                   |
|                                                                                                           |
| Adding ILX archive directory [OK]                                                                         |
|                                                                                                           |
| Checking modules are provisioned.                                                                         |
|                                                                                                           |
| Checking apm... [OK]                                                                                      |
|                                                                                                           |
| Checking ltm... [OK]                                                                                      |
|                                                                                                           |
| Checking ilx... [OK]                                                                                      |
|                                                                                                           |
| SUCCESS: All modules provisioned.                                                                         |
|                                                                                                           |
| Type the IP address of your WebSSH2 service virtual server                                                |
|                                                                                                           |
| and press ENTER: **192.168.20.62 **                                                                       |
|                                                                                                           |
| You typed **192.168.20.62**, is that correct (Y/n)? **y**                                                 |
|                                                                                                           |
| Checking IP... [OK]                                                                                       |
|                                                                                                           |
| Type the IP address of your RADIUS service virtual server                                                 |
|                                                                                                           |
| and press ENTER: **192.168.20.63**                                                                        |
|                                                                                                           |
| You typed **192.168.20.63**, is that correct (Y/n)? **y**                                                 |
|                                                                                                           |
| Checking IP... [OK]                                                                                       |
|                                                                                                           |
| Type the IP address of your LDAP service virtual server                                                   |
|                                                                                                           |
| and press ENTER [**192.168.20.63**]:                                                                      |
|                                                                                                           |
| You typed **192.168.20.63**, is that correct (Y/n)? **y**                                                 |
|                                                                                                           |
| Type the IP address of your LDAPS service virtual server                                                  |
|                                                                                                           |
| and press ENTER [**192.168.20.63**]:                                                                      |
|                                                                                                           |
| You typed **192.168.20.63**, is that correct (Y/n)? **y**                                                 |
|                                                                                                           |
| Type the IP address of your Webtop service virtual server                                                 |
|                                                                                                           |
| and press ENTER [**192.168.20.63**]:                                                                      |
|                                                                                                           |
| You typed **192.168.20.63**, is that correct (Y/n)? **y**                                                 |
|                                                                                                           |
| Checking for startup\_script\_webssh\_commands.sh... [NOT FOUND]                                          |
|                                                                                                           |
| Downloading startup\_script\_webssh\_commands.sh... [OK]                                                  |
|                                                                                                           |
| Downloading startup\_script\_webssh\_commands.sh.sha256... [OK]                                           |
|                                                                                                           |
| Hash check for startup\_script\_webssh\_commands.sh [OK]                                                  |
|                                                                                                           |
| Checking for BIG-IP-13.1.0.2-ILX-WebSSH2-current.tgz... [NOT FOUND]                                       |
|                                                                                                           |
| Downloading BIG-IP-13.1.0.2-ILX-WebSSH2-current.tgz... [OK]                                               |
|                                                                                                           |
| Downloading BIG-IP-13.1.0.2-ILX-WebSSH2-current.tgz.sha256... [OK]                                        |
|                                                                                                           |
| Hash check for BIG-IP-13.1.0.2-ILX-WebSSH2-current.tgz [OK]                                               |
|                                                                                                           |
| Checking for BIG-IP-ILX-ephemeral\_auth-current.tgz... [NOT FOUND]                                        |
|                                                                                                           |
| Downloading BIG-IP-ILX-ephemeral\_auth-current.tgz... [OK]                                                |
|                                                                                                           |
| Downloading BIG-IP-ILX-ephemeral\_auth-current.tgz.sha256... [OK]                                         |
|                                                                                                           |
| Hash check for BIG-IP-ILX-ephemeral\_auth-current.tgz [OK]                                                |
|                                                                                                           |
| Sample Certificate Authority                                                                              |
|                                                                                                           |
| ============================                                                                              |
|                                                                                                           |
| | ...                                                                                                     |
| | Would you like to download a sample CA for testing (Y/n)? **y**                                         |
|                                                                                                           |
| Checking for ca.pua.lab.cer... [NOT FOUND]                                                                |
|                                                                                                           |
| Downloading ca.pua.lab.cer... [OK]                                                                        |
|                                                                                                           |
| Downloading ca.pua.lab.cer.sha256... [OK]                                                                 |
|                                                                                                           |
| Hash check for ca.pua.lab.cer [OK]                                                                        |
|                                                                                                           |
| Installing CA file ca.pua.lab.cer [OK]                                                                    |
|                                                                                                           |
| Creating pua\_webtop-clientssl profile with CA ca.pua.lab.cer [OK]                                        |
|                                                                                                           |
| Placing startup\_script\_webssh\_commands.sh in /config... [OK]                                           |
|                                                                                                           |
| Placing BIG-IP-13.1.0.2-ILX-WebSSH2-current.tgz in /var/ilx/workspaces/Common/archive... [OK]             |
|                                                                                                           |
| Placing BIG-IP-ILX-ephemeral\_auth-current.tgz in /var/ilx/workspaces/Common/archive... [OK]              |
|                                                                                                           |
| Creating ephemeral\_config data group... [OK]                                                             |
|                                                                                                           |
| Creating ephemeral\_LDAP\_Bypass data group... [OK]                                                       |
|                                                                                                           |
| Creating ephemeral\_RADIUS\_Bypass data group... [OK]                                                     |
|                                                                                                           |
| Creating ephemeral\_radprox\_host\_groups data group... [OK]                                              |
|                                                                                                           |
| Creating ephemeral\_radprox\_radius\_attributes data group... [OK]                                        |
|                                                                                                           |
| Creating ephemeral\_radprox\_radius\_client data group... [OK]                                            |
|                                                                                                           |
| Importing WebSSH2 Workspace... [OK]                                                                       |
|                                                                                                           |
| Importing Ephemeral Authentication Workspace... [OK]                                                      |
|                                                                                                           |
| Modifying Ephemeral Authentication Workspace... [OK]                                                      |
|                                                                                                           |
| Creating WEBSSH Proxy Service Virtual Server... [OK]                                                      |
|                                                                                                           |
| Creating tmm route for Plugin... [OK]                                                                     |
|                                                                                                           |
| Installing webssh tmm vip startup script... [OK]                                                          |
|                                                                                                           |
| Creating WebSSH2 Plugin... [OK]                                                                           |
|                                                                                                           |
| Creating Ephemeral Authentication Plugin... [OK]                                                          |
|                                                                                                           |
| Creating RADIUS Proxy Service Virtual Server... [OK]                                                      |
|                                                                                                           |
| Creating LDAP Proxy Service Virtual Server... [OK]                                                        |
|                                                                                                           |
| Creating LDAPS (ssl) Proxy Service Virtual Server... [OK]                                                 |
|                                                                                                           |
| Creating APM connectivity profile... [OK]                                                                 |
|                                                                                                           |
| Checking for profile-pua\_webtop\_policy.conf.tar.gz... [NOT FOUND]                                       |
|                                                                                                           |
| Downloading profile-pua\_webtop\_policy.conf.tar.gz... [OK]                                               |
|                                                                                                           |
| Downloading profile-pua\_webtop\_policy.conf.tar.gz.sha256... [OK]                                        |
|                                                                                                           |
| Hash check for profile-pua\_webtop\_policy.conf.tar.gz [OK]                                               |
|                                                                                                           |
| Importing APM sample profile profile-pua\_webtop\_policy.conf.tar.gz [OK]                                 |
|                                                                                                           |
| Modifying pua APM Portal Resource...[OK]                                                                  |
|                                                                                                           |
| Applying pua APM Policy...[OK]                                                                            |
|                                                                                                           |
| Creating Webtop Virtual Server... [OK]                                                                    |
|                                                                                                           |
| RADIUS Testing Option                                                                                     |
|                                                                                                           |
| =====================                                                                                     |
|                                                                                                           |
| | ...                                                                                                     |
| | Do you want to configure this BIG-IP to authenticate against itself for testing purposes (y/N)? **y**   |
|                                                                                                           |
| Are you really sure!? (y/N)? **y**                                                                        |
|                                                                                                           |
| Modifying BIG-IP for RADIUS authentication against itself... [OK]                                         |
|                                                                                                           |
| You can test WebSSH2 and Ephemeral authentication without APM configuration now                           |
|                                                                                                           |
| by browsing to:                                                                                           |
|                                                                                                           |
|   \ **https://192.168.20.62:2222/ssh/host/192.168.30.205**                                                |
|                                                                                                           |
|   username: testuser                                                                                      |
|                                                                                                           |
|   password: anypassword                                                                                   |
|                                                                                                           |
| This will allow anyone using the username testuser to log in with any password                            |
|                                                                                                           |
| as a guest                                                                                                |
|                                                                                                           |
| Saving config... [OK]                                                                                     |
|                                                                                                           |
| You can test your new APM webtop now by browsing to:                                                      |
|                                                                                                           |
|   **https://192.168.20.63**                                                                               |
|                                                                                                           |
|   username: <any>                                                                                         |
|                                                                                                           |
|   password: <any>                                                                                         |
|                                                                                                           |
| This will let anyone in with any policy. The next step after testing would be                             |
|                                                                                                           |
| to add access control through AD, MFA, or some other method.                                              |
|                                                                                                           |
| If the RADIUS testing option was enabled, any username will log in using                                  |
|                                                                                                           |
| Ephemeral Authentication.                                                                                 |
|                                                                                                           |
| Task complete.                                                                                            |
|                                                                                                           |
| Now go build an APM policy for pua!                                                                       |
|                                                                                                           |
| Cleaning up...                                                                                            |
+===========================================================================================================+
+-----------------------------------------------------------------------------------------------------------+

Offline Installation Method
---------------------------

This method utilizes the **build\_pua\_offline.sh/zip** method to
install the PUA solutions from a closed network or a BIG-IP with limited
or no Internet connectivity.

Run Installation Script
~~~~~~~~~~~~~~~~~~~~~~~

1. SCP **build\_pua\_offline.zip** to the BIG-IP (/config will be fine)

   a. If running an Automated or Semi-Automated setup, SCP your
      customized **pua\_config.sh** script to the same folder

2. Unzip **build\_pua\_offline.zip**

+-------------------------------------------------------------------------------------+
| [root@pua131-build:Active:Standalone] config # **unzip build\_pua\_offline.zip **   |
|                                                                                     |
| Archive:  build\_pua\_offline.zip                                                   |
|                                                                                     |
|   inflating: build\_pua\_offline.sh                                                 |
+=====================================================================================+
+-------------------------------------------------------------------------------------+

1. Run **build\_pua\_offline.sh**

   a. If running a fully automated script, skip to
      `Validation <#_Validation>`__

2. Answer the questions when prompted

   a. If using the **Semi-Automated** setup, the defaults will be
      inserted for you, to accept them just hit **<ENTER>**

+-----------------------------------------------------------------------------------------------------------+
| [root@pua131-build:Active:Standalone] config # **bash build\_pua\_offline.sh **                           |
|                                                                                                           |
| Introduction                                                                                              |
|                                                                                                           |
| ============                                                                                              |
|                                                                                                           |
| | ...                                                                                                     |
| | Press any key to continue, or CTRL-C to cancel.                                                         |
|                                                                                                           |
| Preparing environment... [OK]                                                                             |
|                                                                                                           |
| Changing to /tmp/pua.cN9WbyIUdO... [OK]                                                                   |
|                                                                                                           |
| **Offline mode detected. Skipping downloads.**                                                            |
|                                                                                                           |
| Extracting archive [OK]                                                                                   |
|                                                                                                           |
| Adding ILX archive directory [OK]                                                                         |
|                                                                                                           |
| Checking modules are provisioned.                                                                         |
|                                                                                                           |
| Checking apm... [OK]                                                                                      |
|                                                                                                           |
| Checking ltm... [OK]                                                                                      |
|                                                                                                           |
| Checking ilx... [OK]                                                                                      |
|                                                                                                           |
| SUCCESS: All modules provisioned.                                                                         |
|                                                                                                           |
| Type the IP address of your WebSSH2 service virtual server                                                |
|                                                                                                           |
| and press ENTER: \ **192.168.20.62**                                                                      |
|                                                                                                           |
| You typed **192.168.20.62**, is that correct (Y/n)? **y**                                                 |
|                                                                                                           |
| Checking IP... [OK]                                                                                       |
|                                                                                                           |
| Type the IP address of your RADIUS service virtual server                                                 |
|                                                                                                           |
| and press ENTER: **192.168.20.63**                                                                        |
|                                                                                                           |
| You typed **192.168.20.63**, is that correct (Y/n)? **y**                                                 |
|                                                                                                           |
| Checking IP... [OK]                                                                                       |
|                                                                                                           |
| Type the IP address of your LDAP service virtual server                                                   |
|                                                                                                           |
| and press ENTER [**192.168.20.63**]:                                                                      |
|                                                                                                           |
| You typed **192.168.20.63**, is that correct (Y/n)? **y**                                                 |
|                                                                                                           |
| Type the IP address of your LDAPS service virtual server                                                  |
|                                                                                                           |
| and press ENTER [**192.168.20.63**]:                                                                      |
|                                                                                                           |
| You typed **192.168.20.63**, is that correct (Y/n)? **y**                                                 |
|                                                                                                           |
| Type the IP address of your Webtop service virtual server                                                 |
|                                                                                                           |
| and press ENTER [**192.168.20.63**]:                                                                      |
|                                                                                                           |
| You typed **192.168.20.63**, is that correct (Y/n)? **y**                                                 |
|                                                                                                           |
| Checking for startup\_script\_webssh\_commands.sh... [OK]                                                 |
|                                                                                                           |
| Hash check for startup\_script\_webssh\_commands.sh [OK]                                                  |
|                                                                                                           |
| Checking for BIG-IP-13.1.0.2-ILX-WebSSH2-current.tgz... [OK]                                              |
|                                                                                                           |
| Hash check for BIG-IP-13.1.0.2-ILX-WebSSH2-current.tgz [OK]                                               |
|                                                                                                           |
| Checking for BIG-IP-ILX-ephemeral\_auth-current.tgz... [OK]                                               |
|                                                                                                           |
| Hash check for BIG-IP-ILX-ephemeral\_auth-current.tgz [OK]                                                |
|                                                                                                           |
| Sample Certificate Authority                                                                              |
|                                                                                                           |
| ============================                                                                              |
|                                                                                                           |
| | ...                                                                                                     |
| | Would you like to install a sample CA for testing (Y/n)? **y**                                          |
|                                                                                                           |
| Checking for ca.pua.lab.cer... [OK]                                                                       |
|                                                                                                           |
| Hash check for ca.pua.lab.cer [OK]                                                                        |
|                                                                                                           |
| Installing CA file ca.pua.lab.cer [OK]                                                                    |
|                                                                                                           |
| Creating pua\_webtop-clientssl profile with CA ca.pua.lab.cer [OK]                                        |
|                                                                                                           |
| Placing startup\_script\_webssh\_commands.sh in /config... [OK]                                           |
|                                                                                                           |
| Placing BIG-IP-13.1.0.2-ILX-WebSSH2-current.tgz in /var/ilx/workspaces/Common/archive... [OK]             |
|                                                                                                           |
| Placing BIG-IP-ILX-ephemeral\_auth-current.tgz in /var/ilx/workspaces/Common/archive... [OK]              |
|                                                                                                           |
| Creating ephemeral\_config data group... [OK]                                                             |
|                                                                                                           |
| Creating ephemeral\_LDAP\_Bypass data group... [OK]                                                       |
|                                                                                                           |
| Creating ephemeral\_RADIUS\_Bypass data group... [OK]                                                     |
|                                                                                                           |
| Creating ephemeral\_radprox\_host\_groups data group... [OK]                                              |
|                                                                                                           |
| Creating ephemeral\_radprox\_radius\_attributes data group... [OK]                                        |
|                                                                                                           |
| Creating ephemeral\_radprox\_radius\_client data group... [OK]                                            |
|                                                                                                           |
| Importing WebSSH2 Workspace... [OK]                                                                       |
|                                                                                                           |
| Importing Ephemeral Authentication Workspace... [OK]                                                      |
|                                                                                                           |
| Modifying Ephemeral Authentication Workspace... [OK]                                                      |
|                                                                                                           |
| Creating WEBSSH Proxy Service Virtual Server... [OK]                                                      |
|                                                                                                           |
| Creating tmm route for Plugin... [OK]                                                                     |
|                                                                                                           |
| Installing webssh tmm vip startup script... [OK]                                                          |
|                                                                                                           |
| Creating WebSSH2 Plugin... [OK]                                                                           |
|                                                                                                           |
| Creating Ephemeral Authentication Plugin... [OK]                                                          |
|                                                                                                           |
| Creating RADIUS Proxy Service Virtual Server... [OK]                                                      |
|                                                                                                           |
| Creating LDAP Proxy Service Virtual Server... [OK]                                                        |
|                                                                                                           |
| Creating LDAPS (ssl) Proxy Service Virtual Server... [OK]                                                 |
|                                                                                                           |
| Creating APM connectivity profile... [OK]                                                                 |
|                                                                                                           |
| Checking for profile-pua\_webtop\_policy.conf.tar.gz... [OK]                                              |
|                                                                                                           |
| Hash check for profile-pua\_webtop\_policy.conf.tar.gz [OK]                                               |
|                                                                                                           |
| Importing APM sample profile profile-pua\_webtop\_policy.conf.tar.gz [OK]                                 |
|                                                                                                           |
| Modifying pua APM Portal Resource...[OK]                                                                  |
|                                                                                                           |
| Applying pua APM Policy...[OK]                                                                            |
|                                                                                                           |
| Creating Webtop Virtual Server... [OK]                                                                    |
|                                                                                                           |
| RADIUS Testing Option                                                                                     |
|                                                                                                           |
| =====================                                                                                     |
|                                                                                                           |
| | ...                                                                                                     |
| | Do you want to configure this BIG-IP to authenticate against itself for testing purposes (y/N)? **y**   |
|                                                                                                           |
| Are you really sure!? (y/N)? **y**                                                                        |
|                                                                                                           |
| Modifying BIG-IP for RADIUS authentication against itself... [OK]                                         |
|                                                                                                           |
| You can test WebSSH2 and Ephemeral authentication without APM configuration now                           |
|                                                                                                           |
| by browsing to:                                                                                           |
|                                                                                                           |
|   **https://192.168.20.62:2222/ssh/host/192.168.30.205**                                                  |
|                                                                                                           |
|   username: testuser                                                                                      |
|                                                                                                           |
|   password: anypassword                                                                                   |
|                                                                                                           |
| This will allow anyone using the username testuser to log in with any password                            |
|                                                                                                           |
| as a guest                                                                                                |
|                                                                                                           |
| Saving config... [OK]                                                                                     |
|                                                                                                           |
| You can test your new APM webtop now by browsing to:                                                      |
|                                                                                                           |
|   **https://192.168.20.63**                                                                               |
|                                                                                                           |
|   username: <any>                                                                                         |
|                                                                                                           |
|   password: <any>                                                                                         |
+===========================================================================================================+
+-----------------------------------------------------------------------------------------------------------+
