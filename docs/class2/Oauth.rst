Agility 2017 Hands-on Lab Guide

OAuth Federation with F5

APM 331 Presented by: Adam Schumacher, Chas Lesley & Graham Alderson

What’s inside

`OAuth Federation with F5 1 <#oauth-federation-with-f5>`__

`Lab Environment 1 <#_Toc484003943>`__

`Module: Social Login 2 <#module-social-login>`__

`Purpose 2 <#_Toc484003945>`__

`Task 1: Setup Virtual Server 2 <#task-1-setup-virtual-server>`__

`Task 2: Setup APM Profile 3 <#_Toc484003947>`__

`Task 3: Add the Access Policy to the Virtual Server
7 <#_Toc484003948>`__

`Task 4: Google (Built-In Provider)
9 <#task-4-google-built-in-provider>`__

`Task 5: Facebook (Built-In Provider)
19 <#task-5-facebook-built-in-provider>`__

`Task 6: LinkedIn (Custom Provider)
29 <#task-6-linkedin-custom-provider>`__

`Task 7: Add Header Insertion for SSO to the App 43 <#_Toc484003952>`__

`Module: API Protection 46 <#_Toc484003953>`__

`Purpose 46 <#_Toc484003954>`__

`Task 1: Setup Virtual Server for the API
46 <#task-1-setup-virtual-server-for-the-api>`__

`Task 2: Authorization Server 48 <#_Toc484003956>`__

`Task 3: Resource Server 56 <#_Toc484003957>`__

`Task 3: Verify 62 <#_Toc484003958>`__

`Task 4: Testing Session and Token States 67 <#_Toc484003959>`__

`Module: Reporting and Session Management
69 <#module-reporting-and-session-management>`__

`Task 1: Big-IP as Authorization Server (Big-IP 2)
69 <#task-1-big-ip-as-authorization-server-big-ip-2>`__

`Task 2: Big-IP as Client / Resource Server (Big-IP 1)
69 <#task-2-big-ip-as-client-resource-server-big-ip-1>`__

`Module: Troubleshooting 71 <#_Toc484003963>`__

`Task 1: Logging Levels 71 <#_Toc484003964>`__

`Task 2: Traffic Captures 71 <#_Toc484003965>`__

`Information: Logging at the Other Side 72 <#_Toc484003966>`__

`Information: The Browser 72 <#_Toc484003967>`__

`Learn More 73 <#learn-more>`__

OAuth Federation with F5
========================

Lab Environment
===============

All lab prep is already completed if you are working in the UDF or
Ravello blueprint. The following information will be critical for
operating your lab. Additional information can be found in the ***Learn
More*** section of this guide for setting up your own lab.

Lab Credentials

+-------------------------------------------+------------+------------+
| Host/Resource                             | Username   | Password   |
+===========================================+============+============+
| Windows Jump Host                         | user       | user       |
+-------------------------------------------+------------+------------+
| Big-IP 1, Big-IP 2 GUI (Browser Access)   | admin      | admin      |
+-------------------------------------------+------------+------------+
| Big-IP 1, Big-IP 2 CLI (SSH Access)       | root       | default    |
+-------------------------------------------+------------+------------+

Lab Network & Resource Design

\ |image0|

Module: Social Login
====================

Purpose
-------

This module will teach you how to configure a Big-IP as a client and
resource server enabling you to integrate with social login providers
like Facebook, Google, and LinkedIn to provide access to a web
application. You will inject the identity provided by the social network
into a header that the backend application can use to identify the user.

Task 1: Setup Virtual Server
----------------------------

+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+------------+
| 1. Go to ***Local Traffic*** -> ***Virtual*** ***Servers*** -> ***Create***                                                                                                               | |image1|   |
+===========================================================================================================================================================================================+============+
| 1. Enter the following values *(leave others default)*                                                                                                                                    | |image2|   |
|                                                                                                                                                                                           |            |
|     **Name**: social.f5agility.com-vs                                                                                                                                                     |            |
|                                                                                                                                                                                           |            |
|     **Destination Address:** 10.1.20.111                                                                                                                                                  |            |
|                                                                                                                                                                                           |            |
|     **Service Port:** 443                                                                                                                                                                 |            |
|                                                                                                                                                                                           |            |
|     **HTTP Profile:** http                                                                                                                                                                |            |
|                                                                                                                                                                                           |            |
|     **SSL Profile (Client):**                                                                                                                                                             |            |
|                                                                                                                                                                                           |            |
|     f5agility-wildcard-self-clientssl                                                                                                                                                     |            |
|                                                                                                                                                                                           |            |
|     **Source Address Translation:**                                                                                                                                                       |            |
|                                                                                                                                                                                           |            |
|     Auto Map                                                                                                                                                                              |            |
+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+------------+
| 1. Select webapp-pool from the Default Pool drop down and then click ***Finished***                                                                                                       | |image3|   |
+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+------------+
| 1. Test access to https://social.f5agility.com from the jump host’s browser.                                                                                                              | |image4|   |
|                                                                                                                                                                                           |            |
|    You should be able to see the backend application, but it will give you an error indicating you have not logged in because it requires a header to be inserted to identify the user.   |            |
+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+------------+

 Task 2: Setup APM Profile
--------------------------

+----------------------------------------------------------------------------------------------------------------------------------------------+-------------+
| 1. Go to ***Access*** -> ***Profiles / Policies*** -> ***Access Profiles (Per Session Policies)*** -> ***Create***                           | |image5|    |
+==============================================================================================================================================+=============+
| 1. Enter the following values (leave others default) then click ***Finished***                                                               | |image6|    |
|                                                                                                                                              |             |
|     **Name**: social-ap                                                                                                                      | |image7|    |
|                                                                                                                                              |             |
|     **Profile Type:** All                                                                                                                    |             |
|                                                                                                                                              |             |
|     **Profile Scope:** Profile                                                                                                               |             |
|                                                                                                                                              |             |
|     **Languages**: English                                                                                                                   |             |
+----------------------------------------------------------------------------------------------------------------------------------------------+-------------+
| 1. Click ***Edit*** for social-ap, a new browser tab will open                                                                               | |image8|    |
+----------------------------------------------------------------------------------------------------------------------------------------------+-------------+
| 1. Click the ***+*** between ***Start*** and ***Deny***, select ***OAuth Logon Page*** from the ***Logon*** tab, click ***Add Item***        | |image9|    |
|                                                                                                                                              |             |
|                                                                                                                                              | |image10|   |
+----------------------------------------------------------------------------------------------------------------------------------------------+-------------+
| 1. Set the ***Type*** on ***Lines 2, 3, and 4*** to none                                                                                     | |image11|   |
+----------------------------------------------------------------------------------------------------------------------------------------------+-------------+
| 1. Change the ***Logon Page, Input Field #1*** to “Choose a Social Logon Provider”                                                           | |image12|   |
+----------------------------------------------------------------------------------------------------------------------------------------------+-------------+
| 1. Click the ***Values*** column for ***Line 1***, a new window will open.                                                                   | |image13|   |
|                                                                                                                                              |             |
|    *Alternatively*, you may click ***[Edit]*** on the ***Input Field #1 Values*** line\ **.** Either item will bring you to the next menu.   | |image14|   |
+----------------------------------------------------------------------------------------------------------------------------------------------+-------------+
| 1. Click the ***X*** to remove ***F5, Ping, Custom, and ROPC***                                                                              | |image15|   |
+----------------------------------------------------------------------------------------------------------------------------------------------+-------------+
| 1. Click ***Finished***                                                                                                                      | |image16|   |
|                                                                                                                                              |             |
|     *Note: The resulting screen is shown*                                                                                                    | |image17|   |
+----------------------------------------------------------------------------------------------------------------------------------------------+-------------+
| 1. Go to the ***Branch Rules*** tab and click the ***X*** to remove ***F5***, ***Ping***, ***Custom***, ***F5 ROPC***, and ***Ping ROPC***   | |image18|   |
+----------------------------------------------------------------------------------------------------------------------------------------------+-------------+
| 1. Click ***Save***                                                                                                                          | |image19|   |
+----------------------------------------------------------------------------------------------------------------------------------------------+-------------+
| 1. Click ***Apply Access Policy*** in the top left and then close the browser tab                                                            | |image20|   |
+----------------------------------------------------------------------------------------------------------------------------------------------+-------------+

Task 3: Add the Access Policy to the Virtual Server
---------------------------------------------------

+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+-------------+
| 1. Go to ***Local Traffic*** -> ***Virtual*** ***Servers*** -> ***social.f5agility.com-vs***                                                                                                                                            | |image21|   |
+=========================================================================================================================================================================================================================================+=============+
| 1. Modify the ***Access Profile*** setting from none to social-ap and click ***Update***                                                                                                                                                | |image22|   |
+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+-------------+
| 1. Test access to https://social.f5agility.com from the jump host again, you should now see a logon page requiring you to select your authentication provider. Any attempt to authenticate will fail since we have only deny endings.   | |image23|   |
+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+-------------+

Task 4: Google (Built-In Provider)
----------------------------------

+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+-------------+
| Setup a Google Project                                                                                                                                                                                                      |
+=============================================================================================================================================================================================================================+=============+
| 1. Login at https://console.developers.google.com                                                                                                                                                                           | |image24|   |
|                                                                                                                                                                                                                             |             |
|    *Note: This portion of the exercise requires a Google Account. You may use an existing one or create one for the purposes of this lab*                                                                                   |             |
+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+-------------+
| 1. Click **Create Project** and give it a name like “OAuth Lab” and click **Create**                                                                                                                                        | |image25|   |
|                                                                                                                                                                                                                             |             |
|     *Note: You may have existing projects so the menus may be slightly different.*                                                                                                                                          | |image26|   |
|                                                                                                                                                                                                                             |             |
|     *Note: You may have to click on Google+ API under Social APIs*                                                                                                                                                          |             |
+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+-------------+
| 1. Go to the ***Credentials*** section on the left side.                                                                                                                                                                    | |image27|   |
|                                                                                                                                                                                                                             |             |
|     *Note: You may have navigate to your OAuth Lab project depending on your browser or prior work in Google Developer*                                                                                                     |             |
+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+-------------+
| 1. Click ***OAuth Consent Screen*** tab, fill out the product name with “OAuth Lab”, then click save                                                                                                                        | |image28|   |
+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+-------------+
| 1. Go to the ***Credentials*** tab (if you are not taken there), click ***Create Credentials*** and select ***OAuth Client ID***                                                                                            | |image29|   |
+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+-------------+
| 1. Under the **Create Client ID** screen, select and enter the following values and click **Create**                                                                                                                        | |image30|   |
|                                                                                                                                                                                                                             |             |
|     **Application Type:** Web Application                                                                                                                                                                                   |             |
|                                                                                                                                                                                                                             |             |
|     **Name:** OAuth Lab                                                                                                                                                                                                     |             |
|                                                                                                                                                                                                                             |             |
|     **Authorized Javascript Origins:**                                                                                                                                                                                      |             |
|                                                                                                                                                                                                                             |             |
|     https://social.f5agility.com                                                                                                                                                                                            |             |
|                                                                                                                                                                                                                             |             |
|     **Authorized Redirect URIs:**                                                                                                                                                                                           |             |
|                                                                                                                                                                                                                             |             |
|     https://social.f5agility.com/oauth/client/redirect                                                                                                                                                                      |             |
+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+-------------+
| 1. Copy the ***Client ID*** and ***Client Secret*** to notepad, or you can get it by clicking on the ***OAuth Lab Credentials*** section later if needed. You will need these when you setup Access Policy Manager (APM).   | |image31|   |
+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+-------------+
| 1. Click ***Library*** in the left-hand navigation section, then select ***Google+ API*** under ***Social APIs*** or search for it                                                                                          | |image32|   |
+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+-------------+
| 1. Click ***Enable*** and wait for it to complete, you will now be able to view reporting on usage here                                                                                                                     | |image33|   |
|                                                                                                                                                                                                                             |             |
|                                                                                                                                                                                                                             | |image34|   |
+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+-------------+
| 1. For Reference: This is a screenshot of the completed Google project:                                                                                                                                                     | |image35|   |
+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+-------------+

+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+-------------+
|     Configure Access Policy Manager (APM) to authenticate with Google                                                                                                                                   |
+=========================================================================================================================================================================================================+=============+
| 1. Configure the **OAuth** **Server** Object: Go to ***Access*** -> ***Federation*** -> ***OAuth Client / Resource Server*** -> ***OAuth Server*** and click ***Create***                               | |image36|   |
+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+-------------+
| 1. Enter the values as shown below for the **OAuth Server** and click ***Finished***                                                                                                                    | |image37|   |
|                                                                                                                                                                                                         |             |
|     **Name**: Google                                                                                                                                                                                    |             |
|                                                                                                                                                                                                         |             |
|     **Mode:** Client + Resource Server                                                                                                                                                                  |             |
|                                                                                                                                                                                                         |             |
|     **Type:** Google                                                                                                                                                                                    |             |
|                                                                                                                                                                                                         |             |
|     **OAuth Provider:** Google                                                                                                                                                                          |             |
|                                                                                                                                                                                                         |             |
|     **DNS Resolver:** oauth-dns                                                                                                                                                                         |             |
|                                                                                                                                                                                                         |             |
|     *(configured for you)*                                                                                                                                                                              |             |
|                                                                                                                                                                                                         |             |
|     **Client ID:** <Client ID from Google>                                                                                                                                                              |             |
|                                                                                                                                                                                                         |             |
|     **Client Secret: **                                                                                                                                                                                 |             |
|                                                                                                                                                                                                         |             |
|     <Client Secret from Google>                                                                                                                                                                         |             |
|                                                                                                                                                                                                         |             |
|     **Client’s ServerSSL Profile Name:**                                                                                                                                                                |             |
|                                                                                                                                                                                                         |             |
|     apm-default-serverssl                                                                                                                                                                               |             |
|                                                                                                                                                                                                         |             |
|     **Resource Server ID:**                                                                                                                                                                             |             |
|                                                                                                                                                                                                         |             |
|     <Client ID from Google>                                                                                                                                                                             |             |
|                                                                                                                                                                                                         |             |
|     **Resource Server Secret:**                                                                                                                                                                         |             |
|                                                                                                                                                                                                         |             |
|     <Client Secret from Google>                                                                                                                                                                         |             |
|                                                                                                                                                                                                         |             |
|     **Resource Server’s ServerSSL Profile Name:**                                                                                                                                                       |             |
|                                                                                                                                                                                                         |             |
|     apm-default-serverssl                                                                                                                                                                               |             |
+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+-------------+
| 1. Configure the VPE for Google: Go to ***Access*** -> ***Profiles / Policies*** -> ***Access Profiles (Per Session Policies)*** and click ***Edit*** on ***social-ap***, a new browser tab will open   | |image38|   |
+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+-------------+
| 1. Click the + on the ***Google*** provider’s branch after the ***OAuth Logon Page***                                                                                                                   | |image39|   |
+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+-------------+
| 1. Select ***OAuth Client*** from the ***Authentication*** tab and click ***Add Item***                                                                                                                 | |image40|   |
+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+-------------+
| 1. Enter the following in the ***OAuth Client*** input screen and click ***Save***                                                                                                                      | |image41|   |
|                                                                                                                                                                                                         |             |
|     **Name:** Google OAuth Client                                                                                                                                                                       |             |
|                                                                                                                                                                                                         |             |
|     **Server:** /Common/Google                                                                                                                                                                          |             |
|                                                                                                                                                                                                         |             |
|     **Grant Type:** Authorization Code                                                                                                                                                                  |             |
|                                                                                                                                                                                                         |             |
|     **Authentication Redirect Request:**                                                                                                                                                                |             |
|                                                                                                                                                                                                         |             |
|     /Common/GoogleAuthRedirectRequest                                                                                                                                                                   |             |
|                                                                                                                                                                                                         |             |
|     **Token Request:**                                                                                                                                                                                  |             |
|                                                                                                                                                                                                         |             |
|     /Common/GoogleTokenRequest                                                                                                                                                                          |             |
|                                                                                                                                                                                                         |             |
|     **Refresh Token Request:**                                                                                                                                                                          |             |
|                                                                                                                                                                                                         |             |
|     /Common/GoogleTokenRefreshRequest                                                                                                                                                                   |             |
|                                                                                                                                                                                                         |             |
|     **Validate Token Request:**                                                                                                                                                                         |             |
|                                                                                                                                                                                                         |             |
|     /Common/GoogleValidationScopesRequest                                                                                                                                                               |             |
|                                                                                                                                                                                                         |             |
|     **Redirection URI: **                                                                                                                                                                               |             |
|                                                                                                                                                                                                         |             |
|     https://%{session.server.network.name}/oauth/client/redirect                                                                                                                                        |             |
|                                                                                                                                                                                                         |             |
|     **Scope:** profile                                                                                                                                                                                  |             |
+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+-------------+
| 1. Click ***+*** on the ***Successful*** branch after the ***Google OAuth Client***                                                                                                                     | |image42|   |
+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+-------------+
| 1. Select ***OAuth Scope*** from the ***Authentication*** tab, and click ***Add Item***                                                                                                                 | |image43|   |
+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+-------------+
| 1. Enter the following on the ***OAuth Scope*** input screen and click ***Save***                                                                                                                       | |image44|   |
|                                                                                                                                                                                                         |             |
|     **Name**: Google OAuth Scope                                                                                                                                                                        |             |
|                                                                                                                                                                                                         |             |
|     **Server:** /Common/Google                                                                                                                                                                          |             |
|                                                                                                                                                                                                         |             |
|     **Scopes Request:**                                                                                                                                                                                 |             |
|                                                                                                                                                                                                         |             |
|     /Common/GoogleValidationScopesRequest                                                                                                                                                               |             |
|                                                                                                                                                                                                         |             |
|     Click ***Add New Entry***                                                                                                                                                                           |             |
|                                                                                                                                                                                                         |             |
|     **Scope Name: **                                                                                                                                                                                    |             |
|                                                                                                                                                                                                         |             |
|     https://www.googleapis.com/auth/userinfo.profile                                                                                                                                                    |             |
|                                                                                                                                                                                                         |             |
|     **Request:**                                                                                                                                                                                        |             |
|                                                                                                                                                                                                         |             |
|     /Common/GoogleScopeUserInfoProfileRequest                                                                                                                                                           |             |
+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+-------------+
| 1. Click the ***+*** on the ***Successful*** branch after the ***Google OAuth Scope*** object                                                                                                           | |image45|   |
+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+-------------+
| 1. Select ***Variable Assign*** from the ***Assignment*** tab, and click ***Add Item***                                                                                                                 | |image46|   |
+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+-------------+
| 1. Name it Google Variable Assign and click ***Add New Entry*** then ***change***                                                                                                                       | |image47|   |
+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+-------------+
| 1. Enter the following values and click ***Finished***                                                                                                                                                  | |image48|   |
|                                                                                                                                                                                                         |             |
|     Left Side **Type:** Custom Variable                                                                                                                                                                 |             |
|                                                                                                                                                                                                         |             |
|     Left Side **Security**: Unsecure                                                                                                                                                                    |             |
|                                                                                                                                                                                                         |             |
|     Left Side **Value**:                                                                                                                                                                                |             |
|                                                                                                                                                                                                         |             |
|     session.logon.last.username                                                                                                                                                                         |             |
|                                                                                                                                                                                                         |             |
|     Right Side **Type**: Session Variable                                                                                                                                                               |             |
|                                                                                                                                                                                                         |             |
|     Right Side **Session Variable:**                                                                                                                                                                    |             |
|                                                                                                                                                                                                         |             |
|     session.oauth.scope.last.scope\_data.userinfo.profile.displayName                                                                                                                                   |             |
+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+-------------+
| 1. Review the ***Google Variable Assign*** object and click ***Save***                                                                                                                                  | |image49|   |
+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+-------------+
| 1. Click ***Deny*** on the ***Fallback*** branch after the ***Google Variable Assign*** object, select ***Allow*** in the pop up window and click ***Save***                                            | |image50|   |
+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+-------------+
| 1. Click ***Apply Access Policy*** in the top left and then close the tab                                                                                                                               | |image51|   |
+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+-------------+
| Test Configuration                                                                                                                                                                                      |
+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+-------------+
| 1. Test by opening Chrome in the jump host and browsing to *https://social.f5agility.com*, select the provider and attempt logon.                                                                       | |image52|   |
|                                                                                                                                                                                                         |             |
|    ***Note:** You are able to login and reach the app now, but SSO to the app has not been setup so you get an application error.*                                                                      |             |
|                                                                                                                                                                                                         |             |
|    ***Note:** You may also be prompted for additional security measures as you are logging in from a new location.*                                                                                     |             |
+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+-------------+

Task 5: Facebook (Built-In Provider)
------------------------------------

+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+-------------+
| Setup a Facebook Project                                                                                                                                                                                   |
+============================================================================================================================================================================================================+=============+
| 1. Go to https://developers.facebook.com and *Login*                                                                                                                                                       | |image53|   |
|                                                                                                                                                                                                            |             |
|    *Note: This portion of the exercise requires a Facebook Account. You may use an existing one or create one for the purposes of this lab*                                                                |             |
+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+-------------+
| 1. If prompted click, ***Get Started*** and accept the ***Developer Policy.*** Otherwise, click ***Create App***                                                                                           | |image54|   |
+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+-------------+
| 1. Click ***Create App*** and name (***Display Name***) your app (Or click the top left project drop down and create a new app, then name it). Then click ***Create App ID***.                             | |image55|   |
|                                                                                                                                                                                                            |             |
|     *Note: For example the **Display Name** given here was “OAuth Lab”. You may also be prompted with a security captcha*                                                                                  |             |
+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+-------------+
| 1. Click ***Get Started*** in the ***Facebook Login*** section (*Or click + Add Product and then Get Started for Facebook*)                                                                                | |image56|   |
+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+-------------+
| 1. From the *“Choose a Platform”* screen click on ***WWW (Web)***                                                                                                                                          | |image57|   |
+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+-------------+
| 1. In the *“Tell Us about Your Website”* prompt, enter https://social.f5agility.com for the ***Site URL*** and click ***Save*** then click ***Continue***                                                  | |image58|   |
+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+-------------+
| 1. Click ***Next*** on the *“Set Up the Facebook SDK for Javascript”* screen                                                                                                                               | |image59|   |
+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+-------------+
| 1. Click ***Next*** on the *“Check Login Status”* screen                                                                                                                                                   | |image60|   |
|                                                                                                                                                                                                            |             |
|     *Note: Additional screen content removed.*                                                                                                                                                             |             |
+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+-------------+
| 1. Click ***Next*** on the *“Add the Facebook Login Button”* screen                                                                                                                                        | |image61|   |
+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+-------------+
| 1. Click ***Facebook Login*** on the left side bar and then click ***Settings***                                                                                                                           | |image62|   |
+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+-------------+
| 1. For the ***Client OAuth Settings*** screen in the ***Valid OAuth redirect URIs*** enter https://social.f5agility.com/oauth/client/redirect and then click enter to create it, then ***Save Changes***   | |image63|   |
+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+-------------+
| 1. Click ***Dashboard*** in the left navigation bar                                                                                                                                                        | |image64|   |
+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+-------------+
| 1. Here you can retrieve your ***App ID*** and ***App Secret*** for use in Access Policy Manager (APM).                                                                                                    | |image65|   |
|                                                                                                                                                                                                            |             |
|     *Screenshot of completed Facebook project*                                                                                                                                                             |             |
|                                                                                                                                                                                                            |             |
|     *Note: If you want Facebook Auth to work for users other than the developer you will need to publish the project*                                                                                      |             |
+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+-------------+
| Configure Access Policy Manager (APM) to authenticate with Facebook                                                                                                                                        |
+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+-------------+
| 1. Configure the **OAuth** **Server** Object: Go to ***Access*** -> ***Federation*** -> ***OAuth Client / Resource Server*** -> ***OAuth Server*** and click ***Create***                                  | |image66|   |
+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+-------------+
| 1. Enter the values as shown below for the **OAuth Server** and click ***Finished***                                                                                                                       | |image67|   |
|                                                                                                                                                                                                            |             |
|     **Name**: Facebook                                                                                                                                                                                     |             |
|                                                                                                                                                                                                            |             |
|     **Mode:** Client + Resource Server                                                                                                                                                                     |             |
|                                                                                                                                                                                                            |             |
|     **Type:** Facebook                                                                                                                                                                                     |             |
|                                                                                                                                                                                                            |             |
|     **OAuth Provider:** Facebook                                                                                                                                                                           |             |
|                                                                                                                                                                                                            |             |
|     **DNS Resolver:** oauth-dns                                                                                                                                                                            |             |
|                                                                                                                                                                                                            |             |
|     *(configured for you)*                                                                                                                                                                                 |             |
|                                                                                                                                                                                                            |             |
|     **Client ID:** <App ID from Facebook>                                                                                                                                                                  |             |
|                                                                                                                                                                                                            |             |
|     **Client Secret: **                                                                                                                                                                                    |             |
|                                                                                                                                                                                                            |             |
|     <App Secret from Facebook>                                                                                                                                                                             |             |
|                                                                                                                                                                                                            |             |
|     **Client’s ServerSSL Profile Name:**                                                                                                                                                                   |             |
|                                                                                                                                                                                                            |             |
|     apm-default-serverssl                                                                                                                                                                                  |             |
|                                                                                                                                                                                                            |             |
|     **Resource Server ID:**                                                                                                                                                                                |             |
|                                                                                                                                                                                                            |             |
|     <App ID from Facebook>                                                                                                                                                                                 |             |
|                                                                                                                                                                                                            |             |
|     **Resource Server Secret:**                                                                                                                                                                            |             |
|                                                                                                                                                                                                            |             |
|     <App Secret from Facebook>                                                                                                                                                                             |             |
|                                                                                                                                                                                                            |             |
|     **Resource Server’s ServerSSL Profile Name:**                                                                                                                                                          |             |
|                                                                                                                                                                                                            |             |
| 1. apm-default-serverssl                                                                                                                                                                                   |             |
+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+-------------+
| 1. Configure the VPE for Facebook: Go to ***Access*** -> ***Profiles / Policies*** -> ***Access Profiles (Per Session Policies)*** and click ***Edit*** on ***social-ap***, a new browser tab will open    | |image68|   |
+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+-------------+
| 1. Click the + on the ***Facebook*** provider’s branch after the ***OAuth Logon Page***                                                                                                                    | |image69|   |
+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+-------------+
| 1. Select ***OAuth Client*** from the ***Authentication*** tab and click ***Add Item***                                                                                                                    | |image70|   |
+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+-------------+
| 1. Enter the following in the ***OAuth Client*** input screen and click ***Save***                                                                                                                         | |image71|   |
|                                                                                                                                                                                                            |             |
|     **Name:** Facebook OAuth Client                                                                                                                                                                        |             |
|                                                                                                                                                                                                            |             |
|     **Server:** /Common/Facebook                                                                                                                                                                           |             |
|                                                                                                                                                                                                            |             |
|     **Grant Type:** Authorization Code                                                                                                                                                                     |             |
|                                                                                                                                                                                                            |             |
|     **Authentication Redirect Request:**                                                                                                                                                                   |             |
|                                                                                                                                                                                                            |             |
|     /Common/FacebookAuthRedirectRequest                                                                                                                                                                    |             |
|                                                                                                                                                                                                            |             |
|     **Token Request:**                                                                                                                                                                                     |             |
|                                                                                                                                                                                                            |             |
|     /Common/FacebookTokenRequest                                                                                                                                                                           |             |
|                                                                                                                                                                                                            |             |
|     **Refresh Token Request:** None                                                                                                                                                                        |             |
|                                                                                                                                                                                                            |             |
|     **Validate Token Request:**                                                                                                                                                                            |             |
|                                                                                                                                                                                                            |             |
|     /Common/FacebookValidationScopesRequest                                                                                                                                                                |             |
|                                                                                                                                                                                                            |             |
|     **Redirection URI: **                                                                                                                                                                                  |             |
|                                                                                                                                                                                                            |             |
|     https://%{session.server.network.name}/oauth/client/redirect                                                                                                                                           |             |
|                                                                                                                                                                                                            |             |
|     **Scope:** public\_profile *(Note underscore)*                                                                                                                                                         |             |
+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+-------------+
| 1. Click ***+*** on the ***Successful*** branch after the ***Facebook OAuth Client***                                                                                                                      | |image72|   |
+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+-------------+
| 1. Select ***OAuth Scope*** from the ***Authentication*** tab, and click ***Add Item***                                                                                                                    | |image73|   |
+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+-------------+
| 1. Enter the following on the ***OAuth Scope*** input screen and click ***Save***                                                                                                                          | |image74|   |
|                                                                                                                                                                                                            |             |
|     **Name**: Facebook OAuth Scope                                                                                                                                                                         |             |
|                                                                                                                                                                                                            |             |
|     **Server:** /Common/Facebook                                                                                                                                                                           |             |
|                                                                                                                                                                                                            |             |
|     **Scopes Request:**                                                                                                                                                                                    |             |
|                                                                                                                                                                                                            |             |
|     /Common/FacebookValidationScopesRequest                                                                                                                                                                |             |
|                                                                                                                                                                                                            |             |
|     Click ***Add New Entry***                                                                                                                                                                              |             |
|                                                                                                                                                                                                            |             |
|     **Scope Name:** public\_profile                                                                                                                                                                        |             |
|                                                                                                                                                                                                            |             |
|     **Request:**                                                                                                                                                                                           |             |
|                                                                                                                                                                                                            |             |
|     /Common/FacebookScopePublicProfile                                                                                                                                                                     |             |
+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+-------------+
| 1. Click the ***+*** on the ***Successful*** branch after the ***Facebook OAuth Scope*** object                                                                                                            | |image75|   |
+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+-------------+
| 1. Select ***Variable Assign*** from the ***Assignment*** tab, and click ***Add Item***                                                                                                                    | |image76|   |
+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+-------------+
| 1. Name it Facebook Variable Assign and click ***Add New Entry*** then ***change***                                                                                                                        | |image77|   |
+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+-------------+
| 1. Enter the following values and click ***Finished***                                                                                                                                                     | |image78|   |
|                                                                                                                                                                                                            |             |
|     Left Side **Type:** Custom Variable                                                                                                                                                                    |             |
|                                                                                                                                                                                                            |             |
|     Left Side **Security**: Unsecure                                                                                                                                                                       |             |
|                                                                                                                                                                                                            |             |
|     Left Side **Value**:                                                                                                                                                                                   |             |
|                                                                                                                                                                                                            |             |
|     session.logon.last.username                                                                                                                                                                            |             |
|                                                                                                                                                                                                            |             |
|     Right Side **Type**: Session Variable                                                                                                                                                                  |             |
|                                                                                                                                                                                                            |             |
|     Right Side **Session Variable:**                                                                                                                                                                       |             |
|                                                                                                                                                                                                            |             |
|     session.oauth.scope.last.scope\_data.public\_profile.name                                                                                                                                              |             |
+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+-------------+
| 1. Review the ***Facebook Variable Assign*** object and click ***Save***                                                                                                                                   | |image79|   |
+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+-------------+
| 1. Click ***Deny*** on the ***Fallback*** branch after the ***Facebook Variable Assign*** object, select ***Allow*** in the pop up window and click ***Save***                                             | |image80|   |
+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+-------------+
| 1. Click ***Apply Access Policy*** in the top left and then close the tab                                                                                                                                  | |image81|   |
+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+-------------+
| Test Configuration                                                                                                                                                                                         |
+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+-------------+
| 1. Test by opening Chrome in the jump host and browsing to *https://social.f5agility.com*, select the provider and attempt logon.                                                                          | |image82|   |
|                                                                                                                                                                                                            |             |
|    ***Note:** You are able to login and reach the app now, but SSO to the app has not been setup so you get an application error.*                                                                         |             |
|                                                                                                                                                                                                            |             |
|    ***Note:** You may also be prompted for additional security measures as you are logging in from a new location.*                                                                                        |             |
|                                                                                                                                                                                                            |             |
|    ***Note:** You may need to start a Chrome New Incognito Window so no session data carries over.*                                                                                                        |             |
+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+-------------+
| 1. You should be prompted to authorize your request. Click ***Continue as <Account>*** (Where <Account> is your Facebook Profile name)                                                                     | |image83|   |
+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+-------------+

Task 6: LinkedIn (Custom Provider)
----------------------------------

+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+-------------+
| Setup a LinkedIn Project                                                                                                                                                                                         |
+==================================================================================================================================================================================================================+=============+
| 1. Login at                                                                                                                                                                                                      | |image84|   |
|                                                                                                                                                                                                                  |             |
|     https://www.linkedin.com/secure/developer                                                                                                                                                                    |             |
|                                                                                                                                                                                                                  |             |
| *Note: This portion of the exercise requires a LinkedIn Account. You may use an existing one or create one for the purposes of this lab*                                                                         |             |
+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+-------------+
| 1. Click ***Create Application***                                                                                                                                                                                | |image85|   |
+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+-------------+
| 1. In the “\ *Create a New Application”* screen fill in the required values an click ***Submit***                                                                                                                | |image86|   |
|                                                                                                                                                                                                                  |             |
|     *Note: Generic values have been shown. You may use the values you deem appropriate*                                                                                                                          |             |
|                                                                                                                                                                                                                  |             |
|     *Note: An Application logo has been provided on your desktop ‘OAuth2.png’*                                                                                                                                   |             |
+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+-------------+
| 1. In the *“Authentication Keys”* screen, check the boxes for ***r\_basicprofile*** and ***r\_emailaddress***. In the ***Authorized Redirect URLs***, enter https://social.f5agility.com/oauth/client/redirect   | |image87|   |
|                                                                                                                                                                                                                  |             |
|     Click ***Add***. Finally, click ***Update*** at the bottom of the screen.                                                                                                                                    |             |
+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+-------------+

+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| Configure Access Policy Manager (APM) to authenticate with LinkedIn                                                                                                                                                 |
+=====================================================================================================================================================================================================================+==============+
| 1. Configure the **OAuth** **Server** Object: Go to ***Access*** -> ***Federation*** -> ***OAuth Client / Resource Server*** -> ***Provider*** and click ***Create***                                               | |image88|    |
|                                                                                                                                                                                                                     |              |
|    *Note: You are creating a “Provider”*                                                                                                                                                                            |              |
+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| 1. Enter the values as shown below for the **OAuth Provider** and click ***Finished***                                                                                                                              | |image89|    |
|                                                                                                                                                                                                                     |              |
|     **Name**: LinkedIn                                                                                                                                                                                              |              |
|                                                                                                                                                                                                                     |              |
|     **Type:** Custom                                                                                                                                                                                                |              |
|                                                                                                                                                                                                                     |              |
|     **Authentication URI:**                                                                                                                                                                                         |              |
|                                                                                                                                                                                                                     |              |
|     https://www.linkedin.com/oauth/v2/authorization                                                                                                                                                                 |              |
|                                                                                                                                                                                                                     |              |
|     **Token URI:** https://www.linkedin.com/oauth/v2/accessToken                                                                                                                                                    |              |
|                                                                                                                                                                                                                     |              |
|     **Token Validation Scope URI: **                                                                                                                                                                                |              |
|                                                                                                                                                                                                                     |              |
|     https://www.linkedin.com/v1/people/~                                                                                                                                                                            |              |
+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| 1. Configure the **OAuth** **Redirect** **Request** Profile Object: Go to ***Access*** -> ***Federation*** -> ***OAuth Client / Resource Server*** -> ***Request*** and click ***Create***                          | |image90|    |
+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| 1. Enter the values as shown for the **OAuth** **Request** and click ***Finished***                                                                                                                                 | |image91|    |
|                                                                                                                                                                                                                     |              |
|     **Name:**                                                                                                                                                                                                       | |image92|    |
|                                                                                                                                                                                                                     |              |
|     LinkedInAuthRedirectRequest                                                                                                                                                                                     |              |
|                                                                                                                                                                                                                     |              |
|     **HTTP Method:** GET                                                                                                                                                                                            |              |
|                                                                                                                                                                                                                     |              |
|     **Type:** auth-redirect-request                                                                                                                                                                                 |              |
|                                                                                                                                                                                                                     |              |
|     Add the following request parameters and click ***Add*** after entering the values for each:                                                                                                                    |              |
|                                                                                                                                                                                                                     |              |
|     **Parameter Type:** custom                                                                                                                                                                                      |              |
|                                                                                                                                                                                                                     |              |
|     **Parameter Name:** response\_type                                                                                                                                                                              |              |
|                                                                                                                                                                                                                     |              |
|     **Parameter Value:** code                                                                                                                                                                                       |              |
|                                                                                                                                                                                                                     |              |
|     **Parameter Type:** client-id                                                                                                                                                                                   |              |
|                                                                                                                                                                                                                     |              |
|     **Parameter Name:** client\_id                                                                                                                                                                                  |              |
|                                                                                                                                                                                                                     |              |
|     **Parameter Type:** redirect-uri                                                                                                                                                                                |              |
|                                                                                                                                                                                                                     |              |
|     **Parameter Name:** redirect\_uri                                                                                                                                                                               |              |
|                                                                                                                                                                                                                     |              |
|     **Parameter Type:** scope                                                                                                                                                                                       |              |
|                                                                                                                                                                                                                     |              |
|     **Parameter Name:** scope                                                                                                                                                                                       |              |
|                                                                                                                                                                                                                     |              |
|     *Note: LinkedIn requires a state parameter, but we already insert it by default. *                                                                                                                              |              |
+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| 1. Configure the **OAuth** **Token** **Request** Profile Object: Go to ***Access*** -> ***Federation*** -> ***OAuth Client / Resource Server*** -> ***Request*** and click ***Create***                             | |image93|    |
+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| 1. Enter the values as shown for the **OAuth** **Request** and click ***Finished***                                                                                                                                 | |image94|    |
|                                                                                                                                                                                                                     |              |
|     **Name:**                                                                                                                                                                                                       | |image95|    |
|                                                                                                                                                                                                                     |              |
|     LinkedInTokenRequest                                                                                                                                                                                            |              |
|                                                                                                                                                                                                                     |              |
|     **HTTP Method:** POST                                                                                                                                                                                           |              |
|                                                                                                                                                                                                                     |              |
|     **Type:** token-request                                                                                                                                                                                         |              |
|                                                                                                                                                                                                                     |              |
|     Add the following request parameters and click ***Add*** after entering the values for each:                                                                                                                    |              |
|                                                                                                                                                                                                                     |              |
|     **Parameter Type:** grant-type                                                                                                                                                                                  |              |
|                                                                                                                                                                                                                     |              |
|     **Parameter Name:** grant\_type                                                                                                                                                                                 |              |
|                                                                                                                                                                                                                     |              |
|     **Parameter Type:** redirect-uri                                                                                                                                                                                |              |
|                                                                                                                                                                                                                     |              |
|     **Parameter Name:** redirect\_uri                                                                                                                                                                               |              |
|                                                                                                                                                                                                                     |              |
|     **Parameter Type:** client-id                                                                                                                                                                                   |              |
|                                                                                                                                                                                                                     |              |
|     **Parameter Name:** client\_id                                                                                                                                                                                  |              |
|                                                                                                                                                                                                                     |              |
|     **Parameter Type:** client-secret                                                                                                                                                                               |              |
|                                                                                                                                                                                                                     |              |
|     **Parameter Name:** client\_secret                                                                                                                                                                              |              |
+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| 1. Configure the **OAuth** **Validation Scopes Request** Profile Object: Go to ***Access*** -> ***Federation*** -> ***OAuth Client / Resource Server*** -> ***Request*** and click ***Create***                     | |image96|    |
+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| 1. Enter the values as shown for the **OAuth** **Request** and click ***Finished***                                                                                                                                 | |image97|    |
|                                                                                                                                                                                                                     |              |
|     **Name:**                                                                                                                                                                                                       | |image98|    |
|                                                                                                                                                                                                                     |              |
|     LinkedInValidationScopesRequest                                                                                                                                                                                 |              |
|                                                                                                                                                                                                                     |              |
|     **HTTP Method:** GET                                                                                                                                                                                            |              |
|                                                                                                                                                                                                                     |              |
|     **Type:** validation-scopes-request                                                                                                                                                                             |              |
|                                                                                                                                                                                                                     |              |
|     Add the following request                                                                                                                                                                                       |              |
|                                                                                                                                                                                                                     |              |
|     parameters and click ***Add*** after entering the values for each:                                                                                                                                              |              |
|                                                                                                                                                                                                                     |              |
|     **Parameter Type:** custom                                                                                                                                                                                      |              |
|                                                                                                                                                                                                                     |              |
|     **Parameter Name:**                                                                                                                                                                                             |              |
|                                                                                                                                                                                                                     |              |
|     oauth2\_access\_token                                                                                                                                                                                           |              |
|                                                                                                                                                                                                                     |              |
|     **Parameter Value:**                                                                                                                                                                                            |              |
|                                                                                                                                                                                                                     |              |
|     %{session.oauth.client.last.access\_token}                                                                                                                                                                      |              |
|                                                                                                                                                                                                                     |              |
|     **Parameter Type:** custom                                                                                                                                                                                      |              |
|                                                                                                                                                                                                                     |              |
|     **Parameter Name:** format                                                                                                                                                                                      |              |
|                                                                                                                                                                                                                     |              |
|     **Parameter Value:** json                                                                                                                                                                                       |              |
+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| 1. Configure the **OAuth** **Scope Data Request** Profile Object: Go to ***Access*** -> ***Federation*** -> ***OAuth Client / Resource Server*** -> ***Request*** and click ***Create***                            | |image99|    |
+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| 1. Enter the values as shown for the **OAuth** **Request** and click ***Finished***                                                                                                                                 | |image100|   |
|                                                                                                                                                                                                                     |              |
|     **Name:** LinkedInScopeBasicProfile                                                                                                                                                                             | |image101|   |
|                                                                                                                                                                                                                     |              |
|     **HTTP Method:** GET                                                                                                                                                                                            |              |
|                                                                                                                                                                                                                     |              |
|     **URI:** https://api.linkedin.com/v1/people/~                                                                                                                                                                   |              |
|                                                                                                                                                                                                                     |              |
|     **Type:** scope-data-request                                                                                                                                                                                    |              |
|                                                                                                                                                                                                                     |              |
|     Add the following request                                                                                                                                                                                       |              |
|                                                                                                                                                                                                                     |              |
|     parameters and click ***Add*** after entering the values for each:                                                                                                                                              |              |
|                                                                                                                                                                                                                     |              |
|     **Parameter Type:** custom                                                                                                                                                                                      |              |
|                                                                                                                                                                                                                     |              |
|     **Parameter Name:**                                                                                                                                                                                             |              |
|                                                                                                                                                                                                                     |              |
|     oauth2\_access\_token                                                                                                                                                                                           |              |
|                                                                                                                                                                                                                     |              |
|     **Parameter Value:**                                                                                                                                                                                            |              |
|                                                                                                                                                                                                                     |              |
|     %{session.oauth.client.last.access\_token}                                                                                                                                                                      |              |
|                                                                                                                                                                                                                     |              |
|     **Parameter Type:** custom                                                                                                                                                                                      |              |
|                                                                                                                                                                                                                     |              |
|     **Parameter Name:** format                                                                                                                                                                                      |              |
|                                                                                                                                                                                                                     |              |
|     **Parameter Value:** json                                                                                                                                                                                       |              |
+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| 1. Configure the **OAuth** **Server** Object: Go to ***Access*** -> ***Federation*** -> ***OAuth Client / Resource Server*** -> ***OAuth Server*** and click ***Create***                                           | |image102|   |
+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| 1. Enter the values as shown below for the **OAuth Server** and click ***Finished***                                                                                                                                | |image103|   |
|                                                                                                                                                                                                                     |              |
|     **Name**: LinkedIn                                                                                                                                                                                              |              |
|                                                                                                                                                                                                                     |              |
|     **Mode:** Client + Resource Server                                                                                                                                                                              |              |
|                                                                                                                                                                                                                     |              |
|     **Type:** Custom                                                                                                                                                                                                |              |
|                                                                                                                                                                                                                     |              |
|     **OAuth Provider:** LinkedIn                                                                                                                                                                                    |              |
|                                                                                                                                                                                                                     |              |
|     **DNS Resolver:** oauth-dns                                                                                                                                                                                     |              |
|                                                                                                                                                                                                                     |              |
|     *(configured for you)*                                                                                                                                                                                          |              |
|                                                                                                                                                                                                                     |              |
|     **Client ID:** <App ID from LinkedIn>                                                                                                                                                                           |              |
|                                                                                                                                                                                                                     |              |
|     **Client Secret: **                                                                                                                                                                                             |              |
|                                                                                                                                                                                                                     |              |
|     <App Secret from LinkedIn >                                                                                                                                                                                     |              |
|                                                                                                                                                                                                                     |              |
|     **Client’s ServerSSL Profile Name:**                                                                                                                                                                            |              |
|                                                                                                                                                                                                                     |              |
|     apm-default-serverssl                                                                                                                                                                                           |              |
|                                                                                                                                                                                                                     |              |
|     **Resource Server ID:**                                                                                                                                                                                         |              |
|                                                                                                                                                                                                                     |              |
|     <App ID from LinkedIn >                                                                                                                                                                                         |              |
|                                                                                                                                                                                                                     |              |
|     **Resource Server Secret:**                                                                                                                                                                                     |              |
|                                                                                                                                                                                                                     |              |
|     <App Secret from LinkedIn >                                                                                                                                                                                     |              |
|                                                                                                                                                                                                                     |              |
|     **Resource Server’s ServerSSL Profile Name:**                                                                                                                                                                   |              |
|                                                                                                                                                                                                                     |              |
| apm-default-serverssl                                                                                                                                                                                               |              |
+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| 1. Configure the VPE for LinkedIn: Go to ***Access*** -> ***Profiles / Policies*** -> ***Access Profiles (Per Session Policies)*** and click ***Edit*** on ***social-ap***, a new browser tab will open             | |image104|   |
+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| 1. Click on the link ***OAuth Logon Page*** as shown                                                                                                                                                                | |image105|   |
+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| 1. Click on the ***Values*** area of ***Line #1*** as shown. A pop-up window will appear                                                                                                                            | |image106|   |
+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| 1. Click ***Add Option***. In the new ***Line 3***, type LinkedIn in both the ***Value*** and ***Text (Optional)*** fields and click ***Finished***                                                                 | |image107|   |
+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| 1. Click on the ***Branch Rules*** tab of the ***OAuth Logon Page*** screen                                                                                                                                         | |image108|   |
+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| 1. Click ***Add Branch Rule***. In the resulting new line enter LinkedIn for the ***Name*** field and click the ***Change*** link on the ***Expression*** line                                                      | |image109|   |
+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| 1. Click ***Add Expression*** on the ***Simple*** tab                                                                                                                                                               | |image110|   |
+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| 1. Select OAuth Logon Page in the ***Agent Sel***: drop down. Select OAuth provider type from the ***Condition*** drop down. In the ***OAuth provider*** field enter LinkedIn and then click ***Add Expression***   | |image111|   |
+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| 1. Click ***Finished*** on the ***Simple*** Expression tab                                                                                                                                                          | |image112|   |
+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| 1. Click ***Save*** on the completed ***Branch Rules*** tab                                                                                                                                                         | |image113|   |
+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| 1. Click the + on the ***LinkedIn*** provider’s branch after the ***OAuth Logon Page***                                                                                                                             | |image114|   |
|                                                                                                                                                                                                                     |              |
|     *Note: If not still in the VPE: Go to **Access** -> **Profiles / Policies** -> **Access Profiles (Per Session Policies)**. Click **Edit** on **social-ap**, a new browser tab will open*                        |              |
+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| 1. Select ***OAuth Client*** from the ***Authentication*** tab and click ***Add Item***                                                                                                                             | |image115|   |
+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| 1. Enter the following in the ***OAuth Client*** input screen and click ***Save***                                                                                                                                  | |image116|   |
|                                                                                                                                                                                                                     |              |
|     **Name:** LinkedIn OAuth Client                                                                                                                                                                                 |              |
|                                                                                                                                                                                                                     |              |
|     **Server:** /Common/LinkedIn                                                                                                                                                                                    |              |
|                                                                                                                                                                                                                     |              |
|     **Grant Type:** Authorization Code                                                                                                                                                                              |              |
|                                                                                                                                                                                                                     |              |
|     **Authentication Redirect Request:**                                                                                                                                                                            |              |
|                                                                                                                                                                                                                     |              |
|     /Common/LinkedInAuthRedirectRequest                                                                                                                                                                             |              |
|                                                                                                                                                                                                                     |              |
|     **Token Request:**                                                                                                                                                                                              |              |
|                                                                                                                                                                                                                     |              |
|     /Common/LinkedInTokenRequest                                                                                                                                                                                    |              |
|                                                                                                                                                                                                                     |              |
|     **Refresh Token Request:** None                                                                                                                                                                                 |              |
|                                                                                                                                                                                                                     |              |
|     **Validate Token Request:**                                                                                                                                                                                     |              |
|                                                                                                                                                                                                                     |              |
|     /Common/LinkedInValidationScopesRequest                                                                                                                                                                         |              |
|                                                                                                                                                                                                                     |              |
|     **Redirection URI: **                                                                                                                                                                                           |              |
|                                                                                                                                                                                                                     |              |
|     https://%{session.server.network.name}/oauth/client/redirect                                                                                                                                                    |              |
|                                                                                                                                                                                                                     |              |
| **Scope:** r\_basicprofile *(Note underscore)*                                                                                                                                                                      |              |
+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| 1. Click ***+*** on the ***Successful*** branch after the ***LinkedIn OAuth Client***                                                                                                                               | |image117|   |
+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| 1. Select ***OAuth Scope*** from the ***Authentication*** tab, and click ***Add Item***                                                                                                                             | |image118|   |
+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| 1. Enter the following on the ***OAuth Scope*** input screen and click ***Save***                                                                                                                                   | |image119|   |
|                                                                                                                                                                                                                     |              |
|     **Name**: LinkedIn OAuth Scope                                                                                                                                                                                  |              |
|                                                                                                                                                                                                                     |              |
|     **Server:** /Common/LinkedIn                                                                                                                                                                                    |              |
|                                                                                                                                                                                                                     |              |
|     **Scopes Request:**                                                                                                                                                                                             |              |
|                                                                                                                                                                                                                     |              |
|     /Common/LinkedInValidationScopesRequest                                                                                                                                                                         |              |
|                                                                                                                                                                                                                     |              |
|     Click ***Add New Entry***                                                                                                                                                                                       |              |
|                                                                                                                                                                                                                     |              |
|     **Scope Name:** r\_basicprofile                                                                                                                                                                                 |              |
|                                                                                                                                                                                                                     |              |
|     **Request:**                                                                                                                                                                                                    |              |
|                                                                                                                                                                                                                     |              |
|     /Common/LinkedInScopeBasicProfile                                                                                                                                                                               |              |
+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| 1. Click the ***+*** on the ***Successful*** branch after the ***LinkedIn OAuth Scope*** object                                                                                                                     | |image120|   |
+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| 1. Select ***Variable Assign*** from the ***Assignment*** tab, and click ***Add Item***                                                                                                                             | |image121|   |
+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| 1. Name it LinkedIn Variable Assign and click ***Add New Entry*** then ***change***                                                                                                                                 | |image122|   |
+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| 1. Enter the following values and click ***Finished***                                                                                                                                                              | |image123|   |
|                                                                                                                                                                                                                     |              |
|     Left Side **Type:** Custom Variable                                                                                                                                                                             |              |
|                                                                                                                                                                                                                     |              |
|     Left Side **Security**: Unsecure                                                                                                                                                                                |              |
|                                                                                                                                                                                                                     |              |
|     Left Side **Value**:                                                                                                                                                                                            |              |
|                                                                                                                                                                                                                     |              |
|     session.logon.last.username                                                                                                                                                                                     |              |
|                                                                                                                                                                                                                     |              |
|     Right Side **Type**: Session Variable                                                                                                                                                                           |              |
|                                                                                                                                                                                                                     |              |
|     Right Side **Session Variable:**                                                                                                                                                                                |              |
|                                                                                                                                                                                                                     |              |
|     session.oauth.scope.last.firstName                                                                                                                                                                              |              |
+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| 1. Review the ***LinkedIn Variable Assign*** object and click ***Save***                                                                                                                                            | |image124|   |
+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| 1. Click ***Deny*** on the ***Fallback*** branch after the ***LinkedIn Variable Assign*** object, select ***Allow*** in the pop up window and click ***Save***                                                      | |image125|   |
+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| 1. Click ***Apply Access Policy*** in the top left and then close the tab                                                                                                                                           | |image126|   |
+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| Test Configuration                                                                                                                                                                                                  |
+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| 1. Test by opening Chrome in the jump host and browsing to *https://social.f5agility.com*, select the provider and attempt logon.                                                                                   | |image127|   |
|                                                                                                                                                                                                                     |              |
|    ***Note:** You are able to login and reach the app now, but SSO to the app has not been setup so you get an application error.*                                                                                  |              |
|                                                                                                                                                                                                                     |              |
|    ***Note:** You may also be prompted for additional security measures as you are logging in from a new location.*                                                                                                 |              |
|                                                                                                                                                                                                                     |              |
|    ***Note:** You may need to start a Chrome New Incognito Window so no session data carries over.*                                                                                                                 |              |
+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| 1. You will be prompted to authorize your request. Click ***Allow.***                                                                                                                                               | |image128|   |
+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+

Task 7: Add Header Insertion for SSO to the App
-----------------------------------------------

In this task you will create a policy that runs on every request. It
will insert a header into the serverside HTTP Requests that contains the
username. The application will use this to identify who the user is,
providing Single Sign On (SSO).

+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| Configure the Per Request Policy                                                                                                                                                                                                                                                                                                                                                                                                     |
+======================================================================================================================================================================================================================================================================================================================================================================================================================================+==============+
| 1. Go to ***Access*** -> ***Profiles/Policies*** -> ***Per Request Policies*** and click ***Create***                                                                                                                                                                                                                                                                                                                                | |image129|   |
+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| 1. Enter prp-x-user-insertion the Name field and click ***Finished***                                                                                                                                                                                                                                                                                                                                                                | |image130|   |
+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| 1. Click ***Edit*** on the **prp-x-user-insertion policy** line                                                                                                                                                                                                                                                                                                                                                                      | |image131|   |
+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| 1. Click the ***+*** symbol between **Start** and **Allow**                                                                                                                                                                                                                                                                                                                                                                          | |image132|   |
+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| 1. Under the ***General Purpose*** tab select ***HTTP Headers*** and click ***Add Item***                                                                                                                                                                                                                                                                                                                                            | |image133|   |
+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| 1. Under the HTTP Header Modify section, click Add New Entry to add the following two headers and then click Save                                                                                                                                                                                                                                                                                                                    | |image134|   |
|                                                                                                                                                                                                                                                                                                                                                                                                                                      |              |
|     **Header Operation**: replace                                                                                                                                                                                                                                                                                                                                                                                                    |              |
|                                                                                                                                                                                                                                                                                                                                                                                                                                      |              |
|     **Header Name:** X-User                                                                                                                                                                                                                                                                                                                                                                                                          |              |
|                                                                                                                                                                                                                                                                                                                                                                                                                                      |              |
|     **Header Value:** %{session.logon.last.username}                                                                                                                                                                                                                                                                                                                                                                                 |              |
|                                                                                                                                                                                                                                                                                                                                                                                                                                      |              |
|     **Header Operation**: replace                                                                                                                                                                                                                                                                                                                                                                                                    |              |
|                                                                                                                                                                                                                                                                                                                                                                                                                                      |              |
|     **Header Name:** X-Provider                                                                                                                                                                                                                                                                                                                                                                                                      |              |
|                                                                                                                                                                                                                                                                                                                                                                                                                                      |              |
|     **Header Value:** %{session.logon.last.oauthprovidertype}                                                                                                                                                                                                                                                                                                                                                                        |              |
|                                                                                                                                                                                                                                                                                                                                                                                                                                      |              |
|     *Note: Replace instead of Insert has been selected for Header Operation to improve security. A malicious user might insert their own X-User header. As using Insert would simply add another header. Using Replace will add a header if it does not exist, or replace one if it does.*                                                                                                                                           |              |
+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| 1. You do not need to Apply Policy on per request policies. You may simply close the browser tab                                                                                                                                                                                                                                                                                                                                     | |image135|   |
+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| Add the Per Request Policy to the Virtual Server                                                                                                                                                                                                                                                                                                                                                                                     |
+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| 1. Go to ***Local Traffic*** -> ***Virtual Servers*** and click on ***social.f5agility.com-vs***                                                                                                                                                                                                                                                                                                                                     | |image136|   |
+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| 1. Scroll to the ***Access Policy*** section of the Virtual Server and select prp-x-user-insertion from the ***Per-Request Policy*** drop down. Scroll to the bottom of the page and click ***Update***                                                                                                                                                                                                                              | |image137|   |
+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| Test Configuration                                                                                                                                                                                                                                                                                                                                                                                                                   |
+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| 1. Go to https://social.f5agility.com in your browser and logon using one of the social logon providers. This time you should see your name appear in the top right corner. You can also click “Headers” in the webapp and look at the headers presented to the client. You will see x-user present here with your name as the value. You’ll also see the x-provider header you inserted indicating where the data is coming from.   | |image138|   |
+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+

Module: API Protection
======================

Purpose
-------

This section will teach you how to configure a Big-IP (#1) as a Resource
Server protecting an API with OAuth and another Big-IP (#2) as the
Authorization Server providing the OAuth tokens.

Task 1: Setup Virtual Server for the API
----------------------------------------

+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| 1. Go to ***Local Traffic*** -> ***Virtual Servers*** and click on ***Create***                                                                                                                                           | |image139|   |
+===========================================================================================================================================================================================================================+==============+
| 1. Enter the following values *(leave others default)* then scroll down to ***Resources***                                                                                                                                | |image140|   |
|                                                                                                                                                                                                                           |              |
|     **Name**: api.f5agility.com-vs                                                                                                                                                                                        |              |
|                                                                                                                                                                                                                           |              |
|     **Destination Address:** 10.1.20.112                                                                                                                                                                                  |              |
|                                                                                                                                                                                                                           |              |
|     **Service Port:** 443                                                                                                                                                                                                 |              |
|                                                                                                                                                                                                                           |              |
|     **HTTP Profile:** http                                                                                                                                                                                                |              |
|                                                                                                                                                                                                                           |              |
|     **SSL Profile (Client):**                                                                                                                                                                                             |              |
|                                                                                                                                                                                                                           |              |
|     f5agility-wildcard-self-clientssl                                                                                                                                                                                     |              |
|                                                                                                                                                                                                                           |              |
|     **Source Address Translation:**                                                                                                                                                                                       |              |
|                                                                                                                                                                                                                           |              |
|     Auto Map                                                                                                                                                                                                              |              |
+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| 1. In the ***Resources*** section, select following value *(leave others default)* then click ***Finished***                                                                                                              | |image141|   |
|                                                                                                                                                                                                                           |              |
|     **Default Pool:** api-pool                                                                                                                                                                                            |              |
+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| Test Configuration                                                                                                                                                                                                        |
+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| 1. On the Jump Host, launch ***Postman*** from the desktop icon                                                                                                                                                           | |image142|   |
+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| 1. The request should be prefilled with the settings below. If not change as needed or select ***TEST API Call*** from the ***API Collection*** and click ***Send***                                                      | |image143|   |
|                                                                                                                                                                                                                           |              |
|     **Method:** GET                                                                                                                                                                                                       |              |
|                                                                                                                                                                                                                           |              |
|     **Target:** https://api.f5agility.com/department                                                                                                                                                                      |              |
|                                                                                                                                                                                                                           |              |
|     **Authorization:** No Auth                                                                                                                                                                                            |              |
|                                                                                                                                                                                                                           |              |
|     **Headers:** (none should be set)                                                                                                                                                                                     |              |
+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| 1. You should receive a 200 OK, 4 headers and the body should contain a list of departments.                                                                                                                              | |image144|   |
|                                                                                                                                                                                                                           |              |
|     *Note: This request is working because we have not yet provided any protection for the API.*                                                                                                                          |              |
|                                                                                                                                                                                                                           |              |
|     *Note: If you get “Could not get any response” then Postman’s settings may be set to verify SSL Certificates (default). Click **File** -> **Settings** and turn “\ **SSL Certificate Verification**\ ” to **Off**.*   |              |
+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+

Task 2: Authorization Server
----------------------------

+-----------------------------------------------------------------------------------------------------------------------------------+--------------+
| Configure the Databased Instance                                                                                                  |
+===================================================================================================================================+==============+
| 1. Go to ***Access*** -> ***Federation*** -> ***OAuth Authorization Server*** -> ***Database Instance*** and click ***Create***   | |image145|   |
+-----------------------------------------------------------------------------------------------------------------------------------+--------------+
| 1. Enter oauth-api-db for the ***Name*** field and click ***Finished***.                                                          | |image146|   |
+-----------------------------------------------------------------------------------------------------------------------------------+--------------+

+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| Configure the Scope                                                                                                                                                                                                                                                                                  |
+======================================================================================================================================================================================================================================================================================================+==============+
| 1. Go to ***Access*** -> Federation -> ***OAuth Authorization Server*** -> ***Scope*** and click ***Create***                                                                                                                                                                                        | |image147|   |
+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| 1. Enter the following values and and click ***Finished***.                                                                                                                                                                                                                                          | |image148|   |
|                                                                                                                                                                                                                                                                                                      |              |
|     **Name:** oauth-scope-username                                                                                                                                                                                                                                                                   |              |
|                                                                                                                                                                                                                                                                                                      |              |
|     **Scope Name:** username                                                                                                                                                                                                                                                                         |              |
|                                                                                                                                                                                                                                                                                                      |              |
|     **Scope Value:**                                                                                                                                                                                                                                                                                 |              |
|                                                                                                                                                                                                                                                                                                      |              |
|     %{session.logon.last.username}                                                                                                                                                                                                                                                                   |              |
|                                                                                                                                                                                                                                                                                                      |              |
|     **Caption:** username                                                                                                                                                                                                                                                                            |              |
|                                                                                                                                                                                                                                                                                                      |              |
|     *Note: This scope is requested by the Resource Server and the information here is provided back. You can hardcode a value or use a variable as we have here. So if the scope username is requested, we will supply back the username that was used to login at the Authorization Server (AS).*   |              |
+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| Configure the Client Application                                                                                                                                                                                                                                                                     |
+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| 1. Go to ***Access*** -> Federation -> ***OAuth Authorization Server*** -> ***Client Application*** and click ***Create***                                                                                                                                                                           | |image149|   |
+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| 1. Enter the following values and click ***Finished***.                                                                                                                                                                                                                                              | |image150|   |
|                                                                                                                                                                                                                                                                                                      |              |
|     **Name:** oauth-api-client                                                                                                                                                                                                                                                                       |              |
|                                                                                                                                                                                                                                                                                                      |              |
|     **Application Name:** HR API                                                                                                                                                                                                                                                                     |              |
|                                                                                                                                                                                                                                                                                                      |              |
|     **Caption:** HR API                                                                                                                                                                                                                                                                              |              |
|                                                                                                                                                                                                                                                                                                      |              |
|     **Authentication Type:** Secret                                                                                                                                                                                                                                                                  |              |
|                                                                                                                                                                                                                                                                                                      |              |
|     **Scope:** oauth-scope-username                                                                                                                                                                                                                                                                  |              |
|                                                                                                                                                                                                                                                                                                      |              |
|     **Grant Type:** Authorization Code                                                                                                                                                                                                                                                               |              |
|                                                                                                                                                                                                                                                                                                      |              |
|     **Redirect URI(s): **                                                                                                                                                                                                                                                                            |              |
|                                                                                                                                                                                                                                                                                                      |              |
|     https://www.getpostman.com/oauth2/callback                                                                                                                                                                                                                                                       |              |
|                                                                                                                                                                                                                                                                                                      |              |
|     *(Remember to click **Add**)*                                                                                                                                                                                                                                                                    |              |
|                                                                                                                                                                                                                                                                                                      |              |
|     *Note: The Redirect URI above is a special URI for the Postman client you’ll be using. This would normally be a specific URI to your client. *                                                                                                                                                   |              |
+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| Configure the Resource Server                                                                                                                                                                                                                                                                        |
+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| 1. Go to ***Access*** -> ***Federation*** -> ***OAuth Authorization Server*** -> ***Resource Server*** and click ***Create***                                                                                                                                                                        | |image151|   |
+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| 1. Enter the following values and click ***Finished***.                                                                                                                                                                                                                                              | |image152|   |
|                                                                                                                                                                                                                                                                                                      |              |
|     **Name:** oauth-api-rs                                                                                                                                                                                                                                                                           |              |
|                                                                                                                                                                                                                                                                                                      |              |
|     **Application Type:** Secret                                                                                                                                                                                                                                                                     |              |
+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+

+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| Configure the OAuth Profile                                                                                                                                                                                                                                                                                            |
+========================================================================================================================================================================================================================================================================================================================+==============+
| 1. Go to ***Access*** -> ***Federation*** -> ***OAuth Authorization Server*** -> ***OAuth Profile*** and click ***Create***                                                                                                                                                                                            | |image153|   |
+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| 1. Enter the following values and click ***Finished***.                                                                                                                                                                                                                                                                | |image154|   |
|                                                                                                                                                                                                                                                                                                                        |              |
|     **Name:** oauth-api-profile                                                                                                                                                                                                                                                                                        |              |
|                                                                                                                                                                                                                                                                                                                        |              |
|     **Client Application:** oauth-api-client                                                                                                                                                                                                                                                                           |              |
|                                                                                                                                                                                                                                                                                                                        |              |
|     **Resource Server:** oauth-api-rs                                                                                                                                                                                                                                                                                  |              |
|                                                                                                                                                                                                                                                                                                                        |              |
|     **Database Instance:** oauth-api-db                                                                                                                                                                                                                                                                                |              |
+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| Configure the APM Per Session Policy                                                                                                                                                                                                                                                                                   |
+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| 1. Go to ***Access*** -> ***Profiles/Policies*** -> ***Access Profiles (Per Session Policies)*** and click ***Create***                                                                                                                                                                                                | |image155|   |
+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| 1. In the ***General Properties*** section enter the following values                                                                                                                                                                                                                                                  | |image156|   |
|                                                                                                                                                                                                                                                                                                                        |              |
|     **Name:** oauthas-ap                                                                                                                                                                                                                                                                                               |              |
|                                                                                                                                                                                                                                                                                                                        |              |
|     **Profile Type:** All                                                                                                                                                                                                                                                                                              |              |
|                                                                                                                                                                                                                                                                                                                        |              |
|     **Profile Scope:** Profile                                                                                                                                                                                                                                                                                         |              |
+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| 1. In the ***Configurations*** section select the following value from the ***OAuth Profile*** drop down menu.                                                                                                                                                                                                         | |image157|   |
|                                                                                                                                                                                                                                                                                                                        |              |
|     **OAuth Profile:** oauth-api-profile                                                                                                                                                                                                                                                                               |              |
+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| 1. In the ***Language Settings*** section enter the following value and then click ***Finished***.                                                                                                                                                                                                                     | |image158|   |
|                                                                                                                                                                                                                                                                                                                        |              |
|     **Languages:** English                                                                                                                                                                                                                                                                                             |              |
+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| 1. Click ***Edit*** on the ***oauthas-ap*** policy, a new browser tab will open.                                                                                                                                                                                                                                       | |image159|   |
+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| 1. Click the ***+*** between ***Start*** and ***Deny***.                                                                                                                                                                                                                                                               | |image160|   |
+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| 1. Select ***Logon Page*** from the ***Logon*** tab, and click ***Add Item***                                                                                                                                                                                                                                          | |image161|   |
+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| 1. Accept the defaults on the ***Logon Page*** and click ***Save***                                                                                                                                                                                                                                                    | |image162|   |
+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| 1. Click the ***+*** between ***Logon Page*** and ***Deny***                                                                                                                                                                                                                                                           | |image163|   |
+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| 1. Select ***OAuth Authorization*** from the ***Authentication*** tab and click ***Add Item***                                                                                                                                                                                                                         | |image164|   |
+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| 1. Accept the defaults for the ***OAuth Authorization*** and click ***Save***                                                                                                                                                                                                                                          | |image165|   |
+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| 1. Click ***Deny*** on the ***Successful*** branch after the ***OAuth Authorization*** object, select ***Allow***, click ***Save***                                                                                                                                                                                    | |image166|   |
+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| 1. Click ***Apply Access Policy*** in the top left and then close the tab                                                                                                                                                                                                                                              | |image167|   |
|                                                                                                                                                                                                                                                                                                                        |              |
|     *Note that we are not validating the credentials entered on the Logon Page, so you can enter anything you want. In a production deployment you would most likely include some process for validating credentials such as an LDAP Auth or AD Auth object, or perhaps limiting access by IP or client certificate*   |              |
|                                                                                                                                                                                                                                                                                                                        |              |
|     *This policy might also set some variables that get used as scope values. Thus, you could determine what the scope values are by utilizing the policy here.*                                                                                                                                                       |              |
+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| Create the Authorization Virtual Server                                                                                                                                                                                                                                                                                |
+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| 1. Go to ***Local Traffic*** -> ***Virtual Servers*** and click ***Create***                                                                                                                                                                                                                                           | |image168|   |
+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| 1. Enter the following values for the Authorization Server Virtual Server                                                                                                                                                                                                                                              | |image169|   |
|                                                                                                                                                                                                                                                                                                                        |              |
|     **Name:** oauthas.f5agility.com-vs                                                                                                                                                                                                                                                                                 |              |
|                                                                                                                                                                                                                                                                                                                        |              |
|     **Destination Address:** 10.1.20.110                                                                                                                                                                                                                                                                               |              |
|                                                                                                                                                                                                                                                                                                                        |              |
|     **Service Port:** 443                                                                                                                                                                                                                                                                                              |              |
|                                                                                                                                                                                                                                                                                                                        |              |
|     **HTTP Profile:** http                                                                                                                                                                                                                                                                                             |              |
|                                                                                                                                                                                                                                                                                                                        |              |
|     **SSL Profile (Client): **                                                                                                                                                                                                                                                                                         |              |
|                                                                                                                                                                                                                                                                                                                        |              |
|     f5agility-wildcard-self-clientssl                                                                                                                                                                                                                                                                                  |              |
|                                                                                                                                                                                                                                                                                                                        |              |
|     **Source Address Translation:**                                                                                                                                                                                                                                                                                    |              |
|                                                                                                                                                                                                                                                                                                                        |              |
|     Auto Map                                                                                                                                                                                                                                                                                                           |              |
+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| 1. Scroll to the ***Access Policy*** section, select oauthas-ap from the ***Access Profile*** drop down menu and then click ***Finished*** at the bottom of the screen.                                                                                                                                                | |image170|   |
+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+

Task 3: Resource Server 
------------------------

+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| Configure the OAuth Provider                                                                                                                                                                                                                                                                                                                                            |
+=========================================================================================================================================================================================================================================================================================================================================================================+==============+
| 1. Go to ***Access*** -> ***Federation*** -> ***OAuth Client/Resource Server*** -> ***Provider*** and click ***Create***                                                                                                                                                                                                                                                | |image171|   |
+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| 1. Enter the following values for the Authorization Server Virtual Server and then click ***Finished***                                                                                                                                                                                                                                                                 | |image172|   |
|                                                                                                                                                                                                                                                                                                                                                                         |              |
|     **Name:**                                                                                                                                                                                                                                                                                                                                                           |              |
|                                                                                                                                                                                                                                                                                                                                                                         |              |
|     oauthas.f5agility.com-provider                                                                                                                                                                                                                                                                                                                                      |              |
|                                                                                                                                                                                                                                                                                                                                                                         |              |
|     **Type:** F5                                                                                                                                                                                                                                                                                                                                                        |              |
|                                                                                                                                                                                                                                                                                                                                                                         |              |
|     **Authentication URI:**                                                                                                                                                                                                                                                                                                                                             |              |
|                                                                                                                                                                                                                                                                                                                                                                         |              |
|     https://oauthas.f5agility.com/f5-oauth2/v1/authorize                                                                                                                                                                                                                                                                                                                |              |
|                                                                                                                                                                                                                                                                                                                                                                         |              |
|     **Token URI:**                                                                                                                                                                                                                                                                                                                                                      |              |
|                                                                                                                                                                                                                                                                                                                                                                         |              |
|     https://oauthas.f5agility.com/f5-oauth2/v1/token                                                                                                                                                                                                                                                                                                                    |              |
|                                                                                                                                                                                                                                                                                                                                                                         |              |
|     **Token Validation Scope: **                                                                                                                                                                                                                                                                                                                                        |              |
|                                                                                                                                                                                                                                                                                                                                                                         |              |
|     https://oauthas.f5agility.com/f5-oauth2/v1/introspect                                                                                                                                                                                                                                                                                                               |              |
+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| Configure the OAuth Server                                                                                                                                                                                                                                                                                                                                              |
+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| 1. Go to ***Access*** -> Federation -> ***OAuth Client/Resource Server*** -> ***OAuth Server*** and click ***Create***                                                                                                                                                                                                                                                  | |image173|   |
+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| 1. Enter the following values for the Authorization Server Virtual Server and then click ***Finished***                                                                                                                                                                                                                                                                 | |image174|   |
|                                                                                                                                                                                                                                                                                                                                                                         |              |
|     **Name:** api-resource-server                                                                                                                                                                                                                                                                                                                                       |              |
|                                                                                                                                                                                                                                                                                                                                                                         |              |
|     **Mode:** Resource Server                                                                                                                                                                                                                                                                                                                                           |              |
|                                                                                                                                                                                                                                                                                                                                                                         |              |
|     **Type:** F5                                                                                                                                                                                                                                                                                                                                                        |              |
|                                                                                                                                                                                                                                                                                                                                                                         |              |
|     **OAuth Provider:**                                                                                                                                                                                                                                                                                                                                                 |              |
|                                                                                                                                                                                                                                                                                                                                                                         |              |
|     Oauthas.f5agility.com-provider                                                                                                                                                                                                                                                                                                                                      |              |
|                                                                                                                                                                                                                                                                                                                                                                         |              |
|     **DNS Resolver:** oauth-dns                                                                                                                                                                                                                                                                                                                                         |              |
|                                                                                                                                                                                                                                                                                                                                                                         |              |
|     **Resource Server ID:** (see step 5)                                                                                                                                                                                                                                                                                                                                |              |
|                                                                                                                                                                                                                                                                                                                                                                         |              |
|     *<Get this from Big-IP 2 -> Access -> Federation -> OAuth Authorization Server -> Resource Server -> oauth-api-rs>*                                                                                                                                                                                                                                                 |              |
|                                                                                                                                                                                                                                                                                                                                                                         |              |
|     **Resource Server Secret:** (see step 5)                                                                                                                                                                                                                                                                                                                            |              |
|                                                                                                                                                                                                                                                                                                                                                                         |              |
|     *<Get this from Big-IP 2 -> Access -> Federation -> OAuth Authorization Server -> Resource Server -> oauth-api-rs>*                                                                                                                                                                                                                                                 |              |
|                                                                                                                                                                                                                                                                                                                                                                         |              |
|     **Resource Server’s Server SSL Profile Name: **                                                                                                                                                                                                                                                                                                                     |              |
|                                                                                                                                                                                                                                                                                                                                                                         |              |
|     apm-allowuntrusted-serverssl                                                                                                                                                                                                                                                                                                                                        |              |
|                                                                                                                                                                                                                                                                                                                                                                         |              |
|     *Note: We are using a custom serverssl profile to allow negotiation with an untrusted certificate. This is needed because our Authorization Server is using a self-signed certificate. In production for proper security you should leverage a trusted certificate (most likely publicly signed) and the apm-default-serverssl profile (or other as appropriate)*   |              |
+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| 1. The values for step 4 above can be obtained by accessing Big-IP 2 and navigating to ***Access*** -> ***Federation*** -> ***OAuth Authorization Server*** -> ***Resource Server*** -> ***oauth-api-rs*** as shown.                                                                                                                                                    | |image175|   |
+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| 1. To configure the ***APM Per Session Policy*** go to ***Access*** -> ***Profiles / Policies*** -> ***Access Profiles (Per Session Policies)*** and then click ***Create***                                                                                                                                                                                            | |image176|   |
+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| 1. Enter the following values and then click ***Finished***                                                                                                                                                                                                                                                                                                             | |image177|   |
|                                                                                                                                                                                                                                                                                                                                                                         |              |
|     **Name:** api-ap                                                                                                                                                                                                                                                                                                                                                    |              |
|                                                                                                                                                                                                                                                                                                                                                                         |              |
|     **Profile Type: **                                                                                                                                                                                                                                                                                                                                                  |              |
|                                                                                                                                                                                                                                                                                                                                                                         |              |
|     OAuth-Resource-Server                                                                                                                                                                                                                                                                                                                                               |              |
|                                                                                                                                                                                                                                                                                                                                                                         |              |
|     **Profile Scope:** Profile                                                                                                                                                                                                                                                                                                                                          |              |
|                                                                                                                                                                                                                                                                                                                                                                         |              |
|     **Languages:** English                                                                                                                                                                                                                                                                                                                                              |              |
|                                                                                                                                                                                                                                                                                                                                                                         |              |
|     *Note: User Identification Method is set to OAuth Token and you cannot change it for this profile type.*                                                                                                                                                                                                                                                            |              |
+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| 1. Click ***Edit*** on the new api-ap policy and a new window will open                                                                                                                                                                                                                                                                                                 | |image178|   |
+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| 1. Click ***Deny*** on the fallback branch after ***Start***, select ***Allow*** and click ***Save***                                                                                                                                                                                                                                                                   | |image179|   |
+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| 1. Click ***Apply Access Policy*** in the top left and then close the tab                                                                                                                                                                                                                                                                                               | |image180|   |
+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| 1. To configure the ***APM Per Request Policy*** go to ***Access*** -> ***Profiles / Policies*** -> ***Per Request Policies*** and then click ***Create***                                                                                                                                                                                                              | |image181|   |
+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| 1. Enter api-prp for the ***Name*** and click ***Finished***                                                                                                                                                                                                                                                                                                            | |image182|   |
+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| 1. Click ***Edit*** on the ***api-prp*** policy and a new window will appear                                                                                                                                                                                                                                                                                            | |image183|   |
+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| 1. Click ***Add New Subroutine***                                                                                                                                                                                                                                                                                                                                       | |image184|   |
+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| 1. Leave the “\ ***Select Subroutine template***\ ” as Empty. Enter RS Scope Check for the ***Name*** and then click ***Save***                                                                                                                                                                                                                                         | |image185|   |
+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| 1. Click the ***+*** next to the ***RS Scope Check***                                                                                                                                                                                                                                                                                                                   | |image186|   |
+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| 1. Click Edit Terminals on the RS Scope Check Subroutine                                                                                                                                                                                                                                                                                                                | |image187|   |
+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| 1. First, rename ***Out*** to Success, then click ***Add Terminal*** and name it Failure                                                                                                                                                                                                                                                                                | |image188|   |
+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| 1. Go to the ***Set Default*** tab and select ***Failure*** then click Save                                                                                                                                                                                                                                                                                             | |image189|   |
+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| 1. Click ***Edit Terminals*** again *(it will ignore the order settings if you do this in one step without saving in between)*                                                                                                                                                                                                                                          | |image190|   |
+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| 1. Move ***Success*** to the top using the up arrow on the right side then click ***Save***                                                                                                                                                                                                                                                                             | |image191|   |
+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| 1. Click the ***+*** between ***In*** and ***Success***, a new window will appear                                                                                                                                                                                                                                                                                       | |image192|   |
+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| 1. Select ***OAuth Scope*** from the ***Authentication*** tab and click ***Add Item***                                                                                                                                                                                                                                                                                  | |image193|   |
+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| 1. Enter the following values and then click ***Save***                                                                                                                                                                                                                                                                                                                 | |image194|   |
|                                                                                                                                                                                                                                                                                                                                                                         |              |
|     **Server:**                                                                                                                                                                                                                                                                                                                                                         |              |
|                                                                                                                                                                                                                                                                                                                                                                         |              |
|     /Common/api-resource-server                                                                                                                                                                                                                                                                                                                                         |              |
|                                                                                                                                                                                                                                                                                                                                                                         |              |
|     **Scopes Request: **                                                                                                                                                                                                                                                                                                                                                |              |
|                                                                                                                                                                                                                                                                                                                                                                         |              |
|     /Common/F5ScopesRequest                                                                                                                                                                                                                                                                                                                                             |              |
+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| 1. Verify that the ***Successful*** branch terminates in ***Success*** and the ***Fallback*** branch terminates in ***Failure***                                                                                                                                                                                                                                        | |image195|   |
+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| 1. In the main policy, click ***+*** between the ***Start*** and ***Allow***                                                                                                                                                                                                                                                                                            | |image196|   |
+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| 1. Select ***RS Scope Check*** from the ***Subroutines*** tab and click ***Add Item***                                                                                                                                                                                                                                                                                  | |image197|   |
+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| 1. Verify that the Success branch terminates in Allow and the Fallback branch terminates in Reject                                                                                                                                                                                                                                                                      | |image198|   |
|                                                                                                                                                                                                                                                                                                                                                                         |              |
|     *Note: You do not need to “Apply Policy “ on Per Request Policies*                                                                                                                                                                                                                                                                                                  |              |
+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| 1. To add the APM Policies to the API Virtual Server, go to ***Local Traffic*** -> ***Virtual Servers*** and click on ***api.f5agility.com-vs***                                                                                                                                                                                                                        | |image199|   |
+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| 1. Scroll down to the ***Access Policy*** section. Change ***Access Profile*** from **None** to api-ap                                                                                                                                                                                                                                                                  | |image200|   |
|                                                                                                                                                                                                                                                                                                                                                                         |              |
| 2. and change ***Per-Request Policy*** from **None** to api-prp and then click ***Update***                                                                                                                                                                                                                                                                             |              |
+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+

Task 3: Verify
--------------

+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| 1. On the Jump Host, launch ***Postman*** from the desktop icon                                                                                                                                                                                                                                    | |image201|                                                                                                                                                                                                                                                                                                          |
+====================================================================================================================================================================================================================================================================================================+=====================================================================================================================================================================================================================================================================================================================+
| 1. The request should be prefilled with the settings below (same as earlier). If not change as needed or select ***TEST API Call*** from the ***API Collection*** and click ***Send***                                                                                                             | |image202|                                                                                                                                                                                                                                                                                                          |
|                                                                                                                                                                                                                                                                                                    |                                                                                                                                                                                                                                                                                                                     |
|     **Method:** GET                                                                                                                                                                                                                                                                                |                                                                                                                                                                                                                                                                                                                     |
|                                                                                                                                                                                                                                                                                                    |                                                                                                                                                                                                                                                                                                                     |
|     **Target:** https://api.f5agility.com/department                                                                                                                                                                                                                                               |                                                                                                                                                                                                                                                                                                                     |
|                                                                                                                                                                                                                                                                                                    |                                                                                                                                                                                                                                                                                                                     |
|     **Authorization:** No Auth                                                                                                                                                                                                                                                                     |                                                                                                                                                                                                                                                                                                                     |
|                                                                                                                                                                                                                                                                                                    |                                                                                                                                                                                                                                                                                                                     |
|     **Headers:** (none should be set)                                                                                                                                                                                                                                                              |                                                                                                                                                                                                                                                                                                                     |
+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| 1. You should receive a ***401 Unauthorized*** and ***3 headers***, including ***WWW-Authenticate: Bearer***. The body will be empty.                                                                                                                                                              | |image203|                                                                                                                                                                                                                                                                                                          |
|                                                                                                                                                                                                                                                                                                    |                                                                                                                                                                                                                                                                                                                     |
|     *Note: Your API call failed because you are not providing an OAuth token.*                                                                                                                                                                                                                     | *Both tabs shown*                                                                                                                                                                                                                                                                                                   |
|                                                                                                                                                                                                                                                                                                    |                                                                                                                                                                                                                                                                                                                     |
|                                                                                                                                                                                                                                                                                                    | |image204|                                                                                                                                                                                                                                                                                                          |
+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| 1. Click the ***Authorization*** tab and change the ***Type*** from **No Auth** to OAuth 2.0                                                                                                                                                                                                       | |image205|                                                                                                                                                                                                                                                                                                          |
+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| 1. If present, select any existing tokens on the left side and delete them on the right side. Click ***Get New Access Token***                                                                                                                                                                     | |image206|                                                                                                                                                                                                                                                                                                          |
+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| 1. In the ***Get New Access Token*** window, if the values do not match then adjust as needed, and click ***Request Token***                                                                                                                                                                       | |image207|                                                                                                                                                                                                                                                                                                          |
|                                                                                                                                                                                                                                                                                                    |                                                                                                                                                                                                                                                                                                                     |
|     **Token Name:**                                                                                                                                                                                                                                                                                | *Note: If you’re doing this lab on your own machine and using self signed certificates you must add the certs to the trusted store on your computer. If you’ve just done this, you must close Postman and reopen. You also need to go to File -> Settings in Postman and turn SSL certificate validation to off.*   |
|                                                                                                                                                                                                                                                                                                    |                                                                                                                                                                                                                                                                                                                     |
|     <Anything is fine here>                                                                                                                                                                                                                                                                        |                                                                                                                                                                                                                                                                                                                     |
|                                                                                                                                                                                                                                                                                                    |                                                                                                                                                                                                                                                                                                                     |
|     **Auth URL:**                                                                                                                                                                                                                                                                                  |                                                                                                                                                                                                                                                                                                                     |
|                                                                                                                                                                                                                                                                                                    |                                                                                                                                                                                                                                                                                                                     |
|     https://oauthas.f5agility.com/f5-oauth2/v1/authorize                                                                                                                                                                                                                                           |                                                                                                                                                                                                                                                                                                                     |
|                                                                                                                                                                                                                                                                                                    |                                                                                                                                                                                                                                                                                                                     |
|     **Access Token URL:**                                                                                                                                                                                                                                                                          |                                                                                                                                                                                                                                                                                                                     |
|                                                                                                                                                                                                                                                                                                    |                                                                                                                                                                                                                                                                                                                     |
|     https://oauthas.f5agility.com/f5-oauth2/v1/token                                                                                                                                                                                                                                               |                                                                                                                                                                                                                                                                                                                     |
|                                                                                                                                                                                                                                                                                                    |                                                                                                                                                                                                                                                                                                                     |
|     **Client ID: **                                                                                                                                                                                                                                                                                |                                                                                                                                                                                                                                                                                                                     |
|                                                                                                                                                                                                                                                                                                    |                                                                                                                                                                                                                                                                                                                     |
|     <Get this from Big-IP 2 -> Access -> Federation -> OAuth Authorization Server -> Client Application -> oauth-api-client>                                                                                                                                                                       |                                                                                                                                                                                                                                                                                                                     |
|                                                                                                                                                                                                                                                                                                    |                                                                                                                                                                                                                                                                                                                     |
|     **Client Secret:**                                                                                                                                                                                                                                                                             |                                                                                                                                                                                                                                                                                                                     |
|                                                                                                                                                                                                                                                                                                    |                                                                                                                                                                                                                                                                                                                     |
|     <Get this from Big-IP 2 -> Access -> Federation -> OAuth Authorization Server -> Client Application -> oauth-api-client>                                                                                                                                                                       |                                                                                                                                                                                                                                                                                                                     |
|                                                                                                                                                                                                                                                                                                    |                                                                                                                                                                                                                                                                                                                     |
|     **Scope:**                                                                                                                                                                                                                                                                                     |                                                                                                                                                                                                                                                                                                                     |
|                                                                                                                                                                                                                                                                                                    |                                                                                                                                                                                                                                                                                                                     |
|     **Grant Type:**                                                                                                                                                                                                                                                                                |                                                                                                                                                                                                                                                                                                                     |
|                                                                                                                                                                                                                                                                                                    |                                                                                                                                                                                                                                                                                                                     |
|     Authorization Code                                                                                                                                                                                                                                                                             |                                                                                                                                                                                                                                                                                                                     |
|                                                                                                                                                                                                                                                                                                    |                                                                                                                                                                                                                                                                                                                     |
|     **Request access token locally:**                                                                                                                                                                                                                                                              |                                                                                                                                                                                                                                                                                                                     |
|                                                                                                                                                                                                                                                                                                    |                                                                                                                                                                                                                                                                                                                     |
|     checked                                                                                                                                                                                                                                                                                        |                                                                                                                                                                                                                                                                                                                     |
+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| 1. Logon with any credentials, such as user/password                                                                                                                                                                                                                                               | |image208|                                                                                                                                                                                                                                                                                                          |
+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| 1. Authorize the HR API by clicking ***Authorize***                                                                                                                                                                                                                                                | |image209|                                                                                                                                                                                                                                                                                                          |
+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| 1. You now have received an OAuth Token. Click the ***name of your token*** under ***Existing Tokens*** (left) and your token will appear on the right                                                                                                                                             | |image210|                                                                                                                                                                                                                                                                                                          |
+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| 1. Change the ***Add token to*** drop down to Header and the click ***Use Token***. You will note that the ***Header*** tab (in the section tabs just above) now has one header in the ***Header*** tab which contains your ***Authorization Header*** of type ***Bearer*** with a string value.   | |image211|                                                                                                                                                                                                                                                                                                          |
|                                                                                                                                                                                                                                                                                                    |                                                                                                                                                                                                                                                                                                                     |
|     *The Header tab data is shown in the graphic*                                                                                                                                                                                                                                                  | |image212|                                                                                                                                                                                                                                                                                                          |
+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| 1. Click ***Send*** at the top of the Postman screen                                                                                                                                                                                                                                               | |image213|                                                                                                                                                                                                                                                                                                          |
+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| 1. You should receive a ***200 OK***, ***5 headers*** and the ***body*** should contain a list of departments                                                                                                                                                                                      | |image214|                                                                                                                                                                                                                                                                                                          |
|                                                                                                                                                                                                                                                                                                    |                                                                                                                                                                                                                                                                                                                     |
|     Note: This time the request was successful because you presented a valid OAuth token to the resource server (the Big-IP), so it allowed the traffic to the API server on the backend.                                                                                                          |                                                                                                                                                                                                                                                                                                                     |
+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+

Task 4: Testing Session and Token States
----------------------------------------

+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Invalidate the Session                                                                                                                                                                                                                                                                    |
+===========================================================================================================================================================================================================================================================================================+===========================================================================================================================================================================================+
| 1. Go to ***Big-IP 1 (OAuth C/RS)*** -> ***Access*** -> ***Overview*** -> ***Active Sessions***. Select the existing sessions and click ***Kill Selected Sessions***, then confirm by clicking ***Delete***                                                                               | |image215|                                                                                                                                                                                |
+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| 1. Go back to ***Postman*** and click ***Send*** with your current OAuth token still inserted into the header. You should still receive a 200 OK, 5 headers and the body should contain a list of departments.                                                                            | |image216|                                                                                                                                                                                |
|                                                                                                                                                                                                                                                                                           |                                                                                                                                                                                           |
|                                                                                                                                                                                                                                                                                           |     *Note: You were still able to reach the API because you were able to establish a new session with your existing valid token*.                                                         |
+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Invalidate both the Current Session and Token                                                                                                                                                                                                                                             |
+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| 1. Go Big-IP 2 (OAuth AS) -> ***Access*** -> ***Overview*** -> ***OAuth Reports*** -> ***Tokens***. Change the ***DB Instance*** to oauth-api-db.                                                                                                                                         | |image217|                                                                                                                                                                                |
+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| 1. Select all tokens, click ***Checkbox*** left in title bar and the click ***Revoke*** in the top right                                                                                                                                                                                  | |image218|                                                                                                                                                                                |
+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| 1. Go to ***Big-IP 1 (OAuth C/RS)*** -> ***Access*** -> ***Overview*** -> ***Active Sessions***. Select the existing sessions and click ***Kill Selected Sessions***, then confirm by clicking ***Delete***                                                                               | |image219|                                                                                                                                                                                |
+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| 1. Go back to ***Postman*** and click Send with your *current OAuth token still inserted* into the header. You should receive a ***401 Unauthorized***, ***3 headers***, no body, and the WWW-Authenticate header will provide an error description indicating the token is not active.   | |image220|                                                                                                                                                                                |
|                                                                                                                                                                                                                                                                                           |                                                                                                                                                                                           |
|     *Note: You can remove the header, delete the token, and start over getting a new token and it will work once again.*                                                                                                                                                                  |     *Note: This time you were no longer able to reach the API because you no longer had a valid token to establish your new session with. Getting a new token will resolve the issue. *   |
+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+

Module: Reporting and Session Management
========================================

Task 1: Big-IP as Authorization Server (Big-IP 2)
-------------------------------------------------

+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| 1. You can see reporting on OAuth traffic at ***Access*** -> ***Overview*** -> ***OAuth Reports*** -> ***Server***                                                                                                                                                                                    | |image221|   |
+=======================================================================================================================================================================================================================================================================================================+==============+
| 1. You can see the session logs by going to ***Access***-> ***Overview***-> ***Active Sessions*** and click on the active session, or for past sessions under ***Access*** -> ***Overview*** -> ***Access Reports*** -> ***All Sessions Report*** *(it runs by default and asks for a time period)*   | |image222|   |
+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+

Task 2: Big-IP as Client / Resource Server (Big-IP 1)
-----------------------------------------------------

+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| 1. After logging in Go to ***Access*** -> ***Overview*** -> ***Active Sessions*** and note that the “User” field is populated with the name from your social account *(from social account labs).* This happens because we took the relevant variable from the OAuth response and put it into the variable *session.logon.last.username*.   | |image223|   |
+=============================================================================================================================================================================================================================================================================================================================================+==============+
| 1. There are more session variables retrieved from the provider you can examine. To see them click on ***View*** under ***Variables*** for the session. Search for variables that start with “session.oauth.scope.last”. The scope will determine what the Authorization Server returns to you.                                             | |image224|   |
|                                                                                                                                                                                                                                                                                                                                             |              |
|     *Note: You can terminate this session if desired at the Active Sessions screen*                                                                                                                                                                                                                                                         | |image225|   |
+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| 1. You can see reporting on OAuth traffic at ***Access*** -> ***Overview*** -> ***OAuth Reports*** -> ***Client*** / ***Resource Server***                                                                                                                                                                                                  | |image226|   |
+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| 1. You can see the session logs by going to ***Access***-> ***Overview***-> ***Active Sessions*** and click on the active session, or for past sessions under Access -> Overview -> Access Reports -> All Sessions Report *(it runs by default and asks for a time period)*                                                                 | |image227|   |
+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+

Module: Troubleshooting
=======================

Task 1: Logging Levels
----------------------

+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| 1. You can turn up the logging levels specific to OAuth at ***Access*** -> ***Overview*** -> ***Event Logs*** -> ***Settings***. Often times *Informational* is enough to identify issues. It is recommended to start there before going to debug. In particular pay attention *session.oauth.client.last.errMsg* as it contains the errors the other side reported back to you.   | |image228|   |
|                                                                                                                                                                                                                                                                                                                                                                                    |              |
|                                                                                                                                                                                                                                                                                                                                                                                    | |image229|   |
+====================================================================================================================================================================================================================================================================================================================================================================================+==============+
+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+

Task 2: Traffic Captures
------------------------

+-----------------------------------------------------------------------------------------------------------------------------------------------------+--------------+
| 1. You can actually examine what Big-IP has sent out when acting as a client/resource server. First, capture the traffic on the tmm channel:        | |image230|   |
|                                                                                                                                                     |              |
|     tcpdump -i tmm:h -s0 -w /tmp/oauth.dmp                                                                                                          |              |
+=====================================================================================================================================================+==============+
| 1. Then attempt your login using OAuth and ctrl-c the capture to end it. Now you need to ssldump the output:                                        | |image231|   |
|                                                                                                                                                     |              |
|    ssldump -dr /tmp/oauth.dmp \| more                                                                                                               |              |
|                                                                                                                                                     |              |
|    Note: Your SSL Ciphers must support ssldump utility. Refer to the following link for further details https://support.f5.com/csp/article/K10209   |              |
+-----------------------------------------------------------------------------------------------------------------------------------------------------+--------------+

Information: Logging at the Other Side
--------------------------------------

Sometimes the issue is not at your end and some providers have their own
logging and reporting you can leverage. As an example, Google has a
dashboard that reports errors.

Information: The Browser
------------------------

Although a lot of the critical stuff is passed back and forth directly
without your browser being involved, you can at least validate the
browser portions of the transaction are good (e.g. are you passing all
the values you should, example below for Google).

Learn More
==========

***Links & Information ***

-  Access Policy Manager (APM) Operations Guide:
   https://support.f5.com/content/kb/en-us/products/big-ip_apm/manuals/product/f5-apm-operations-guide/_jcr_content/pdfAttach/download/file.res/f5-apm-operations-guide.pdf

-  Access Policy Manager (APM) Authentication & Single Sign On Concepts:
   https://support.f5.com/kb/en-us/products/big-ip_apm/manuals/product/apm-authentication-sso-13-0-0.html

-  OAuth Overview:
   https://support.f5.com/kb/en-us/products/big-ip_apm/manuals/product/apm-authentication-sso-13-0-0/35.html#guid-c1b617a7-07b5-4ad6-9b84-29d6ecd789b4

-  OAuth Client & Resource Server:
   https://support.f5.com/kb/en-us/products/big-ip_apm/manuals/product/apm-authentication-sso-13-0-0/36.html#guid-c6db081e-e8ac-454b-84c8-02a1a282a888

-  OAuth Authorization Server:
   https://support.f5.com/kb/en-us/products/big-ip_apm/manuals/product/apm-authentication-sso-13-0-0/37.html#guid-be8761c9-5e2f-4ad8-b829-871c7feb2a20

-  Troubleshooting Tips

   -  OAuth Client & Resource Server:
      https://support.f5.com/kb/en-us/products/big-ip_apm/manuals/product/apm-authentication-sso-13-0-0/36.html#guid-774384bc-cf63-469d-a589-1595d0ddfba2

   -  OAuth Authorization Server:
      https://support.f5.com/kb/en-us/products/big-ip_apm/manuals/product/apm-authentication-sso-13-0-0/37.html#guid-8b97b512-ec2b-4bfb-a6aa-1af24842ee7a

***Lab Reproduction***

If you are building your own, here is some important information about
the environment not covered in the lab. This lab environment requires
two Big-IPs. One will act as an OAuth Client and Resource (Client/RS)
Server. The other will act as an OAuth Authorization Server (AS). Both
must be licensed and provisioned for Access Policy Manager (APM).

On the OAuth Client/RS Big-IP you will need backend pools for the two
virtual servers, the lab expects a webapp behind the Social VS that
accepts a header named x-user and reposts it back to the user. The lab
expects an API behind the API VS that can respond with a list of
departments to a request to /department. Also, a DNS Resolver must be
configured on this Big-IP, in our case we don’t have a local DNS server
to respond for the names used, so we are also leveraging an iRule and VS
to answer DNS requests for specific names. You will need a browser for
testing the social module and Postman for testing the API module.

Notes:

+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| F5 Networks, Inc. \| f5.com                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
+======================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================+
| US Headquarters: 401 Elliott Ave W, Seattle, WA 98119 \| 888-882-4447 // Americas: info@f5.com // Asia-Pacific: apacinfo@f5.com // Europe/Middle East/Africa: emeainfo@f5.com // Japan: f5j-info@f5.com                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| ©2017 F5 Networks, Inc. All rights reserved. F5, F5 Networks, and the F5 logo are trademarks of F5 Networks, Inc. in the U.S. and in certain other countries. Other F5 trademarks are identified at f5.com. Any other products, services, or company names referenced herein may be trademarks of their respective owners with no endorsement or affiliation, express or implied, claimed by F5. These training materials and documentation are F5 Confidential Information and are subject to the F5 Networks Reseller Agreement. You may not share these training materials and documentation with any third party without the express written permission of F5.   |
+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+

.. |image0| image:: media/image2.png
   :width: 6.24722in
   :height: 4.01806in
.. |image1| image:: media/image3.png
   :width: 3.20588in
   :height: 0.68533in
.. |image2| image:: media/image4.png
   :width: 2.53529in
   :height: 3.83595in
.. |image3| image:: media/image5.png
   :width: 3.35625in
   :height: 1.94789in
.. |image4| image:: media/image6.png
   :width: 3.49028in
   :height: 2.04653in
.. |image5| image:: media/image7.png
   :width: 3.59218in
   :height: 0.64388in
.. |image6| image:: media/image8.png
   :width: 3.56425in
   :height: 1.40552in
.. |image7| image:: media/image9.png
   :width: 3.55866in
   :height: 1.35766in
.. |image8| image:: media/image10.png
   :width: 3.58101in
   :height: 0.64999in
.. |image9| image:: media/image11.png
   :width: 3.57542in
   :height: 1.00179in
.. |image10| image:: media/image12.png
   :width: 3.55307in
   :height: 1.68402in
.. |image11| image:: media/image13.png
   :width: 3.50303in
   :height: 1.64246in
.. |image12| image:: media/image14.png
   :width: 3.52514in
   :height: 0.91255in
.. |image13| image:: media/image15.png
   :width: 3.54706in
   :height: 0.38482in
.. |image14| image:: media/image16.png
   :width: 3.56458in
   :height: 0.92612in
.. |image15| image:: media/image17.png
   :width: 3.46183in
   :height: 2.38736in
.. |image16| image:: media/image18.png
   :width: 3.46927in
   :height: 1.66263in
.. |image17| image:: media/image19.png
   :width: 3.60363in
   :height: 1.09375in
.. |image18| image:: media/image20.png
   :width: 3.46267in
   :height: 2.48594in
.. |image19| image:: media/image21.png
   :width: 3.48045in
   :height: 1.84858in
.. |image20| image:: media/image22.png
   :width: 3.45251in
   :height: 1.24160in
.. |image21| image:: media/image23.png
   :width: 3.27059in
   :height: 1.63159in
.. |image22| image:: media/image24.png
   :width: 3.32961in
   :height: 2.10896in
.. |image23| image:: media/image25.png
   :width: 3.38108in
   :height: 1.95529in
.. |image24| image:: media/image26.png
   :width: 3.10300in
   :height: 1.92737in
.. |image25| image:: media/image27.png
   :width: 3.19452in
   :height: 1.63222in
.. |image26| image:: media/image28.png
   :width: 3.15084in
   :height: 1.72999in
.. |image27| image:: media/image29.png
   :width: 3.35754in
   :height: 1.47225in
.. |image28| image:: media/image30.png
   :width: 3.32402in
   :height: 3.61440in
.. |image29| image:: media/image31.png
   :width: 3.10056in
   :height: 2.08849in
.. |image30| image:: media/image32.png
   :width: 3.52514in
   :height: 2.76291in
.. |image31| image:: media/image33.png
   :width: 3.46369in
   :height: 1.44887in
.. |image32| image:: media/image34.png
   :width: 3.39092in
   :height: 2.91683in
.. |image33| image:: media/image35.png
   :width: 3.26261in
   :height: 1.39553in
.. |image34| image:: media/image36.png
   :width: 3.20670in
   :height: 1.87925in
.. |image35| image:: media/image37.png
   :width: 3.13966in
   :height: 2.19066in
.. |image36| image:: media/image38.png
   :width: 3.59218in
   :height: 0.57610in
.. |image37| image:: media/image39.png
   :width: 3.56011in
   :height: 3.79790in
.. |image38| image:: media/image10.png
   :width: 3.58101in
   :height: 0.64999in
.. |image39| image:: media/image40.png
   :width: 3.29050in
   :height: 1.33669in
.. |image40| image:: media/image41.png
   :width: 3.28492in
   :height: 2.61926in
.. |image41| image:: media/image42.png
   :width: 3.52559in
   :height: 2.00127in
.. |image42| image:: media/image43.png
   :width: 3.14983in
   :height: 1.58383in
.. |image43| image:: media/image44.png
   :width: 3.30726in
   :height: 2.79557in
.. |image44| image:: media/image45.png
   :width: 3.38547in
   :height: 1.14595in
.. |image45| image:: media/image46.png
   :width: 3.52514in
   :height: 1.31095in
.. |image46| image:: media/image47.png
   :width: 3.48045in
   :height: 2.26032in
.. |image47| image:: media/image48.png
   :width: 3.50779in
   :height: 1.27141in
.. |image48| image:: media/image49.png
   :width: 3.54190in
   :height: 1.00844in
.. |image49| image:: media/image50.png
   :width: 3.57542in
   :height: 1.47199in
.. |image50| image:: media/image51.png
   :width: 3.55866in
   :height: 1.02798in
.. |image51| image:: media/image52.png
   :width: 3.54648in
   :height: 0.97695in
.. |image52| image:: media/image53.png
   :width: 3.51955in
   :height: 2.45970in
.. |image53| image:: media/image54.png
   :width: 3.36313in
   :height: 2.30660in
.. |image54| image:: media/image55.png
   :width: 3.41417in
   :height: 2.37188in
.. |image55| image:: media/image56.png
   :width: 3.45810in
   :height: 1.53657in
.. |image56| image:: media/image57.png
   :width: 3.50838in
   :height: 1.43844in
.. |image57| image:: media/image58.png
   :width: 3.52509in
   :height: 1.37612in
.. |image58| image:: media/image59.png
   :width: 3.49162in
   :height: 2.04029in
.. |image59| image:: media/image60.png
   :width: 3.49162in
   :height: 2.53571in
.. |image60| image:: media/image61.png
   :width: 3.45251in
   :height: 1.63962in
.. |image61| image:: media/image62.png
   :width: 3.45251in
   :height: 1.14128in
.. |image62| image:: media/image63.png
   :width: 3.48603in
   :height: 2.10741in
.. |image63| image:: media/image64.png
   :width: 3.49721in
   :height: 3.22733in
.. |image64| image:: media/image65.png
   :width: 3.51955in
   :height: 1.09770in
.. |image65| image:: media/image66.png
   :width: 3.50279in
   :height: 1.18698in
.. |image66| image:: media/image67.png
   :width: 3.53889in
   :height: 0.49812in
.. |image67| image:: media/image68.png
   :width: 3.55866in
   :height: 3.81582in
.. |image68| image:: media/image69.png
   :width: 3.54167in
   :height: 0.64285in
.. |image69| image:: media/image70.png
   :width: 3.54190in
   :height: 1.02648in
.. |image70| image:: media/image41.png
   :width: 3.28492in
   :height: 2.61926in
.. |image71| image:: media/image71.png
   :width: 3.56983in
   :height: 1.99843in
.. |image72| image:: media/image72.png
   :width: 3.49162in
   :height: 1.10941in
.. |image73| image:: media/image44.png
   :width: 3.30726in
   :height: 2.79557in
.. |image74| image:: media/image73.png
   :width: 3.58101in
   :height: 1.19524in
.. |image75| image:: media/image74.png
   :width: 3.53073in
   :height: 1.04656in
.. |image76| image:: media/image47.png
   :width: 3.48045in
   :height: 2.26032in
.. |image77| image:: media/image75.png
   :width: 3.55833in
   :height: 1.28771in
.. |image78| image:: media/image49.png
   :width: 3.54190in
   :height: 1.00844in
.. |image79| image:: media/image76.png
   :width: 3.51397in
   :height: 1.35122in
.. |image80| image:: media/image77.png
   :width: 3.51948in
   :height: 1.29357in
.. |image81| image:: media/image78.png
   :width: 3.52503in
   :height: 1.17523in
.. |image82| image:: media/image79.png
   :width: 3.68056in
   :height: 2.45347in
.. |image83| image:: media/image80.png
   :width: 1.74302in
   :height: 1.82575in
.. |image84| image:: media/image81.png
   :width: 3.32761in
   :height: 2.42288in
.. |image85| image:: media/image82.png
   :width: 3.36313in
   :height: 1.17519in
.. |image86| image:: media/image83.png
   :width: 1.70224in
   :height: 3.37989in
.. |image87| image:: media/image84.png
   :width: 3.15084in
   :height: 3.73761in
.. |image88| image:: media/image85.png
   :width: 3.55000in
   :height: 0.72407in
.. |image89| image:: media/image86.png
   :width: 3.46111in
   :height: 1.65546in
.. |image90| image:: media/image87.png
   :width: 3.47020in
   :height: 0.69338in
.. |image91| image:: media/image88.png
   :width: 3.37959in
   :height: 4.31312in
.. |image92| image:: media/image89.png
   :width: 2.45695in
   :height: 3.01556in
.. |image93| image:: media/image87.png
   :width: 3.47020in
   :height: 0.69338in
.. |image94| image:: media/image90.png
   :width: 3.35853in
   :height: 4.17219in
.. |image95| image:: media/image91.png
   :width: 1.54967in
   :height: 1.90598in
.. |image96| image:: media/image87.png
   :width: 3.47020in
   :height: 0.69338in
.. |image97| image:: media/image92.png
   :width: 3.41538in
   :height: 4.26471in
.. |image98| image:: media/image93.png
   :width: 2.67984in
   :height: 1.53800in
.. |image99| image:: media/image87.png
   :width: 3.47020in
   :height: 0.69338in
.. |image100| image:: media/image94.png
   :width: 3.35882in
   :height: 4.34492in
.. |image101| image:: media/image93.png
   :width: 2.67984in
   :height: 1.53800in
.. |image102| image:: media/image95.png
   :width: 3.50993in
   :height: 0.55828in
.. |image103| image:: media/image96.png
   :width: 3.49813in
   :height: 3.80966in
.. |image104| image:: media/image69.png
   :width: 3.54167in
   :height: 0.64285in
.. |image105| image:: media/image97.png
   :width: 3.56954in
   :height: 1.05200in
.. |image106| image:: media/image98.png
   :width: 3.54967in
   :height: 0.90751in
.. |image107| image:: media/image99.png
   :width: 3.56944in
   :height: 1.94164in
.. |image108| image:: media/image100.png
   :width: 3.56944in
   :height: 1.21967in
.. |image109| image:: media/image101.png
   :width: 3.55629in
   :height: 1.51444in
.. |image110| image:: media/image102.png
   :width: 3.47020in
   :height: 0.48452in
.. |image111| image:: media/image103.png
   :width: 3.47020in
   :height: 1.20213in
.. |image112| image:: media/image104.png
   :width: 3.43046in
   :height: 1.48028in
.. |image113| image:: media/image105.png
   :width: 3.46358in
   :height: 1.41811in
.. |image114| image:: media/image106.png
   :width: 3.47622in
   :height: 1.14912in
.. |image115| image:: media/image107.png
   :width: 3.32450in
   :height: 2.65082in
.. |image116| image:: media/image108.png
   :width: 3.46439in
   :height: 2.05707in
.. |image117| image:: media/image109.png
   :width: 3.52318in
   :height: 1.25638in
.. |image118| image:: media/image44.png
   :width: 3.30726in
   :height: 2.79557in
.. |image119| image:: media/image110.png
   :width: 3.49148in
   :height: 1.34521in
.. |image120| image:: media/image111.png
   :width: 3.54305in
   :height: 1.38847in
.. |image121| image:: media/image47.png
   :width: 3.48045in
   :height: 2.26032in
.. |image122| image:: media/image112.png
   :width: 3.49669in
   :height: 1.29839in
.. |image123| image:: media/image113.png
   :width: 3.53642in
   :height: 0.98353in
.. |image124| image:: media/image114.png
   :width: 3.48344in
   :height: 1.22381in
.. |image125| image:: media/image115.png
   :width: 3.49669in
   :height: 1.37888in
.. |image126| image:: media/image116.png
   :width: 3.51656in
   :height: 1.51544in
.. |image127| image:: media/image117.png
   :width: 3.44410in
   :height: 2.41152in
.. |image128| image:: media/image118.png
   :width: 2.04616in
   :height: 2.19712in
.. |image129| image:: media/image119.png
   :width: 3.41215in
   :height: 0.68887in
.. |image130| image:: media/image120.png
   :width: 3.41060in
   :height: 1.16475in
.. |image131| image:: media/image121.png
   :width: 3.45033in
   :height: 0.69527in
.. |image132| image:: media/image122.png
   :width: 3.50993in
   :height: 0.94570in
.. |image133| image:: media/image123.png
   :width: 3.50331in
   :height: 2.36969in
.. |image134| image:: media/image124.png
   :width: 3.50993in
   :height: 2.14570in
.. |image135| image:: media/image125.png
   :width: 3.48344in
   :height: 0.93133in
.. |image136| image:: media/image126.png
   :width: 3.50000in
   :height: 0.72642in
.. |image137| image:: media/image127.png
   :width: 3.49786in
   :height: 2.15547in
.. |image138| image:: media/image128.png
   :width: 3.55078in
   :height: 2.62645in
.. |image139| image:: media/image129.png
   :width: 3.25750in
   :height: 0.67793in
.. |image140| image:: media/image130.png
   :width: 2.73529in
   :height: 4.10552in
.. |image141| image:: media/image131.png
   :width: 3.40397in
   :height: 2.02825in
.. |image142| image:: media/image132.png
   :width: 0.71189in
   :height: 0.71189in
.. |image143| image:: media/image133.png
   :width: 3.54135in
   :height: 1.48069in
.. |image144| image:: media/image134.png
   :width: 3.56935in
   :height: 1.12105in
.. |image145| image:: media/image135.png
   :width: 3.54722in
   :height: 0.62774in
.. |image146| image:: media/image136.png
   :width: 3.52941in
   :height: 2.11632in
.. |image147| image:: media/image137.png
   :width: 3.55294in
   :height: 0.63149in
.. |image148| image:: media/image138.png
   :width: 3.38823in
   :height: 2.68118in
.. |image149| image:: media/image139.png
   :width: 3.51765in
   :height: 0.55088in
.. |image150| image:: media/image140.png
   :width: 3.28056in
   :height: 4.24677in
.. |image151| image:: media/image141.png
   :width: 3.48823in
   :height: 0.62854in
.. |image152| image:: media/image142.png
   :width: 3.42353in
   :height: 1.24410in
.. |image153| image:: media/image143.png
   :width: 3.54706in
   :height: 0.63646in
.. |image154| image:: media/image144.png
   :width: 3.52941in
   :height: 2.05905in
.. |image155| image:: media/image7.png
   :width: 3.56471in
   :height: 0.63896in
.. |image156| image:: media/image145.png
   :width: 3.52941in
   :height: 1.66349in
.. |image157| image:: media/image146.png
   :width: 3.28644in
   :height: 1.97062in
.. |image158| image:: media/image147.png
   :width: 3.29412in
   :height: 2.07094in
.. |image159| image:: media/image148.png
   :width: 3.38235in
   :height: 0.53990in
.. |image160| image:: media/image149.png
   :width: 3.40588in
   :height: 0.93308in
.. |image161| image:: media/image150.png
   :width: 3.35706in
   :height: 1.31115in
.. |image162| image:: media/image151.png
   :width: 3.46471in
   :height: 3.53335in
.. |image163| image:: media/image152.png
   :width: 3.52941in
   :height: 0.90966in
.. |image164| image:: media/image153.png
   :width: 3.48235in
   :height: 2.04670in
.. |image165| image:: media/image154.png
   :width: 3.47721in
   :height: 2.51475in
.. |image166| image:: media/image155.png
   :width: 3.49412in
   :height: 1.58554in
.. |image167| image:: media/image156.png
   :width: 3.48235in
   :height: 1.10055in
.. |image168| image:: media/image157.png
   :width: 3.51176in
   :height: 0.54267in
.. |image169| image:: media/image158.png
   :width: 3.40834in
   :height: 5.15560in
.. |image170| image:: media/image159.png
   :width: 3.41765in
   :height: 0.77574in
.. |image171| image:: media/image160.png
   :width: 3.54118in
   :height: 0.99086in
.. |image172| image:: media/image161.png
   :width: 3.49007in
   :height: 2.18623in
.. |image173| image:: media/image162.png
   :width: 3.56471in
   :height: 0.82661in
.. |image174| image:: media/image163.png
   :width: 3.43401in
   :height: 3.73529in
.. |image175| image:: media/image164.png
   :width: 3.46471in
   :height: 1.59050in
.. |image176| image:: media/image165.png
   :width: 3.53529in
   :height: 0.69972in
.. |image177| image:: media/image166.png
   :width: 3.46944in
   :height: 3.86679in
.. |image178| image:: media/image167.png
   :width: 3.44118in
   :height: 0.76485in
.. |image179| image:: media/image168.png
   :width: 3.40000in
   :height: 1.18808in
.. |image180| image:: media/image169.png
   :width: 2.16471in
   :height: 0.97693in
.. |image181| image:: media/image170.png
   :width: 3.42353in
   :height: 0.61301in
.. |image182| image:: media/image171.png
   :width: 2.19412in
   :height: 0.96376in
.. |image183| image:: media/image172.png
   :width: 3.15294in
   :height: 0.90126in
.. |image184| image:: media/image173.png
   :width: 2.08235in
   :height: 1.00346in
.. |image185| image:: media/image174.png
   :width: 2.05882in
   :height: 1.34661in
.. |image186| image:: media/image175.png
   :width: 2.17647in
   :height: 0.25188in
.. |image187| image:: media/image176.png
   :width: 3.49412in
   :height: 0.58411in
.. |image188| image:: media/image177.png
   :width: 3.46471in
   :height: 1.21657in
.. |image189| image:: media/image178.png
   :width: 3.50576in
   :height: 0.90422in
.. |image190| image:: media/image176.png
   :width: 3.49412in
   :height: 0.58411in
.. |image191| image:: media/image179.png
   :width: 3.48823in
   :height: 1.20640in
.. |image192| image:: media/image180.png
   :width: 2.14118in
   :height: 0.60902in
.. |image193| image:: media/image181.png
   :width: 3.35294in
   :height: 2.00607in
.. |image194| image:: media/image182.png
   :width: 3.39735in
   :height: 1.70444in
.. |image195| image:: media/image183.png
   :width: 3.39073in
   :height: 1.05177in
.. |image196| image:: media/image184.png
   :width: 3.35762in
   :height: 0.76338in
.. |image197| image:: media/image185.png
   :width: 3.35605in
   :height: 0.70857in
.. |image198| image:: media/image186.png
   :width: 3.53285in
   :height: 1.08118in
.. |image199| image:: media/image187.png
   :width: 3.50993in
   :height: 1.07947in
.. |image200| image:: media/image188.png
   :width: 3.45695in
   :height: 2.63250in
.. |image201| image:: media/image132.png
   :width: 0.71189in
   :height: 0.71189in
.. |image202| image:: media/image133.png
   :width: 3.54135in
   :height: 1.48069in
.. |image203| image:: media/image189.png
   :width: 3.49669in
   :height: 0.80424in
.. |image204| image:: media/image190.png
   :width: 3.46358in
   :height: 0.81753in
.. |image205| image:: media/image191.png
   :width: 3.45033in
   :height: 2.13855in
.. |image206| image:: media/image192.png
   :width: 3.43046in
   :height: 1.56766in
.. |image207| image:: media/image193.png
   :width: 3.48667in
   :height: 4.16821in
.. |image208| image:: media/image194.png
   :width: 1.72185in
   :height: 1.81920in
.. |image209| image:: media/image195.png
   :width: 2.97260in
   :height: 2.30797in
.. |image210| image:: media/image196.png
   :width: 3.35108in
   :height: 1.01038in
.. |image211| image:: media/image197.png
   :width: 3.36424in
   :height: 1.99506in
.. |image212| image:: media/image198.png
   :width: 3.41722in
   :height: 0.51194in
.. |image213| image:: media/image199.png
   :width: 3.42384in
   :height: 2.08919in
.. |image214| image:: media/image200.png
   :width: 3.68056in
   :height: 0.92708in
.. |image215| image:: media/image201.png
   :width: 3.30464in
   :height: 1.83376in
.. |image216| image:: media/image200.png
   :width: 3.43709in
   :height: 0.86576in
.. |image217| image:: media/image202.png
   :width: 3.47020in
   :height: 1.39463in
.. |image218| image:: media/image203.png
   :width: 3.43046in
   :height: 1.28740in
.. |image219| image:: media/image201.png
   :width: 3.30464in
   :height: 1.83376in
.. |image220| image:: media/image204.png
   :width: 3.25009in
   :height: 0.74813in
.. |image221| image:: media/image205.png
   :width: 2.64746in
   :height: 1.92715in
.. |image222| image:: media/image206.png
   :width: 3.41417in
   :height: 1.62914in
.. |image223| image:: media/image207.png
   :width: 3.30464in
   :height: 1.90671in
.. |image224| image:: media/image208.png
   :width: 3.21192in
   :height: 1.84898in
.. |image225| image:: media/image209.png
   :width: 3.13907in
   :height: 0.44599in
.. |image226| image:: media/image210.png
   :width: 3.17219in
   :height: 2.02481in
.. |image227| image:: media/image211.png
   :width: 3.17219in
   :height: 1.47537in
.. |image228| image:: media/image212.png
   :width: 3.40397in
   :height: 1.00642in
.. |image229| image:: media/image213.png
   :width: 3.35099in
   :height: 2.51577in
.. |image230| image:: media/image214.png
   :width: 3.43046in
   :height: 0.56117in
.. |image231| image:: media/image215.png
   :width: 3.46358in
   :height: 1.45993in
