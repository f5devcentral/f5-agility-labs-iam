Lab 1: Configure Identity Aware Proxy(15.1)
===========================================

The 15.1 Zero Trust Architecture shifts many of the objects that would exist in a per-session policy to the per-request policy thereby creating a more secure authentication and authorization scheme. The authenticity of each request is further enhanced through the use of F5’s Access Guard agent installed on a client.  This agent provides a PKI signed report of the posture assessment performed on the client real-time rather than the historical way plug-ins reported status. Previously, after a user connected to an application they would experience a delay in access as the agent performed the posture assessment to provide an unsigned report to the BIG-IP. 

Topics Covered
----------------
- Real-time Posture Assessments
- Per-Request Frameworks
- Contextual Access
- HTTP Connector

Expected time to complete: **1 hour**

Setup Lab Environment
----------------------------------------

To access your dedicated student lab environment, you will require a web browser and Remote Desktop Protocol (RDP) client software. The web browser will be used to access the Lab Training Portal. The RDP client will be used to connect to the Jump Host, where you will be able to access the BIG-IP management interfaces (HTTPS, SSH).

#. Click **DEPLOYMENT** located on the top left corner to display the environment

#. Click **ACCESS** next to jumpbox.f5lab.local

   |image090|

#. Select your RDP solution.  

#. The RDP client on your local host establishes a RDP connection to the Jump Host.

#. Login with the following credentials:

         - User: **f5lab\\user1**
         - Password: **user1**

#. After successful logon the Chrome browser will auto launch opening the site https://portal.f5lab.local.  This process usually takes 30 seconds after logon.

	|image091|

#. Click the **Classes** tab at the top of the page.

#. Scroll down the page until you see **201- 15.1 Zero Trust - Identity Aware Proxy** on the left

   |image087|

#. Hover over tile **Configure Identity Aware Proxy(15.1)**. A start and stop icon should appear within the tile.  Click the **Play** Button to start the automation to build the environment

   |image088|


#. The screen should refresh displaying the progress of the automation within 30 seconds.  Scroll to the bottom of the automation workflow to ensure all requests succeeded.  If you you experience errors try running the automation a second time or open an issue on the `Access Labs Repo <https://github.com/f5devcentral/access-labs>`__.

   |image089|



Section 1.1 - Access Guided Configuration
----------------------------------------

The first step in deploying the IAP is accessing Guided Configuration

Task 1 - Access the Zero Trust IAP guided configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. From the webbrowser, click on the **Access** tab located on the left side.

   |image000|

#. Click **Guided Configuration**

   |image001|

#. Click **Zero Trust**

   |image002|

#. Click **Identity Aware Proxy**

   |image003|

#. Click **Next**


   .. NOTE::  Review the design considerations for deploying IAP in a **Single Proxy** versus a **Multi-proxy** solution.

   |image004|
   
   
Section 1.2 - Device Posture 
------------------------------------------------

In this section, you will configure the IAP to perform posture assessment from client devices.  

Task 1 - Configure name of IAP Policy and enable Posture Checks
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. Define the configuration name **IAP_DEMO**

#. Check **Enable F5 Client Posture Check**

#. select **ca.f5lab.local** from the CA Trust Certificate dropdown list

#. Select **add** to create a posture assessment group

   |image005|

Task 2 - Define a firewall Posture Assessment
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. Define the Posture Group Name **FW_CHECK**
#. Check the enable a **Firewall** box
#. Check the enable a **Domain Managed Devices** box
#. Enter the Domain Name **f5lab.local** 
#. Click **Done**

   |image006|


Task 3 - Verify the posture assessment 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. The Posture Settings box should contain **FW_CHECK**
#. Click **Save & Next**

   |image007|
   
   
Section 1.3 - Virtual Server
------------------------------------------------

In this section, you will define the virtual server IP address and its SSL profile settings 

Task 1 - Create a virtual server
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. Click **Show Advanced Setting** located in the top right corner to expose the Server-Side SSL profile settings
#. Enter the IP address **10.1.10.100**

   |image008|


#. Click the **Create New** radio button under Client SSL Profile
#. Select **acme.com-wildcard** from the Client SSL certificate dropdown box
#. Select **acme.com-wildcard** from the Associated Private Key dropdown box
#. Select **ca.f5lab.local** from the Trusted Certificate Authorities for Client Authentication drop down box

   |image009|

#. In the **Server SSL Profile** section, move the **serverssl** SSL Profile to the **Selected** side (select item and then click the right-arrow)
#. Click **Save & Next**

   |image010|


Section 1.4 - User Identity
------------------------------------------------

In this section you will configure a single User Identity using Active Directory.  

Task 1 - Configure Active Directory AAA
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. Enter **"ad"** for the name
#. Ensure the Authentication Type is **AAA**
#. Ensure the Choose Authentication Server Type is set to **Active Directory**
#. Select **ad-servers** from the Choose Authentication Server dropdown box
#. Check **Active Directory Query Properties**
#. Select the **memberOf** in the Required Attributes box 
#. Click **Save**
#. Click **Save & Next**

|image011|





Section 1.5 - MFA
------------------------------------------------

In this section you will configure a RADIUS server to enable simulated MFA capabilities.


Task 1 - Configure a RADIUS AAA Server
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


#. Check **Enable MultiFactor Authentication**

   |image013|

#. Select **Custom Radius Based**

   |image014|

#. Select **Create New** from the Choose RADIUS Server dropdown

   |image015|

#. Enter the Server Pool Name **radius_pool**
#. Enter the Server Address **10.1.20.8**
#. Enter the Secret **secret**
#. Click **Save**

   |image016|

#. Verify Custom RADIUS based Authentication appears
#. Click **Save & Next**

   |image017|

	
Section 1.6 - SSO & HTTP Header
------------------------------------------------

In this section you will configure HTTP Basic SSO.

Task 1 - Create a HTTP basic SSO object
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


#. Check **Enable Single Sign-On(Optional)**

   |image018|

#. Enter the name **basic_sso**
#. Verify **HTTP Basic** is selected
#. Select **Create New** from the SSO Configuration Object dropdown box

   |image019|

#. Verify the Username Source is **session.sso.token.last.username**
#. Verify the Password Source is **session.sso.token.last.password**
#. Click **Save**

   |image020|


#. Verify the **basic_sso** object was created
#. click **Save & Next**

   |image021|


Section 1.7 - Applications
------------------------------------------------

In this section you will define a single application

Task 1 - Create basic.acme.com application
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. Enter the **basic.acme.com** for the application name
#. Enter the **basic.acme.com** for the FQDN
#. Enter the IP address **10.1.20.6** for the pool member
#. Click **Save** 

   |image022|



Section 1.8 - Application Groups
------------------------------------------------

Application Groups will be covered in a later section of the lab.

Task 1 - Skip Application Group Section
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. Click **Save & Next**

|image028|

Section 1.9 - Contextual Access
------------------------------------------------

In this section you will define contextual access for the previously created application.  Context access is where all of the previously created objects are put together to provide fine-grain access control.

Task 1 - Create Contextual Access for basic.acme.com
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


#. Enter **basic.acme.com** for the contextual access name
#. Select **basic.acme.com** from the Resource dropdown box
#. Select **fw_check** from the Device Posture dropdown box
#. Select **ad** from the Primary Authentication dropdown box
#. Select **basic_sso** from the Single Sign-On dropdown box
#. Check **Enable Additional Checks**

   |image023|

#. For the **Default Fallback** rule, select **Step Up** from the dropdown box under **Match Action**

#. Select **Custom Radius based Authentication (MFA)** from the Step Up Authentication box

   |image024|

#. Click **Save & Next**

   |image025|



Section 1.10 - Customization
------------------------------------------------

The Customization section allows an administrator to define the images, colors, and messages that are presented to a user.

Task 1 - Customize the Remediation Page URL
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The default **remediation Page** URL uses the hostname site **request.com**.  This should be changed to reference a real host where users can download and install the EPI updates.

#. Scroll down to the Remediation Page Section

   |image029|

#. Enter the URL **https://iap1.acme.com/epi/downloads**

   |image030|

#. Click **Save & Next**

#. On the Logon Protection menu, Click **Save & Next**




Section 1.11 - Summary
------------------------------------------------

The **Summary** page allows you to review the configuration that is about to be deployed.  In the event a change is required anywhere in the configuration the **pencil icon** on the right side can be selected to quickly edit the appropriate section.



Task 1 - Deploy the configuration 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. Click **Deploy**

   |image031|

#. Once the deployment is complete, click **Finish**


Section 1.12 - Testing 
------------------------------------------------

In this section you will access the application basic.acme.com and watch how the BIG-IP restricts access when a device fails it's posture assessment.

Task 1 - Access basic.acme.com
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. NOTE:: Posture Assessments in a Per-Request Policy use F5 Access Guard(running on clients) to perform posture assessments prior to accessing an application.  This improves the user experience since posture checks do not introduce any delay when accessing the application. This also improves security by allowing posture assessments to occur continuously throughout the life of the session.

#. From the jumpbox, browse to https://basic.acme.com
#. At the logon page enter the Username:**user1** and Password:**user1**
#. Click **Logon**

   |image033|


#. The RADIUS logon page, prepopulates the username:**user1**.  Enter the PIN: **123456**

   |image034|

#. The SSO profile passes the username and password to the website for logon.

   |image035|

#. Close the browser Window to ensure there is not cached data



Task 2 - Disable Windows Firewall
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. Right click the computer icon in the taskbar and open **Network and Sharing Center**

   |image036|

#. Click **Windows Firewall**

   |image037|

#. Click **Turn Windows Firewall on or off**

   |image038|

#. Click the radio button **Turn off Windows Firewall** under Public Network Settings
#. Click **Ok**

   |image039|


Task 3 - See Deny Page basic.acme.com 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. From the jumpbox, browse to https://basic.acme.com

#. Refresh the screen using the F5 key until the deny page appears.

#. After approximately 15 seconds you will receive a deny page from the IAP stating that you have failed the network firewall check

   |image040|

#. Close the browser Window to ensure there is no cached data


Task 4 - Enable Windows Firewall
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. Right click the computer icon in the taskbar and open **Network and Sharing Center**

   |image036|

#. Click **Windows Firewall**

   |image037|

#. Click **Turn Windows Firewall on or off**

   |image038|

#. Click the radio button **Turn on Windows Firewall** under Public Network Settings
#. Click **Ok**

   |image041|
   
#. From the jumpbox, browse to https://basic.acme.com to sure you can connect. 

#. This concludes lab 1.
 
   |image100|




.. |image000| image:: media/lab01/image000.png
.. |image001| image:: media/lab01/image001.png
.. |image002| image:: media/lab01/image002.png
.. |image003| image:: media/lab01/image003.png
.. |image004| image:: media/lab01/image004.png
.. |image005| image:: media/lab01/image005.png
.. |image006| image:: media/lab01/image006.png
.. |image007| image:: media/lab01/image007.png
.. |image008| image:: media/lab01/image008.png
.. |image009| image:: media/lab01/image009.png
.. |image010| image:: media/lab01/image010.png
.. |image011| image:: media/lab01/image011.png
.. |image013| image:: media/lab01/image013.png
.. |image014| image:: media/lab01/image014.png
.. |image015| image:: media/lab01/image015.png
.. |image016| image:: media/lab01/image016.png
.. |image017| image:: media/lab01/image017.png
.. |image018| image:: media/lab01/image018.png
.. |image019| image:: media/lab01/image019.png
.. |image020| image:: media/lab01/image020.png
.. |image021| image:: media/lab01/image021.png
.. |image022| image:: media/lab01/image022.png
.. |image023| image:: media/lab01/image023.png
.. |image024| image:: media/lab01/image024.png
.. |image025| image:: media/lab01/image025.png
.. |image028| image:: media/lab01/image028.png
.. |image029| image:: media/lab01/image029.png
.. |image030| image:: media/lab01/image030.png
.. |image031| image:: media/lab01/image031.png
.. |image032| image:: media/lab01/image032.png
.. |image033| image:: media/lab01/image033.png
.. |image034| image:: media/lab01/image034.png
.. |image035| image:: media/lab01/image035.png
.. |image036| image:: media/lab01/image036.png
.. |image037| image:: media/lab01/image037.png
.. |image038| image:: media/lab01/image038.png
.. |image039| image:: media/lab01/image039.png
.. |image040| image:: media/lab01/image040.png
.. |image041| image:: media/lab01/image041.png
.. |image042| image:: media/lab01/image042.png
.. |image043| image:: media/lab01/image043.png
.. |image087| image:: media/lab01/087.png
.. |image088| image:: media/lab01/088.png
.. |image089| image:: media/lab01/089.png
.. |image090| image:: media/lab01/090.png
.. |image091| image:: media/lab01/091.png
.. |image100| image:: media/lab01/100.png

