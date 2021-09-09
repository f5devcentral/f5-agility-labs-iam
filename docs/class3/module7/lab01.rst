Lab 1: Cert Auth to Kerberos SSO
=====================================

Task 1 - Setup Lab Environment
-----------------------------------

To access your dedicated student lab environment, you will require a web browser and Remote Desktop Protocol (RDP) client software. The web browser will be used to access the Lab Training Portal. The RDP client will be used to connect to the Jump Host, where you will be able to access the BIG-IP management interfaces (HTTPS, SSH).

#. Click **DEPLOYMENT** located on the top left corner to display the environment

#. Click **ACCESS** next to jumpohost.f5lab.local

   |image001|

#. Select your RDP resolution.

#. The RDP client on your local host establishes a RDP connection to the Jump Host.

#. Login with the following credentials:

         - User: **f5lab\\user1**
         - Password: **user1**

#. After successful logon the Chrome browser will auto launch opening the site https://portal.f5lab.local.  This process usually takes 30 seconds after logon.

#. Click the **Classes** tab at the top of the page.

	|image002|

#. Scroll down the page until you see **306 Per-Session Access Control** on the left

   |image003|

#. Hover over tile **Cert Auth to Kerberos SSOs**. A start and stop icon should appear within the tile.  Click the **Play** Button to start the automation to build the environment

   +---------------+-------------+
   | |image004|    | |image005|  |
   +---------------+-------------+

#. The screen should refresh displaying the progress of the automation within 30 seconds.  Scroll to the bottom of the automation workflow to ensure all requests succeeded.  If you experience errors try running the automation a second time or open an issue on the `Access Labs Repo <https://github.com/f5devcentral/access-labs>`__.

   |image006|

Task 2 - Create an OCSP Responder
-----------------------------------

#. From a browser navigate to https://bigip1.f5lab.local

#. Login with username **admin** and password **admin**

    |image009|

#. Navigate to Access >> Authentiction >> OCSP Responder >> click the **Plus Sign(+)**.

    |image010|

#. Enter the Name **cer2kerb-ocsp**
#. From the Configuration dropdown menu select **Advanced**
#. From the Certificate Authority File dropdown menu select **ca.f5lab.local**
#. Enter the Certifcate Authority Path **/ocsp**
#. Uncheck **Nonce**
#. Click **Finished**

    |image011|



Task 3 - Create an LDAP AAA Server
------------------------------------------------

#. Navigate to Access >> Authentiction >> LDAP >> click the **Plus Sign(+)**.

    |image012|

#. Enter the Name **ldap-servers**
#. Enter the Server Pool Name **ldap-pool**
#. Add the server address **10.1.20.7**
#. Enter the Admin DN **CN=admin,CN=Users,DC=f5lab,DC=local**
#. Enter the Admin Password **admin**
#. Click **Finished**

    |image013|


Task 4 - Create a Kerberos SSO 
--------------------------------

#. Navigate to Access >> Single Sign-On >> Kerberos >> click the **Plus Sign(+)**.

    |image014|

#. Enter the Name **kerb-sso**
#. Enter the Kerberos Realm **F5LAB.LOCAL**
#. Enter the Account Name **HOST/cert2kerb.f5lab.local**
#. Enter Account Password **cert2kerb**
#. From the Send Authorization dropdown menu select **On 401 Status Code**
#. Click **Finished**

    |image015|




Task 5 - Create a per-session policy
---------------------------------------

#. Navigate to Access >> Profiles/Polcies >> Access Profiles (Per-Session Policies) >> click the **Plus Sign(+)**.

    |image016|

#. Enter the Name **cert2kerb**
#. From the Profile Type dropdown menu select **All**

    |image017|

#. Scroll to the bottom of the **New Profile** window to the
   **Language Settings**
#. Select *English* from the **Factory Built‑in Languages** on the right,
   and click the **Double Arrow (<<)**, then click the **Finished** button.

   |image018|

#. From the **Access ‑> Profiles/Policies ‑> Access Profiles
   (Per‑Session Policies)** screen, click the **Edit** link on the previously
   created ``cert2kerb`` line

   |image019|

#. In the Visual Policy Editor window for ``/Common/cert2kerb``,
   click the **Plus (+) Sign** between **Start** and **Deny**

   |image020|

#. In the pop‑up dialog box, select the **Authentication** tab and then click
   the **Radio Button** next to **On-Demand Cert Auth**

#. Once selected, click the **Add Item** button

   |image021|

#. Leave the Auth Mode the default of **request**
#. Click **Save**

    |image022|

#. Click the **Plus (+) Sign** on the Successful branch of the On-demand Cert Auth policy item.

   |image023|  

#. In the pop‑up dialog box, select the **Authentication** tab and then click
   the **Radio Button** next to **OCSP Auth**

#. Once selected, click the **Add Item** button

   |image024|    

#. Select **/Common/cert2kerb-ocsp** from the OCSP Responder dropdown menu
#. Click **Save**

    |image025|

#. Click the **Plus (+) Sign** on the Successful branch of the OCSP Auth policy item.

   |image026|    

#. In the pop‑up dialog box, select the **Assignment** tab and then click
   the **Radio Button** next to **Variable Assign**

#. Once selected, click the **Add Item** button

   |image027|  

#. Change the name to **upn_extract**
#. Click **Add new entry**
#. Click **change**

    |image028|

#. Enter the Custom Variable **session.custom.upn**
#. Enter the text below for the **custom expression**

    .. code-block:: text

        session.custom.upn = set x509e_fields [split [mcget {session.ssl.cert.x509extension}] "\n"];
        # For each element in the list:
        foreach field $x509e_fields {
        # If the element contains UPN:
        if { $field contains "othername:UPN" } {
        ## set start of UPN variable
        set start [expr {[string first "othername:UPN<" $field] +14}]
        # UPN format is <user@domain>
        # Return the UPN, by finding the index of opening and closing brackets, then use string range to get everything between.
        return [string range $field $start [expr { [string first ">" $field $start] - 1 } ] ];  } }
        #Otherwise return UPN Not Found:
        return "UPN-NOT-FOUND";

#. Click **Finished**

    |image029|

#. Click **Save**

    |image030|

#. Click the **Plus (+) Sign** on the Successful branch of the upn_extract policy item.

   |image031|    

#. In the pop‑up dialog box, select the **Authentication** tab and then click
   the **Radio Button** next to **LDAP Query**

#. Once selected, click the **Add Item** button

   |image032|  

#. Select **/Common/ldap-servers** from the Server dropdown menu
#. Enter the SearchDN **dc=f5lab,dc=local**
#. Enter the SearchFilter **(userPrincipalName=%{session.custom.upn})**
#. Click **Add new entry**
#. Enter the Required Attribute **sAMAccountName**
#. Click **Save**

    |image033|

#. Click **Branch Rules**
#. Click the **x** on User Group Membership Line to delete it.

    |image034|

#. Click **Add Branch Rule**
#. Enter the name **Query Passed**
#. Click **change**

    |image035|

#. Click **Add Expression**

    |image036|

#. From the Context dropdown Menu select **LDAP Query**
#. From the Condition dropdown Menu select **LDAP Query Passed**   
#. Click **Add Expression**

    |image037|

#. Click **Finished**

    |image038|

#. Click **Save**

    |image039|

#. Click the **Plus (+) Sign** on the Successful branch of the Query Passed policy item.

   |image040|    

#. In the pop‑up dialog box, select the **Assignment** tab and then click
   the **Radio Button** next to **Variable Assign**

#. Once selected, click the **Add Item** button

   |image041|   

#. Change the name to **set_variables**
#. Click **Add new entry**
#. Click **change**

    |image042|

#. Enter the Custom Variable **session.sso.logon.last.username**
#. From the dropdown menu on the right column select **AAA Attribute**
#. Enter the Session Variable **session.logon.last.username**
#. Click **Finished**


    |image043|

#. Click **Add new entry**
#. Click **change**

    |image044|


#. Enter the Custom Variable **session.logon.last.username**
#. From the dropdown menu on the right column select **AAA Attribute**
#. From the Agent Type dropdown menu select **LDAP**
#. Enter the LDAP attribute name **sAMAccountName**
#. Click **Finished**

    |image045|

#. Click **Add new entry**
#. Click **change**

    |image046|  


#. Enter the Custom Variable **session.logon.last.domain**
#. From the dropdown menu on the right column select **Text**
#. Enter the Text **F5LAB.LOCAL**
#. Click **Finished**

    |image047|

#. Click **Save**

    |image048|

#. Click the **Deny** Terminal on the set_variables fallback branch

   |image049| 

#. Select **Allow**
#. Click **Save**

    |image050|

#. Click **Apply Policy**

    |image051|

Task 6 - Create a Client-Side SSL Profile
-------------------------------------------

#. Navigate to Local Traffic >> Profiles >> SSL >> Client >> Click the **Plus Sign(+)**.

    |image052|

#. Enter the name **cert2kerb-client**
#. Select the **custom box** to the right on the Certificate Key Chain line
#. Click **Add**

    |image053|

#. From the Certificate dropdown menu select **acme.com-wildcard**
#. From the key dropdown menu select **acme.com-wildcard**
#. Click **Add**

    |image054|
#. Select the **custom box** to the right on the Trusted Certificate Authorities line
#. From the Trusted Certificate Authorities dropdown menu **ca.f5lab.local**
#. Select the **custom box** to the right on the Advertised Certificate Authorities line
#. From the Advertised Certificate Authorities dropdown menu **ca.f5lab.local**
#. Click **Finished**

    |image055|


Task 7 - Create a Virtual Server
----------------------------------

#. Navigate to Local Traffic >> Virtual Servers >> Virtual Server List >> Click the **Plus Sign(+)**.

    |image056|

#. Enter the Name **cert2kerb**
#. Enter the Destination Address/Mask **10.1.10.100**
#. Enter the Service Port **Port**

    |image057|

#. Scroll down to the Configuration Properties Section
#. From the HTTP Profile (Client) dropdown menu select **http**
#. From the SSL Profile (Client) dropdown menu select **cert2kerb-client**
#. From the Source Address Translation dropdown menu select **Auto Map**

    |image058|

#. Scroll down to the Access Policy Section
#. From the Access Profile dropdown menu select **cert2kerb**

    |image059|

#. Scroll down to the Resources Section
#. From the Default Pool dropdown menu select **cert2kerb-pool** 
#. Click **Finished**

    |image060|

    
Task 8 - Test the Configuration
---------------------------------

#. From a browser on the jumphost navigate to https://cert2kerb.acme.com
#. Select the certificate **user1**
#. Click **OK**

    |image061|


#. You are successfully logged into the https://cert2kerb.acme.com website

    |image062|



Task 9 - Lab Cleanup
------------------------

#. From a browser on the jumphost navigate to https://portal.f5lab.local

#. Click the **Classes** tab at the top of the page.

    |image002|

#. Scroll down the page until you see **06 Per-Session Access Control** on the left

   |image003|

#. Hover over tile **Cert Auth to Kerberos SSO**. A start and stop icon should appear within the tile.  Click the **Stop** Button to trigger the automation to remove any prebuilt objects from the environment

    +---------------+-------------+
    | |image004|    | |image007|  |
    +---------------+-------------+


#. The screen should refresh displaying the progress of the automation within 30 seconds.  Scroll to the bottom of the automation workflow to ensure all requests succeeded.  If you experience errors try running the automation a second time or open an issue on the `Access Labs Repo <https://github.com/f5devcentral/access-labs>`__.

   |image008|

#. This concludes the lab.

   |image000|



.. |image000| image:: ./media/lab01/000.png
.. |image001| image:: ./media/lab01/001.png
.. |image002| image:: ./media/lab01/002.png
.. |image003| image:: ./media/lab01/003.png
.. |image004| image:: ./media/lab01/004.png
.. |image005| image:: ./media/lab01/005.png
.. |image006| image:: ./media/lab01/006.png
.. |image007| image:: ./media/lab01/007.png
.. |image008| image:: ./media/lab01/008.png
.. |image009| image:: ./media/lab01/009.png
.. |image010| image:: ./media/lab01/010.png
.. |image011| image:: ./media/lab01/011.png
.. |image012| image:: ./media/lab01/012.png
.. |image013| image:: ./media/lab01/013.png
.. |image014| image:: ./media/lab01/014.png
.. |image015| image:: ./media/lab01/015.png
.. |image016| image:: ./media/lab01/016.png
.. |image017| image:: ./media/lab01/017.png
.. |image018| image:: ./media/lab01/018.png
.. |image019| image:: ./media/lab01/019.png
.. |image020| image:: ./media/lab01/020.png
.. |image021| image:: ./media/lab01/021.png
.. |image022| image:: ./media/lab01/022.png
.. |image023| image:: ./media/lab01/023.png
.. |image024| image:: ./media/lab01/024.png
.. |image025| image:: ./media/lab01/025.png
.. |image026| image:: ./media/lab01/026.png
.. |image027| image:: ./media/lab01/027.png
.. |image028| image:: ./media/lab01/028.png
.. |image029| image:: ./media/lab01/029.png
.. |image030| image:: ./media/lab01/030.png
.. |image031| image:: ./media/lab01/031.png
.. |image032| image:: ./media/lab01/032.png
.. |image033| image:: ./media/lab01/033.png
.. |image034| image:: ./media/lab01/034.png
.. |image035| image:: ./media/lab01/035.png
.. |image036| image:: ./media/lab01/036.png
.. |image037| image:: ./media/lab01/037.png
.. |image038| image:: ./media/lab01/038.png
.. |image039| image:: ./media/lab01/039.png
.. |image040| image:: ./media/lab01/040.png
.. |image041| image:: ./media/lab01/041.png
.. |image042| image:: ./media/lab01/042.png
.. |image043| image:: ./media/lab01/043.png
.. |image044| image:: ./media/lab01/044.png
.. |image045| image:: ./media/lab01/045.png
.. |image046| image:: ./media/lab01/046.png
.. |image047| image:: ./media/lab01/047.png
.. |image048| image:: ./media/lab01/048.png
.. |image049| image:: ./media/lab01/049.png
.. |image050| image:: ./media/lab01/050.png
.. |image051| image:: ./media/lab01/051.png
.. |image052| image:: ./media/lab01/052.png
.. |image053| image:: ./media/lab01/053.png
.. |image054| image:: ./media/lab01/054.png
.. |image055| image:: ./media/lab01/055.png
.. |image056| image:: ./media/lab01/056.png
.. |image057| image:: ./media/lab01/057.png
.. |image058| image:: ./media/lab01/058.png
.. |image059| image:: ./media/lab01/059.png
.. |image060| image:: ./media/lab01/060.png
.. |image061| image:: ./media/lab01/061.png
.. |image062| image:: ./media/lab01/062.png