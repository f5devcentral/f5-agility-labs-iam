Lab 1 - Social Login Lab
======================================

.. toctree::
   :maxdepth: 1
   :glob:

.. NOTE:: The entire module covering Social Login is performed on BIG-IP 1 (OAuth C/RS)

Purpose
-------

This module will teach you how to configure a Big-IP as a client and
resource server enabling you to integrate with social login providers
like Facebook, Google, and LinkedIn to provide access to a web
application. You will inject the identity provided by the social network
into a header that the backend application can use to identify the user.

Task 1: Setup Virtual Server
----------------------------
1. Go to **Local Traffic -> Virtual Servers -> Create**

|image1|

2. Enter the following values *(leave others default)*


**Name**: social.f5agility.com-vs

**Destination Address:** 10.1.20.111

**Service Port:** 443

**HTTP Profile:** http

**SSL Profile (Client):** f5agility-wildcard-self-clientssl

**Source Address Translation:**

Auto Map

|image2|

3. Select webapp-pool from the Default Pool drop down and then click **Finished**

|image3|

4. Test access to https://social.f5agility.com from the jump host’s browser.

You should be able to see the backend application, but it will give you an error indicating you have not logged in because it requires a header to be inserted to identify the user.

|image4|

Task 2: Setup APM Profile
-------------------------

1. Go to **Access -> Profiles / Policies -> Access Profiles (Per Session Policies) -> Create**

|image5|

2. Enter the following values (leave others default) then click **Finished**

**Name**: social-ap

**Profile Type:** All

**Profile Scope:** Profile

**Languages**: English

|image6|

|br|

|image7|

3. Click **Edit** for social-ap, a new browser tab will open

|image8|

4. Click the **+** between **Start** and **Deny**, select **OAuth Logon Page** from the **Logon** tab, click **Add Item**

|image9|

|br|

|image10|

5. Set the **Type** on **Lines 2, 3, and 4** to none

|image11|

6. Change the **Logon Page, Input Field #1** to “Choose a Social Logon Provider”

|image12|

7. Click the **Values** column for **Line 1**, a new window will open.

|image13|

*Alternatively*, you may click **[Edit]** on the **Input Field #1 Values** line. Either item will bring you to the next menu.

|image14|

8. Click the **X** to remove **F5, Ping, Custom, and ROPC**

|image15|

9. Click ***Finished***

|image16|

|br|

|image17|

.. NOTE:: The resulting screen is shown

10. Go to the **Branch Rules** tab and click the **X** to remove **F5**, **Ping**, **Custom**, **F5 ROPC**, and **Ping ROPC**

|image18|

11. Click **Save**

|image19|

12. Click **Apply Access Policy** in the top left and then close the browser tab

|image20|

Task 3: Add the Access Policy to the Virtual Server
---------------------------------------------------

1. Go to **Local Traffic -> Virtual Servers -> social.f5agility.com-vs**

|image21|

2. Modify the **Access Profile** setting from none to social-ap and click **Update**

|image22|

3. Test access to https://social.f5agility.com from the jump host again, you should now see a logon page requiring you to select your authentication provider. Any attempt to authenticate will fail since we have only deny endings.

|image23|

Task 4: Google (Built-In Provider)
----------------------------------

Setup a Google Project
~~~~~~~~~~~~~~~~~~~~~~

1. Login at https://console.developers.google.com

|image24|

.. NOTE:: This portion of the exercise requires a Google Account. You may use an existing one or create one for the purposes of this lab

2. Click **Create Project** and give it a name like “OAuth Lab” and click **Create**

|image25|

|image26|

.. NOTE:: You may have existing projects so the menus may be slightly different.

.. NOTE:: You may have to click on Google+ API under Social APIs

3. Go to the **Credentials** section on the left side.

|image27|

.. NOTE:: You may have navigate to your OAuth Lab project depending on your browser or prior work in Google Developer

4. Click **OAuth Consent Screen** tab, fill out the product name with “OAuth Lab”, then click save

|image28|

5. Go to the **Credentials** tab (if you are not taken there), click **Create Credentials** and select **OAuth Client ID**

|image29|

6. Under the **Create Client ID** screen, select and enter the following values and click **Create**

 **Application Type:** Web Application

 **Name:** OAuth Lab

 **Authorized Javascript Origins:** https://social.f5agility.com

 **Authorized Redirect URIs:** https://social.f5agility.com/oauth/client/redirect

|image30|

7. Copy the **Client ID** and **Client Secret** to notepad, or you can get it by clicking on the **OAuth Lab Credentials** section later if needed. You will need these when you setup Access Policy Manager (APM).

|image31|

8. Click **Library** in the left-hand navigation section, then select **Google+ API** under **Social APIs** or search for it

|image32|

9. Click **Enable** and wait for it to complete, you will now be able to view reporting on usage here

|image33|

|br|

|image34|

10. For Reference: This is a screenshot of the completed Google project:

|image35|

Configure Access Policy Manager (APM) to authenticate with Google
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

1. Configure the **OAuth Server** Object: Go to **Access -> Federation -> OAuth Client / Resource Server -> OAuth Server** and click **Create**

|image36|

2. Enter the values as shown below for the **OAuth Server** and click **Finished**

**Name**: Google

**Mode:** Client + Resource Server

**Type:** Google

**OAuth Provider:** Google

**DNS Resolver:** oauth-dns *(configured for you)*

**Client ID:** <Client ID from Google>

**Client Secret:** <Client Secret from Google>

**Client’s ServerSSL Profile Name:** apm-default-serverssl

**Resource Server ID:** <Client ID from Google>

**Resource Server Secret:** <Client Secret from Google>

**Resource Server’s ServerSSL Profile Name:** apm-default-serverssl

|image37|

3. Configure the VPE for Google: Go to **Access -> Profiles / Policies -> Access Profiles (Per Session Policies)** and click **Edit** on **social-ap**, a new browser tab will open

|image38|

4. Click the + on the **Google** provider’s branch after the **OAuth Logon Page**

|image39|

5. Select **OAuth Client** from the **Authentication** tab and click **Add Item**

|image40|

6. Enter the following in the **OAuth Client** input screen and click **Save**

**Name:** Google OAuth Client

**Server:** /Common/Google

**Grant Type:** Authorization Code

**Authentication Redirect Request:** /Common/GoogleAuthRedirectRequest

**Token Request:** /Common/GoogleTokenRequest

**Refresh Token Request:** /Common/GoogleTokenRefreshRequest

**Validate Token Request:** /Common/GoogleValidationScopesRequest

**Redirection URI:** https://%{session.server.network.name}/oauth/client/redirect

**Scope:** profile

|image41|

7. Click **+** on the **Successful** branch after the **Google OAuth Client**

|image42|

8. Select **OAuth Scope** from the **Authentication** tab, and click **Add Item**

|image43|

9. Enter the following on the **OAuth Scope** input screen and click **Save**

**Name**: Google OAuth Scope

**Server:** /Common/Google

**Scopes Request:** /Common/GoogleValidationScopesRequest

- Click **Add New Entry**

**Scope Name:** https://www.googleapis.com/auth/userinfo.profile

**Request:** /Common/GoogleScopeUserInfoProfileRequest

|image44|

10. Click the **+** on the **Successful** branch after the **Google OAuth Scope** object

|image45|

11. Select **Variable Assign** from the **Assignment** tab, and click **Add Item**

|image46|

12. Name it Google Variable Assign and click **Add New Entry** then **change**

|image47|

13. Enter the following values and click **Finished**

Left Side **Type:** Custom Variable

Left Side **Security**: Unsecure

Left Side **Value**: session.logon.last.username

Right Side **Type**: Session Variable

Right Side **Session Variable:** session.oauth.scope.last.scope_data.userinfo.profile.displayName

|image48|

14. Review the **Google Variable Assign** object and click **Save**

|image49|

15. Click **Deny** on the **Fallback** branch after the **Google Variable Assign** object, select **Allow** in the pop up window and click **Save**

|image50|

16. Click **Apply Access Policy** in the top left and then close the tab

|image51|

Test Configuration
~~~~~~~~~~~~~~~~~~

1. Test by opening Chrome in the jump host and browsing to *https://social.f5agility.com*, select the provider and attempt logon.

|image52|

.. NOTE:: You are able to login and reach the app now, but SSO to the app has not been setup so you get an application error.

.. NOTE:: You may also be prompted for additional security measures as you are logging in from a new location.


Task 5: Facebook (Built-In Provider)
------------------------------------

Setup a Facebook Project
~~~~~~~~~~~~~~~~~~~~~~~~

1. Go to https://developers.facebook.com and *Login*

.. NOTE:: This portion of the exercise requires a Facebook Account. You may use an existing one or create one for the purposes of this lab

|image53|

2. If prompted click, **Get Started** and accept the ***Developer Policy.*** Otherwise, click **Create App**

|image54|

3. Click **Create App** and name (**Display Name**) your app (Or click the top left project drop down and create a new app, then name it). Then click **Create App ID**.

.. Note:: For example the **Display Name** given here was “OAuth Lab”. You may also be prompted with a security captcha

|image55|

4. Click **Get Started** in the **Facebook Login** section (*Or click + Add Product and then Get Started for Facebook*)

|image56|

5. From the *“Choose a Platform”* screen click on **WWW (Web)**

|image57|

6. In the *“Tell Us about Your Website”* prompt, enter https://social.f5agility.com for the **Site URL** and click **Save** then click **Continue**

|image58|

7.  Click **Next** on the *“Set Up the Facebook SDK for Javascript”* screen

|image59|

8. Click **Next** on the *“Check Login Status”* screen

.. Note:: Additional screen content removed.

|image60|

9. Click **Next** on the *“Add the Facebook Login Button”* screen

|image61|

10. Click **Facebook Login** on the left side bar and then click **Settings**

|image62|

11. For the **Client OAuth Settings** screen in the **Valid OAuth redirect URIs** enter https://social.f5agility.com/oauth/client/redirect and then click enter to create it, then **Save Changes**

|image63|

12. Click **Dashboard** in the left navigation bar

|image64|

13. Here you can retrieve your **App ID** and **App Secret** for use in Access Policy Manager (APM).

|image65|

 *Screenshot of completed Facebook project*

.. Note:: If you want Facebook Auth to work for users other than the developer you will need to publish the project



.. |br| raw:: html

   <br />

.. |image1| image:: media/image3.png
.. |image2| image:: media/image4.png
.. |image3| image:: media/image5.png
.. |image4| image:: media/image6.png
.. |image5| image:: media/image7.png
.. |image6| image:: media/image8.png
.. |image7| image:: media/image9.png
.. |image8| image:: media/image10.png
.. |image9| image:: media/image11.png
.. |image10| image:: media/image12.png
.. |image11| image:: media/image13.png
.. |image12| image:: media/image14.png
.. |image13| image:: media/image15.png
.. |image14| image:: media/image16.png
.. |image15| image:: media/image17.png
.. |image16| image:: media/image18.png
.. |image17| image:: media/image19.png
.. |image18| image:: media/image20.png
.. |image19| image:: media/image21.png
.. |image20| image:: media/image22.png
.. |image21| image:: media/image23.png
.. |image22| image:: media/image24.png
.. |image23| image:: media/image25.png
.. |image24| image:: media/image26.png
.. |image25| image:: media/image27.png
.. |image26| image:: media/image28.png
.. |image27| image:: media/image29.png
.. |image28| image:: media/image30.png
.. |image29| image:: media/image31.png
.. |image30| image:: media/image32.png
.. |image31| image:: media/image33.png
.. |image32| image:: media/image34.png
.. |image33| image:: media/image35.png
.. |image34| image:: media/image36.png
.. |image35| image:: media/image37.png
.. |image36| image:: media/image38.png
.. |image37| image:: media/image39.png
.. |image38| image:: media/image10.png
.. |image39| image:: media/image40.png
.. |image40| image:: media/image41.png
.. |image41| image:: media/image42.png
.. |image42| image:: media/image43.png
.. |image43| image:: media/image44.png
.. |image44| image:: media/image45.png
.. |image45| image:: media/image46.png
.. |image46| image:: media/image47.png
.. |image47| image:: media/image48.png
.. |image48| image:: media/image49.png
.. |image49| image:: media/image50.png
.. |image50| image:: media/image51.png
.. |image51| image:: media/image52.png
.. |image52| image:: media/image53.png
.. |image53| image:: media/image54.png
.. |image54| image:: media/image55.png
.. |image55| image:: media/image56.png
.. |image56| image:: media/image57.png
.. |image57| image:: media/image58.png
.. |image58| image:: media/image59.png
.. |image59| image:: media/image60.png
.. |image60| image:: media/image61.png
.. |image61| image:: media/image62.png
.. |image62| image:: media/image63.png
.. |image63| image:: media/image64.png
.. |image64| image:: media/image65.png
.. |image65| image:: media/image66.png
.. |image66| image:: media/image67.png
.. |image67| image:: media/image68.png
.. |image68| image:: media/image69.png
.. |image69| image:: media/image70.png
.. |image70| image:: media/image41.png
.. |image71| image:: media/image71.png
.. |image72| image:: media/image72.png
.. |image73| image:: media/image44.png
.. |image74| image:: media/image73.png
.. |image75| image:: media/image74.png
.. |image76| image:: media/image47.png
.. |image77| image:: media/image75.png
.. |image78| image:: media/image49.png
.. |image79| image:: media/image76.png
.. |image80| image:: media/image77.png
.. |image81| image:: media/image78.png
.. |image82| image:: media/image79.png
.. |image83| image:: media/image80.png
.. |image84| image:: media/image81.png
.. |image85| image:: media/image82.png
.. |image86| image:: media/image83.png
.. |image87| image:: media/image84.png
.. |image88| image:: media/image85.png
.. |image89| image:: media/image86.png
.. |image90| image:: media/image87.png
.. |image91| image:: media/image88.png
.. |image92| image:: media/image89.png
.. |image93| image:: media/image87.png
.. |image94| image:: media/image90.png
.. |image95| image:: media/image91.png
.. |image96| image:: media/image87.png
.. |image97| image:: media/image92.png
.. |image98| image:: media/image93.png
.. |image99| image:: media/image87.png
.. |image100| image:: media/image94.png
.. |image101| image:: media/image93.png
.. |image102| image:: media/image95.png
.. |image103| image:: media/image96.png
.. |image104| image:: media/image69.png
.. |image105| image:: media/image97.png
.. |image106| image:: media/image98.png
.. |image107| image:: media/image99.png
.. |image108| image:: media/image100.png
.. |image109| image:: media/image101.png
.. |image110| image:: media/image102.png
.. |image111| image:: media/image103.png
.. |image112| image:: media/image104.png
.. |image113| image:: media/image105.png
.. |image114| image:: media/image106.png
.. |image115| image:: media/image107.png
.. |image116| image:: media/image108.png
.. |image117| image:: media/image109.png
.. |image118| image:: media/image44.png
.. |image119| image:: media/image110.png
.. |image120| image:: media/image111.png
.. |image121| image:: media/image47.png
.. |image122| image:: media/image112.png
.. |image123| image:: media/image113.png
.. |image124| image:: media/image114.png
.. |image125| image:: media/image115.png
.. |image126| image:: media/image116.png
.. |image127| image:: media/image117.png
.. |image128| image:: media/image118.png
.. |image129| image:: media/image119.png
.. |image130| image:: media/image120.png
.. |image131| image:: media/image121.png
.. |image132| image:: media/image122.png
.. |image133| image:: media/image123.png
.. |image134| image:: media/image124.png
.. |image135| image:: media/image125.png
.. |image136| image:: media/image126.png
.. |image137| image:: media/image127.png
.. |image138| image:: media/image128.png
