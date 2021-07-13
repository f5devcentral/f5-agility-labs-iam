Lab 1: Deploy Priviledged User Access (PUA) or Ephemeral Authentication using LDAP
======================================================================================

In this lab ephemeral authentication is configured on Access Policy Manager (APM) using LDAP authentication. 

.. note:: 
   An External LDAP server is required for this scenario


Task 1 - Access Lab Environment
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

To access your dedicated student lab environment, you will need a web browser and Remote Desktop Protocol (RDP) client software. The web browser will be used to access the Unified Demo Framework (UDF) Training Portal. The RDP client will be used to connect to the jumphost, where you will be able to access the BIG-IP management interfaces (HTTPS, SSH).

#. Click **DEPLOYMENT** located on the top left corner to display the environment

#. Click **ACCESS** next to jumphost.f5lab.local

   |image200|

#. Select your RDP resolution.

#. The RDP client on your local host establishes a RDP connection to the Jumphost.

#. Login with the following credentials:

         - User: **f5lab\user1**
         - Password: **user1**

#. After successful logon the Chrome browser will auto launch opening the site https://portal.f5lab.local.  This process usually takes 30 seconds after logon.

	|image201|

#. Click the **Classes** tab at the top of the page.

#. Scroll down the page until you see **302 Ephemeral Authentication-v16** on the left

   |image202|

#. Hover over tile **Implement Priviledged User Access Authentication**. A start and stop icon should appear within the tile.  Click the **Play** Button to start the automation to build the environment

   |image203|

#. The screen should refresh displaying the progress of the automation within 30 seconds.  Scroll to the bottom of the automation workflow to ensure all requests succeeded.  If you you experience errors try running the automation a second time or open an issue on the `Access Labs Repo <https://github.com/f5devcentral/access-labs>`__.

   |image204|



Task 2 - Create Ephemeral Authentication configuration 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Ephemeral authentication Configuration defines the authentication method (LDAP or radius) and ephemeral password usage for privileged user access.

#. Navigate to Access >> Ephemeral Authentication >> Authentication Configuration >> Click the **+ (Plus Symbol)**

   |image1|

#. Configure the General Properties:

   #. Name: **ldap.auth.conf**
   #. Authentication Method: **ldap**
   #. Click **Save**

   |image2|

.. note::
      Password Expiration section defines the password usage and timer.



Task 3 - Create an SSH Security Configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The SSH Security Configuration defines the ciphers, exchange methods, HMACs, and compression algorithms required by the backend resource.

#. Navigate to Access >> Ephemeral Authentication >> WebSSH Configuration >> SSH Security. Click the **+ (Plus Symbol)**.

   |image3|

#. Configure the SSH Properties

   #. Ciphers: **aes256-ctr**, **aes192-ctr**
   #. Key Exchange Methods: **diffie-hellman-group1-sha14**, **diffie-hellman-group-exchange-sha1**
   #. HMACs: **hmac-sha1**
   #. Compression Algorithms: **none**
   #. Click **Save**

   |image4|


Task 4 - Create an Access Configuration for Ephemeral Authentication
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Ephemeral Authentication Configuration specifies the password setting for privileged use access.

#. Navigate to Access >> Ephemeral Authentication >> Access Configuration. Click the **+ (plus symbol)**

   |image5|

#. Configure the General Properties

   #. Name: **ldap.access.conf**
   #. Authentication Configuration: **ldap.auth.conf**
   #. SSH Security Configuration: **ldap.ssh.conf**
   #. Click **Save**

   |image6|

Task 5 - Create WebSSH Resource 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. Navigate to Access >> Ephemeral Authentication >> WebSSH Configuration >> Resource. Click the **+ (plus symbol)**

   |image7|

#. Configure the General Properties

   #. Name: **Client01**
   #. Destination: 
      #. select: **IP Address** radio button
      #. Enter IP: **10.1.20.8**
      #. Port: **2022**
   #. Authentication configuration: **ldap.auth.conf**

#. Configure the Customization Setting for English

   #. Caption: **Client01**
   #. Click **Save**

   |image8|

Task 6 - Creating an LDAP Authentication configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The LDAP Authentication configuration defines the external LDAP server used to identity users.

#. Navigate to Access >> Ephemeral Authentication >> LDAP Authentication. Click the **+ (plus symbol)**

   |image9|
   
#. Configure General Properties

   #. Name: **ldap.conf**
   #. Proxy User DN: **cn=Admin,cn=Users,dc=f5lab,dc=local**
   #. Proxy User Password: **admin**

#. User settings 

   #. Bypass User List: **cn=Admin,cn=Users,dc=f5lab,dc=local**, and Click **Add**
   #. Click **Finished**

   |image10|



Task 7 - Create a Webtop
~~~~~~~~~~~~~~~~~~~~~~~~~~

The Webtop houses links to resources we would like to access.

#. Navigate to Access >> Webtops >> Webtop Lists. Click the **+ (plus symbol)**

   |image13|

#. General Properties

   #. Name: **pua.webtop**
   #. Type: **Full**
   #. Click **Finish**

   |image14|

Task 8 - Create an Access Profile
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. Navigate to Access >> Profiles / Policies >> Access Profiles (Per-Session Policies). Click the **+ (plus symbol)**

   |image15|

#. Configure General Properties

   #. Name: **pua.ldap.psp**
   #. Profile Type: **All**

   |image16|

#. Configure Language Setting

   #. Click **English**
   #. CLick **<<**
   #. Click **Finish**

   |image17|

Task 9 - Create an Admin Access Macro
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. Click **Edit** to modify the access profile

   |image18|

#. Click **Add Macro**

   |image19|


#. Enter **Admin Access** for the Name
#. Click **Save**

   |image20|

#. Expand the **Admin Access** Macro
#. Click the **+ (plus symbol)** symbol between In and Out

   |image21|

#. Click **Assignment**
#. Click **SSO credentials Mapping**
#. Click **Add Item**

   |image22|

#. Click **Save**

   |image23|

#. Click the **+ (plus symbol)** symbol to right of SSO Credential Mapping

   |image24|

#. Click **Assignment**
#. Click **Advance Rsource Assign**
#. Click **Add Item**

   |image25|

#. Click **Add new entry**
#. Click **Add/Delete**

   |image26|

#. Click **WebSSH**
#. Click **/Common/Client01**

   |image27|

#. Click **Webtop**
#. Click **/Common/pua.webtop**
#. Click **Update**

   |image28|

#. Click **Save**

   |image29|

Task 10 - Create an GET UPN from CAC Macro
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. Click **Add New Macro**

   |image30|

#. Name: **GET UPN from CAC**
#. Click **Save**

   |image31|

#. Expand **GET UPN from CAC**
#. Click **+** Symbol

   |image32|

#. Click **Assignment**
#. Click **Variable Assign**
#. Click **Add Item**

   |image33|

#. Name: **GET UPN**
#. Click **Add new entry**
#. Click **change**

   |image34|

#. Define **Custom Variable** and **Custom Expression**
   
   .. code-block:: console

      Custom Variable = session.custom.ephemeral.upn

      Custom Expression = 
      set x509e_fields [split [mcget {session.ssl.cert.x509extension}] "\n"]; 
      # For each element in the list: 
      foreach field $x509e_fields { 
      # If the element contains UPN:
      if { $field contains "othername:UPN" } { 
      ## set start of UPN variable - updated for new CACs
      set start [expr {[string first "othername:UPN<" $field] +14}]
      # UPN format is <user@domain> 
      # Return the UPN, by finding the index of opening and closing brackets, then use string range to get everything between. 
      return [string range $field $start [expr { [string first ">" $field $start] - 1 } ] ];??} } 
      # Otherwise return UPN Not Found: 
      return "UPN-NOT-FOUND";

#. Click **Finished**

   |image35|

#. Click **Save**

   |image36|

#. Click **+ (plus symbol)** beside GET UPN

   |image37|

#. Click **General Purpose**
#. Click **Empty**
#. Click **Add Item**

   |image38|

#. Name: **Check UPN**
#. Click **Branch Rules**

   |image39|

#. Click **Add Branch Rule**
#. Name: **NO UPN**
#. Click **change**

   |image40|

#. Click **Advance**

   |image41|

#. Enter: **expr { [mcget {session.custom.ephemeral.upn}] == "UPN-NOT-FOUND" }**
#. Click **Finished**

   |image42|

#. Click **Save**

   |image43|

# Click **+ (plus symbol)** to the right of NO UPN

   |image44|

#. Click **General Purpose**
#. Click **Message Box**
#. Click **Add Item**

   |image45|

#. Name: **NO UPN**
#. Tile: **NO UPN**
#. Click **Save**

   |image46|

#. Click **Edit Terminals**

   |image47|

#. Name: **Found**
#. Click **Add Terminal**
#. Name: **Not Found**
#. Click **Save**

   |image48|

#. Click the **Found** Terminal beside NO UPN

   |image49|

#. Click **Not Found**
#. Click **Save**

   |image50|


Task 11 - Create the LDAP Macro
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. Click **Add New Macro**

   |image51|

#. Name: **LDAP Query**
#. Click **Save**

   |image52|

#. Expand the LDAP Query Macro
#. Click **+ (plus symbol)** 

   |image53|

#. Click **Authentication**
#. Click **LDAP Query**
#. Click **Add Item**

   |image54|

#. Update the Properties tab
   *. Server = **/Common/pua.ldap-servers** 
   *. SearchDN = **DC=f5lab**, **DC=local**
   *. SearchFilter = **UserPrincipalName=%{session.custom.ephemeral.upn}**
   *. Fetch groups to which the user or group belong = **Direct**
   *S. Click **Branch Rules**
   
   |image55|


#. Click the **X** to remove the User Group Membership query

   |image56|

#. Click **Add Branch Rules**   
#. Name: **LDAP Query**
#. Click **change**

   |image57|

#.  Click **Add Expression**

   |image58|

#. Context: **LDAP Query**
#. Condition: **LDAP Query Passed**
#. LDAP Query has **Passed**
#. Click **Add Expression**

   |image59|

#. Click **Finished** and **Save**

   |image60|
   |image61|

#. Click **+ (plus symbol)** on the fallback branch

   |image62|

#. Click **General Purpose**
#. Click **Message Box**
#. Click **Add Item**

   |image63|

#. Name: **LDAP Failure**
#. Tile: **LDAP Failure for user %{UserPrincipalName}**
#. Click: **Save**

   |image64|

#. Click: **Edit Terminals**

   |image65|

#. Name: **Success**
#. Click **Add Terminal**
#. Name: **Failure**

   |image66|

#. Click the **Success** Terminal beside LDAP Failure

   |image67|

#. Click **Failure**
#. Click **Save**

   |image68|


Task 12 - Create the CAC AUTH Macro
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. Click **Add New Macro**

   |image69|

#. Name: **CAC AUTH**
#. Click **Save**

   |image70|

#. Expand the **CAC AUTH** Macro
#. CLick **+ (plus symbol)** between the IN and Out Terminal

   |image71|

#. Click **Authentication**
#. Click **On-Demand Cert-Auth**
#. Click **Add Item**

   |image72|

#. Ensure Auth Mode is set to **Request**
#. Click **Save**

   |image73|

#. Click **+** between On-Demand Cert-Auth and Out on the successful branch

   |image74|

#. Click **Macro**
#. Click **GET UPN from CAC**
#. Click **Add Item**

   |image75|

#. Click **+** on the Not Found branch between GET UPN from CAC and Out

   |image76|

#. Click **General Purpose**
#. Click **Message Box**
#. Click **Add Item**

   |image77|

#. Name: **CAC Failure**
#. Title: **CAC Failure**
#. Click **Save**

   |image78|

#. Click **+* (plus symbol)** on the Found Branch between GET UPN from CAC and Out

   |image79|

#. Click **Macro**
#. Click **LDAP_Query**
#. Click **Add Item**

   |image80|

#. Click **Edit Terminal**

   |image81|

#. Name: **Success**
#. Click **Add Terminal**

   |image82|

#. Name: **Failure**
#. Click the down arrow beside the Failure box to change the order.

   |image83|

#. Click **Save**

   |image84|

#. Change the Success 1st, 2nd, and 4th terminal to **Failure**, and click **Save**

   |image85|

   |image86|

   |image87|


Task 13 - Update the Initial Access Policy
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. Click the **+ (plus symbol)** between the Start and Deny Terminals

   |image88|

#. Click **General Purpose**
#. Click **Message Box**
#. Click **Add Item**


   |image89|

#. Name: **Warning Banner**
#. Title: **Official Lab Use Only!!**
#. Click **Save**

   |image90|

#. Click **+ (plus symbol)** between the Warning Banner and Deny Terminals

   |image91|

#. Click **Macro**
#. Click **CAC Auth**
#. Click **Add Item**

   |image92|


#. Click **+ (plus symbol)** between CAC Auth and Deny Terminals on the successful branch

   |image93|

#. Click **Assignment**
#. Click **Variable Assign**
#. Click **Add Item**

   |image94|

#. Click **Add new entry**
#. Click **Change**

   |image95|

#. Set Custom Variable = **session.custom.ephemeral.last.username**
#. Set Custom Expression = **session.logon.last.username**
#. Click **Finish**

   |image96|

#. Click **Add new entry**
#. Click **Change**

   |image97|

#. Set Custom Variable = **session.logon.last.username**
#. Change Customer Expression to **AAA Attribute**
#. Change Agent Type: LDAP_Query to **LDAP**
#. Change LDAP attribute name to **sAMAccountName**
#. Click **Finish**

   |image98|

#. Click **Add new entry**
#. Click **Change**

   |image99|

#. Set Custom Variable = **session.custom.ephemeral.last.dn**
#. Change Customer Expression to **AAA Attribute**
#. Change Agent Type: LDAP_Query to **LDAP**
#. Change LDAP attribute name to **dn**
#. Click **Finish**

   |image100|

#. Click **Save**

   |image101|

#. Click **+ (plus symbol)** between the Variable Assign and deny Terminals

   |image102|

#. Click **Macro**
#. Click **Admin Access**
#. Click **Add Item**

   |image103|

#. Click the **Deny** terminal beside Admin Access

   |image104|

#. Click **Allow**
#. Click **SAVE**

   |image105|




#. Click **Apply Policy**

   |image106|


Task 14 - Create an SSL Profile
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. Navigate to Local Traffic >> Profiles >> SSL >> Client >> **+ (plus symbol)**

   |image107|

#. Name: **pua.webtop.ssl**
#. Click **Custom** box beside Certificate Key Chain
#. Click **Add** 

   |image108|

#. Verify Certificate is set to **acme.com-wildcard**
#. Verify Key is set to **acme.com-wildcard**
   

   |image109|

#. Verify Trusted Certficate Authorities is set to **ca.f5lab.local**
#. Verify Advertised Certificate Authorities is set to **ca.f5lab.local**
#. Click **update**

   |image110|


Task 15 - Create a Connectivity Profile

Navigate to Access >> Profiles / Policies >> Connectivity / VPN >> Connectivity >> Profile **+ (plus symbol)**

   |image111|

#. Profile Name: **pua.cp**
#. Parent Profle: **/Common/Connectivity**
#. Click **OK**

   |image112|

Task 16 - Add the **pua.webtop.ssl** profile to **pua.webtop.ssl** virtual Server
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Navigate to Local Traffic >> Virtual Servers
#. Select the **PUA** partitiion
#. Click **Virtual Servers**

   |image113|

#. Click the **pua.acme.com** link

   |image114|

#. Under Configuration, move **pua.webtop.ssl** SSL Profile to Selected

   |image115|

#. Access Policy 
   *. Set Access Profile to **pua.ldap.psp**
   *. Set Connectivity Profile to **pua.cp**

#. Ephemeral Authentication
   * Set Access Configuration to **pua.access.conf**
   * Set LDAP Authentication Configuration to **pua.ldap.conf**
   * Click **Update**

   |image116|


#. Navigate to Local Traffic >> Virtual Servers
#. Select the **LDAP** partitiion
#. Click **pua-LDAP**

   |image117|

#. Ephemeral Authentication
   * Set Access Configuration to **pua.access.conf**
   * Set LDAP Authentication Configuration to **pua.ldap.conf**
   * Click **Update**


Task 17 - PUA testing 
~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. Open a browser to **https://pua.acme.com**
#. Click **Continue**

   |image118|

#. Uncheck Remember this decision
#. Choose **user1** Certificate
#. Click **OK**

   |image119|

#. Click **Client01** tab

   |image120|

#. Observer the user logged into the server and connectivity status

   |image121|




.. |image1| image:: media/lab01/image001.png
.. |image2| image:: media/lab01/image002.png
.. |image3| image:: media/lab01/image003.png
.. |image4| image:: media/lab01/image004.png
.. |image5| image:: media/lab01/image005.png
.. |image6| image:: media/lab01/image006.png
	:width: 800px
.. |image7| image:: media/lab01/image007.png
.. |image8| image:: media/lab01/image008.png
.. |image9| image:: media/lab01/image009.png
.. |image10| image:: media/lab01/image010.png
.. |image11| image:: media/lab01/image011.png
.. |image12| image:: media/lab01/image012.png
	:width: 800px
.. |image13| image:: media/lab01/image013.png
	:width: 800px
.. |image14| image:: media/lab01/image014.png
	:width: 800px
.. |image15| image:: media/lab01/image015.png
	:width: 800px
.. |image16| image:: media/lab01/image016.png
	:width: 800px
.. |image17| image:: media/lab01/image017.png
	:width: 800px
.. |image18| image:: media/lab01/image018.png
.. |image19| image:: media/lab01/image019.png
.. |image20| image:: media/lab01/image020.png
.. |image21| image:: media/lab01/image021.png
	:width: 700px
.. |image23| image:: media/lab01/image023.png
.. |image22| image:: media/lab01/image022.png
.. |image24| image:: media/lab01/image024.png
.. |image25| image:: media/lab01/image025.png
.. |image26| image:: media/lab01/image026.png
.. |image27| image:: media/lab01/image027.png
	:width: 600px
.. |image28| image:: media/lab01/image028.png
.. |image29| image:: media/lab01/image029.png
.. |image30| image:: media/lab01/image030.png

.. |image31| image:: media/lab01/image031.png
.. |image32| image:: media/lab01/image032.png
.. |image33| image:: media/lab01/image033.png
	:width: 800px
.. |image34| image:: media/lab01/image034.png
.. |image35| image:: media/lab01/image035.png
.. |image36| image:: media/lab01/image036.png
.. |image37| image:: media/lab01/image037.png
.. |image38| image:: media/lab01/image038.png
.. |image39| image:: media/lab01/image039.png
.. |image40| image:: media/lab01/image040.png
.. |image41| image:: media/lab01/image041.png
.. |image42| image:: media/lab01/image042.png
.. |image43| image:: media/lab01/image043.png
.. |image44| image:: media/lab01/image044.png
.. |image45| image:: media/lab01/image045.png
.. |image46| image:: media/lab01/image046.png
.. |image47| image:: media/lab01/image047.png
.. |image48| image:: media/lab01/image048.png
.. |image49| image:: media/lab01/image049.png
	:width: 800px
.. |image50| image:: media/lab01/image050.png
.. |image51| image:: media/lab01/image051.png
.. |image52| image:: media/lab01/image052.png
.. |image53| image:: media/lab01/image053.png
.. |image54| image:: media/lab01/image054.png
.. |image55| image:: media/lab01/image055.png
.. |image56| image:: media/lab01/image056.png
	:width: 800px
.. |image57| image:: media/lab01/image057.png
.. |image58| image:: media/lab01/image058.png
.. |image59| image:: media/lab01/image059.png
.. |image60| image:: media/lab01/image060.png
.. |image61| image:: media/lab01/image061.png
	:width: 800px
.. |image62| image:: media/lab01/image062.png
.. |image63| image:: media/lab01/image063.png
.. |image64| image:: media/lab01/image064.png
.. |image65| image:: media/lab01/image065.png
.. |image66| image:: media/lab01/image066.png
	:width: 800px
.. |image67| image:: media/lab01/image067.png
.. |image68| image:: media/lab01/image068.png
.. |image69| image:: media/lab01/image069.png
	:width: 800px
.. |image70| image:: media/lab01/image070.png
	:width: 1000px
.. |image71| image:: media/lab01/image071.png
.. |image72| image:: media/lab01/image072.png
.. |image73| image:: media/lab01/image073.png
.. |image74| image:: media/lab01/image074.png
.. |image75| image:: media/lab01/image075.png
.. |image76| image:: media/lab01/image076.png
.. |image77| image:: media/lab01/image077.png
.. |image78| image:: media/lab01/image078.png

.. |image79| image:: media/lab01/image079.png
.. |image80| image:: media/lab01/image080.png
	:width: 1200px
.. |image81| image:: media/lab01/image081.png
	:width: 1000px
.. |image82| image:: media/lab01/image082.png
	:width: 800px
.. |image83| image:: media/lab01/image083.png
	:width: 1200px
.. |image84| image:: media/lab01/image084.png
	:width: 800px
.. |image85| image:: media/lab01/image085.png
	:width: 1200px
.. |image86| image:: media/lab01/image086.png
	:width: 1200px
.. |image87| image:: media/lab01/image087.png
	:width: 1200px
.. |image88| image:: media/lab01/image088.png
	:width: 800px
.. |image89| image:: media/lab01/image089.png
.. |image90| image:: media/lab01/image090.png
	:width: 800px
.. |image91| image:: media/lab01/image091.png
	:width: 800px
.. |image92| image:: media/lab01/image092.png
.. |image93| image:: media/lab01/image093.png
	:width: 800px
.. |image94| image:: media/lab01/image094.png
	:width: 800px
.. |image95| image:: media/lab01/image095.png
	:width: 800px
.. |image96| image:: media/lab01/image096.png
	:width: 800px
.. |image97| image:: media/lab01/image097.png
	:width: 800px
.. |image98| image:: media/lab01/image098.png
	:width: 800px
.. |image99| image:: media/lab01/image099.png
	:width: 800px
.. |image100| image:: media/lab01/image100.png
.. |image101| image:: media/lab01/image101.png

.. |image103| image:: media/lab01/image103.png
	:width: 800px
.. |image102| image:: media/lab01/image102.png
.. |image104| image:: media/lab01/image104.png
.. |image105| image:: media/lab01/image105.png
.. |image106| image:: media/lab01/image106.png
.. |image107| image:: media/lab01/image107.png
.. |image108| image:: media/lab01/image108.png
.. |image109| image:: media/lab01/image109.png
   :width: 800px
.. |image110| image:: media/lab01/image110.png
.. |image111| image:: media/lab01/image111.png
.. |image112| image:: media/lab01/image112.png
.. |image113| image:: media/lab01/image113.png
.. |image114| image:: media/lab01/image114.png
.. |image115| image:: media/lab01/image115.png
.. |image116| image:: media/lab01/image116.png
.. |image117| image:: media/lab01/image117.png
.. |image122| image:: media/lab01/image122.png
.. |image118| image:: media/lab01/image118.png
.. |image119| image:: media/lab01/image119.png
.. |image120| image:: media/lab01/image120.png
.. |image121| image:: media/lab01/image121.png
.. |image200| image:: media/lab01/200.png
.. |image201| image:: media/lab01/201.png
.. |image202| image:: media/lab01/202.png
.. |image203| image:: media/lab01/203.png
.. |image204| image:: media/lab01/204.png

