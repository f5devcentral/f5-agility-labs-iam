Lab –  Set up Google Authenticator (GA)
---------------------------------------

This lab will teach you how to configure Google Authenticator as Second Auth Factor.
Estimated completion time: **30 minutes**

Task - Create the VS used to generate GA tokens
-----------------------------------------------

+-----------------------------------------------------------------+---------------------------------------------------------------------+
| 1. Log in to the BIG IP then go to **Local Traffic** ->         |                                                                     |
| **Virtual Servers** -> **Virtual Server List**. Click on        |                                                                     |
| **Create**.                                                     |                                                                     |
|                                                                 |                                                                     |
|                                                                 | |image104|                                                          |
+-----------------------------------------------------------------+---------------------------------------------------------------------+
| 2. Enter the following values (leave others default) and then   |                                                                     |
| **finished.**                                                   | |image105|                                                          |
|                                                                 |                                                                     |
|     **Name:** ``VS_GENERATE_TOKEN``                             | |image106|                                                          |
|                                                                 |                                                                     |
|     **Destination Address:** ``10.1.10.80``                     |                                                                     |
|                                                                 |                                                                     |
|     **Service Port:** ``443``                                   |                                                                     |
|                                                                 |                                                                     |
|     **HTTP Profile:** ``http``                                  |                                                                     |
|                                                                 |                                                                     |
|     **SSL Profile (Client):** ``f5demo_client_ssl``             |                                                                     |
|                                                                 |                                                                     |
|     **iRules:** ``generate_ga_code``                            |                                                                     |
+-----------------------------------------------------------------+---------------------------------------------------------------------+

Task - Generate a token
-----------------------

+-----------------------------------------------------------------+---------------------------------------------------------------------+
| 1. Open a **Chrome** browser and click on                       |                                                                     |
| **generategacode bookmark.** You should see the                 |                                                                     |
| **GA generator App**.                                           | |image107|                                                          |
+-----------------------------------------------------------------+---------------------------------------------------------------------+
| 2. Enter the **account:** ``sales_manager`` and **domain:**     |                                                                     |
| ``f5demo.com``. Also **check** the **generate QR code**,        |                                                                     |
| and then click **Submit**                                       | |image108|                                                          |
+-----------------------------------------------------------------+---------------------------------------------------------------------+
| 3. Open up your **Google Authenticator** app and touch          |                                                                     |
| the **“plus sign”**, select scan barcode and **scan** the       |                                                                     |
| **QR code**. Save the **secret**, we will need it soon.         | |image109|                                                          |
+-----------------------------------------------------------------+---------------------------------------------------------------------+
| 4. Go to **Local Traffic** -> **iRules** -> **Data Group List** |                                                                     |
| .Click on **google_auth_keys**.                                 | |image110|                                                          |
+-----------------------------------------------------------------+---------------------------------------------------------------------+
| 5. Create a new record, using the info saved in **step 3**.     |                                                                     |
| Click **Add** and then **Update.**                              | |image111|                                                          |
|                                                                 |                                                                     |
|     **String:** ``sales_manager``                               |                                                                     |
|                                                                 |                                                                     |
|     **Value:** ``use the secret ie (G4ZEIWDJLBJE4ZCM)``         |                                                                     |
+-----------------------------------------------------------------+---------------------------------------------------------------------+
| 6. Repeat the steps **1 to 5**, for the users:                  | |image112|                                                          |
|                                                                 |                                                                     |
|    **sales_user** and **partner_user**                          |                                                                     |
+-----------------------------------------------------------------+---------------------------------------------------------------------+

Task - Update the VS with the verification iRule
------------------------------------------------

+-----------------------------------------------------------------+---------------------------------------------------------------------+
| 1. Go to **Local Traffic** -> **Virtual Servers** ->            |                                                                     |
| **Virtual Server List**, then find the Virtual Server           |                                                                     |
| **webtop_demo_vs** and **click on** it.                         | |image113|                                                          |
+-----------------------------------------------------------------+---------------------------------------------------------------------+
| 2. In the following page, choose **Resources** and click on     |                                                                     |
| **manage** in the **iRules** section                            | |image114|                                                          |
+-----------------------------------------------------------------+---------------------------------------------------------------------+
| 3. Find the **ga_code_verify** irule in the right list and      |                                                                     |
| **click on the arrows** pointing left. The irule should now     |                                                                     |
| moved to the left side. Then Click **finished**.                | |image115|                                                          |
+-----------------------------------------------------------------+---------------------------------------------------------------------+

Task - Update the Access Policy
-------------------------------

+----------------------------------------------------------------------+---------------------------------------------------------------------+
| 1. Go to **Access** -> **Profiles/Policies** ->                      |                                                                     |
| **Access Profiles.** Find the **webtop_demo** policy and             |                                                                     |
| click on **Edit**.                                                   | |image116|                                                          |
+----------------------------------------------------------------------+---------------------------------------------------------------------+
| 2. In the **VPE** (Visual Policy Editor), click the ``+``            |                                                                     |
| between **AD Auth** and **AD Query.**                                | |image117|                                                          |
+----------------------------------------------------------------------+---------------------------------------------------------------------+
| 3. In the **Logon tab**, choose **Logon Page** and then **Add Item** |                                                                     |
|                                                                      | |image118|                                                          |
+----------------------------------------------------------------------+---------------------------------------------------------------------+
| 4. **Modify** the values according to the picture                    |                                                                     |
| (leave others default) and then **Save.**                            | |image119|                                                          |
|                                                                      |                                                                     |
|     **Name:** ``Get Ga Code``                                        |                                                                     |
|                                                                      |                                                                     |
|     **Post Variabl:e** ``ga_code_attempt``                           |                                                                     |
|                                                                      |                                                                     |
|     **Session Variable:** ``ga_code_attempt``                        |                                                                     |
|                                                                      |                                                                     |
|     **Form Header Text:** ``Empty``                                  |                                                                     |
|                                                                      |                                                                     |
|     **Logon Page Input Field:** ``Google Authenticator Token``       |                                                                     |
|                                                                      |                                                                     |
|     **Logon Button:** ``Submit``                                     |                                                                     |
+----------------------------------------------------------------------+---------------------------------------------------------------------+
| 5. Click on **Add New Macro**, name it as                            |                                                                     |
| ``Verify Google Token`` and click **Save**                           | |image120|                                                          |
|                                                                      |                                                                     |
|                                                                      | |image121|                                                          |
+----------------------------------------------------------------------+---------------------------------------------------------------------+
| 6. Click on **Edit Terminals** in the **Macro Settings**             | |image122|                                                          |
|                                                                      |                                                                     |
|                                                                      | |image123|                                                          |
+----------------------------------------------------------------------+---------------------------------------------------------------------+
| 7. Click on **Add Terminal**, and name the terminal **Failure**.     | |image124|                                                          |
+----------------------------------------------------------------------+---------------------------------------------------------------------+
| 8. **Rename** the terminal called Out to **Successful**              | |image125|                                                          |
+----------------------------------------------------------------------+---------------------------------------------------------------------+
| 9. Click on the **Set default** tab and set the default to           |                                                                     |
| ``Failure``, then **Save**                                           | |image126|                                                          |
+----------------------------------------------------------------------+---------------------------------------------------------------------+
| 10. Change the order in the terminals using the arrows,              |                                                                     |
| **Successful** should be the number one.                             | |image127|                                                          |
+----------------------------------------------------------------------+---------------------------------------------------------------------+
| 11. **Edit** the new macro by clicking on the ``+``                  |                                                                     |
| in the **macro settings**                                            | |image128|                                                          |
+----------------------------------------------------------------------+---------------------------------------------------------------------+
| 12. Go to the **General Purpose** Tab, click on                      |                                                                     |
| **iRule Event** and then **Add Item**                                | |image129|                                                          |
+----------------------------------------------------------------------+---------------------------------------------------------------------+
| 13. Name it ``Google Auth Verification`` and use the                 |                                                                     |
| **ID** ``ga_code_verify``.                                           | |image130|                                                          |
+----------------------------------------------------------------------+---------------------------------------------------------------------+
| 14. Then **click** on **Branch Rules**, **Add Branch Rule**.         |                                                                     |
| Name and change the expression (**advanced tab**) according          |                                                                     |
| to the image. Then **Save**                                          | |image131|                                                          |
|                                                                      |                                                                     |
| **Name:** ``Successful``                                             |                                                                     |
|                                                                      |                                                                     |
| **Expression:** ``expr { [mcget {session.custom.ga_result}] == 0 }`` |                                                                     |
|                                                                      |                                                                     |
| **Name:** ``No Google Auth Key Found``                               |                                                                     |
|                                                                      |                                                                     |
| **Expression:** ``expr { [mcget {session.custom.ga_result}] == 2 }`` |                                                                     |
|                                                                      |                                                                     |
| **Name:** ``Invalid Google Auth Key``                                |                                                                     |
|                                                                      |                                                                     |
| **Expression:** ``expr { [mcget {session.custom.ga_result}] == 3 }`` |                                                                     |
|                                                                      |                                                                     |
| **Name:** ``User locked out``                                        |                                                                     |
|                                                                      |                                                                     |
| **Expression:** ``expr { [mcget {session.custom.ga_result}] == 4 }`` |                                                                     |
|                                                                      |                                                                     |
| **Note:** ``It’s very important the order.``                         |                                                                     |
+----------------------------------------------------------------------+---------------------------------------------------------------------+
| 15. Click on the terminals and **set Successful to Successful**      |                                                                     |
| and **the rest to Failure**                                          | |image132|                                                          |
+----------------------------------------------------------------------+---------------------------------------------------------------------+
| 16. Now, we’re going to insert the Macro in the main policy.         |                                                                     |
| **Click** on the ``+`` between **Get Ga Code** and **AD Query**.     | |image133|                                                          |
+----------------------------------------------------------------------+---------------------------------------------------------------------+
| 17. Click on the **Macros Tab** and select your                      |                                                                     |
| **Verify Google Token** macro, then click **Add Item**. Click on     |                                                                     |
| **Apply Policy**                                                     | |image134|                                                          |
+----------------------------------------------------------------------+---------------------------------------------------------------------+
| 18. Go to ``https://webtop.vlab.f5demo.com`` from the jump host,     | |image135|                                                          |
|                                                                      |                                                                     |
|    You can login with any user:                                      |                                                                     |
|                                                                      |                                                                     |
| -  **sales_user**                                                    |                                                                     |
|                                                                      |                                                                     |
| -  **sales_manager**                                                 |                                                                     |
|                                                                      |                                                                     |
| -  **partner_user**                                                  |                                                                     |
|                                                                      |                                                                     |
| You should see the ``Google Authenticator`` page as                  |                                                                     |
| ``Second Auth Factor``.                                              |                                                                     |
+----------------------------------------------------------------------+---------------------------------------------------------------------+

.. |image104| image:: /_static/class9/image104.png
.. |image105| image:: /_static/class9/image105.png
.. |image106| image:: /_static/class9/image106.png
.. |image107| image:: /_static/class9/image107.png
.. |image108| image:: /_static/class9/image108.png
.. |image109| image:: /_static/class9/image109.png
.. |image110| image:: /_static/class9/image110.png
.. |image111| image:: /_static/class9/image111.png
.. |image112| image:: /_static/class9/image112.png
.. |image113| image:: /_static/class9/image113.png
.. |image114| image:: /_static/class9/image114.png
.. |image115| image:: /_static/class9/image115.png
.. |image116| image:: /_static/class9/image116.png
.. |image117| image:: /_static/class9/image117.png
.. |image118| image:: /_static/class9/image118.png
.. |image119| image:: /_static/class9/image119.png
.. |image120| image:: /_static/class9/image120.png
.. |image121| image:: /_static/class9/image121.png
.. |image122| image:: /_static/class9/image122.png
.. |image123| image:: /_static/class9/image123.png
.. |image124| image:: /_static/class9/image124.png
.. |image125| image:: /_static/class9/image125.png
.. |image126| image:: /_static/class9/image126.png
.. |image127| image:: /_static/class9/image127.png
.. |image128| image:: /_static/class9/image128.png
.. |image129| image:: /_static/class9/image129.png
.. |image130| image:: /_static/class9/image130.png
.. |image131| image:: /_static/class9/image131.png
.. |image132| image:: /_static/class9/image132.png
.. |image133| image:: /_static/class9/image133.png
.. |image134| image:: /_static/class9/image134.png
.. |image135| image:: /_static/class9/image135.png
