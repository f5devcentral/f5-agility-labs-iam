Lab 5: SWG iApp - Transparent Proxy for HTTP and HTTPS
======================================================

In this lab exercise, you will configure SWG in transparent proxy mode
to support environments where clients do not leverage an explicit proxy.
BIG-IP is deployed inline on the client’s outbound path to the Internet
to intercept the traffic.

Estimated completion time: 15 minutes

**Objectives:**

-  Deploy SWG in transparent proxy mode

-  Test web browsing behavior

**Lab Requirements:**

-  Lab 1 previously completed successfully (working SWG iApp deployment)

-  BIG-IP must be in path between the client workstation and the
   Internet (this has already been done for you in this lab)

Task 1 – Create a new Access Policy
-----------------------------------

-  Use Firefox to access the BIG-IP GUI (https://10.1.1.10, admin/admin)

-  Browse to **Access >> Profiles / Policies >> Access Profiles
   (Per-Session Policies)** and click **Create...**

-  Name the profile **AP_Transparent**

-  Change the Profile Type to **SWG-Transparent**

-  Add **English** to **Accepted Languages**

-  Accept all other default settings and click **Finished**

-  Click on the **Edit…** link for the appropriate Access Policy
   created above

-  Go to the VPE tab in your browser and on the **fallback** branch,
   click on the **Deny** Ending and change it to **Allow**

-  Click **Save**

-  Click **Apply Access Policy**

Task 2 – Reconfigure SWG iApp to apply Transparent Access Policy
----------------------------------------------------------------

-  Browse to **iApps >> Application Services > Applications**

-  Click on **SWG**

-  Click **Reconfigure**

-  Change **Configuration** **Type** to **Transparent** **Proxy**

-  Find the section **Which SWG-Transparent Access Policy do you want
   to use?**

-  Change **Access Policy** to **AP\_Transparent**

-  Find the section **Which Per-Request Access Policy do you want to
   use?**

-  Change the **per-request policy** to **Lab_Per_Request**

-  Set **Should the system translate client addresses** to **Yes...**

-  Set **Which SNAT mode do you want to use** to **use SNAT Auto Map**

-  Browse to the bottom and click **Finished**

Task 3 – Testing
----------------

-  Open Internet Explorer on your Jump Host client machine

-  Ensure Internet Explorer options are configured to ***not*** use an
   explicit proxy

-  Browse to https://www.nhl.com. You should not be prompted for
   authentication.
