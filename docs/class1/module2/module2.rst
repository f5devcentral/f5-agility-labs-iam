Lab 2 - SAML Identity Provider (IdP) Lab
========================================

.. toctree::
   :maxdepth: 1
   :glob:

The purpose of this lab is to configure and test a SAML Identity Provider.
Students will configure the various aspect of a SAML Identity Provider, import
and bind to a SAML Service Provider and test IdP-Initiated SAML Federation.

Objective:

-  Gain an understanding of SAML Identity Provider(IdP) configurations and
   its component parts

-  Gain an understanding of the access flow for IdP-Initiated SAML

Lab Requirements:

-  All Lab requirements will be noted in the tasks that follow

Estimated completion time: 25 minutes

TASK 1 ‑ Configure the SAML Identity Provider (IdP)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

IdP Service
-----------

1. Begin by selecting: **Access ‑> Federation ‑> SAML Identity Provider ‑> Local IdP Services**
2. Click the **Create** button (far right)

|image26|

3. In the **Create New SAML IdP Service** dialog box, click **General Settngs**
in the left navigation pane and key in the following:

+-------------------+------------------------------+
| IdP Service Name: | *idp.f5demo.com‑app*         |
+-------------------+------------------------------+
| IdP Entity ID:    | *https://idp.f5demo.com/app* |
+-------------------+------------------------------+

|image27|

.. NOTE:: The yellow box on "Host" will disappear when the Entity ID is entered

4. In the **Create New SAML IdP Service** dialog box, click **Assertion
Settings** in the left navigation pane and key in the following:

+--------------------------+----------------------------------------------+
| Assertion Subject Type:  | *Persistent Identifier* (drop down)          |
+--------------------------+----------------------------------------------+
| Assertion Subject Value: | *%{session.logon.last.username}* (drop down) |
+--------------------------+----------------------------------------------+

|image28|

5. In the **Create New SAML IdP Service** dialog box, click **SAML Attributes** in the left navigation pane and click the **Add** button as shown
6. In the **Name** field in the resulting pop-up window, enter the following: *emailaddress*
7. Under **Attribute Values**, click the **Add** button
8. In the **Values** line, enter the following: *%{session.ad.last.attr.mail}*
9. Click the **Update** button
10. Click the **OK** button

|image29|

|br|

|image30|

11. In the **Create New SAML IdP Service** dialog box, click **Security Settings** in the left navigation pane and key in the following:

+----------------------+--------------------------------+
| Signing Key:         | */Common/SAML.key* (drop down) |
+----------------------+--------------------------------+
| Signing Certificate: | */Common/SAML.crt* (drop down) |
+----------------------+--------------------------------+

.. NOTE:: The certificate and key were previously imported

12. Click **OK** to complete the creation of the IdP service

|image31|

SP Connector
------------

1. Click on **External SP Connectors** (under the **SAML Identity Provider** tab) in the horizontal navigation menu
2. Click specifically on the **Down Arrow** next to the **Create** button (far right)
3. Select **From Metadata** from the drop down menu

|image32|

4. In the **Create New SAML Service Provider** dialogue box, click **Browse** and select the *app.partner.com_metadata.xml* file from the Desktop of your jump host
5. In the **Service Provider Name** field, enter the following: *app.partner.com*
6. Click **OK** on the dialog box

|image33|

.. NOTE:: The app.partner.com_metadata.xml file was created previously. Oftentimes
  SP providers will have a metadata file representing their SP service. This can be
  imported to save object creation time as has been done in this lab.

7. Click on **Local IdP Services** (under the **SAML Identity Provider** tab) in the horizontal navigation menu
8. Select the **Checkbox** next to the previously created *idp.f5demo.com* and click the **Bind/Unbind SP Connectors** button at the bottom of the GUI

|image34|

9. In the **Edit SAML SP's that use this IdP** dialog, select the */Common/app.partner.com* SAML SP Connection Name created previously
10. Click the **OK** button at the bottom of the dialog box

|image35|

11. Under the **Access ‑> Federation ‑> SAML Identity Provider ‑> Local IdP Services** menu you should now see the following (as shown):

+---------------------+----------------------+
| Name:               | *idp.f5demo.com-app* |
+---------------------+----------------------+
| SAML SP Connectors: | *app.partner.com*    |
+---------------------+----------------------+

|image36|

TASK 2 ‑ Create SAML Resource, Webtop, and SAML IdP Access Policy
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

SAML Resource
-------------

1. Begin by selecting **Access ‑> Federation ‑> SAML Resources**
2. Click the **Create** button (far right)
3. In the **New SAML Resource** window, enter the following values:

+--------------------+----------------------+
| Name:              | *partner‑app*        |
+--------------------+----------------------+
| SSO Configuration: | *idp.f5demo.com‑app* |
+--------------------+----------------------+
| Caption:           | *Partner App*        |
+--------------------+----------------------+

4. Click **Finished** at the bottom of the configuration window

|image37|

|br|

|image38|

Webtop
------

1. Select **Access ‑> Webtops ‑> Webtop List**
2. Click the **Create** button (far right)

|image39|

3. In the resulting window, enter the following values:

+-------+--------------------+
| Name: | *full_webtop*      |
+-------+--------------------+
| Type: | *Full* (drop down) |
+-------+--------------------+

4. Click **Finished** at the bottom of the GUI

|image40|

SAML IdP Access Policy
----------------------

1. Select **Access ‑> Profiles/Policies ‑> Access Profiles (Per-Session Policies)**
2. Click the **Create** button (far right)

|image41|

3. In the **New Profile** window, enter the following information:

+----------------+-------------------------+
| Name:          | *idp.f5demo.com‑policy* |
+----------------+-------------------------+
| Profile Type:  | *All* (drop down)       |
+----------------+-------------------------+
| Profile Scope: | *Profile* (default)     |
+----------------+-------------------------+

4. Scroll to the bottom of the **New Profile** window to the **Language Settings** section
5. Select *English* from the **Factory Built‑in Languages** menu on the right and click the **Double Arrow (<<)**, then click the **Finished** button.
6. The **Default Language** should be automatically set

|image42|

7. From the **Access ‑> Profiles/Policies ‑> Access Profiles (Per-Session Policies) screen**, click the **Edit** link on the previously created *idp.f5demo.com‑policy* line

|image43|

8. In the **Visual Policy Editor** window for */Common/idp.f5demo.com‑policy*, click the **Plus (+) Sign** between **Start** and **Deny**

|image44|

9. In the pop-up dialog box, select the **Logon** tab and then select the **Radio** next to **Logon Page**, and click the **Add Item** button
10. Click **Save** in the resulting Logon Page dialog box

|image45|

11. In the **Visual Policy Editor** window for */Common/idp.f5demo.com‑policy*, click the **Plus (+) Sign** between **Logon Page** and **Deny**

|image46|

12. In the pop-up dialog box, select the **Authentication** tab and then select the **Radio** next to **AD Auth**, and click the **Add Item** button

|image47|

13. In the resulting **AD Auth** pop-up window, select */Common/f5demo_ad* from the **Server** drop down menu
14. Click **Save** at the bottom of the window

|image48|

15. In the **Visual Policy Editor** window for */Common/idp.f5demo.com‑policy*, click the **Plus (+) Sign** on the successful branch between **AD Auth** and **Deny**

|image49|

16. In the pop-up dialog box, select the **Authentication** tab and then select the **Radio** next to **AD Query**, and click the **Add Item** button

|image50|

17. In the resulting **AD Query** pop-up window, select */Common/f5demo_ad* from the **Server** drop down menu

|image51|

18. In the **AD Query** pop‑up window, select the **Branch Rules** tab
19. Change the **Name** of the branch to *Successful*.
20. Click the **Change** link next to the **Expression**

|image52|

21. In the resulting pop-up window, delete the existing expression by clicking the **X** as shown

|image53|

22. Create a new **Simple** expression by clicking the **Add Expression** button

|image54|

23. In the resulting menu, select the following from the drop down menus:

+------------+-------------------+
| Agent Sel: | *AD Query*        |
+------------+-------------------+
| Condition: | *AD Query Passed* |
+------------+-------------------+

24. Click the **Add Expression** Button

|image55|

25. Click the **Finished** button to complete the expression

|image56|

|br|

|image57|

26. Click the **Save** button to complete the **AD Query**
27. In the **Visual Policy Editor** window for */Common/idp.f5demo.com‑policy*, click the **Plus (+) Sign** on the successful branch between **AD Query** and **Deny**

|image58|

28. In the pop-up dialog box, select the **Assignment** tab and then select the **Radio** next to **Advanced Resource Assign**, and click the **Add Item** button

|image59|

29. In the resulting **Advanced Resource Assign** pop-up window, click the **Add New Entry** button
30. In the new Resource Assignment entry, click the **Add/Delete** link

|image60|

31. In the resulting pop-up window, click the **SAML** tab, and select the **Checkbox** next to */Common/partner-app*

|image61|

32. Click the **Webtop** tab, and select the **Checkbox** next to */Common/full_webtop*

|image62|

33. Click the **Update** button at the bottom of the window to complete the Resource Assignment entry
34. Click the **Save** button at the bottom of the **Advanced Resource Assign** window
35. In the **Visual Policy Editor**, select the **Deny** ending on the fallback branch following **Advanced Resource Assign**

|image63|

36. In the **Select Ending** dialog box, selet the **Allow** radio button and then click **Save**

|image64|

37. In the **Visual Policy Editor**, click **Apply Access Policy** (top left), and close the **Visual Policy Editor**

|image65|

TASK 3 - Create the IdP Virtual Server and Apply the IdP Access Policy
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

1. Begin by selecting **Local Traffic ‑> Virtual Servers**
2. Click the **Create** button (far right)

|image66|

3. In the **New Virtual Server** window, enter the following information:

+---------------------------+----------------------------+
| General Properties                                     |
+===========================+============================+
| Name:                     | *idp.f5demo.com*           |
+---------------------------+----------------------------+
| Destination Address/Mask: | *10.1.10.110*              |
+---------------------------+----------------------------+
| Service Port:             | *443*                      |
+---------------------------+----------------------------+

+---------------------------+----------------------------+
| Configuration                                          |
+===========================+============================+
| HTTP Profile:             | *http* (drop down)         |
+---------------------------+----------------------------+
| SSL Profile (Client)      | *idp.f5demo.com‑clientssl* |
+---------------------------+----------------------------+

+-----------------+-------------------------+
| Access Policy                             |
+=================+=========================+
| Access Profile: | *idp.f5demo.com‑policy* |
+-----------------+-------------------------+

|image67|

|br|

|image68|

4. Scroll to the bottom of the configuration window and click **Finished**

TASK 4 - Test the SAML IdP
~~~~~~~~~~~~~~~~~~~~~~~~~~

1. Using your browser from the jump host, navigate to the SAML IdP you just configured at *https://idp.f5demo.com* (or click the provided bookmark)

|image69|

2. Log in to the IdP. Were you successfully authenticated? Did you see the webtop with the SP application?

.. NOTE:: Use the credentials provided in the Authentication section at the beginning of this guide (user/Agility1)

3. Click on the Partner App icon. Were you successfully authenticated (via SAML) to the SP?
4. Review your Active Sessions **(Access ‑> Overview ‑> Active Sessions­­­)**
5. Review your Access Report Logs **(Access ‑> Overview ‑> Access Reports)**

.. |br| raw:: html

   <br />

.. |image26| image:: media/image28.png
.. |image27| image:: media/image29.png
.. |image28| image:: media/image30.png
.. |image29| image:: media/image31.png
.. |image30| image:: media/image32.png
.. |image31| image:: media/image33.png
.. |image32| image:: media/image34.png
.. |image33| image:: media/image35.png
.. |image34| image:: media/image36.png
.. |image35| image:: media/image37.png
.. |image36| image:: media/image38.png
.. |image37| image:: media/image39.png
.. |image38| image:: media/image40.png
.. |image39| image:: media/image41.png
.. |image40| image:: media/image42.png
.. |image41| image:: media/image10.png
.. |image42| image:: media/image43.png
.. |image43| image:: media/image44.png
.. |image44| image:: media/image45.png
.. |image45| image:: media/image46.png
.. |image46| image:: media/image47.png
.. |image47| image:: media/image48.png
.. |image48| image:: media/image49.png
.. |image49| image:: media/image50.png
.. |image50| image:: media/image51.png
.. |image51| image:: media/image52.png
.. |image52| image:: media/image53.png
.. |image53| image:: media/image54.png
.. |image54| image:: media/image55.png
.. |image55| image:: media/image56.png
.. |image56| image:: media/image57.png
.. |image57| image:: media/image58.png
.. |image58| image:: media/image59.png
.. |image59| image:: media/image60.png
.. |image60| image:: media/image61.png
.. |image61| image:: media/image62.png
.. |image62| image:: media/image63.png
.. |image63| image:: media/image64.png
.. |image64| image:: media/image65.png
.. |image65| image:: media/image66.png
.. |image66| image:: media/image23.png
.. |image67| image:: media/image67.png
.. |image68| image:: media/image68.png
.. |image69| image:: media/image69.png
