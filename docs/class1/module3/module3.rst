Lab 3: Kerberos to SAML Lab
===========================

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

#. Using the existing Access Policy from Lab 2, navigate to **Access ‑>
   Profiles/Policies ‑> Access Profiles (Per-Session Policies)**, and click
   the **Edit** link next to the previously created *idp.f5demo.com-policy*

   |image70|

#. Delete the **Logon Page** object by clicking on the **X** as shown

   |image71|

#. In the resulting **Item Deletion Confirmation** dialog, ensure that the
   previous node is connect to the **fallback** branch, and click the
   **Delete** button

   |image72|

#. In the **Visual Policy Editor** window for ``/Common/idp.f5demo.com‑policy``,
   click the **Plus (+) Sign** between **Start** and **AD Auth**

   |image73|

#. In the pop-up dialog box, select the **Logon** tab and then select the
   **Radio** next to **HTTP 401 Response**, and click the **Add Item** button

   |image74|

#. In the **HTTP 401 Response** dialog box, enter the following information:

   +-------------------+---------------------------------+
   | Basic Auth Realm: | ``f5demo.com``                  |
   +-------------------+---------------------------------+
   | HTTP Auth Level:  | ``basic+negotiate`` (drop down) |
   +-------------------+---------------------------------+

#. Click the **Save** button at the bottom of the dialog box

   |image75|

#. In the **Visual Policy Editor** window for ``/Common/idp.f5demo.com‑policy``,
   click the **Plus (+) Sign** on the **Negotiate** branch between
   **HTTP 401 Response** and **Deny**

#. In the pop-up dialog box, select the **Authentication** tab and then
   select the **Radio** next to **Kerberos Auth**, and click the
   **Add Item** button

   |image76|

#. In the **Kerberos Auth** dialog box, enter the following information:

   +----------------------+-------------------------------------+
   | AAA Server:          | ``/Common/apm-krb-aaa`` (drop down) |
   +----------------------+-------------------------------------+
   | Request Based Auth:  | ``Disabled`` (drop down)            |
   +----------------------+-------------------------------------+

#. Click the **Save** button at the bottom of the dialog box

   |image77|

   .. NOTE:: The *apm-krb-aaa* object was pre-created for you in this lab.
      More details on the configuration of Kerberos AAA are included in
      the Learn More section at the end of this guide.

#. In the **Visual Policy Editor** window for
   ``/Common/idp.f5demo.com‑policy``, click the **Plus (+) Sign** on the
   **Successful** branch between **Kerberos Auth** and **Deny**

   |image78|

#. In the pop-up dialog box, select the **Authentication** tab and then
   select the **Radio** next to **AD Query**, and click the **Add Item** button

   |image79|

#. In the resulting **AD Query(1)** pop-up window, select
   ``/Commmon/f5demo_ad`` from the **Server** drop down menu

#. In the **SearchFilter** field, enter the following value:
   ``userPrincipalName=%{session.logon.last.username}``

   |image80|

#. In the **AD Query(1)** window, click the **Branch Rules** tab

#. Change the **Name** of the branch to *Successful*.

#. Click the **Change** link next to the **Expression**

   |image81|

#. In the resulting pop-up window, delete the existing expression by clicking
   the **X** as shown

   |image82|

#. Create a new **Simple** expression by clicking the **Add Expression** button

   |image83|

#. In the resulting menu, select the following from the drop down menus:

   +------------+---------------------+
   | Agent Sel: | ``AD Query``        |
   +------------+---------------------+
   | Condition: | ``AD Query Passed`` |
   +------------+---------------------+

#. Click the **Add Expression** Button

   |image84|

#. Click the **Finished** button to complete the expression

   |image85|

#. Click the **Save** button to complete the **AD Query**

   |image86|

#. In the **Visual Policy Editor** window for ``/Common/idp.f5demo.com‑policy``,
   click the **Plus (+) Sign** on the **Successful** branch between
   **AD Query(1)** and **Deny**

#. In the pop-up dialog box, select the **Assignment** tab and then select
   the **Radio** next to **Advanced Resource Assign**, and click the
   **Add Item** button

   |image87|

#. In the resulting **Advanced Resource Assign(1)** pop-up window, click
   the **Add New Entry** button

#. In the new Resource Assignment entry, click the **Add/Delete** link

   |image88|

#. In the resulting pop-up window, click the **SAML** tab, and select the
   **Checkbox** next to */Common/partner-app*

   |image89|

#. Click the **Webtop** tab, and select the **Checkbox** next to
   ``/Common/full_webtop``

   |image90|

#. Click the **Update** button at the bottom of the window to complete
   the Resource Assignment entry

#. Click the **Save** button at the bottom of the
   **Advanced Resource Assign(1)** window

#. In the **Visual Policy Editor**, select the **Deny** ending on the
   fallback branch following **Advanced Resource Assign**

   |image91|

#. In the **Select Ending** dialog box, selet the **Allow** radio button
   and then click **Save**

   |image92|

#. In the **Visual Policy Editor**, click **Apply Access Policy**
   (top left), and close the **Visual Policy Editor**

   |image93|

TASK 2 - Test the Kerberos to SAML Configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. NOTE:: In the following Lab Task it is recommended that you use Microsoft
   Internet Explorer.  While other browsers also support Kerberos
   (if configured), for the purposes of this Lab Microsoft Internet
   Explorer has been configured and will be used.

#. Using Internet Explorer from the jump host, navigate to the SAML IdP you
   previously configured at *https://idp.f5demo.com* (or click the
   provided bookmark)

   |image94|

#. Were you prompted for credentials? Were you successfully authenticated?
   Did you see the webtop with the SP application?

#. Click on the Partner App icon. Were you successfully authenticated
   (via SAML) to the SP?

#. Review your Active Sessions **(Access ‑> Overview ‑> Active Sessions­­­)**

#. Review your Access Report Logs **(Access ‑> Overview ‑> Access Reports)**

.. |br| raw:: html

   <br />

.. |image70| image:: /_static/class1/image44.png
.. |image71| image:: /_static/class1/image70.png
.. |image72| image:: /_static/class1/image71.png
.. |image73| image:: /_static/class1/image72.png
.. |image74| image:: /_static/class1/image73.png
.. |image75| image:: /_static/class1/image74.png
.. |image76| image:: /_static/class1/image75.png
.. |image77| image:: /_static/class1/image76.png
.. |image78| image:: /_static/class1/image77.png
.. |image79| image:: /_static/class1/image78.png
.. |image80| image:: /_static/class1/image79.png
.. |image81| image:: /_static/class1/image53.png
.. |image82| image:: /_static/class1/image54.png
.. |image83| image:: /_static/class1/image80.png
.. |image84| image:: /_static/class1/image56.png
.. |image85| image:: /_static/class1/image81.png
.. |image86| image:: /_static/class1/image58.png
.. |image87| image:: /_static/class1/image60.png
.. |image88| image:: /_static/class1/image61.png
.. |image89| image:: /_static/class1/image62.png
.. |image90| image:: /_static/class1/image63.png
.. |image91| image:: /_static/class1/image82.png
.. |image92| image:: /_static/class1/image65.png
.. |image93| image:: /_static/class1/image83.png
.. |image94| image:: /_static/class1/image84.png
