Lab 2: URL Category-based Decryption Bypass
===========================================

In this lab exercise, you will bypass SSL decryption based on requests
to URLs categorized as financial services web sites.

Estimated completion time: 25 minutes

**Objectives:**

-  Apply a new Per-Request Policy to bypass SSL decryption for specific
   URL categories

-  Test web browsing behavior

**Lab Requirements:**

-  Lab 1 previously completed successfully (working SWG iApp deployment)

Task 1 – Copy and configure new Per-Request Policy
--------------------------------------------------

-  Copy the **Lab\_Per\_Request** Per Request Policy by browsing
   to **Access Policy > Per-Request Policies** and click **Copy**

-  Name the copy **Lab\_Per\_Request\_SSL\_Bypass**

-  Edit the new Per-Request Policy by clicking **Edit**, then go
   to the VPE tab in your browser

-  Modify the Encrypted Category Lookup object to include a branch for
   SSL Bypass:

-  Click on the existing **Category Lookup** object

-  On the **Properties** tab, change the name to **Encrypted**
   **Category** **Lookup**

-  Click to access the **Branch Rules** tab

-  Click **Add Branch Rule** and name it **Banks**

-  Click **Change** to modify the Expression of this new Branch
   Rule

-  Click **Add Expression**

-  Change **Agent Sel**: to **Category Lookup**

-  Change **Category is**: to **Financial Data and Services**

-  Click **Add Expression**

-  Click **Finished**

-  Click **Save**

-  Add an **SSL Bypass Set** object (from the General Purpose tab)
   on the **Banks** branch of the **Encrypted Category Lookup**

-  Click **Save**

-  Add an **SSL Intercept Set** object (from the General Purpose
   tab) on the “fallback” branch of the **Encrypted Category Lookup**

-  Click **Save**

-  Add a **URL Filter** object on the **SSL Bypass** Branch; select the
   **LAB\_URL\_FILTER URL** filter previously created in Lab1

-  Click **Save**

-  Change the **Allow** branch to an ending of **Allow**

   |image24|

Task 2 – Reconfigure SWG iApp to assign New Per-Request Policy
--------------------------------------------------------------

-  Browse to **iApps >> Application Services > Applications”**

-  Click on **SWG**

-  Click **Reconfigure**

-  Find the section **Which Per-Request Access Policy do you want to
   use?**

-  Change the per-request policy to **Lab\_Per\_Request\_SSL\_Bypass**

-  Scroll to the bottom and click **finished**

Task 3 – Testing
----------------

Test 1:
~~~~~~~

-  Open **Internet Explorer** on your Jump Host client machine

-  Browse to **http://www.wellsfargo.com**

-  The browser should prompt you for authentication. Submit your
   credentials.

-  User: ``user1``

-  Password: ``AgilityRocks!``

-  Verify the site loads correctly and inspect the SSL certificate to
   confirm that it is originated from Wells Fargo and SSL Bypass was
   enabled

|image25|

.. |image24| image:: /_static/class3/image26.png
   :width: 6.92014in
   :height: 2.76250in
.. |image25| image:: /_static/class3/image27.png
   :width: 5.30833in
   :height: 1.78333in