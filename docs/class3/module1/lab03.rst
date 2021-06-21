Lab 3: SAML Identity Provider (IdP) - kerberos Auth
======================================================

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

Task 1 - Setup Lab Environment
-----------------------------------

To access your dedicated student lab environment, you will need a web browser and Remote Desktop Protocol (RDP) client software. The web browser will be used to access the Unified Demo Framework (UDF) Training Portal. The RDP client will be used to connect to the jumphost, where you will be able to access the BIG-IP management interfaces (HTTPS, SSH).

#. Click **DEPLOYMENT** located on the top left corner to display the environment

#. Click **ACCESS** next to jumphost.f5lab.local

   |image001|

#. Select your RDP resolution.

#. The RDP client on your local host establishes a RDP connection to the Jump Host.

#. Login with the following credentials:

         - User: **f5lab\\user1**
         - Password: **user1**

#. After successful logon the Chrome browser will auto launch opening the site https://portal.f5lab.local.  This process usually takes 30 seconds after logon.

#. Click the **Classes** tab at the top of the page.

	|image002|

#. Scroll down the page until you see **301 SAML Federation** on the left

   |image003|

#. Hover over tile **SAML Identity Provider (IdP) - Kerberos Auth**. A start and stop icon should appear within the tile.  Click the **Play** Button to start the automation to build the environment

   +---------------+-------------+
   | |image062|    | |image004|  |
   +---------------+-------------+ 

#. The screen should refresh displaying the progress of the automation within 30 seconds.  Scroll to the bottom of the automation workflow to ensure all requests succeeded.  If you experience errors try running the automation a second time or open an issue on the `Access Labs Repo <https://github.com/f5devcentral/access-labs>`__.

   |image005|



TASK 2 ‑ Configure the SAML Identity Provider (IdP)
--------------------------------------------------------

IdP Service
~~~~~~~~~~~~~~~~

#. Begin by selecting: **Access ‑> Federation ‑> SAML Identity Provider
   ‑> Local IdP Services**

#. Click the **Create** button (far right)

   |image006|

#. In the **Create New SAML IdP Service** dialog box, click **General Settngs**
   in the left navigation pane and key in the following:

   +-------------------+--------------------------------+
   | IdP Service Name: | ``idp.acme.com``               |
   +-------------------+--------------------------------+
   | IdP Entity ID:    | ``https://idp.acme.com``       |
   +-------------------+--------------------------------+

   |image007|

   .. NOTE:: The yellow box on "Host" will disappear when the Entity ID is
      entered

#. In the **Create New SAML IdP Service** dialog box, click **Assertion
   Settings** in the left navigation pane and key in the following:

   +--------------------------+------------------------------------------------+
   | Assertion Subject Type:  | ``Persistent Identifier`` (drop down)          |
   +--------------------------+------------------------------------------------+
   | Assertion Subject Value: | ``%{session.logon.last.username}`` (drop down) |
   +--------------------------+------------------------------------------------+

   |image008|

#. In the **Create New SAML IdP Service** dialog box, click
   **SAML Attributes** in the left navigation pane and click the
   **Add** button as shown

    |image009|

#. In the **Name** field in the resulting pop-up window, enter the
   following: ``emailaddress``

#. Under **Attribute Values**, click the **Add** button

#. In the **Values** line, enter the following: ``%{session.ad.last.attr.mail}``

#. Click the **Update** button

#. Click the **OK** button

   |image010|

#. In the **Create New SAML IdP Service** dialog box, click
   **Security Settings** in the left navigation pane and key in
   the following:

   +----------------------+---------------------------------------+
   | Signing Key:         | ``/Common/idp.acme.com`` (drop down)  |
   +----------------------+---------------------------------------+
   | Signing Certificate: | ``/Common/idp.acme.com`` (drop down)  |
   +----------------------+---------------------------------------+

   .. NOTE:: The certificate and key were previously imported

#. Click **OK** to complete the creation of the IdP service

   |image011|

SP Connector
~~~~~~~~~~~~~~~~~

#. Click on **External SP Connectors** (under the **SAML Identity Provider**
   tab) in the horizontal navigation menu

#. Click specifically on the **Down Arrow** next to the **Create** button
   (far right)

#. Select **From Metadata** from the drop down menu

   |image012|

#. In the **Create New SAML Service Provider** dialogue box, click **Browse**
   and select the *sp_acme_com.xml* file from the Desktop of
   your jump host

#. In the **Service Provider Name** field, enter the following:
   ``sp.acme.com``

#. Click **OK** on the dialog box

   |image013|

   .. NOTE:: The sp_acme_com.xml file was created previously.
      Oftentimes SP providers will have a metadata file representing their
      SP service. This can be imported to save object creation time as has
      been done in this lab.

#. Click on **Local IdP Services** (under the **SAML Identity Provider** tab)
   in the horizontal navigation menu

   |image014|

#. Select the **Checkbox** next to the previously created ``idp.acme.com``
   and click the **Bind/Unbind SP Connectors** button at the bottom of the GUI

   |image015|

#. In the **Edit SAML SP's that use this IdP** dialog, select the
   ``/Common/sp.acme.com`` SAML SP Connection Name created previously

#. Click the **OK** button at the bottom of the dialog box

   |image016|

#. Under the **Access ‑> Federation ‑> SAML Identity Provider ‑>
   Local IdP Services** menu you should now see the following (as shown):

   +---------------------+------------------------+
   | Name:               | ``idp.acme.com``       |
   +---------------------+------------------------+
   | SAML SP Connectors: | ``sp.acme.com``        |
   +---------------------+------------------------+

   |image017|

TASK 3 - Create a SAML Resource
-------------------------------------

#. Begin by selecting **Access ‑> Federation ‑> SAML Resources >> **+** (Plus Button)

   |image018|

#. In the **New SAML Resource** window, enter the following values:

   +--------------------+------------------------+
   | Name:              | ``sp.acme.com``        |
   +--------------------+------------------------+
   | SSO Configuration: | ``idp.acmem.com``      |
   +--------------------+------------------------+
   | Caption:           | ``sp.acme.com``        |
   +--------------------+------------------------+

#. Click **Finished** at the bottom of the configuration window

   |image019|



Task 4 - Create a Webtop
-------------------------------

#. Select Access ‑> Webtops ‑> Webtop Lists >> **+** (Plus Button)


   |image020|

#. In the resulting window, enter the following values:

   +------------------+----------------------+
   | Name:            | ``full_webtop``      |
   +------------------+----------------------+
   | Type:            | ``Full`` (drop down) |
   +------------------+----------------------+
   | Minimize To Tray | ``uncheck``          |
   +------------------+----------------------+

#. Click **Finished** at the bottom of the GUI

   |image021|


Task 5 - Create a Kerberos AAA Object
----------------------------------------

#. From the jumphost, navigate to the command line enter the command below to generate a kerberos key tab file

   ``ktpass -princ HTTP/idp.acme.com@F5LAB.LOCAL -mapuser f5lab\krbtsrv -ptype KRB5_NT_PRINCIPAL -pass ’P@$$w0rd' -out C:\Users\user1\Desktop\out.keytab``

   |image022|

#. From the BIG-IP GUI, navigate to Access >> Authentication >> Kerberos >> Click the **+** Plus Symbol


   |image023|

   +------------------+-------------------------+
   | Name:            | ``idp.acme.com``        |
   +------------------+-------------------------+
   | SPN Format:      | ``Host-based service``  |
   +------------------+-------------------------+
   | Auth Realm:      | ``F5LAB.LOCAL``         |
   +------------------+-------------------------+
   | Service Name:    | ``HTTP``                |
   +------------------+-------------------------+
   | Keytab File:     | ``out.keytab``          |
   +------------------+-------------------------+

#. Click **Finished**

   |image024|



Task 6 - Create a SAML IdP Access Policy
---------------------------------------------

#. Select **Access ‑> Profiles/Policies ‑> Access Profiles
   (Per-Session Policies)**

#. Click the **Create** button (far right)

   |image025|

#. In the **New Profile** window, enter the following information:

   +----------------------+---------------------------+
   | Name:                | ``idp.acme.com‑psp``      |
   +----------------------+---------------------------+
   | Profile Type:        | ``All`` (drop down)       |
   +----------------------+---------------------------+
   | Profile Scope:       | ``Profile`` (default)     |
   +----------------------+---------------------------+
   | Customization Type:  | ``modern`` (default)      |
   +----------------------+---------------------------+

   |image026|

#. Scroll to the bottom of the **New Profile** window to the
   **Language Settings** section

#. Select *English* from the **Factory Built‑in Languages** menu on the
   right and click the **Double Arrow (<<)**, then click the **Finished**
   button.

#. The **Default Language** should be automatically set

   |image027|

#. From the **Access ‑> Profiles/Policies ‑> Access Profiles
   (Per-Session Policies) screen**, click the **Edit** link on the previously
   created ``idp.acme.com-psp`` line

   |image028|

#. Click the **Plus (+) Sign** between **Start** and **Deny**

   |image029|

#. In the pop-up dialog box, select the **Logon** tab and then select the
   **Radio** next to **HTTP 401 Response**, and click the **Add Item** button

   |image030|

#. In the **HTTP 401 Response** dialog box, enter the following information:

   +-------------------+---------------------------------+
   | HTTP Auth Level:  | ``negotiate`` (drop down)       |
   +-------------------+---------------------------------+

#. Click the **Save** button at the bottom of the dialog box

   |image031|

#. Click the **Branch Rules** tab
#. Click the **X** on the Basic Branch

   |image032|

#. Click **Save**

   |image033|

#. Click the **+** (Plus symbo) on the negotiate branch

   |image034|

#. Click the **Authentication** tab
#. Select **Kerberos Auth**
#. Click **Add Item**

   |image035|

#. In the **Kerberos Auth** dialog box, enter the following information:

   +-----------------------+--------------------------------------------+
   | AAA Server:           | ``/Common/idp.acme.com`` (drop down)       |
   +-----------------------+--------------------------------------------+
   | Request Based Auth:   | ``Enabled`` (drop down)                    |
   +-----------------------+--------------------------------------------+

#. Click **Save**

   |image036|

#. Click the **Plus (+) Sign** on the **Successful** branch between **Kerberos Auth** and **Deny**

   |image037|

#. In the pop-up dialog box, select the **Authentication** tab and then
   select the **Radio** next to **AD Query**, and click the **Add Item** button

   |image038|

#. In the resulting **AD Query** pop-up window, select
   ``/Commmon/f5lab.local`` from the **Server** drop down menu

#. In the **SearchFilter** field, enter the following value:
   ``userPrincipalName=%{session.logon.last.username}``

   |image039|

#. In the **AD Query** window, click the **Branch Rules** tab

#. Change the **Name** of the branch to *Successful*.

#. Click the **Change** link next to the **Expression**

   |image040|

#. In the resulting pop-up window, delete the existing expression by clicking
   the **X** as shown

   |image041|

#. Create a new **Simple** expression by clicking the **Add Expression** button

   |image042|

#. In the resulting menu, select the following from the drop down menus:

   +------------+---------------------+
   | Agent Sel: | ``AD Query``        |
   +------------+---------------------+
   | Condition: | ``AD Query Passed`` |
   +------------+---------------------+

#. Click the **Add Expression** Button

   |image043|

#. Click the **Finished** button to complete the expression

   |image044|

#. Click the **Save** button to complete the **AD Query**

   |image045|

#. Click the **Plus (+) Sign** on the **Successful** branch between
   **AD Query** and **Deny**

   |image046|

#. In the pop-up dialog box, select the **Assignment** tab and then select
   the **Radio** next to **Advanced Resource Assign**, and click the
   **Add Item** button

   |image047|

#. In the resulting **Advanced Resource Assign** pop-up window, click
   the **Add New Entry** button

#. In the new Resource Assignment entry, click the **Add/Delete** link

   |image048|

#. In the resulting pop-up window, click the **SAML** tab, and select the
   **Checkbox** next to */Common/sp.acme.com*

   |image049|

#. Click the **Webtop** tab, and select the **Checkbox** next to
   ``/Common/full_webtop``

#. Click the **Update** button at the bottom of the window to complete
   the Resource Assignment entry

     |image050|


#. Click the **Save** button at the bottom of the **Advanced Resource Assign** window

   |image051|


#. In the **Visual Policy Editor**, select the **Deny** ending on the
   fallback branch following **Advanced Resource Assign**

   |image052|

#. In the **Select Ending** dialog box, selet the **Allow** radio button
   and then click **Save**

   |image053|

#. In the **Visual Policy Editor**, click **Apply Access Policy**
   (top left), and close the **Visual Policy Editor**

   |image054|

TASK 7 - Create the IdP Virtual Server
----------------------------------------


#. Begin by selecting **Local Traffic ‑> Virtual Servers**

#. Click the **Create** button (far right)

   |image055|

#. In the **New Virtual Server** window, enter the following information:

   +---------------------------+------------------------------+
   | General Properties                                       |
   +===========================+==============================+
   | Name:                     | ``idp.acme.com``             |
   +---------------------------+------------------------------+
   | Destination Address/Mask: | ``10.1.10.102``              |
   +---------------------------+------------------------------+
   | Service Port:             | ``443``                      |
   +---------------------------+------------------------------+

   |image056|

   +---------------------------+------------------------------+
   | Configuration                                            |
   +===========================+==============================+
   | HTTP Profile:             | ``http`` (drop down)         |
   +---------------------------+------------------------------+
   | SSL Profile (Client)      | ``wildcard.acme.com``        |
   +---------------------------+------------------------------+

   |image057|

   +-----------------+---------------------------+
   | Access Policy                               |
   +=================+===========================+
   | Access Profile: | ``idp.acme.com-psp``      |
   +-----------------+---------------------------+

   |image058|


#. Scroll to the bottom of the configuration window and click **Finished**


TASK 8 - Test the Configuration
-----------------------------------

#. From the jumphost, navigate to the SAML IdP you previously configured at *https://idp.acme.com*.  Noticee you are automatically signed into the IDP. 
  
#. Click **sp.acme.com**

   |image059|

#.  You are then successfully logged into https://sp.acme.com and presented a webpage.

   |image060|

#. From the jumphost CLI, type klist.  You will see there is a kerberos ticket for HTTP/idp.acme.com@F5LAB.LOCAL

   |image061|


#. Review your Active Sessions **(Access ‑> Overview ‑> Active Sessions­­­)**

#. Review your Access Report Logs **(Access ‑> Overview ‑> Access Reports)**


Task 9 - Lab Cleanup
------------------------

#. From a browser on the jumphost navigate to https://portal.f5lab.local

#. Click the **Classes** tab at the top of the page.

   |image002|

#. Scroll down the page until you see **301 SAML Federation** on the left

   |image003|

#. Hover over tile **SAML Identity Provider (IdP) - Kerberos Auth**. A start and stop icon should appear within the tile.  Click the **Stop** Button to trigger the automation to remove any prebuilt objects from the environment

   +---------------+-------------+
   | |image062|    | |image998|  |
   +---------------+-------------+ 

#. The screen should refresh displaying the progress of the automation within 30 seconds.  Scroll to the bottom of the automation workflow to ensure all requests succeeded.  If you you experience errors try running the automation a second time or open an issue on the `Access Labs Repo <https://github.com/f5devcentral/access-labs>`__.

   |image999|

#. This concludes the lab.

   |image000|


.. |image000| image:: ./media/lab03/000.png
.. |image001| image:: ./media/lab03/001.png
.. |image002| image:: ./media/lab03/002.png
.. |image003| image:: ./media/lab03/003.png
.. |image004| image:: ./media/lab03/004.png
.. |image005| image:: ./media/lab03/005.png
.. |image006| image:: ./media/lab03/006.png
.. |image007| image:: ./media/lab03/007.png
.. |image008| image:: ./media/lab03/008.png
.. |image009| image:: ./media/lab03/009.png
.. |image010| image:: ./media/lab03/010.png
.. |image011| image:: ./media/lab03/011.png
.. |image012| image:: ./media/lab03/012.png
.. |image013| image:: ./media/lab03/013.png
.. |image014| image:: ./media/lab03/014.png
.. |image015| image:: ./media/lab03/015.png
.. |image016| image:: ./media/lab03/016.png
.. |image017| image:: ./media/lab03/017.png
.. |image018| image:: ./media/lab03/018.png
.. |image019| image:: ./media/lab03/019.png
.. |image020| image:: ./media/lab03/020.png
.. |image021| image:: ./media/lab03/021.png
.. |image022| image:: ./media/lab03/022.png
.. |image023| image:: ./media/lab03/023.png
.. |image024| image:: ./media/lab03/024.png
.. |image025| image:: ./media/lab03/025.png
.. |image026| image:: ./media/lab03/026.png
.. |image027| image:: ./media/lab03/027.png
.. |image028| image:: ./media/lab03/028.png
.. |image029| image:: ./media/lab03/029.png
.. |image030| image:: ./media/lab03/030.png
.. |image031| image:: ./media/lab03/031.png
.. |image032| image:: ./media/lab03/032.png
.. |image033| image:: ./media/lab03/033.png
.. |image034| image:: ./media/lab03/034.png
.. |image035| image:: ./media/lab03/035.png
.. |image036| image:: ./media/lab03/036.png
.. |image037| image:: ./media/lab03/037.png
.. |image038| image:: ./media/lab03/038.png
.. |image039| image:: ./media/lab03/039.png
.. |image040| image:: ./media/lab03/040.png
.. |image041| image:: ./media/lab03/041.png
.. |image042| image:: ./media/lab03/042.png
.. |image043| image:: ./media/lab03/043.png
.. |image044| image:: ./media/lab03/044.png
.. |image045| image:: ./media/lab03/045.png
.. |image046| image:: ./media/lab03/046.png
.. |image047| image:: ./media/lab03/047.png
.. |image048| image:: ./media/lab03/048.png
.. |image049| image:: ./media/lab03/049.png
.. |image050| image:: ./media/lab03/050.png
.. |image051| image:: ./media/lab03/051.png
.. |image052| image:: ./media/lab03/052.png
.. |image053| image:: ./media/lab03/053.png
.. |image054| image:: ./media/lab03/054.png
.. |image055| image:: ./media/lab03/055.png
.. |image056| image:: ./media/lab03/056.png
.. |image057| image:: ./media/lab03/057.png
.. |image058| image:: ./media/lab03/058.png
.. |image059| image:: ./media/lab03/059.png
.. |image060| image:: ./media/lab03/060.png
.. |image061| image:: ./media/lab03/061.png
.. |image062| image:: ./media/lab03/062.png
.. |image998| image:: ./media/lab03/998.png
.. |image999| image:: ./media/lab03/999.png
