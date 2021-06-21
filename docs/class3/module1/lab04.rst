Lab 4: SAML Identity Provider (IdP) - LocalDB Auth
======================================================



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

#. Hover over tile **SAML Identity Provider (IdP) - LocalDB Auth**. A start and stop icon should appear within the tile.  Click the **Play** Button to start the automation to build the environment

   +---------------+-------------+
   | |image050|    | |image004|  |
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
   **Security Settings** in the left navigation pane and key in
   the following:

   +----------------------+---------------------------------------+
   | Signing Key:         | ``/Common/idp.acme.com`` (drop down)  |
   +----------------------+---------------------------------------+
   | Signing Certificate: | ``/Common/idp.acme.com`` (drop down)  |
   +----------------------+---------------------------------------+

   .. NOTE:: The certificate and key were previously imported

#. Click **OK** to complete the creation of the IdP service

   |image009|

SP Connector
~~~~~~~~~~~~~~~~~

#. Click on **External SP Connectors** (under the **SAML Identity Provider**
   tab) in the horizontal navigation menu

#. Click specifically on the **Down Arrow** next to the **Create** button
   (far right)

#. Select **From Metadata** from the drop down menu

   |image010|

#. In the **Create New SAML Service Provider** dialogue box, click **Browse**
   and select the *sp_acme_com.xml* file from the Desktop of
   your jump host

#. In the **Service Provider Name** field, enter the following:
   ``sp.acme.com``

#. Click **OK** on the dialog box

   |image011|

   .. NOTE:: The sp_acme_com.xml file was created previously.
      Oftentimes SP providers will have a metadata file representing their
      SP service. This can be imported to save object creation time as has
      been done in this lab.

#. Click on **Local IdP Services** (under the **SAML Identity Provider** tab)
   in the horizontal navigation menu

   |image012|

#. Select the **Checkbox** next to the previously created ``idp.acme.com``
   and click the **Bind/Unbind SP Connectors** button at the bottom of the GUI

   |image013|

#. In the **Edit SAML SP's that use this IdP** dialog, select the
   ``/Common/sp.acme.com`` SAML SP Connection Name created previously

#. Click the **OK** button at the bottom of the dialog box

   |image014|

#. Under the **Access ‑> Federation ‑> SAML Identity Provider ‑>
   Local IdP Services** menu you should now see the following (as shown):

   +---------------------+------------------------+
   | Name:               | ``idp.acme.com``       |
   +---------------------+------------------------+
   | SAML SP Connectors: | ``sp.acme.com``        |
   +---------------------+------------------------+

   |image015|

TASK 3 - Create a SAML Resource
-------------------------------------


#. Begin by selecting **Access ‑> Federation ‑> SAML Resources >> **+** (Plus Button)

   |image016|

#. In the **New SAML Resource** window, enter the following values:

   +--------------------+------------------------+
   | Name:              | ``sp.acme.com``        |
   +--------------------+------------------------+
   | SSO Configuration: | ``idp.acmem.com``      |
   +--------------------+------------------------+
   | Caption:           | ``sp.acme.com``        |
   +--------------------+------------------------+

#. Click **Finished** at the bottom of the configuration window

   |image017|



Task 4 - Create a Webtop
-------------------------------

#. Select Access ‑> Webtops ‑> Webtop Lists >> **+** (Plus Button)


   |image018|

#. In the resulting window, enter the following values:

   +------------------+----------------------+
   | Name:            | ``full_webtop``      |
   +------------------+----------------------+
   | Type:            | ``Full`` (drop down) |
   +------------------+----------------------+
   | Minimize To Tray | ``uncheck``          |
   +------------------+----------------------+

#. Click **Finished** at the bottom of the GUI

   |image019|


Task 5 - Create a Local Dabasebase 
----------------------------------------

#. Navigate to Access >> Authentication >> Local User DB >> Instances >> **+** (Plus Symbol).  


   |image020|

#. In the **Create New Local User DB Instance** window, enter the following information:

   +-------------------------------+------------------+
   | Name:                         | ``users``        |
   +-------------------------------+------------------+
   | Lockout Interval:             | ``600``          |
   +-------------------------------+------------------+
   | Lockoout Threshold:           | ``3``            |
   +-------------------------------+------------------+
   | Dynamic User Remove Interval: | ``1800``         |
   +-------------------------------+------------------+
  

#. Click **OK**

   |image021|

#. Navigate to Access >> Authentication >> Local User DB >> Users >> **+** (Plus Symbol).  

   |image022|

#. In the **User Information** window, enter the following information:

   +-------------------------------+------------------+
   | User Name:                    | ``user1``        |
   +-------------------------------+------------------+
   | Password:                     | ``user1``        |
   +-------------------------------+------------------+
   | Confirm Password:             | ``user1``        |
   +-------------------------------+------------------+


#. Click **OK**

   |image023|

Task 6 - Create a SAML IdP Access Policy
---------------------------------------------

#. Select **Access ‑> Profiles/Policies ‑> Access Profiles
   (Per-Session Policies)**

#. Click the **Create** button (far right)

   |image024|

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

   |image025|

#. Scroll to the bottom of the **New Profile** window to the
   **Language Settings** section

#. Select *English* from the **Factory Built‑in Languages** menu on the
   right and click the **Double Arrow (<<)**, then click the **Finished**
   button.

#. The **Default Language** should be automatically set

   |image026|

#. From the **Access ‑> Profiles/Policies ‑> Access Profiles
   (Per-Session Policies) screen**, click the **Edit** link on the previously
   created ``idp.acme.com-psp`` line

   |image027|

#. Click the **Plus (+) Sign** between **Start** and **Deny**

   |image028|

#. In the pop-up dialog box, select the **Logon** tab and then select the
   **Radio** next to **Logon Page**, and click the **Add Item** button

   |image029|

#. Click **Save** in the resulting Logon Page dialog box

   |image030|

#. Click the **Plus (+) Sign** between **Logon Page** and **Deny**

   |image031|

#. In the pop-up dialog box, select the **Authentication** tab and then
   select the **Radio** next to **LocalDB Auth**, and click the **Add Item** button

   |image032|

#. In the resulting **LocalDB Auth** pop-up window, select ``/Common/users``
   from the **LocalDB Instance** drop down menu

#. Click **Save** at the bottom of the window

   |image033|

#. Click the **Plus (+) Sign** on the successful branch between **LocalDB Auth**
   and **Deny**

   |image034|

#. In the pop-up dialog box, select the **Assignment** tab and then select
   the **Radio** next to **Advanced Resource Assign**, and click the
   **Add Item** button

   |image035|

#. In the resulting **Advanced Resource Assign** pop-up window, click
   the **Add New Entry** button

#. In the new Resource Assignment entry, click the **Add/Delete** link

   |image036|

#. In the resulting pop-up window, click the **SAML** tab, and select the
   **Checkbox** next to */Common/sp.acme.com*

   |image037|

#. Click the **Webtop** tab, and select the **Checkbox** next to
   ``/Common/full_webtop``

#. Click the **Update** button at the bottom of the window to complete
   the Resource Assignment entry

   |image038|


#. Click the **Save** button at the bottom of the **Advanced Resource Assign** window

   |image039|


#. In the **Visual Policy Editor**, select the **Deny** ending on the
   fallback branch following **Advanced Resource Assign**

   |image040|

#. In the **Select Ending** dialog box, selet the **Allow** radio button
   and then click **Save**

   |image041|

#. In the **Visual Policy Editor**, click **Apply Access Policy**
   (top left), and close the **Visual Policy Editor**

   |image042|


TASK 7 - Create the IdP Virtual Server
----------------------------------------


#. Begin by selecting **Local Traffic ‑> Virtual Servers**

#. Click the **Create** button (far right)

   |image043|

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

   |image044|

   +---------------------------+------------------------------+
   | Configuration                                            |
   +===========================+==============================+
   | HTTP Profile:             | ``http`` (drop down)         |
   +---------------------------+------------------------------+
   | SSL Profile (Client)      | ``wildcard.acme.com``        |
   +---------------------------+------------------------------+

   |image045|

   +-----------------+---------------------------+
   | Access Policy                               |
   +=================+===========================+
   | Access Profile: | ``idp.acme.com-psp``      |
   +-----------------+---------------------------+

   |image046|


#. Scroll to the bottom of the configuration window and click **Finished**


TASK 8 - Test the Configuration
------------------------------------------

#. From the jumphost, navigate to the SAML IdP you previously configured at **https://idp.acme.com**.  

#. Logon with the the following credentials: 

   - Username:**user1** 
   - Password:**user1**

   |image047|
  
#. Click **sp.acme.com**

   |image048|

#. You are then successfully logged into https://sp.acme.com and presented a webpage.

   |image049|

#. Review your Active Sessions **(Access ‑> Overview ‑> Active Sessions­­­)**

#. Review your Access Report Logs **(Access ‑> Overview ‑> Access Reports)**


Task 9 - Lab Cleanup
------------------------

#. From a browser on the jumphost navigate to https://portal.f5lab.local

#. Click the **Classes** tab at the top of the page.

   |image002|

#. Scroll down the page until you see **301 SAML Federation** on the left

   |image003|

#. Hover over tile **SAML Identity Provider (IdP) - LocalDB Auth**. A start and stop icon should appear within the tile.  Click the **Stop** Button to trigger the automation to remove any prebuilt objects from the environment

   +---------------+-------------+
   | |image050|    | |image998|  |
   +---------------+-------------+ 

#. The screen should refresh displaying the progress of the automation within 30 seconds.  Scroll to the bottom of the automation workflow to ensure all requests succeeded.  If you you experience errors try running the automation a second time or open an issue on the `Access Labs Repo <https://github.com/f5devcentral/access-labs>`__.

   |image999|

#. This concludes the lab.

   |image000|


.. |image000| image:: ./media/lab04/000.png
.. |image001| image:: ./media/lab04/001.png
.. |image002| image:: ./media/lab04/002.png
.. |image003| image:: ./media/lab04/003.png
.. |image004| image:: ./media/lab04/004.png
.. |image005| image:: ./media/lab04/005.png
.. |image006| image:: ./media/lab04/006.png
.. |image007| image:: ./media/lab04/007.png
.. |image008| image:: ./media/lab04/008.png
.. |image009| image:: ./media/lab04/009.png
.. |image010| image:: ./media/lab04/010.png
.. |image011| image:: ./media/lab04/011.png
.. |image012| image:: ./media/lab04/012.png
.. |image013| image:: ./media/lab04/013.png
.. |image014| image:: ./media/lab04/014.png
.. |image015| image:: ./media/lab04/015.png
.. |image016| image:: ./media/lab04/016.png
.. |image017| image:: ./media/lab04/017.png
.. |image018| image:: ./media/lab04/018.png
.. |image019| image:: ./media/lab04/019.png
.. |image020| image:: ./media/lab04/020.png
.. |image021| image:: ./media/lab04/021.png
.. |image022| image:: ./media/lab04/022.png
.. |image023| image:: ./media/lab04/023.png
.. |image024| image:: ./media/lab04/024.png
.. |image025| image:: ./media/lab04/025.png
.. |image026| image:: ./media/lab04/026.png
.. |image027| image:: ./media/lab04/027.png
.. |image028| image:: ./media/lab04/028.png
.. |image029| image:: ./media/lab04/029.png
.. |image030| image:: ./media/lab04/030.png
.. |image031| image:: ./media/lab04/031.png
.. |image032| image:: ./media/lab04/032.png
.. |image033| image:: ./media/lab04/033.png
.. |image034| image:: ./media/lab04/034.png
.. |image035| image:: ./media/lab04/035.png
.. |image036| image:: ./media/lab04/036.png
.. |image037| image:: ./media/lab04/037.png
.. |image038| image:: ./media/lab04/038.png
.. |image039| image:: ./media/lab04/039.png
.. |image040| image:: ./media/lab04/040.png
.. |image041| image:: ./media/lab04/041.png
.. |image042| image:: ./media/lab04/042.png
.. |image043| image:: ./media/lab04/043.png
.. |image044| image:: ./media/lab04/044.png
.. |image045| image:: ./media/lab04/045.png
.. |image046| image:: ./media/lab04/046.png
.. |image047| image:: ./media/lab04/047.png
.. |image048| image:: ./media/lab04/048.png
.. |image049| image:: ./media/lab04/049.png
.. |image050| image:: ./media/lab04/050.png
.. |image998| image:: ./media/lab04/998.png
.. |image999| image:: ./media/lab04/999.png

