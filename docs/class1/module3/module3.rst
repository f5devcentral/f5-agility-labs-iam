Lab 3 – Kerberos to SAML Lab
============================

.. toctree::
   :maxdepth: 1
   :glob:

The purpose of this lab is to deploy and test a Kerberos to SAML
configuration. Students will modify a previous built Access Policy and
create a seamless access experience from Kerberos to SAML for connecting
users. This lab will leverage the work performed previously in Lab 2.
Archive files are available for the completed Lab 2.

Objective:

-  Gain an understanding of the Kerberos to SAML relationship its
   component parts.

-  Develop an awareness of the different deployment models that Kerberos
   to SAML authentication opens up

Lab Requirements:

-  All Lab requirements will be noted in the tasks that follow

Estimated completion time: 25 minutes

TASK 1 – Modify the SAML Identity Provider (IdP) Access Policy
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

1. Using the existing Access Policy from Lab 2, navigate to **Access ‑> Profiles/Policies ‑> Access Profiles (Per-Session Policies)**, and click the **Edit** link next to the previously created *idp.f5demo.com-policy*

|image70|

2. Delete the **Logon Page** object by clicking on the **X** as shown

|image71|

3. In the resulting **Item Deletion Confirmation** dialog, ensure that the previous node is connect to the **fallback** branch, and click the **Delete** button

|image72|

4. In the **Visual Policy Editor** window for */Common/idp.f5demo.com‑policy*, click the **Plus (+) Sign** between **Start** and **AD Auth**

|image73|

5. In the pop-up dialog box, select the **Logon** tab and then select the **Radio** next to **HTTP 401 Response**, and click the **Add Item** button

|image74|

6. In the **HTTP 401 Response** dialog box, enter the following information:

+-------------------+-------------------------------+
| Basic Auth Realm: | *f5demo.com*                  |
+-------------------+-------------------------------+
| HTTP Auth Level:  | *basic+negotiate* (drop down) |
+-------------------+-------------------------------+

7. Click the **Save** button at the bottom of the dialog box

|image75|

8. In the **Visual Policy Editor** window for */Common/idp.f5demo.com‑policy*, click the **Plus (+) Sign** on the **Negotiate** branch between **HTTP 401 Response** and **Deny**
9. In the pop-up dialog box, select the **Authentication** tab and then select the **Radio** next to **Kerberos Auth**, and click the **Add Item** button

|image76|

10. In the **Kerberos Auth** dialog box, enter the following information:

+----------------------+-----------------------------------+
| AAA Server:          | */Common/apm-krb-aaa* (drop down) |
+----------------------+-----------------------------------+
| Request Based Auth:  | *Disabled* (drop down)            |
+----------------------+-----------------------------------+

11. Click the **Save** button at the bottom of the dialog box

|image77|

.. NOTE:: The *apm-krb-aaa* object was pre-created for you in this lab. More details on the configuration of Kerberos AAA are included in the Learn More section at the end of this guide.

12. In the **Visual Policy Editor** window for */Common/idp.f5demo.com‑policy*, click the **Plus (+) Sign** on the **Successful** branch between **Kerberos Auth** and **Deny**

|image78|

13. In the pop-up dialog box, select the **Authentication** tab and then select the **Radio** next to **AD Query**, and click the **Add Item** button

|image79|

14. In the resulting **AD Query(1)** pop-up window, select */Commmon/f5demo_ad* from the **Server** drop down menu
15. In the **SearchFilter** field, enter the following value: *userPrincipalName=%{session.logon.last.username}*

|image80|

16. In the **AD Query(1)** window, click the **Branch Rules** tab
17. Change the **Name** of the branch to *Successful*.
18. Click the **Change** link next to the **Expression**

|image81|

19. In the resulting pop-up window, delete the existing expression by clicking the **X** as shown

|image82|

20. Create a new **Simple** expression by clicking the **Add Expression** button

|image83|

21. In the resulting menu, select the following from the drop down menus:

+------------+-------------------+
| Agent Sel: | *AD Query*        |
+------------+-------------------+
| Condition: | *AD Query Passed* |
+------------+-------------------+

22. Click the **Add Expression** Button

|image84|

23. Click the **Finished** button to complete the expression

|image85|

24. Click the **Save** button to complete the **AD Query**

|image86|

25. In the **Visual Policy Editor** window for */Common/idp.f5demo.com‑policy*, click the **Plus (+) Sign** on the **Successful** branch between **AD Query(1)** and **Deny**
26. In the pop-up dialog box, select the **Assignment** tab and then select the **Radio** next to **Advanced Resource Assign**, and click the **Add Item** button

|image87|

27. In the resulting **Advanced Resource Assign(1)** pop-up window, click the **Add New Entry** button
28. In the new Resource Assignment entry, click the **Add/Delete** link

|image88|

29. In the resulting pop-up window, click the **SAML** tab, and select the **Checkbox** next to */Common/partner-app*

|image89|

30. Click the **Webtop** tab, and select the **Checkbox** next to */Common/full_webtop*

|image90|

31. Click the **Update** button at the bottom of the window to complete the Resource Assignment entry
32. Click the **Save** button at the bottom of the **Advanced Resource Assign(1)** window

33. In the **Visual Policy Editor**, select the **Deny** ending on the fallback branch following **Advanced Resource Assign**

|image91|

34. In the **Select Ending** dialog box, selet the **Allow** radio button and then click **Save**

|image92|

35. In the **Visual Policy Editor**, click **Apply Access Policy** (top left), and close the **Visual Policy Editor**

|image93|

TASK 2 - Test the Kerberos to SAML Configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. NOTE:: In the following Lab Task it is recommended that you use Microsoft
  Internet Explorer.  While other browsers also support Kerberos
  (if configured), for the purposes of this Lab Microsoft Internet
  Explorer has been configured and will be used.

1. Using Internet Explorer from the jump host, navigate to the SAML IdP you previously configured at *https://idp.f5demo.com* (or click the provided bookmark)

|image94|

2. Were you prompted for credentials? Were you successfully authenticated? Did you see the webtop with the SP application?
3. Click on the Partner App icon. Were you successfully authenticated (via SAML) to the SP?
4. Review your Active Sessions **(Access ‑> Overview ‑> Active Sessions­­­)**
5. Review your Access Report Logs **(Access ‑> Overview ‑> Access Reports)**

.. |br| raw:: html

   <br />

.. |image70| image:: media/image44.png
.. |image71| image:: media/image70.png
.. |image72| image:: media/image71.png
.. |image73| image:: media/image72.png
.. |image74| image:: media/image73.png
.. |image75| image:: media/image74.png
.. |image76| image:: media/image75.png
.. |image77| image:: media/image76.png
.. |image78| image:: media/image77.png
.. |image79| image:: media/image78.png
.. |image80| image:: media/image79.png
.. |image81| image:: media/image53.png
.. |image82| image:: media/image54.png
.. |image83| image:: media/image80.png
.. |image84| image:: media/image56.png
.. |image85| image:: media/image81.png
.. |image86| image:: media/image58.png
.. |image87| image:: media/image60.png
.. |image88| image:: media/image61.png
.. |image89| image:: media/image62.png
.. |image90| image:: media/image63.png
.. |image91| image:: media/image82.png
.. |image92| image:: media/image65.png
.. |image93| image:: media/image83.png
.. |image94| image:: media/image84.png
