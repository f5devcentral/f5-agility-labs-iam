Lab 1: APM Troubleshooting Lab Object Preparation (GUI)
=======================================================

.. NOTE::
   You only need to perform EITHER Lab 1 OR Lab 2.  They accomplish the same goal, but using different methods.  Lab 2 gets the Lab Preparation using TMSH

The purpose of this lab is to preconfigure some objects that will be
used throughout the other labs. These objects are as follows:

-  Domain Name Services (DNS) Resolver
-  Network Time Protocol (NTP) Server
-  Access Policy (APM) AAA Server – Active Directory
-  Access Policy (APM) SSO Configuration – NTLMv1
-  Access Policy (APM) Access Profile
-  Local Traffic (LTM) Pool and Member
-  Local Traffic (LTM) Virtual Server

Connect to the Lab
------------------

|image1|

1. Establish an RDP connection to your Jump Host and double-click on the
   **BIG-IP** Chrome shortcut on the Windows desktop.

   -  User: agility
   -  Password: Agility1

2. Ignore the certificate warning.

3. Login into the BIG-IP Configuration Utility with the desktop icon (or
   Favorite link in Chrome) with the following credentials:

   -  User: **admin**
   -  Password: **admin**

DNS Resolver for System Configuration
-------------------------------------

|image2|

1. Create a DNS entry by selecting: System->Configuration->Device->DNS

|image3|

2. In the Properties Section for DNS Lookup Server List, enter
   **10.128.20.100** in the Address field and click the **ADD** button.

3. Scroll down to the DNS Search Domain List section and enter
   **agilitylab.com** in the Address field and click the **ADD** button.

4. Click the **UPDATE** button at the bottom of the page to save the
   changes you just made.

NTP Server for System Configuration
-----------------------------------

|image4|

1. Create a NTP entry by selecting: System  Configuration  Device 
   NTP

|image5|

2. In the Properties Section for Time Server List, enter
   **10.128.20.100** in the Address field and click the **ADD** button.

3. Click the **UPDATE** button at the bottom of the page to save the
   changes you just made.

Access Policy (APM) AAA Server – Active Directory Object Creation
-----------------------------------------------------------------

|image6|

1. Create a new AAA Server Object of type Active Directory by selecting:
   Access  Authentication  Active Directory

|image7|

2. Click the **CREATE** button on right side of page.

|image8|

3. Under General Properties type **LAB\_AD\_AAA** in the name field.

4. In the Configuration Section, Click the radio button option next to
   **Direct** in the Server Connection row.

5. In the Domain Name field enter **agilitylab.com**

6. Leave the Domain Controller, Admin Name and Admin Password fields
   blank for now.

7. Click the **FINISHED** button at the bottom of the page to save your
   changes.

Access Policy (APM) SSO Configuration – NTLMv1
----------------------------------------------

|image9|

1. Create a new SSO Configuration Object of type NTLM by selecting:
   Access  Single Sign-On  NTLMV1

|image10|

2. Click the **CREATE** button on the right side of the page.

|image11|

3. In the Name field enter **Agility\_Lab\_SSO\_NTLM**

4. Click the **FINISHED** button at the bottom.

Access Policy (APM) Access Profile Creation
-------------------------------------------

|image12|

1. Create a new APM Profile Object of type ALL by selecting: Access 
   Profiles/Policies  Access Profiles (Per-Session Policies)

|image13|

2. Click the **CREATE** button on the right side of the page.

|image14|

3. In the Name field enter, **Agility-Lab-Access-Profile**

4. In the Profile Type drop down list select **All**

5. **In the Profile Scope drop down list select Profile**

|image15|

6. In the Settings section click the checkbox to the right of Access
   Policy Timeout and change the value from 300, to **30**, seconds.

|image16|

7. Scroll the bottom of the page and in the Language Settings section,
   click to highlight **English** in the Factory Builtin Languages box,
   then click the left **<<** arrows to move it to the left box labeled
   Accepted Languages.

8. Click the **FINISHED** button at the bottom of the page to save your
   changes.

Local Traffic (LTM) Pool and Member Creation
--------------------------------------------

|image17|

1. Create a new LTM Pool and Member by selecting Local Traffic  Pools
   Pools List

|image18|

2. Click the **CREATE** button on the right side of the page.

|image19|

3. In the Name field enter **Agility-Lab-Pool**

4. In the Resources section, in the New Members area, enter
   **10.128.20.100** in the Address field.

5. In the Service Port field, enter **80**, or select **HTTP** from the
   drop-down menu.

6. Click the **ADD** button

7. Click the **FINISHED** button at the bottom to save your changes.

Local Traffic (LTM) Virtual Server Creation
-------------------------------------------

This lab will walk you through creating the Virtual Server we will use
during the course of the lab. This Virtual Server will be used to
associate Access Policies which will be evaluated when authenticating
users.

|image20|

1. Create an new Virtual Server by selecting Local Traffic  Virtual
   Servers  Virtual Server List

|image21|

2. Click the **CREATE** button on the right side of the page.

|image22|

3. Under the General Properties section, in the Name field enter
   **Agility-LTM-VIP**

4. In the Destination Address field enter **10.128.10.100**

5. In the Service Port fields enter **443**, or select **HTTPS** from
   the drop-down menu

|image23|

6. Under the Configuration section, in the HTTP Profile field use the
   drop-down menu to select **http**

7. In the SSL Profile (Client) field select **clientssl** from the
   Available profiles then use the **<<** left arrows to move it to the
   Selected box.

8. Ensure VLAN and Tunnel Traffic is set to **All VLANs and Tunnels**

9. In the Source Address Translation field select **Auto Map** from the
   drop-down menu.

|image24|

10. Scroll down to the Access Profile section, select **Agility-Lab-Access-Profile** from the drop-down menu.

|image25|

11. Click the **FINISHED** button to save your changes.


.. |image1| image:: /_static/class8/image3.png
   :width: 5.30000in
   :height: 3.34687in
.. |image2| image:: /_static/class8/image4.png
   :width: 5.30000in
   :height: 1.87749in
.. |image3| image:: /_static/class8/image5.png
   :width: 5.28125in
   :height: 7.47544in
.. |image4| image:: /_static/class8/image6.png
   :width: 5.30000in
   :height: 1.48855in
.. |image5| image:: /_static/class8/image7.png
   :width: 5.28125in
   :height: 3.99637in
.. |image6| image:: /_static/class8/image9.png
   :width: 5.30972in
   :height: 2.05069in
.. |image7| image:: /_static/class8/image10.png
   :width: 5.21875in
   :height: 0.71782in
.. |image8| image:: /_static/class8/image11.png
   :width: 5.21875in
   :height: 6.02240in
.. |image9| image:: /_static/class8/image13.png
   :width: 5.30972in
   :height: 2.66111in
.. |image10| image:: /_static/class8/image14.png
   :width: 5.30000in
   :height: 0.79642in
.. |image11| image:: /_static/class8/image16.png
   :width: 5.30972in
   :height: 6.01667in
.. |image12| image:: /_static/class8/image18.png
   :width: 5.30972in
   :height: 1.95069in
.. |image13| image:: /_static/class8/image19.png
   :width: 5.30000in
   :height: 0.42589in
.. |image14| image:: /_static/class8/image21.png
   :width: 5.30972in
   :height: 2.25208in
.. |image15| image:: /_static/class8/image22.png
   :width: 5.23333in
   :height: 2.07270in
.. |image16| image:: /_static/class8/image23.png
   :width: 5.18567in
   :height: 2.05208in
.. |image17| image:: /_static/class8/image24.png
   :width: 5.25792in
   :height: 2.94792in
.. |image18| image:: /_static/class8/image25.png
   :width: 5.30000in
   :height: 0.88333in
.. |image19| image:: /_static/class8/image26.png
   :width: 5.23958in
   :height: 5.90988in
.. |image20| image:: /_static/class8/image27.png
    :width: 5.28571in
    :height: 2.00000in
.. |image21| image:: /_static/class8/image28.png
    :width: 5.30000in
    :height: 0.47834in
.. |image22| image:: /_static/class8/image29.png
    :width: 5.27083in
    :height: 3.12743in
.. |image23| image:: /_static/class8/image30.png
    :width: 5.19792in
    :height: 5.54507in
.. |image24| image:: /_static/class8/image31.png
    :width: 5.30913in
    :height: 2.26042in
.. |image25| image:: /_static/class8/image32.png
    :width: 5.30000in
    :height: 1.04073in
