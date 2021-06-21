Lab –  Set up DUO as Second Auth Factor
---------------------------------------

This lab will teach you how to configure DUO as Second Auth Factor.
Estimated completion time: **30 minutes**

Task - Get the values from DUO Admin Panel
------------------------------------------

+-----------------------------------------------------------------+---------------------------------------------------------------------+
| 1. Log in to the **Duo Admin Panel** and navigate to            |                                                                     |
| **Applications**. Then click on ``F5 BIG-IP APM``.              |                                                                     |
|                                                                 | |image136|                                                          |
+-----------------------------------------------------------------+---------------------------------------------------------------------+
| 2. **Copy** the values for:                                     | |image137|                                                          |
|                                                                 |                                                                     |
|    ``Integration key``                                          |                                                                     |
|                                                                 |                                                                     |
|    ``Secret key``                                               |                                                                     |
|                                                                 |                                                                     |
|    ``API hostname``                                             |                                                                     |
+-----------------------------------------------------------------+---------------------------------------------------------------------+

Task - Configure the Proxy for APM
----------------------------------

+---------------------------------------------------------------------------+---------------------------------------------------------------------+
| 1. In the **Win 7 External** open (``as administrator``) the              |                                                                     |
| file                                                                      |                                                                     |
| **C:\Program Files\Duo Security Authentication Proxy\conf\authproxy.cfg** |                                                                     |
|                                                                           |                                                                     |
|                                                                           | |image138|                                                          |
+---------------------------------------------------------------------------+---------------------------------------------------------------------+
| 1. Search the section **[radius_server_iframe]** and modify the           |                                                                     |
| following values according to your **DUO account**                        | |image139|                                                          |
|                                                                           |                                                                     |
|   - ``ikey``                                                              |                                                                     |
|                                                                           |                                                                     |
|   - ``skey``                                                              |                                                                     |
|                                                                           |                                                                     |
|   - ``api``                                                               |                                                                     |
+---------------------------------------------------------------------------+---------------------------------------------------------------------+

Task - Modify the Access Policy to include DUO
----------------------------------------------

+-----------------------------------------------------------------+---------------------------------------------------------------------+
| 1. Go to **Access** -> **Authentication** -> **RADIUS**         |                                                                     |
| -> **Create.**                                                  | |image140|                                                          |
+-----------------------------------------------------------------+---------------------------------------------------------------------+
| 2. Create a new record, using the following info and            |                                                                     |
| then **Finished.**                                              | |image141|                                                          |
|                                                                 |                                                                     |
|     **Name**: ``DUO_RADIUS``                                    |                                                                     |
|                                                                 |                                                                     |
|     **Mode:** ``Authentication``                                |                                                                     |
|                                                                 |                                                                     |
|     **Server Connection:** ``Direct``                           |                                                                     |
|                                                                 |                                                                     |
|     **Server Address:** ``10.1.10.199``                         |                                                                     |
|                                                                 |                                                                     |
|     **Authentication Service Port:** ``1812``                   |                                                                     |
|                                                                 |                                                                     |
|     **Secret:** ``password``                                    |                                                                     |
|                                                                 |                                                                     |
|     **Confirm Secret:** ``password``                            |                                                                     |
|                                                                 |                                                                     |
|     **Timeout:** ``60``                                         |                                                                     |
+-----------------------------------------------------------------+---------------------------------------------------------------------+
| 3. Go to **Access** -> **Profile / Policies** ->                |                                                                     |
| **Access Profile** then locate the **webtop_demo** profile      |                                                                     |
| and click **Edit**.                                             | |image142|                                                          |
+-----------------------------------------------------------------+---------------------------------------------------------------------+
| 4. Click on **Add New Macro**                                   | |image143|                                                          |
+-----------------------------------------------------------------+---------------------------------------------------------------------+
| 5. Name it ``DUO`` and **Save**                                 | |image144|                                                          |
+-----------------------------------------------------------------+---------------------------------------------------------------------+
| 6. **Click** on the ``+`` between **In** and **Out**            | |image145|                                                          |
+-----------------------------------------------------------------+---------------------------------------------------------------------+
| 7. Under the **Authentication tab**, search for **RADIUS Auth** |                                                                     |
| and click **Add Item**                                          | |image146|                                                          |
|                                                                 |                                                                     |
|                                                                 | |image147|                                                          |
+-----------------------------------------------------------------+---------------------------------------------------------------------+
| 8. Create a new record, using the following info                |                                                                     |
| (leave the defaults) and then **Save.**                         | |image148|                                                          |
|                                                                 |                                                                     |
|     **Name:** ``DUO AUTH``                                      |                                                                     |
|                                                                 |                                                                     |
|     **AAA Server:** ``/Common/DUO_RADIUS``                      |                                                                     |
+-----------------------------------------------------------------+---------------------------------------------------------------------+
| 9. Go to the **Macro DUO** and click on **Edit Terminals**.     |                                                                     |
| Then **Add Terminal** and **Rename** the terminals according    |                                                                     |
| to the image. Also **change the order.**                        | |image149|                                                          |
|                                                                 |                                                                     |
|                                                                 | |image150|                                                          |
+-----------------------------------------------------------------+---------------------------------------------------------------------+
| 10. **Click** on the ``+`` between **AD Auth** and              |                                                                     |
| **Get Ga Code**                                                 | |image151|                                                          |
+-----------------------------------------------------------------+---------------------------------------------------------------------+
| 11. Under the **General Purpose** tab, choose **Decision Box**  |                                                                     |
| and then **Add Item**                                           | |image152|                                                          |
+-----------------------------------------------------------------+---------------------------------------------------------------------+
| 12. Create a new record, using the following info               |                                                                     |
| (leave the defaults).                                           | |image153|                                                          |
|                                                                 |                                                                     |
|     **Name:** ``MFA DECISION``                                  |                                                                     |
|                                                                 |                                                                     |
|     **Message:** ``Choose one of the following two factor ...`` |                                                                     |
|                                                                 |                                                                     |
|     **Option 1:** ``GOOGLE``                                    |                                                                     |
|                                                                 |                                                                     |
|     **Option 2:** ``DUO``                                       |                                                                     |
+-----------------------------------------------------------------+---------------------------------------------------------------------+
| 13. Under the **Branch Rules** tab change the name              |                                                                     |
| to ``GOOGLE`` and then **Save**.                                | |image154|                                                          |
+-----------------------------------------------------------------+---------------------------------------------------------------------+
| 14. **Click** on the ``+`` in front of the                      |                                                                     |
| **MFA DECISION fallback** branch.                               | |image155|                                                          |
+-----------------------------------------------------------------+---------------------------------------------------------------------+
| 15. Choose ``DUO`` under the **Macros tab**, then **Add Item**. | |image156|                                                          |
+-----------------------------------------------------------------+---------------------------------------------------------------------+
| 16. **Click** on the ``+`` in front of the **DUO Successful**   |                                                                     |
| branch.                                                         | |image157|                                                          |
+-----------------------------------------------------------------+---------------------------------------------------------------------+
| 17. Under the **Authentication** tab, choose **AD Query** and   |                                                                     |
| then **Add Item**                                               | |image158|                                                          |
+-----------------------------------------------------------------+---------------------------------------------------------------------+
| 18. Create a new record, using the following info               |                                                                     |
| (leave the defaults).                                           | |image159|                                                          |
|                                                                 |                                                                     |
|     **Name:** ``AD Query DUO``                                  |                                                                     |
|                                                                 |                                                                     |
|     **Server:** ``/Common/webtop_demo_aaa_srvr``                |                                                                     |
+-----------------------------------------------------------------+---------------------------------------------------------------------+
| 19. Under the **Branch Rules** tab, click on **change**         |                                                                     |
| Expression.                                                     | |image160|                                                          |
+-----------------------------------------------------------------+---------------------------------------------------------------------+
| 20. **Delete** the expression by click on the ``X`` symbol.     | |image161|                                                          |
+-----------------------------------------------------------------+---------------------------------------------------------------------+
| 21. Create a new expression, using the following info           |                                                                     |
| (leave the defaults), then click **Add Expression** and         |                                                                     |
| **Save**                                                        | |image162|                                                          |
|                                                                 |                                                                     |
|     **Agent Sel:** ``AD Auth``                                  |                                                                     |
|                                                                 |                                                                     |
|     **Condition:** ``AD Auth Passed``                           |                                                                     |
|                                                                 |                                                                     |
|     **Active Directory Auth has:** ``Passed``                   |                                                                     |
+-----------------------------------------------------------------+---------------------------------------------------------------------+
| 22. Click on the **AD Query DUO** box, then go to               |                                                                     |
| **Branch Rules** tab and modify the name to **Passed Query**    |                                                                     |
| and **Save**                                                    | |image163|                                                          |
|                                                                 |                                                                     |
|                                                                 | |image164|                                                          |
+-----------------------------------------------------------------+---------------------------------------------------------------------+
| 23. **Click** on the ``+`` in front of the                      |                                                                     |
| **AD QUERY DUO Passed Query** branch.                           | |image165|                                                          |
+-----------------------------------------------------------------+---------------------------------------------------------------------+
| 24. Under the **Assignment** tab choose                         |                                                                     |
| **Advanced Resource Assign**, then **Add Item**                 | |image166|                                                          |
+-----------------------------------------------------------------+---------------------------------------------------------------------+
| 25. Click on **Add new entry**                                  | |image167|                                                          |
+-----------------------------------------------------------------+---------------------------------------------------------------------+
| 26. Click on **Add/Delete**                                     | |image168|                                                          |
+-----------------------------------------------------------------+---------------------------------------------------------------------+
| 27. Add the following resources and then **Save**               | |image169|                                                          |
|                                                                 |                                                                     |
|     **Portal Access:** ``portal_intranet``                      |                                                                     |
|                                                                 |                                                                     |
|     **SAML:** ``AWS_SAML_DEMO, SALESFORCE_SAML_DEMO``           |                                                                     |
|                                                                 |                                                                     |
|     **Webtop:** ``webtop_demo_webtop``                          |                                                                     |
+-----------------------------------------------------------------+---------------------------------------------------------------------+
| 28. Change the ending to **Allow** and click on                 |                                                                     |
| **Apply Access Policy.**                                        | |image170|                                                          |
+-----------------------------------------------------------------+---------------------------------------------------------------------+

Task - Configure the APM to use the DUO Service
-----------------------------------------------

+---------------------------------------------------------------------------------------------------+---------------------------------------------------------------------+
| 1. Go to **Access** -> **Profiles / Policies** ->                                                 |                                                                     |
| **Customization** -> **Advanced**                                                                 |                                                                     |
|                                                                                                   | |image171|                                                          |
+---------------------------------------------------------------------------------------------------+---------------------------------------------------------------------+
| 2. Navigate to **Access Profiles** -> **/Common/webtop_demo**                                     |                                                                     |
| -> **Common** -> **header.inc** and insert the line                                               |                                                                     |
| ``<script src="https://api-XXXXXXXX.duosecurity.com/frame/hosted/Duo-F5-BIG-IP-v2.js"></script>`` |                                                                     |
| at the end of file and then **Save**.                                                             | |image172|                                                          |
|                                                                                                   |                                                                     |
| **NOTE:** Use the ``api URL`` from your ``DUO account``.                                          |                                                                     |
+---------------------------------------------------------------------------------------------------+---------------------------------------------------------------------+
| 3. Click on **Apply Access Policy**                                                               | |image173|                                                          |
+---------------------------------------------------------------------------------------------------+---------------------------------------------------------------------+
| 4. Restart the Proxy DUO Service. Go to **Start** -> **Services** and then click ``Restart``      | |image174|                                                          |
+---------------------------------------------------------------------------------------------------+---------------------------------------------------------------------+
| 5. Go to ``https://webtop.vlab.f5demo.com``. You should see the **Google Authenticator** and      |                                                                     |
| **DUO** options to use as ``Second Factor``. Try to log in with any user:                         | |image175|                                                          |
|                                                                                                   |                                                                     |
|    - **sales_manager**                                                                            |                                                                     |
|                                                                                                   |                                                                     |
|    - **sales_user**                                                                               |                                                                     |
|                                                                                                   |                                                                     |
|    - **partner_user**                                                                             |                                                                     |
+---------------------------------------------------------------------------------------------------+---------------------------------------------------------------------+

.. |image136| image:: /_static/class9/image136.png
.. |image137| image:: /_static/class9/image137.png
.. |image138| image:: /_static/class9/image138.png
.. |image139| image:: /_static/class9/image139.png
.. |image140| image:: /_static/class9/image140.png
.. |image141| image:: /_static/class9/image141.png
.. |image142| image:: /_static/class9/image142.png
.. |image143| image:: /_static/class9/image143.png
.. |image144| image:: /_static/class9/image144.png
.. |image145| image:: /_static/class9/image145.png
.. |image146| image:: /_static/class9/image146.png
.. |image147| image:: /_static/class9/image147.png
.. |image148| image:: /_static/class9/image148.png
.. |image149| image:: /_static/class9/image149.png
.. |image150| image:: /_static/class9/image150.png
.. |image151| image:: /_static/class9/image151.png
.. |image152| image:: /_static/class9/image152.png
.. |image153| image:: /_static/class9/image153.png
.. |image154| image:: /_static/class9/image154.png
.. |image155| image:: /_static/class9/image155.png
.. |image156| image:: /_static/class9/image156.png
.. |image157| image:: /_static/class9/image157.png
.. |image158| image:: /_static/class9/image158.png
.. |image159| image:: /_static/class9/image159.png
.. |image160| image:: /_static/class9/image160.png
.. |image161| image:: /_static/class9/image161.png
.. |image162| image:: /_static/class9/image162.png
.. |image163| image:: /_static/class9/image163.png
.. |image164| image:: /_static/class9/image164.png
.. |image165| image:: /_static/class9/image165.png
.. |image166| image:: /_static/class9/image166.png
.. |image167| image:: /_static/class9/image167.png
.. |image168| image:: /_static/class9/image168.png
.. |image169| image:: /_static/class9/image169.png
.. |image170| image:: /_static/class9/image170.png
.. |image171| image:: /_static/class9/image171.png
.. |image172| image:: /_static/class9/image172.png
.. |image173| image:: /_static/class9/image173.png
.. |image174| image:: /_static/class9/image174.png
.. |image175| image:: /_static/class9/image175.png
