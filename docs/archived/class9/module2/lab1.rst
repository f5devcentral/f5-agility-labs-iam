Lab – Create an APM Policy
--------------------------

This lab will teach you how to create a basic APM Policy using the GUI.
Estimated completion time: **20 minutes**


Task - Setup Virtual Server
---------------------------

+-----------------------------------------------------------------+---------------------------------------------------------------------+
| 1. Go to **Local Traffic** -> **Virtual Servers** -> **Create** | |image17|                                                           |
+-----------------------------------------------------------------+---------------------------------------------------------------------+
| 2. Enter the following values (leave others default)            | |image18|                                                           |
|                                                                 |                                                                     |
|     **Name:** ``webtop_demo_vs``                                |                                                                     |
|                                                                 |                                                                     |
|     **Destination Address:** ``10.1.10.47``                     |                                                                     |
|                                                                 |                                                                     |
|     **Service Port:** ``443``                                   |                                                                     |
|                                                                 |                                                                     |
|     **HTTP Profile:** ``http``                                  |                                                                     |
|                                                                 |                                                                     |
|     **SSL Profile (Client):**  ``f5demo_client_ssl``            |                                                                     |
|                                                                 |                                                                     |
|     **Source Address Translation:**  ``Àutomap``                |                                                                     |
|                                                                 |                                                                     |
+-----------------------------------------------------------------+---------------------------------------------------------------------+

Task - Create a Connectivity Profile
------------------------------------

+-----------------------------------------------------------------+---------------------------------------------------------------------+
| 1. Go to **Access** -> **Connectivity/VPN**                     |                                                                     |
| -> **Profiles -> Add**                                          | |image19|                                                           |
+-----------------------------------------------------------------+---------------------------------------------------------------------+
| 2. Enter the following values (leave others default)            | |image20|                                                           |
|                                                                 |                                                                     |
|     **Name:** ``webtop_demo_cp``                                |                                                                     |
|                                                                 |                                                                     |
|     **Parent Profile:** ``/Common/connectivity``                |                                                                     |
|                                                                 |                                                                     |
+-----------------------------------------------------------------+---------------------------------------------------------------------+

Task - Create an AD Server as AAA
---------------------------------

+-----------------------------------------------------------------+---------------------------------------------------------------------+
| 1. Go to **Access** -> **Authentication**                       |                                                                     |
| -> **Active Directory** -> **Create**                           | |image21|                                                           |
+-----------------------------------------------------------------+---------------------------------------------------------------------+
| 2. Enter the following values (leave others default)            | |image22|                                                           |
|                                                                 |                                                                     |
|     **Name:** ``webtop_demo_aaa_srvr``                          |                                                                     |
|                                                                 |                                                                     |
|     **Domain Name:** ``f5demo.com``                             |                                                                     |
|                                                                 |                                                                     |
|     **Server Connection:** ``Direct``                           |                                                                     |
|                                                                 |                                                                     |
|     **Domain Controller:** ``10.1.20.251``                      |                                                                     |
|                                                                 |                                                                     |
|     **Admin Name:** ``service_account``                         |                                                                     |
|                                                                 |                                                                     |
|     **Admin Password:** ``password``                            |                                                                     |
+-----------------------------------------------------------------+---------------------------------------------------------------------+

Task - Create a container (webtop)
----------------------------------

+-----------------------------------------------------------------+---------------------------------------------------------------------+
| 1. Go to **Access** -> **Webtop** -> **Webtop Lists**           |                                                                     |
| -> **Create**                                                   | |image23|                                                           |
+-----------------------------------------------------------------+---------------------------------------------------------------------+
| 2. Enter the following values (leave others default)            | |image24|                                                           |
|                                                                 |                                                                     |
|     **Name:** ``webtop_demo_webtop``                            |                                                                     |
|                                                                 |                                                                     |
|     **Type:** ``Full``                                          |                                                                     |
+-----------------------------------------------------------------+---------------------------------------------------------------------+

Task - Create a Portal Access
-----------------------------

+-----------------------------------------------------------------+---------------------------------------------------------------------+
| 1. Go to **Access** -> **Connectivity/VPN: Portal Access List** |                                                                     |
| -> **Create**                                                   | |image25|                                                           |
+-----------------------------------------------------------------+---------------------------------------------------------------------+
| 2. Enter the following values (leave others default)            | |image26|                                                           |
|                                                                 |                                                                     |
|     **Name:** ``portal_intranet``                               |                                                                     |
|                                                                 |                                                                     |
|     **Link Type:** ``Application URI``                          |                                                                     |
|                                                                 |                                                                     |
|     **Application URI:** ``http://10.1.20.32``                  |                                                                     |
|                                                                 |                                                                     |
|     **Caption:** ``INTRANET``                                   |                                                                     |
+-----------------------------------------------------------------+---------------------------------------------------------------------+

Task - Setup APM Profile
------------------------

+-----------------------------------------------------------------+---------------------------------------------------------------------+
| 1. Go to **Access** -> **Profiles / Policies**                  |                                                                     |
| -> **Access Profiles (Per Session Policies)** -> **Create**     | |image27|                                                           |
+-----------------------------------------------------------------+---------------------------------------------------------------------+
| 2. Enter the following values (leave others default) then       |                                                                     |
| click **Finished**                                              | |image28|                                                           |
|                                                                 |                                                                     |
|     **Name:** ``webtop_demo``                                   | |image29|                                                           |
|                                                                 |                                                                     |
|     **Profile Type:** ``All``                                   |                                                                     |
|                                                                 |                                                                     |
|     **Profile Scope:** ``Profile``                              |                                                                     |
|                                                                 |                                                                     |
|     **Languages:** ``English``                                  |                                                                     |
+-----------------------------------------------------------------+---------------------------------------------------------------------+
| 3. Click **Edit** for **webtop\_demo**,                         |                                                                     |
| a new browser tab will open                                     | |image30|                                                           |
+-----------------------------------------------------------------+---------------------------------------------------------------------+
| 4. Click the ``+`` between **Start** and **Deny**, select       |                                                                     |
| **Logon Page** from the **Logon** tab, click **Add Item**       | |image31|                                                           |
|                                                                 |                                                                     |
|                                                                 | |image32|                                                           |
+-----------------------------------------------------------------+---------------------------------------------------------------------+
| 5. Enter the following values (leave others default)            |                                                                     |
| then click **Save**                                             | |image33|                                                           |
|                                                                 |                                                                     |
|     **Form Header Text:**                                       |                                                                     |
|     Secure Logon <br> for ``"your demo organization"``          |                                                                     |
+-----------------------------------------------------------------+---------------------------------------------------------------------+
| 6. Click the ``+`` between **Logon Page** and **Deny**,         |                                                                     |
| select **AD Auth** from the **Authentication** tab,             |                                                                     |
| click **Add Item**                                              | |image34|                                                           |
+-----------------------------------------------------------------+---------------------------------------------------------------------+
| 7. Change the **Server** to ``/Common/webtop_demo_aaa_srvr``,   |                                                                     |
| then click **Save**                                             | |image35|                                                           |
+-----------------------------------------------------------------+---------------------------------------------------------------------+
| 8. Change the **AD Auth Successful** branch ending to **Allow**,|                                                                     |
| then click **Save**                                             | |image36|                                                           |
|                                                                 |                                                                     |
|                                                                 | |image37|                                                           |
+-----------------------------------------------------------------+---------------------------------------------------------------------+
| 9. Click the ``+`` between **AD Auth** and **Allow**,           |                                                                     |
| select **Advanced Resource Assign** from the **Assigment** tab, |                                                                     |
| click **Add Item**                                              | |image38|                                                           |
+-----------------------------------------------------------------+---------------------------------------------------------------------+
| 10. Click on **Add new Entry**, then for the new **Expression**,|                                                                     | 
| click **Add/Delete**. Add the following resources,              |                                                                     |
| and then click **Update** and **Save**                          | |image39|                                                           |
|                                                                 |                                                                     |
| -  Portal Access: ``/Common/portal_intranet``                   | |image40|                                                           |
|                                                                 |                                                                     |
| -  Webtop: ``/Common/webtop_demo_webtop``                       |                                                                     |
+-----------------------------------------------------------------+---------------------------------------------------------------------+
| 11. Click **Apply Access Policy** in the top left               |                                                                     |
| and then close the browser tab                                  | |image41|                                                           |
+-----------------------------------------------------------------+---------------------------------------------------------------------+

Task - Add the Access Policy to the Virtual Server
--------------------------------------------------

+-----------------------------------------------------------------+---------------------------------------------------------------------+
| 1. Go to **Local Traffic** -> **Virtual Servers**               |                                                                     |
| -> **webtop__demo_vs**                                          | |image42|                                                           |
+-----------------------------------------------------------------+---------------------------------------------------------------------+
| 2. Modify the **Rewrite Profile** setting to rewrite,           |                                                                     |
| **Access Profile** to ``webtop_demo`` and                       |                                                                     |
| **Connectivity Profile** to ``webtop_demo_cp``,                 |                                                                     |
| then click **Update**                                           | |image43|                                                           |
+-----------------------------------------------------------------+---------------------------------------------------------------------+
| 3. Test access to ``https://webtop.vlab.f5demo.com``            |                                                                     |
| (you can use the bookmark in Chrome) from the jump host,        |                                                                     |
| you should see a logon page.                                    |                                                                     |
|                                                                 |                                                                     |
|    You can login with any user:                                 |                                                                     |
|                                                                 |                                                                     |
| -  **sales_user**                                               |                                                                     |
|                                                                 |                                                                     |
| -  **sales_manager**                                            |                                                                     |
|                                                                 |                                                                     |
| -  **partner_user**                                             |                                                                     |
+-----------------------------------------------------------------+---------------------------------------------------------------------+


.. |image17| image:: /_static/class9/image17.png
.. |image18| image:: /_static/class9/image18.png
.. |image19| image:: /_static/class9/image19.png
.. |image20| image:: /_static/class9/image20.png
.. |image21| image:: /_static/class9/image21.png
.. |image22| image:: /_static/class9/image22.png
.. |image23| image:: /_static/class9/image23.png
.. |image24| image:: /_static/class9/image24.png
.. |image25| image:: /_static/class9/image25.png
.. |image26| image:: /_static/class9/image26.png
.. |image27| image:: /_static/class9/image27.png
.. |image28| image:: /_static/class9/image28.png
.. |image29| image:: /_static/class9/image29.png
.. |image30| image:: /_static/class9/image30.png
.. |image31| image:: /_static/class9/image31.png
.. |image32| image:: /_static/class9/image32.png
.. |image33| image:: /_static/class9/image33.png
.. |image34| image:: /_static/class9/image34.png
.. |image35| image:: /_static/class9/image35.png
.. |image36| image:: /_static/class9/image36.png
.. |image37| image:: /_static/class9/image37.png
.. |image38| image:: /_static/class9/image38.png
.. |image39| image:: /_static/class9/image39.png
.. |image40| image:: /_static/class9/image40.png
.. |image41| image:: /_static/class9/image41.png
.. |image42| image:: /_static/class9/image42.png
.. |image43| image:: /_static/class9/image43.png
