Lab 4: SWG Reporting with BIG-IQ
================================

In this lab exercise, you will explore SWG Reporting with Big-IQ Access.

Estimated completion time: 15 minutes

**Objectives:**

-  View SWG activity reports using BIG-IQ Access

-  Test web browsing behavior

**Lab Requirements:**

-  Lab 3 previously completed successfully (working SWG iApp deployment)

Task 1 – Generate New Web Browsing Traffic
------------------------------------------

-  Open Internet Explorer on your Jump Host machine and browse to
   several web sites, including facebook.com and banking sites to
   generate reporting data for traffic that is allowed, decrypted, SSL
   bypassed, and blocked by SWG.

Task 2 – View SWG Reporting Data
--------------------------------

-  Using Firefox, browse to the BIG-IQ Management GUI
   `**https://10.1.1.30** <https://10.1.1.30>`__

-  Login with the following credentials:

    Username: **admin**

    Password: **admin**

-  Browse to **Monitoring > Dashboards > Access > Secure Web Gateway >
   Users** to see the activity by users

-  Click on **Categories** to view category information,

-  Adjust the time period to **30 days or less**

   |image31|

-  Click on **SSL Bypass** and view the breakdown between **HTTPS
   Inspected** and **Bypassed** Content

   |image32|

-  Click on **Host Name** to look at the hosts your users are accessing

   |image33|

-  Click on **URLs** to get detail on what URLs your users are accessing

   |image34|

.. |image31| image:: /_static/class3/image33.png
   :width: 6.73333in
   :height: 3.25444in
.. |image32| image:: /_static/class3/image34.png
   :width: 6.64035in
   :height: 2.84982in
.. |image33| image:: /_static/class3/image35.png
   :width: 6.98947in
   :height: 2.76667in
.. |image34| image:: /_static/class3/image36.png
   :width: 6.97758in
   :height: 3.24167in