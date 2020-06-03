Lab 3: SSO Lab
===========================

The purpose of this lab is to demonstrate Single Sign-On capabilities
of APM.    The SSO Credential Mapping action enables users to forward
stored user names and passwords to applications and servers automatically,
without having to input credentials repeatedly.   This allows single
sign-on (SSO) functionality for secure user access.  As different applications
and resources support different authentication mechanisms, the SSO system
may be required to store and translate credentials that differ from the
user name and password a user inputs on the logon page.  The SSO credential
mapping action allows for credentials to be retrieved from the logon
page, or in another way for both the user name and the password.

This lab will demonstrate one SSO method, although a number of different SSO
methods exist.  This lab will demonstrate the Kerberos to SAML method.

Objective:

-  Gain an understanding of SSO Token User Name Caching and SSO Token Password
   Caching.

-  Gain an understanding of the Kerberos to SAML relationship and its
   component parts.

-  Develop an awareness of the different deployment models that Kerberos
   to SAML authentication opens up

Lab Requirements:

-  All Lab requirements will be noted in the tasks that follow

Estimated completion time: 15 minutes

TASK 1: Create an SSO object and Webtop Resource
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

______________________________________________________________

SAML Resource

#.  Begin by selecting Access > Federation > SAML Resources


#.  Click the Create button (far right)


#.  In the New SAML Resource window, enter the following values:

	Name			 	partner-app

	SSO Configuration	prebuilt-idp.acme.com

	Caption				partner-app


Click Finished at the bottom of the configuration window

Webtop

#.	Select Access > Webtops > Webtop List

#.	Click Create button (far right)

#.	In the resulting window, enter the following values

	Name	full_webtop
	Type	Full (drop down)

Click finished at the bottom of the GUI


TASK 2 – Configure an Active Directory account, Kerberos AAA Object, and keytab file
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
______________________________________________________________

During this exercise we will make a copy of the idp.acme.com-policy and modify
it to demonstrate Kerberos to SAML functionality.  Navigate to Access, Profiles, Access Profiles
and click on the Copy link to the far right of the **idp.acme.com-policy**.   Name the policy **Kerberos_SAML**

From the Jump Host open a command prompt and type "mmc".   This will launch the Active Directory Management
console.   Click on Active Directory Users and Computers.


#. Create a new user in Active Directory with the follow attributes:


#. The Active Directory account should be name "kerbsso".


#. The next step is the run the ktpass command from the Windows command line as follows below


``ktpass /princ HTTP/kerberos.f5lab@ACME.COM /mapuser f5lab\kerberos /ptype KRB5_NT_PRINCIPAL /pass password /out c:\file.keytab``


#. Configure a Kerberos AAA Object


#. Create the AAA object by navigating to **Access, Authentication, Kerberos


#. Specify a **Name** (AD Domain)


#. Specify the **Auth Realm** (Active Directory Domain)


#. Browse to locate the Keytab file (The Keytab file should be located at c:\file.keytab)


#. Click Finished to complete the creation of the AAA object


#.  Review the AAA server configuration at Access, Authentication


TASK 3: Copy and Modify the idp.acme.com-policy Access Profile
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
______________________________________________________________

#. We will now make a copy of an existing Access Policy and modify the new policy


#. Navigate to Access, Profiles, Per-Session Profile and click on the **copy** link to the right of the idp.acme.com-policy


#. Name the new policy **Kerberos_SAML**


#. Navigate to Access, Profiles, Per-Session Profiles and Edit the **Kerberos_SAML** Access Profile


#. Delete the **Logon Page** object by clicking on the **X** as shown


#. In the resulting **Item Deletion Confirmation** dialog, ensure that the
   previous node is connect to the **fallback** branch, and click the
   **Delete** button

#. In the **Visual Policy Editor** window for ``/Common/Kerberos_SAML access policy``,
   click the **Plus (+) Sign** between **Start** and **AD Auth**


#. In the pop-up dialog box, select the **Logon** tab and then select the
   **Radio** next to **HTTP 401 Response**, and click the **Add Item** button


#. In the **HTTP 401 Response** dialog box, enter the following information:

   +-------------------+---------------------------------+
   | Basic Auth Realm: | ``f5lab.local``                  |
   +-------------------+---------------------------------+
   | HTTP Auth Level:  | ``basic+negotiate`` (drop down) |
   +-------------------+---------------------------------+

#. Click the **Save** button at the bottom of the dialog box


#. In the **Visual Policy Editor** window for ``/Common/Kerberos_SAML policy``,
   click the **Plus (+) Sign** on the **Negotiate** branch between
   **HTTP 401 Response** and **Deny**


#. In the pop-up dialog box, select the **Authentication** tab and then
   select the **Radio** next to **Kerberos Auth**, and click the
   **Add Item** button


#. In the **Kerberos Auth** dialog box, enter the following information:

   +----------------------+-------------------------------------+
   | AAA Server:          | ``/Common/Kerberos_SSL`` (drop down) |
   +----------------------+-------------------------------------+
   | Request Based Auth:  | ``Disabled`` (drop down)            |
   +----------------------+-------------------------------------+


#. Click the **Save** button at the bottom of the dialog box

#. In the **Visual Policy Editor** window for
   ``/Common/Kerberos_SSL policy``, click the **Plus (+) Sign** on the
   **Successful** branch between **Kerberos Auth** and **Deny**

#. In the pop-up dialog box, select the **Authentication** tab and then
   select the **Radio** next to **AD Query**, and click the **Add Item** button

#. In the resulting **AD Query(1)** pop-up window, select
   ``/Commmon/AD_Server`` from the **Server** drop down menu

#. In the **SearchFilter** field, enter the following value:
   ``userPrincipalName=%{session.logon.last.username}``

#. In the **AD Query(1)** window, click the **Branch Rules** tab

#. Change the **Name** of the branch to *Successful*.

#. Click the **Change** link next to the **Expression**

#. In the resulting pop-up window, delete the existing expression by clicking
   the **X** as shown

#. Create a new **Simple** expression by clicking the **Add Expression** button

#. In the resulting menu, select the following from the drop down menus:

   +------------+---------------------+
   | Agent Sel: | ``AD Query``        |
   +------------+---------------------+
   | Condition: | ``AD Query Passed`` |
   +------------+---------------------+

#. Click the **Add Expression** Button

#. Click the **Finished** button to complete the expression

#. Click the **Save** button to complete the **AD Query**

#. In the **Visual Policy Editor** window for ``/Common/Kerberos_SAML policy``,
   click the **Plus (+) Sign** on the **Successful** branch between
   **AD Query(1)** and **Deny**

#. In the pop-up dialog box, select the **Assignment** tab and then select
   the **Radio** next to **Advanced Resource Assign**, and click the
   **Add Item** button

#. In the resulting **Advanced Resource Assign(1)** pop-up window, click
   the **Add New Entry** button

#. In the new Resource Assignment entry, click the **Add/Delete** link

#. In the resulting pop-up window, click the **SAML** tab, and select the
   **Checkbox** next to */Common/partner-app*

#. Click the **Webtop** tab, and select the **Checkbox** next to
   ``/Common/full_webtop``

#. Click the **Update** button at the bottom of the window to complete
   the Resource Assignment entry

#. Click the **Save** button at the bottom of the
   **Advanced Resource Assign(1)** window

#. In the **Visual Policy Editor**, select the **Deny** ending on the
   fallback branch following **Advanced Resource Assign**

#. In the **Select Ending** dialog box, selet the **Allow** radio button
   and then click **Save**

#. In the **Visual Policy Editor**, click **Apply Access Policy**
   (top left), and close the **Visual Policy Editor**

#. The final step in this lab is the apply the **Kerberos_SAML** policy to the idp.acme.com Virtual Server

#. Within the GUI navigate to Local Traffic, Virtual Servers, and click on the idp.acme.com Virtual Server

#. Scroll down to the Access Policy section and select the **Kerberos_SAML** Access Policy and click the update button at the bottom of the page.


TASK 4 - Test the Kerberos to SAML Configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
______________________________________________________________

.. NOTE:: In the following Lab Task it is recommended that you use Microsoft
   Internet Explorer.  While other browsers also support Kerberos
   (if configured), for the purposes of this Lab Microsoft Internet
   Explorer has been configured and will be used.

#. Using Internet Explorer from the jump host, navigate to the SAML IdP you
   previously configured at *idp.acme.com* (or click the
   provided bookmark)

#. Were you prompted for credentials? Were you successfully authenticated?
   Did you see the webtop with the SP application?

#. Click on the Partner App icon. Were you successfully authenticated
   (via SAML) to the SP?

#. Review your Active Sessions **(Access ‑> Overview ‑> Active Sessions­­­)**

#. Review your Access Report Logs **(Access ‑> Overview ‑> Access Reports)**
