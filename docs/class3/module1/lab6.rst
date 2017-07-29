Lab 6: Captive Portal Authentication
====================================

In this lab exercise, you will a captive portal to authenticate client
connecting to the Internet through the SWG transparent proxy.

Estimated completion time: 25 minutes

**Objectives:**

-  Configure SWG with a Captive Portal to facilitate client
   authentication

-  Test web browsing behavior

**Lab Requirements:**

-  Lab 5 previously completed successfully (working SWG transparent
   proxy deployment)

Task 1 – Create a new Access Policy
-----------------------------------

-  Use Firefox to access the BIG-IP GUI (https://10.1.1.10, admin/admin)

-  Browse to **Access >> Profiles / Policies >> Access Profiles
   (Per-Session Policies)** and click **Create…**

-  Name the profile **AP\_Transparent\_Captive\_Portal**

-  Change the Profile Type to **SWG-Transparent**

-  Change Captive Portals to **Enabled**

-  Set Primary Authentication URI to **https://captive.f5demo.com**

-  Add **English** to **Accepted Languages**

-  Accept all other default settings and click **Finished**

-  Click on the **Edit...** link for the appropriate Access Policy
   created above

-  On the VPE browser tab, select the **+** and **Add** a
   **Message Box** object (from the General Purpose tab)

-  For the Message, enter: **Welcome to F5 Agility Guest Wifi Access.
   Please click the link to accept our terms and access the
   internet.**

-  For the Link enter **Go**

-  Click **Save**

-  Select the **+** after the message box and **Add** a **Logon Page** object.

-  Configure the **Logon Page** as shown below:

   |image35|

-  Click **Save**

-  Click on the **Deny** ending and change it to **Allow**

-  Click **Apply Access Policy**

   |image36|

Task 2 – Reconfigure SWG iApp to enable Transparent Capture Portal
------------------------------------------------------------------

-  Browse to **iApps >> Application Services** > **Applications**

-  Click on **SWG**

-  Click **Reconfigure**

-  Find the section **Which SWG-Transparent Access Policy do you want
   to use?**

-  Select **AP\_Transparent\_Captive\_Portal**

-  Change **Configure the transparent proxy to relay to a Captive
   Portal** to **Yes, relay to a captive portal**

-  Set the **Captive Portal Configuration** as follows:

   -  IP Address: **10.1.20.201**

   -  Port: **443**

   -  SSL Certificate: **captive.f5demo.com**

   -  SSL Key: **captive.f5demo.com**

-  Browse to the bottom and click **Finished**

Task 3 – Testing
----------------

-  Open Internet Explorer on your Jump Host client machine

-  Ensure Internet Explorer options are configured to *NOT* use an
   explicit proxy

-  Browse to **https://www.nhl.com**

-  You should be redirected to the capture portal page, prompted to
   accept the policy by clicking **Go**, then prompted to
   provide your email address before being allowed through.

.. |image35| image:: /_static/class3/image37.png
   :width: 5.96528in
   :height: 4.12222in
.. |image36| image:: /_static/class3/image38.png
   :width: 4.54167in
   :height: 1.09167in
