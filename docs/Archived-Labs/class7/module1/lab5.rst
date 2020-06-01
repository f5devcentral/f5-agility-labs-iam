Lab 5 – FORMS Based Authentication
----------------------------------

In this lab, we will show you how to configure APM to leverage SSO
functionality with an application server that uses forms based
authentication.


.. NOTE::
  Lab Requirements:

  - BIG-IP with APM licensed and activated
  - Server running AD and Web services
  - Local Host file entries on the Jump Host


Task – Create a Pool
~~~~~~~~~~~~~~~~~~~~

#. Browse to **Local Traffic > Pools** and click the ‘\ **+**\ ’ next to
   **Pools List** to create a new pool.

#. Name the pool “\ **forms\_pool**\ ”

#. Assign the monitor “\ **http**\ ” by selecting the monitor and moving
   it to the left.

#. **Add** the following new member/node to the pool and click
   **Finished**:

   - Node Name: **forms**, Address: **10.128.20.204**, Service Port: **80**

   |image44|


Task – Create a Virtual Server
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#. Browse to **Local Traffic > Virtual Servers** and click the
   ‘\ **+**\ ’ next to **Virtual Server List** to create a new one.

#. Use the following information to create the virtual server and leave
   the other settings at their default values, then click **Finished**:

   -  Name the pool “\ **forms\_vs**\ ”

   -  Destination Address/Mask: **10.128.10.12**

   -  Service Port: **443**

   -  HTTP Profile: **http**

   -  SSL Profile (Client): **f5demo**

   -  Source Address Translation: **Auto Map**

   -  | Default Pool: **forms\_pool**

   |image45|
   |image46|
   |image47|


Task – Testing without APM
~~~~~~~~~~~~~~~~~~~~~~~~~~

Observe the current behavior of the login page without authentication
enforced by APM.

#. Open your web browser and go to **https://forms.f5demo.com**. You should see a page that looks as follows:

   |image48|

#. Log in with the following credentials:

   Username: **user**

   Password: **Agility1**

   Once successfully logged in you should see a web page similar to the
   following:\

   |image49|

#. **Logout** using the link at the top right-hand corner of the page.


Task – Create Access Policy to use with Forms Based Authentication
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. Open the **Wizards > Device Wizards** page.

#.  Select **Web Application Access Management for Local Traffic Virtual
    Servers**

    |image50|

#.  Click **Next**

#.  Click **Next** for Option 1 on the Configuration Options page

    |image51|

#.  Configure Basic Properties for the policy

    #. For Policy Name enter **Forms\_Access\_Policy**

    #. Uncheck **Enable Antivirus Check in Access Policy**

       |image52|

    #. Click **Next**

#.  Configure the Authentication type used for this new policy

    #. Select **Use Existing** for the Authentication Options

    #. Select **Lab\_SSO\_AD\_Server::Active Directory**

       |image53|

    #. Click **Next**

#.  Configure Single Sign On

    #. Select “\ **Create New**\ ” for “SSO Options”

    #. Choose **Form Based** for the SSO Method

    #. **Uncheck** the option for “Use SSO Template”

    #. Enter **/Account/Login\*** in the “Start URI” field

    #. Enter **/Account/Login** in the “Form Action” field

    #. Enter **UserName** in the “Form Parameter For User Name” field

    #. Enter **Password** in the “Form Parameter For Password” field

       |image54|

    #. Click **Next**

#.  Configure Virtual Server

    #. Select Use **Existing HTTPS Server**

    #. Choose **/Common/forms\_vs** for the Virtual Server

       |image55|

    #. Click **Next**

#.  Review configuration and click **Next**

#. Review the “Setup Summary”, which shows all (existing and new)
   objects associated with this new policy and click **Finished**.

#. Add a logout URI Include to the new access policy

   #. Open the **Access > Profiles / Policies > Access Profiles (Per-Session Policies)** page

   #. Click on the name of the new policy **Forms\_Access\_Policy**

   #. **Add** “\ **/Account/Logout**\ ” to the “Logout URI Include” field

   #. Change **Logout URI Timeout** to **1** second

      |image56|

   #. Click **Update**

#. Enable SSO

   #. Click on the “SSO / Auth Domains” tab

   #. For “SSO Configuration”, select **Forms\_Access\_Policy\_sso**

      |image57|

   #. Click **Update**


Task – Applying Access Policy Changes
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

After you create or change an access policy, the link Apply Access
Policy appears in yellow at the top left of the BIG-IP Configuration
utility screen. You must click this link to activate the access policy
for use in your configuration.

|image58|

#. Click the **Apply Access Policy** link, which will bring you to the
   Apply Access Policy screen, with a list of access policies that have
   been changed.

#. | Select the new Access Policy and click the **Apply** button (by default, all access policies that are new or changed are selected).

   |image59|

   After you apply the access policy, the Access Profiles list screen
   is displayed.



Task – Testing with APM Authentication
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Observe the behavior of the login page now that authentication is
enforced by APM.

#. Open your web browser and go back to **https://forms.f5demo.com**. You should see a page that looks like the following:

   |image60|

#. Logon with the following credentials:

   Username: **user**

   Password: **Agility1**

   Once successfully logged in you will see the same web page observed in task 2:

   |image61|


Task – Testing Logout
~~~~~~~~~~~~~~~~~~~~~

Earlier in Task 3, Step 9, we defined a **Logout URI Include** for this
Access Policy. This is a list of logoff URIs that the access profile
searches for in order to terminate the Access Policy Manager session.
The URI we used was /Account/Logout, and the default logout delay is 5
seconds, which was modified to 1 second.

#. Logout using the **Logout** link at the top right-hand corner of the
   page.

#. Wait 1 second

#. Click the Home link in the banner at the top of the page

#. You should be redirected back to the F5 logon page


.. |image44| image:: media/image45.png
   :width: 3.41667in
   :height: 2.98403in
.. |image45| image:: media/image46.png
   :width: 3.10417in
   :height: 3.19100in
.. |image46| image:: media/image47.png
   :width: 3.20833in
   :height: 2.25136in
.. |image47| image:: media/image48.png
   :width: 3.25189in
   :height: 0.63067in
.. |image48| image:: media/image49.png
   :width: 5.30972in
   :height: 2.74306in
.. |image49| image:: media/image50.png
   :width: 5.30972in
   :height: 2.29514in
.. |image50| image:: media/image51.png
   :width: 5.30972in
   :height: 1.40980in
.. |image51| image:: media/image52.png
   :width: 3.22917in
   :height: 2.19257in
.. |image52| image:: media/image53.png
   :width: 3.38542in
   :height: 1.31987in
.. |image53| image:: media/image54.png
   :width: 4.02308in
   :height: 1.28491in
.. |image54| image:: media/image55.png
   :width: 4.15023in
   :height: 3.78694in
.. |image55| image:: media/image56.png
   :width: 5.29167in
   :height: 1.75000in
.. |image56| image:: media/image57.png
   :width: 4.26042in
   :height: 1.74250in
.. |image57| image:: media/image58.png
   :width: 3.75000in
   :height: 2.10635in
.. |image58| image:: media/image59.png
   :width: 1.71389in
   :height: 0.48991in
.. |image59| image:: media/image60.png
   :width: 2.87083in
   :height: 1.52153in
.. |image60| image:: media/image61.png
   :width: 4.67208in
   :height: 1.72235in
.. |image61| image:: media/image62.png
   :width: 5.30972in
   :height: 2.21667in
