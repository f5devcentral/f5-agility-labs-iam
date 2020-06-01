Lab 1: Client-side Authentication lab
=====================================


The purpose of this lab is to configure and test a SAML Service Provider. It is assumed students have a basic understanding of SAML
(Security Assertion Markup Language) which defines an XML framework for creating, requesting, and exchanging authentication and authorization
data among entites known as Identity Providers (IdPs) and Service Providers (SPs). The Lab environment will have a pre-configured IdP along with
a Virtual Server and Access Policy.  Student tasks consist of configuring various aspects of a SAML Service Provider (SP), importing and binding
to a SAML Identity Provider (IdP) and testing SPI-initiated SAML Federation.  When APM serves as a SAML service provider, APM consumes SAML assertions
(claims) and validates their trustworthiness.   After successfully verifying the assertion, APM creates session variables from the assertion contents.
An Access Policy can use session variables to finely control access to resources and to determine which ACLs to assign.  

Objective:

-  Gain an understanding of SAML Service Provider(SP) configurations and
   its component parts

-  Gain an understanding of the access flow for SP-Initiated SAML

-  Gain a basic understanding of Client-Side Authentication

Lab Requirements:

-  All Lab requirements will be noted inƒ the tasks that follow

Estimated completion time: 20 minutes

TASK 1	Configure the SAML Service Provider (SP)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**Note - within an SP-Initiated flow the SP sends an authn req to the IdP**

Configure an external SP Service Provider
----------
#. Begin by logging into the big-ip1.f5lab.local via the GUI (TMUI)

#. Within the GUI, click on **Access -> Federation -> SAML Service Provider -> External SP Services**

#. Click the **Create** button (far right)

#. In the **Create New SAML SP Service** dialog box click **General Settings**
   in the left navigation pane and key in the following as shown:

   +------------+----------------------------+
   | Name:      | ``sp.acme.com``         |
   +------------+----------------------------+
   | Entity ID: | ``https://sp.acme.com`` |
   +------------+----------------------------+
   
|image1|

|image2|

|image3|

 
**Note - Service Provider hostnames much be resolvable by the BIG-IP and User-Agent**

#. Click **OK** on the dialogue box

**The yellow box on Host will disappear when the Entity ID is entered**

#. Bind the external SP Service Provider (sp.acme.com) to the IdP connector prebuilt-idp.acme.com

#. Click on **Access > Federation > SAML Identity Provider > Local IdP
   Connectors**

#. Check the box to the left of pre-built-idp.acme.com 

#. At the bottom of the page there is a Bind/Unbind SP Connectors link

|image5|


#. Click on the Bind/Unbind SP Connectors link

#. Select the /Common/sp.acme.com SP Connector

#. Click **OK** on the dialog box

#. Click on the **Local SP Services** from the **SAML Service Providers** tab
   in the horizontal navigation menu

#. Click OK

**TASK 2  Configure the SAML SP Access Policy**
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. Begin by selecting **Access > Profiles/Policies >
   Access Profiles (Per Session Policies)**

#. Click the **Create** button (far right)

   
#. In the **New Profile** window, key in the following:

   +----------------+---------------------------+
   | Name:          | ``sp.acme.com`` |
   +----------------+---------------------------+
   | Profile Type:  | ``All`` (from drop down)  |
   +----------------+---------------------------+
   | Profile Scope: | ``Profile`` (default)     |
   +----------------+---------------------------+

#. Scroll to the bottom of the **New Profile** window to the
   **Language Settings**
   
#. Select *English* from the **Factory Built in Languages** on the right,
   and click the **Double Arrow (<<)**, then click the **Finished** button.

#. From the **Access > Profiles/Policies > Access Profiles
   (Per Session Policies)** screen, click the **Edit** link on the previously
   created ``app.acme.com`` line

#. In the Visual Policy Editor window for ``/Common/sp.acme.com policy``,
   click the **Plus (+) Sign** between **Start** and **Deny**
   
#. Click on the Logon tab, and check the Logon Page radio button then click
	Add Item
	
#.  With the Logon Page Agent enter "Hello" within the Form Header Text field
	then click Save
	
#. In the pop up dialog box, select the **Authentication** tab and then click
   the **Radio Button** next to **SAML Auth**

#. Once selected, click the **Add Item** button
  
#. In the **SAML Auth** configuration window, select ``/Common/app.f5demo.com``
   from the **AAA Server** drop down menu

#. Click the **Save** button at the bottom of the window

#. In the **Visual Policy Editor** window for ``/Common/app.acme.com‑policy``,
   click the **Plus (+) Sign** on the **Successful** branch following
   **SAML Auth**
   
#. In the pop-up dialog box, select the **Assignment** tab, and then click
   the **Radio Button** next to **Variable Assign**

#. Once selected, click the **Add Item** buton
 
#. In the **Variable Assign** configuration window, click the
   **Add New Entry** button

#. Under the new **Assignment** row, click the **Change** link

#. In the pop‑up window, configure the following:

   +-------------------+--------------------------------------------+
   | Left Pane                                                      |
   +===================+============================================+
   | Variable Type:    | ``Custom Variable``                        |
   +-------------------+--------------------------------------------+
   | Security:         | ``Unsecure``                               |
   +-------------------+--------------------------------------------+
   | Value:            | ``session.logon.last.username``            |
   +-------------------+--------------------------------------------+

   +-------------------+----------------------------------------------+
   | Right Pane                                                       |
   +===================+==============================================+
   | Variable Type:    | ``Session Variable``                         |
   +-------------------+----------------------------------------------+
   | Session Variable: | ``session.saml.last.attr.name.emailaddress`` |
   +-------------------+----------------------------------------------+

#. Click the **Finished** button at the bottom of the configuration window

#. Click the **Save** button at the bottom of the **Variable Assign**
   dialog window
  
#. In the **Visual Policy Editor** select the **Deny** ending along the
   **fallback** branch following the **Variable Assign**
   
#. From the **Select Ending** dialog box, select the **Allow** button and
   then click **Save**
 
#. In the **Visual Policy Editor** click **Apply Access Policy** (top left)
   and close the **Visual Policy Editor**

TASK 3 ‑ Create the SP Virtual Server & Apply the SP Access Policy
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. Begin by selecting **Local Traffic -> Virtual Servers**

#. Click the **Create** button (far right)
  
#. In the **New Virtual Server** window, key in the following as shown:

   +---------------------------+----------------------------+
   | General Properties                                     |
   +===========================+============================+
   | Name:                     | ``sp_vs``         |
   +---------------------------+----------------------------+
   | Destination Address/Mask: | ``10.1.10.102``            |
   +---------------------------+----------------------------+
   | Service Port:             | ``443``                    |
   +---------------------------+----------------------------+

   +---------------------------+------------------------------+
   | Configuration                                            |
   +===========================+==============================+
   | HTTP Profile:             | ``http`` (drop down)         |
   +---------------------------+------------------------------+
   | SSL Profile (Client)      | ``clientssl`` |
   +---------------------------+------------------------------+

   +-----------------+---------------------------+
   | Access Policy                               |
   +=================+===========================+
   | Access Profile: | ``app.acme.com`` |
   +-----------------+---------------------------+

   +---------+-----------------------+
   | Resources                       |
   +=========+=======================+
   | iRules: | ``application‑irule`` |
   +---------+-----------------------+

#. Scroll to the bottom of the configuration window and click **Finished**

   .. NOTE:: The iRule is being added in order to simulate an application
      server to validate successful access.

TASK 4 ‑ Test the SAML SP
~~~~~~~~~~~~~~~~~~~~~~~~~

#. Using your browser from the jump host, navigate to the SAML SP you just
   configured at ``https://app.f5demo.com`` (or click the provided bookmark)
   
#. Did you successfuly redirect to the IdP?

#. Log in to the IdP. Were you successfully authenticated?

   .. NOTE:: Use the credentials provided in the Authentication section at
      the beginning of this guide (user/Agility1)

#. After successful authentication, were you returned to the SAML SP?

#. Were you successfully authenticated to the app in the SAML SP?

#. Review your Active Sessions **(Access ‑> Overview ‑> Active Sessions­­­)**

#. Review your Access Report Logs **(Access ‑> Overview ‑> Access Reports)**

