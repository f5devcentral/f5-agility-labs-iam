Lab 1: SWG iApp – Explicit Proxy for HTTP and HTTPS
===================================================

In this lab exercise, you will learn how to automate and simplify a
deployment of SWG using an iApp template.

Estimated completion time: 30 minutes

**Objectives:**

-  Create an Explicit Proxy configuration by deploying the SWG iApp
   template

-  Test web browsing behavior

**Lab Requirements:**

-  BIG-IP with SWG licensed

-  BIG-IP must have access to the public Internet

-  BIG-IP must have access to a DNS server that can resolve queries for
   public Internet web site names

-  The latest iApp for SWG can be downloaded from
   **https://downloads.f5.com/** (browse to BIG-IP **iApp
   Templates**) Note: The iApp has already been downloaded and
   imported for you.

Before you can deploy the SWG iApp template, you must have the following
objects configured:

-  AD AAA server

-  SWG-Explicit Access Policy

-  Custom URL Filter

-  Per-Request Access Policy

Task 1 – Create an "SWG-Explicit" Access Policy for Authentication
------------------------------------------------------------------

Create an AD AAA Server
~~~~~~~~~~~~~~~~~~~~~~~

-  Create an AD AAA server by selecting **Access >> Authentication >>
   Active Directory** and clicking on **Create...**

-  Change the Name to **AD\_F5DEMO**

-  Change the Domain Name to **f5demo.com**

-  Change Server Connection to **Direct**

-  Change the Domain Controller to **10.1.20.20**

-  Click **Finished**

   |image1|

Create a Per-Session Access Policy
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-  Browse to **Access >> Profiles / Policies >> Access Profiles
   (Per-Session Policies)** and click **Create...***

-  Name the profile **AP_Explicit_Auth**

-  Change the **Profile** **Type** to **SWG-Explicit**

-  Add **English** to the **Accepted Languages** list

-  Accept all other default settings and click **Finished**

-  Click on the **Edit…** link for the appropriate Access Policy created above

   |image2|

-  Select the **+** between Start and Deny and **Add**
   an **HTTP 407 Response** object

   |image3|

-  Change the **HTTP Auth Level** to **basic**

   |image4|

-  Click **Save**

-  On the **Basic** branch of the **HTTP 407** Object, **Add**
   an **AD Auth** Object

   |image5|

-  Change the **Server** to **/Common/AD_F5DEMO** and change
   **Show Extended Error** to **Enabled**

   |image6|

-  Click **Save**

-  On the **Successful** branch of the **AD Auth** Object, click on the
   **Deny** Ending and change it to **Allow**

-  Click **Save**

-  Click on the **Apply Access Policy** link

   |image7|

Task 2 – Create a custom URL Filter
-----------------------------------

-  Browse to **Access >> Secure Web Gateway >> URL Filters** and
   click **Create...**

-  Name your filter **LAB_URL_FILTER** and click **Finished**

-  Click on the first check box to select all categories

   |image8|

-  Click **Allow** at the bottom of the page

   |image9|

-  Click the check box to select **Social Web – Facebook** and then click
   **Block** (for this lab, our URL filter will only block Facebook)

   |image10|

Task 3 – Create a "Per-Request" Access Policy
---------------------------------------------

-  Browse to **Access >> Profiles / Policies >> Per-Request
   Policies** and click **Create...**

-  Name your policy **Lab_Per_Request**

-  Click **Finished**

-  Click on the **Edit…** link for the appropriate Per-Request Policy created
   above, then go back to the VPE tab in your browser

   |image11|

-  Click on the **+** symbol between **Start** and **Allow**

-  Go to the **General Purpose** tab and add a **Protocol
   Lookup** object

   |image12|

-  Click **Add Item**

-  Click **Save**

-  On the HTTPS branch, click the **+** and **Add** a
   **Category Lookup** object (**General Purpose** tab)

   |image13|

-  Select **Use SNI in Client Hello** for **Categorization Input**

-  Click **Save**

-  After the Category Lookup, **Add** a **URL Filter Assign** Object
   (from the **General Purpose** tab) and choose URL Filter
   **/Common/LAB_URL_FILTER**

   |image14|

   .. IMPORTANT:: Change the Ending of the **Allow**
      outcome on the "fallback" branch from “Reject” to **Allow**

   |image15|

Task 4 – Create Explicit Proxy Configuration using the SWG iApp
----------------------------------------------------------------

Import the SWG iApp template into the BIG-IP – Note: This has been done for you.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-  In the BIG-IP Management UI, browse to **iApps >> Templates** and
   click **Import...**

-  Click **Choose File** or **Browse...** and select the iApp
   file (at the time of writing the current version is 1.1.0rc4
   (f5.secure_web_gateway.v1.1.0rc4.tmpl).

-  Click **Open** and **Upload**

Create a SWG proxy configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-  Browse to **iApps >> Application Services**

-  Click **Create...**

-  Change the name to **SWG**

-  Change the Template to **f5.secure_web_gateway.v1.1.0rc4**
   (your version may be newer)

   a. Answer the questions as follows:

      +--------------------------------------+---------------------------------------+
      | Question                             | Answer                                |
      +==============================================================================+
      | Do you want to see inline help?      | Yes, show inline help                 |
      +--------------------------------------+---------------------------------------+
      | Do you want to enable advanced       | No, do not enable advanced options    |
      | options?                             |                                       |
      +--------------------------------------+---------------------------------------+
      | Which type of SWG configuration do   | Explicit Proxy                        |
      | you want to deploy                   |                                       |
      +--------------------------------------+---------------------------------------+
      | Do you want to use ICAP to forward   | No, do not use ICAP for DLP           |
      | requests for inspection by DLP       |                                       |
      | servers?                             |                                       |
      +--------------------------------------+---------------------------------------+
      | What IP address and port do you want | - IP Address: 10.1.20.200             |
      | to use for the virtual server?       | - Port: 3128                          |
      +--------------------------------------+---------------------------------------+
      | What is the FQDN of this proxy?      | proxy.f5demo.com. The local hosts     |
      |                                      | file on your Jump Host has already    |
      |                                      | been modified to resolve this FQDN to |
      |                                      | the correct IP address indicated      |
      |                                      | above.                                |
      +--------------------------------------+---------------------------------------+
      | On which ports should the system     | 80                                    |
      | accept HTTP traffic?                 |                                       |
      +--------------------------------------+---------------------------------------+
      | On which ports should the system     | 443                                   |
      | accept HTTPS traffic?                |                                       |
      +--------------------------------------+---------------------------------------+
      | Which SWG-Explicit Access Policy do  | AP_Explicit_Auth                      |
      | you want to use?                     |                                       |
      +--------------------------------------+---------------------------------------+
      | Which Per-Request Access Policy do   | Lab_Per_Request                       |
      | you want to use?                     |                                       |
      +--------------------------------------+---------------------------------------+
      | Do you want the system to forward    | Yes, forward all name requests        |
      | all name requests?                   |                                       |
      +--------------------------------------+---------------------------------------+
      | Which DNS servers do you want to use | - IP: 10.1.20.20                      |
      | for forwarding?                      | - Port: 53                            |
      +--------------------------------------+---------------------------------------+
      | Which SSL profile do you want to use | Create a new Client SSL profile       |
      | for client-side connections?         |                                       |
      +--------------------------------------+---------------------------------------+
      | Which Subordinate CA certificate do  | f5agility.crt                         |
      | you want to use?                     |                                       |
      +--------------------------------------+---------------------------------------+
      | Which CA key do you want to use?     | f5agility.key                         |
      +--------------------------------------+---------------------------------------+
      | Does the key require a password? If  | F5labs                                |
      | so, type it here                     |                                       |
      +--------------------------------------+---------------------------------------+
      | Which SSL profile do you want to use | Create a new Server SSL profile       |
      | for server-side connections?         |                                       |
      +--------------------------------------+---------------------------------------+

   b. Click **Finished** – you will see a large number of objects created
      for you on the **Components** tab.

Task 5 – Verify that the “F5 Agility CA” certificate is trusted
---------------------------------------------------------------

A Windows Domain Group Policy was configured to deploy the CA
certificate that SWG uses to forge new certificates (on behalf of the
origin server) to domain-joined machines.

-  Open Internet Explorer on your Jump Host client machine

-  Click the gear icon or hit ``Alt-X`` and select
   **Internet options**

   |image16|

-  Go to the **Content** tab and click **Certificates**

-  Click on the **Trusted Root Certification Authorities** tab and
   scroll down. You should see the **F5 Agility CA** certificate in the
   list.

   |image17|

-  Double-click on the certificate to view its properties, then close
   this window and the Certificates window.

Task 6 – Testing
----------------

Configure your browser with a “Proxy Server”
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-  Go to the **Connections** tab and click **LAN settings**

-  Enable the checkbox for **Use a proxy server for your LAN** and enter:

   -  Address: **10.1.20.200**

   -  Port: **3128**

-  Click **OK** twice.

   |image18|

Test 1:
~~~~~~~

-  Open a new Internet Explorer "InPrivate" browser window on your Jump
   Host client machine

-  Browse to **https://www.google.com**

   |image19|

-  The browser should prompt you for authentication. Submit your
   credentials:

   -  User: ``user1``

   -  Password: ``AgilityRocks!``

-  Verify defined user has an Access Session ID

-  Browse to **Access > Overview > Active Sessions**

   |image20|

Test 2:
~~~~~~~

-  Using an InPrivate browser window from the client test
   machine, go to https://www.google.com and verify the SSL certificate
   is signed by the **F5 Agility CA** you configured in Lab 1

   |image21|

-  Using an InPrivate browser window from the client test
   machine, go to https://www.wellsfargo.com and examine the certificate
   to verify that it is signed by the same **F5 Agility CA** you
   configured in Lab 1

   |image22|

Test 3:
~~~~~~~

-  Using an InPrivate browser window from the client test
   machine, go to https://www.facebook.com and verify that you are
   instead delivered a SWG Block Page, in accordance to the URL Filter
   you configured above.

   |image23|

.. |image1| image:: /_static/class3/image3.png
   :width: 3.69928in
   :height: 4.01600in
.. |image2| image:: /_static/class3/image4.png
   :width: 5.30417in
   :height: 1.38264in
.. |image3| image:: /_static/class3/image5.png
   :width: 5.30417in
   :height: 1.69583in
.. |image4| image:: /_static/class3/image6.png
   :width: 3.31806in
   :height: 3.78403in
.. |image5| image:: /_static/class3/image7.png
   :width: 2.99375in
   :height: 2.42569in
.. |image6| image:: /_static/class3/image8.png
   :width: 2.97778in
   :height: 2.66458in
.. |image7| image:: /_static/class3/image9.png
   :width: 5.30694in
   :height: 3.12847in
.. |image8| image:: /_static/class3/image10.png
   :width: 5.35833in
   :height: 4.54097in
.. |image9| image:: /_static/class3/image11.png
   :width: 3.50000in
   :height: 1.58889in
.. |image10| image:: /_static/class3/image12.png
   :width: 5.22083in
   :height: 4.91736in
.. |image11| image:: /_static/class3/image13.png
   :width: 5.40278in
   :height: 1.57222in
.. |image12| image:: /_static/class3/image14.png
   :width: 4.91458in
   :height: 3.24722in
.. |image13| image:: /_static/class3/image15.png
   :width: 5.19653in
   :height: 3.96181in
.. |image14| image:: /_static/class3/image16.png
   :width: 5.58958in
   :height: 2.93333in
.. |image15| image:: /_static/class3/image17.png
   :width: 4.96736in
   :height: 1.67153in
.. |image16| image:: /_static/class3/image18.png
   :width: 1.90556in
   :height: 2.55139in
.. |image17| image:: /_static/class3/image19.png
   :width: 4.91459in
   :height: 5.05600in
.. |image18| image:: /_static/class3/image20.png
   :width: 3.93600in
   :height: 3.97152in
.. |image19| image:: /_static/class3/image21.png
   :width: 2.44262in
   :height: 2.39685in
.. |image20| image:: /_static/class3/image22.png
   :width: 4.83200in
   :height: 2.86912in
.. |image21| image:: /_static/class3/image23.png
   :width: 5.31000in
   :height: 2.48000in
.. |image22| image:: /_static/class3/image24.png
   :width: 4.17000in
   :height: 2.10168in
.. |image23| image:: /_static/class3/image25.png
   :width: 5.33000in
   :height: 2.17000in