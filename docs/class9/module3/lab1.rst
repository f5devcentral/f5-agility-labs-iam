Lab – Setup AWS Connector
-------------------------

This lab will teach you how to create a SAML AWS connector.
Estimated completion time: **30 minutes**

Task - Download AWS metadata
----------------------------

+-----------------------------------------------------------------+---------------------------------------------------------------------+
| 1. From the jumpbox machine (**Win7**) , open new window        |                                                                     |
| browser tab to                                                  |                                                                     |
| ``https://signin.aws.amazon.com/static/saml-metadata.xml``      |                                                                     |
| and **download** de xml file to the **Desktop**.                |                                                                     |      
| This file will be used to create and AWS external SP Connector  |                                                                     |
| on the BIG-IP.                                                  | |image44|                                                           |
+-----------------------------------------------------------------+---------------------------------------------------------------------+

Task - Create an external SP connector to AWS
---------------------------------------------

+-----------------------------------------------------------------+---------------------------------------------------------------------+
| 1. Logon onto BIG-IP, then go to **Access**                     |                                                                     |
| -> **Federation: SAML Identity Provider**                       |                                                                     |
| -> **External SP Connectors** -> **Create**                     |                                                                     |
| -> **From Metadata**                                            | |image45|                                                           |
|                                                                 | |image46|                                                           |
+-----------------------------------------------------------------+---------------------------------------------------------------------+
| 2. Enter the following values (leave others default)            |                                                                     |
| then click **OK**                                               | |image47|                                                           |
|                                                                 |                                                                     |
|     **Select File:** ``saml-metadata.xml``                      |                                                                     |
|                                                                 |                                                                     |
|     **Service Provider Name:** ``AWS_EXT_SP``                   |                                                                     |
+-----------------------------------------------------------------+---------------------------------------------------------------------+

Task - Create a local IDP Service to AWS
----------------------------------------

+---------------------------------------------------------------------------------------+---------------------------------------------------------------------+
| 1. Logon onto BIG-IP, then go to **Access**                                           |                                                                     |
| -> **Federation: SAML Identity Provider**                                             |                                                                     |
| -> **Local Idp Services** -> **Create**                                               | |image48|                                                           |
+---------------------------------------------------------------------------------------+---------------------------------------------------------------------+
| 2. Enter the following values (leave others default) on the **General Settings**      |                                                                     |
|                                                                                       | |image49|                                                           |
|    **Idp Service Name:** ``AWS_IDP_DEMO``                                             |                                                                     |
|                                                                                       |                                                                     |
|    **IdP Entity ID:** ``https://webtop.vlab.f5demo.com/idp/f5/``                      |                                                                     |
+---------------------------------------------------------------------------------------+---------------------------------------------------------------------+
| 3. Enter the following values (leave others default)                                  |                                                                     |
| on the **Assertion Settings**.                                                        | |image50|                                                           |
|                                                                                       |                                                                     |
|     **Assertion Subject Type:** ``Unspecified``                                       |                                                                     |
|                                                                                       |                                                                     |
|     **Assertion Subject Value:**  ``%{session.ad.last.attr.sAMAccountName}``          |                                                                     |
|                                                                                       |                                                                     |
|     **Authentication Context Class Reference:**                                       |                                                                     |
|                                                                                       |                                                                     |
| ``urn:oasis:names:tc:SAML:2.0:ac:classes:PasswordProtectedTransport``                 |                                                                     |
+---------------------------------------------------------------------------------------+---------------------------------------------------------------------+
| 4. On the **Saml Attributes** click **Add**.                                          | |image51|                                                           |
+---------------------------------------------------------------------------------------+---------------------------------------------------------------------+
| 5. Create the **RoleSessionName** Attribute with the following                        |                                                                     |
| values (leave others default), click **Update**,                                      |                                                                     |
| then click **OK**                                                                     | |image52|                                                           |
|                                                                                       |                                                                     |
|     **Name:** ``https://aws.amazon.com/SAML/Attributes/RoleSessionName``              |                                                                     |
|                                                                                       |                                                                     |
|     **Value:** ``%{session.logon.last.logonname}``                                    |                                                                     |
+---------------------------------------------------------------------------------------+---------------------------------------------------------------------+
| 6. Create the **Role** Attribute with the following values                            |                                                                     |
| (leave others default), click **Update**, then click **OK**                           | |image53|                                                           |
|                                                                                       |                                                                     |
|   **Name:** ``https://aws.amazon.com/SAML/Attributes/Role``                           |                                                                     |
|                                                                                       |                                                                     |
|   **Value:**                                                                          |                                                                     |
|                                                                                       |                                                                     |
| ``arn:aws:iam::AccountId:role/SamlAdmin,arn:aws:iam::AccountId:saml-provider/f5demo`` |                                                                     |
|                                                                                       |                                                                     |
| Take the ``Account Id`` from AWS IAM Console ``https://console.aws.amazon.com/iam``,  |                                                                     |
| click your **User Name** on the upper right, and then select **My Account**. A new    |                                                                     |
| window opens. Copy the ``Account Id`` and use it as part of the ``Value``             |                                                                     |
|                                                                                       |                                                                     |
+---------------------------------------------------------------------------------------+---------------------------------------------------------------------+
| 7. Enter the following values (leave others default) on the **Security Settings**     |                                                                     |
|                                                                                       | |image54|                                                           |
|     **Signing Key:** ``/Common/IDP_CERT_F5DEMO.key``                                  |                                                                     |
|                                                                                       |                                                                     |
|     **Signing Certificate:** ``/Common/IDP_CERT_F5DEMO.crt``                          |                                                                     |
+---------------------------------------------------------------------------------------+---------------------------------------------------------------------+

Task - Download IdP metadata from BIG-IP for AWS
------------------------------------------------

+-----------------------------------------------------------------+---------------------------------------------------------------------+
| 1. Go to **Access** -> **Federation: SAML Identity Provider**   |                                                                     |
| -> **Local IdP Services**, select the ``AWS_IDP_DEMO`` object,  | |image55|                                                           |
| then click **Export Metadata**. Leave the **Sign Metadata**     |                                                                     |
| to **No**, and then click **Download**.                         | |image56|                                                           |
|                                                                 |                                                                     |
+-----------------------------------------------------------------+---------------------------------------------------------------------+

Task - Bind IdP and SP Connector to AWS
---------------------------------------

+-----------------------------------------------------------------+---------------------------------------------------------------------+
| 1. Go to **Access** -> **Federation: SAML Identity Provider**   |                                                                     |
| -> **Local IdP Services**, select the ``AWS_IDP_DEMO`` object,  |                                                                     |
| then click **Bind/Unbind SP Connector**. Then select            |                                                                     |
| ``/Common/AWS_EXT_SP`` as SP connector and click **OK**.        | |image56_2|                                                         |
|                                                                 |                                                                     |
|                                                                 | |image57|                                                           |
+-----------------------------------------------------------------+---------------------------------------------------------------------+

Task - Create an IdP provider in AWS
------------------------------------

+-----------------------------------------------------------------+---------------------------------------------------------------------+
| 1. Sign in to the AWS Management Console and open the           |                                                                     |
| **IAM console** at ``https://console.aws.amazon.com/iam/``      |                                                                     |
| then click **Identity Provider**                                | |image58|                                                           |
+-----------------------------------------------------------------+---------------------------------------------------------------------+
| 2. Click **Create Provider**                                    | |image59|                                                           |
+-----------------------------------------------------------------+---------------------------------------------------------------------+
| 3. Enter the following values (leave others default)            |                                                                     |
| on the **Configure Provider** tab, then click **Next Step**     | |image60|                                                           |                                               
|                                                                 |                                                                     |
|     **Provider Type:** ``SAML``                                 |                                                                     |
|                                                                 |                                                                     |
|     **Provider Name:** ``f5demo``                               |                                                                     |
|                                                                 |                                                                     |
|     **Metadata Document:** ``PATH\\AWS_IDP_DEMO_metadata.xml``  |                                                                     |
|                                                                 |                                                                     |
|  For the ``metadata`` document choose the file that you         |                                                                     |
|  already downloaded.                                            |                                                                     |
+-----------------------------------------------------------------+---------------------------------------------------------------------+
| 4. ``Verify the information`` you have provided, and then       |                                                                     |
| click **Create**.                                               | |image61|                                                           |
+-----------------------------------------------------------------+---------------------------------------------------------------------+

Task - Create a new Role in AWS
-------------------------------

+-----------------------------------------------------------------+---------------------------------------------------------------------+
| 1. In the left navigation pane, click **Roles**.                | |image62|                                                           |
+-----------------------------------------------------------------+---------------------------------------------------------------------+
| 2. Click **Create Role**                                        | |image63|                                                           |
+-----------------------------------------------------------------+---------------------------------------------------------------------+
| 3. Enter the following values (leave others default) on the     |                                                                     |
| **Select type of trusted entity** tab, then click               |                                                                     |
| **Next: Permisions**                                            | |image64|                                                           |
|                                                                 |                                                                     |
|    **Type of trusted entity:** ``SAML 2.0``                     |                                                                     |
|                                                                 |                                                                     |
|    **SAML provider:** ``f5demo``                                |                                                                     |
|                                                                 |                                                                     |
|    **Select:** ``Allow programmatic and AWS Management Console``|                                                                     |
|                                                                 |                                                                     |
|    **Attribute:** ``SAML:aud``                                  |                                                                     |
|                                                                 |                                                                     |
|    **Value:** ``https://signing.aws.amazon.com/saml``           |                                                                     |
+-----------------------------------------------------------------+---------------------------------------------------------------------+
| 4. Enter the following values (leave others default) on the     |                                                                     |
| **Attach permissions policies** tab, then click                 |                                                                     |
| **Next: Review**                                                | |image65|                                                           |
|                                                                 |                                                                     |
|     **Select the Policy Name:** ``AdministratorAccess``         |                                                                     |
+-----------------------------------------------------------------+---------------------------------------------------------------------+
| 5. Enter the following values (leave others default) on the     |                                                                     |
| **Review** tab, then click **Create Role**                      | |image66|                                                           |
|                                                                 |                                                                     |
|     **Role Name:** ``SamlAdmin``                                |                                                                     |
+-----------------------------------------------------------------+---------------------------------------------------------------------+

Task - Create a AWS SAML resource in BIG-IP
-------------------------------------------

+-----------------------------------------------------------------+---------------------------------------------------------------------+
| 1. Go to **Access** -> **Federation: SAML Resources**           |                                                                     |
| -> **Create.**                                                  | |image67|                                                           |
+-----------------------------------------------------------------+---------------------------------------------------------------------+
| 2. Enter the following values (leave others default) on the     |                                                                     |
| **New SAML Resource** tab, then click **Finished.**             | |image68|                                                           |
|                                                                 |                                                                     |
|     **Name:** ``AWS_SAML_DEMO``                                 |                                                                     |
|                                                                 |                                                                     |
|     **SSO Configuration:** ``AWS_IDP_DEMO``                     |                                                                     |
|                                                                 |                                                                     |
|     **Caption:** ``AWS (SAML)``                                 |                                                                     |
+-----------------------------------------------------------------+---------------------------------------------------------------------+

Task - Assign the AWS SAML resource
-----------------------------------

+-----------------------------------------------------------------+---------------------------------------------------------------------+
| 1. Go to **Access** -> **Profiles/Policies**                    |                                                                     |
| -> **Access Profiles**, then click **Edit** for                 |                                                                     |
| **webtop_demo**, a new browser tab will open                    | |image69_2|                                                         |
+-----------------------------------------------------------------+---------------------------------------------------------------------+
| 2. Click the ``+`` between **AD Auth** and                      |                                                                     |
| **Advanced Resource Assign**, select **AD Query** from the      |                                                                     |
| **Authentication** tab, click **Add Item**                      | |image69|                                                           |
|                                                                 |                                                                     |
|                                                                 | |image70|                                                           |
+-----------------------------------------------------------------+---------------------------------------------------------------------+
| 3. Enter the following values (leave others default) then       |                                                                     |
| click **Save**                                                  | |image71|                                                           |
|                                                                 |                                                                     |
|     **Server:** ``/Common/webtop_demo_aaa_srvr``                |                                                                     |
+-----------------------------------------------------------------+---------------------------------------------------------------------+
| 4. Click on the **AD Query** object, a new window will open.    |                                                                     |
| Click on the **Branch Rules** tab                               | |image72|                                                           |
|                                                                 |                                                                     |
|                                                                 | |image73|                                                           |
+-----------------------------------------------------------------+---------------------------------------------------------------------+
| 5. Click on **change** link, and then delete the expression     |                                                                     |
| using ``X``. After that select **AD Auth** from **Agent Sel**   |                                                                     |
| parameter then click **Add Expression**. Click **Finished**     |                                                                     |
| and change the name to **Passed Query** then **Save**.          | |image74|                                                           |
|                                                                 |                                                                     |
|                                                                 | |image75|                                                           |
|                                                                 |                                                                     |
|                                                                 | |image76|                                                           |
|                                                                 |                                                                     |
|                                                                 | |image77|                                                           |
+-----------------------------------------------------------------+---------------------------------------------------------------------+
| 6. Click on the **Advanced Resource Assign** object, a new      |                                                                     |
| window will open. Click **Add/Delete**, then choose             |                                                                     |
| ``/Common/AWS_SAML_DEMO`` from the **SAML** tab and click       |                                                                     |
| **Update,** then **Save**.                                      | |image72|                                                           |
|                                                                 |                                                                     |
|                                                                 | |image78|                                                           |
|                                                                 |                                                                     |
|                                                                 | |image79|                                                           |
+-----------------------------------------------------------------+---------------------------------------------------------------------+
| 7. Click **Apply Access Policy** in the top left and then       |                                                                     |
| close the browser tab                                           | |image80|                                                           |
+-----------------------------------------------------------------+---------------------------------------------------------------------+
| 8. Go to ``https://webtop.vlab.f5demo.com`` from the jump host, | |image81|                                                           |
|                                                                 |                                                                     |
|    You can login with any user:                                 |                                                                     |
|                                                                 |                                                                     |
| -  **sales_user**                                               |                                                                     |
|                                                                 |                                                                     |
| -  **sales_manager**                                            |                                                                     |
|                                                                 |                                                                     |
| -  **partner_user**                                             |                                                                     |
|                                                                 |                                                                     |
| You should see an **AWS (SAML)** object that you just created.  |                                                                     |
+-----------------------------------------------------------------+---------------------------------------------------------------------+
| 9. Click on the **AWS** link. You should be able to access      |                                                                     |
| **AWS GUI** because of ``SSO`` **(SAML Federation)**.           | |image82|                                                           |
+-----------------------------------------------------------------+---------------------------------------------------------------------+



.. |image44| image:: /_static/class9/image44.png
.. |image45| image:: /_static/class9/image45.png
.. |image46| image:: /_static/class9/image46.png
.. |image47| image:: /_static/class9/image47.png
.. |image48| image:: /_static/class9/image48.png
.. |image49| image:: /_static/class9/image49.png
.. |image50| image:: /_static/class9/image50.png
.. |image51| image:: /_static/class9/image51.png
.. |image52| image:: /_static/class9/image52.png
.. |image53| image:: /_static/class9/image53.png
.. |image54| image:: /_static/class9/image54.png
.. |image55| image:: /_static/class9/image55.png
.. |image56| image:: /_static/class9/image56.png
.. |image56_2| image:: /_static/class9/image56_2.png
.. |image57| image:: /_static/class9/image57.png
.. |image58| image:: /_static/class9/image58.png
.. |image59| image:: /_static/class9/image59.png
.. |image60| image:: /_static/class9/image60.png
.. |image61| image:: /_static/class9/image61.png
.. |image62| image:: /_static/class9/image62.png
.. |image63| image:: /_static/class9/image63.png
.. |image64| image:: /_static/class9/image64.png
.. |image65| image:: /_static/class9/image65.png
.. |image66| image:: /_static/class9/image66.png
.. |image67| image:: /_static/class9/image67.png
.. |image68| image:: /_static/class9/image68.png
.. |image69_2| image:: /_static/class9/image69_2.png
.. |image69| image:: /_static/class9/image69.png
.. |image70| image:: /_static/class9/image70.png
.. |image71| image:: /_static/class9/image71.png
.. |image72| image:: /_static/class9/image72.png
.. |image73| image:: /_static/class9/image73.png
.. |image74| image:: /_static/class9/image74.png
.. |image75| image:: /_static/class9/image75.png
.. |image76| image:: /_static/class9/image76.png
.. |image77| image:: /_static/class9/image77.png
.. |image78| image:: /_static/class9/image78.png
.. |image79| image:: /_static/class9/image79.png
.. |image80| image:: /_static/class9/image80.png
.. |image81| image:: /_static/class9/image81.png
.. |image82| image:: /_static/class9/image82.png
