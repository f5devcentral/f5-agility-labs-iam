Lab – Setup Salesforce Connector
--------------------------------

This lab will teach you how to create a SAML Salesforce connector.
Estimated completion time: **30 minutes**

Task - Create a local IDP Service to Salesforce
-----------------------------------------------

+----------------------------------------------------------------------+----------------------------------------------------------------+
| 1. Logon onto BIG-IP, then go to **Access**                          |                                                                |
| -> **Federation: SAML Identity Provider**                            |                                                                |
| -> **Local Idp Services** -> **Create**                              | |image83|                                                      |
+----------------------------------------------------------------------+----------------------------------------------------------------+
| 2. Enter the following values (leave others default) on the          |                                                                |
| **General Settings**                                                 | |image84|                                                      |
|                                                                      |                                                                |
|   **Idp Service Name:** ``SALESFORCE_IDP_DEMO``                      |                                                                |
|                                                                      |                                                                |
|   **IdP Entity ID:** ``https://webtop.vlab.f5demo.com/idp/f5/``      |                                                                |
+----------------------------------------------------------------------+----------------------------------------------------------------+
| 3. Enter the following values (leave others default) on the          |                                                                |
| **Assertion Settings**.                                              | |image85|                                                      |
|                                                                      |                                                                |
|   **Assertion Subject Type:** ``Email Address``                      |                                                                |
|                                                                      |                                                                |
|   **Assertion Subject Value:** ``%{session.ad.last.attr.mail}``      |                                                                |
|                                                                      |                                                                |
|   **Authentication Context Class Reference:**                        |                                                                |
|                                                                      |                                                                |
| ``urn:oasis:names:tc:SAML:2.0:ac:classes:PasswordProtectedTransport``|                                                                |
+----------------------------------------------------------------------+----------------------------------------------------------------+
| 4. Enter the following values (leave others default) on the          |                                                                |
| **Security Settings**.                                               | |image85_2|                                                    |
|                                                                      |                                                                |
|     **Signing Key:** ``/Common/IDP_CERT_F5DEMO.key``                 |                                                                |
|                                                                      |                                                                |
|     **Signing Certificate:** ``/Common/IDP_CERT_F5DEMO.crt``         |                                                                |
+----------------------------------------------------------------------+----------------------------------------------------------------+

Task - Download IdP metadata from BIG-IP for Salesforce
-------------------------------------------------------

+-----------------------------------------------------------------+---------------------------------------------------------------------+
| 1. Go to **Access** -> **Federation: SAML Identity Provider**   |                                                                     |
| -> **Local IdP Services**, select the **SALESFORCE_IDP_DEMO**   |                                                                     |
| object, then click **Export Metadata**. Leave the               |                                                                     |
| **Sign Metadata** to **No**, and then click **Download**.       | |image86|                                                           |
|                                                                 |                                                                     |
|                                                                 | |image86_2|                                                         |
+-----------------------------------------------------------------+---------------------------------------------------------------------+

Task - Create an IdP provider in Salesforce
-------------------------------------------

+-----------------------------------------------------------------+---------------------------------------------------------------------+
| 1. Log in to Salesforce ``https://login.salesforce.com``        | |image87|                                                           |
+-----------------------------------------------------------------+---------------------------------------------------------------------+
| 2. In Quick Find search box, type **single**, and then click    |                                                                     |
| **Single Sign-On Settings.**                                    | |image88|                                                           |
| After that click the **Edit** button and check the              |                                                                     |
| **SAML Enabled** box, and then click **Save**.                  | |image89|                                                           |
+-----------------------------------------------------------------+---------------------------------------------------------------------+
| 3. Click **New from Metadata file**.Then click **Choose File**, |                                                                     |
| select ``SALESFORCE_IDP_DEMO_metadata.xml`` export file you     |                                                                     |
| downloaded from BIG-IP, and then click **Create.**              | |image90|                                                           |
|                                                                 |                                                                     |
|                                                                 | |image91|                                                           |
+-----------------------------------------------------------------+---------------------------------------------------------------------+
| 4. In the **Identity Provider Certificate** area, click         |                                                                     |
| **Choose File** and navigate to **Downloads** to select         |                                                                     |
| the certificate named ``IDP_CERT_F5DEMO.crt.``                  | |image92|                                                           |
| Uncheck the ``Single Logout box`` and **Save.**                 |                                                                     |
+-----------------------------------------------------------------+---------------------------------------------------------------------+
| 5. Click the **Download Metadata**.                             | |image93|                                                           |
+-----------------------------------------------------------------+---------------------------------------------------------------------+

Task - Create a new user in Salesforce
--------------------------------------

+-----------------------------------------------------------------+---------------------------------------------------------------------+
| 1. Log in to Salesforce ``https://login.salesforce.com``        | |image87|                                                           |
+-----------------------------------------------------------------+---------------------------------------------------------------------+
| 2. Under Administration, click **Users** -> **Users**           |                                                                     |
| -> **New User.**                                                | |image94|                                                           |
+-----------------------------------------------------------------+---------------------------------------------------------------------+
| 3. Enter the following values (leave others default) on the     |                                                                     |
| **New User**.                                                   | |image95|                                                           |
|                                                                 |                                                                     |
|     **First Name:** ``Sales``                                   |                                                                     |
|                                                                 |                                                                     |
|     **Last Name:** ``Manager``                                  |                                                                     |
|                                                                 |                                                                     |
|     **E mail:** ``sales_manager@yourdomain``                    |                                                                     |
|                                                                 |                                                                     |
|     **Username:** ``sales_manager@yourdomain``                  |                                                                     |
|                                                                 |                                                                     |
|     **Nickname:** ``sales_manager``                             |                                                                     |
|                                                                 |                                                                     |
|     **Role:** ``VP, North American Sales``                      |                                                                     |
|                                                                 |                                                                     |
|     **User License:** ``Free``                                  |                                                                     |
|                                                                 |                                                                     |
| Repeat steps to the following users and change the **Role**     |                                                                     |
| as you want:                                                    |                                                                     | 
|                                                                 |                                                                     |
| **Sales User** = ``sales_user@yourdomain``                      |                                                                     |
|                                                                 |                                                                     |
| **Partner User** = ``partner_user@yourdomain``                  |                                                                     |
+-----------------------------------------------------------------+---------------------------------------------------------------------+

Task - Modify the users in Active Directory
-------------------------------------------

+-----------------------------------------------------------------+---------------------------------------------------------------------+
| 1. From the **Win 7** Jumpbox open a                            |                                                                     |
| **Remote Desktop Connection** to Win 2008 server ``10.1.1.251`` |                                                                     | 
| Log in using **username:** ``administrator`` and **password:**  |                                                                     |
| ``password``.                                                   | |image96|                                                           |
+-----------------------------------------------------------------+---------------------------------------------------------------------+
| 2. Open the **Active Directory Users and Computers**console,    |                                                                     |
| then right-click on the **Sales Manager** user and then         |                                                                     |
| click **Properties**, modify the ``E-mail`` parameter           |                                                                     |
| according to the user that you already created at Salesforce.   |                                                                     |
| (``sales_manager@yourdomain``). Repeat steps to the following   |                                                                     |
| users:                                                          | |image97|                                                           |
|                                                                 |                                                                     |
|    **Sales User** = ``sales_user@yourdomain``                   |                                                                     |
|                                                                 |                                                                     |
|    **Partner User** = ``partner_user@yourdomain``               |                                                                     |
+-----------------------------------------------------------------+---------------------------------------------------------------------+

Task - Create an external SP connector to Salesforce
----------------------------------------------------

+-----------------------------------------------------------------+---------------------------------------------------------------------+
| 1. Logon onto BIG-IP, then go to **Access**                     |                                                                     |
| -> **Federation: SAML Identity Provider** ->                    |                                                                     |
| **External SP Connectors** -> **Create** -> **From Metadata**   | |image97_2|                                                         |
|                                                                 |                                                                     |
|                                                                 |                                                                     |
+-----------------------------------------------------------------+---------------------------------------------------------------------+
| 2. Enter the following values (leave others default) then       |                                                                     |
| click **OK**                                                    | |image98|                                                           |
|                                                                 |                                                                     |
|     **Select File:** ``SAMLSP-XXXX.xml``                        |                                                                     |
|                                                                 |                                                                     |
|     **Service Provider Name:** ``SALESFORCE_EXT_SP``            |                                                                     |
|                                                                 |                                                                     |
| Use the ``XML file`` that you downloaded from **TASK 3**.       |                                                                     |
+-----------------------------------------------------------------+---------------------------------------------------------------------+

Task - Bind IdP and SP Connector to Salesforce
----------------------------------------------

+-----------------------------------------------------------------+---------------------------------------------------------------------+
| 1. Go to **Access** -> **Federation: SAML Identity Provider**   |                                                                     |
| -> **Local IdP Services**, select the ``SALESFORCE_IDP_DEMO``   |                                                                     |
| object, then click **Bind/Unbind SP Connector**. Then select    |                                                                     |
| ``Common/SALESFORCE_EXT_SP`` as SP connector, and click **OK**. | |image99|                                                           |
|                                                                 |                                                                     |
|                                                                 | |image100|                                                          |
+-----------------------------------------------------------------+---------------------------------------------------------------------+

Task - Create a Salesforce SAML resource in BIG-IP
--------------------------------------------------

+-----------------------------------------------------------------+---------------------------------------------------------------------+
| 1. Go to **Access** -> **Federation: SAML Resources**           |                                                                     |
| -> **Create.**                                                  | |image100_2|                                                        |
+-----------------------------------------------------------------+---------------------------------------------------------------------+
| 2. Enter the following values (leave others default) on the     |                                                                     |
| **New SAML Resource** tab, then click **Finished.**             | |image101|                                                          |
|                                                                 |                                                                     |
|     **Name:** ``SALESFORCE_SAML_DEMO``                          |                                                                     |
|                                                                 |                                                                     |
|     **SSO Configuration:** ``SALESFORCE_IDP_DEMO``              |                                                                     |
|                                                                 |                                                                     |
|     **Caption:** ``SALESFORCE (SAML)``                          |                                                                     |
+-----------------------------------------------------------------+---------------------------------------------------------------------+

Task - Assign the SALESFORCE SAML resource
------------------------------------------

+-----------------------------------------------------------------+---------------------------------------------------------------------+
| 1. Go to **Access** -> **Profiles/Policies** ->                 |                                                                     |
| **Access Profiles**, then click **Edit** for ``webtop_demo``,   |                                                                     |
| a new browser tab will open                                     | |image101_2|                                                        |
+-----------------------------------------------------------------+---------------------------------------------------------------------+
| 2. Click on the **Advanced Resource Assign** object, a new      |                                                                     |
| window will open. Click **Add/Delete**, then choose             |                                                                     |
| ``/Common/AWS_SAML_DEMO`` and ``/Common/SALESFORCE_SAML_DEMO``  | |image101_3|                                                        |
| from the **SAML** tab and click **Update**, then **Save**.      |                                                                     |
|                                                                 | |image101_4|                                                        |
|                                                                 |                                                                     |
|                                                                 | |image102|                                                          |
+-----------------------------------------------------------------+---------------------------------------------------------------------+
| 3. Click **Apply Access Policy** in the top left and then       |                                                                     |
| close the browser tab                                           | |image102_2|                                                        |
+-----------------------------------------------------------------+---------------------------------------------------------------------+
| 4. Go to ``https://webtop.vlab.f5demo.com`` from the jump host, | |image103|                                                          |
|                                                                 |                                                                     |
|    You can login with any user:                                 |                                                                     |
|                                                                 |                                                                     |
| -  **sales_user**                                               |                                                                     |
|                                                                 |                                                                     |
| -  **sales_manager**                                            |                                                                     |
|                                                                 |                                                                     |
| -  **partner_user**                                             |                                                                     |
|                                                                 |                                                                     |
| You should see two ``SAML`` resources **AWS** and               |                                                                     |
| **SALESFORCE**                                                  |                                                                     |
+-----------------------------------------------------------------+---------------------------------------------------------------------+
| 5. Click on the **AWS** and **SALESFORCE** links. You should    |                                                                     |
| be able to access **both** because of **SSO** (``SAML``).       |                                                                     |
+-----------------------------------------------------------------+---------------------------------------------------------------------+


.. |image83| image:: /_static/class9/image83.png
.. |image84| image:: /_static/class9/image84.png
.. |image85| image:: /_static/class9/image85.png
.. |image85_2| image:: /_static/class9/image85_2.png
.. |image86| image:: /_static/class9/image86.png
.. |image86_2| image:: /_static/class9/image86_2.png
.. |image87| image:: /_static/class9/image87.png
.. |image88| image:: /_static/class9/image88.png
.. |image89| image:: /_static/class9/image89.png
.. |image90| image:: /_static/class9/image90.png
.. |image91| image:: /_static/class9/image91.png
.. |image92| image:: /_static/class9/image92.png
.. |image93| image:: /_static/class9/image93.png
.. |image94| image:: /_static/class9/image94.png
.. |image95| image:: /_static/class9/image95.png
.. |image96| image:: /_static/class9/image96.png
.. |image97| image:: /_static/class9/image97.png
.. |image97_2| image:: /_static/class9/image97_2.png
.. |image98| image:: /_static/class9/image98.png
.. |image99| image:: /_static/class9/image99.png
.. |image100| image:: /_static/class9/image100.png
.. |image100_2| image:: /_static/class9/image100_2.png
.. |image101| image:: /_static/class9/image101.png
.. |image101_2| image:: /_static/class9/image101_2.png
.. |image101_3| image:: /_static/class9/image101_3.png
.. |image101_4| image:: /_static/class9/image101_4.png
.. |image102| image:: /_static/class9/image102.png
.. |image102_2| image:: /_static/class9/image102_2.png
.. |image103| image:: /_static/class9/image103.png

