Lab 1: Social Login Lab
=======================

.. toctree::
   :maxdepth: 1
   :glob:

.. NOTE:: The entire module covering Social Login is performed on
   BIG-IP 1 (OAuth C/RS)

Purpose
-------

This module will teach you how to configure a Big-IP as a client and
resource server enabling you to integrate with social login providers
like Facebook, Google, and LinkedIn to provide access to a web
application. You will inject the identity provided by the social network
into a header that the backend application can use to identify the user.

Task 1: Setup Virtual Server
----------------------------
#. Go to **Local Traffic -> Virtual Servers -> Create**

   |image1|

#. Enter the following values *(leave others default)*

   - **Name:** ``social.f5agility.com-vs``

   - **Destination Address:** ``10.1.20.111``

   - **Service Port:** ``443``

   - **HTTP Profile:** ``http``

   - **SSL Profile (Client):** ``f5agility-wildcard-self-clientssl``

   - **Source Address Translation:** ``Auto Map``

   |image2|

#. Select webapp-pool from the Default Pool drop down and then
   click **Finished**

   |image3|

#. Test access to ``https://social.f5agility.com`` from the jump host’s browser.

   You should be able to see the backend application, but it will give you
   an error indicating you have not logged in because it requires a header
   to be inserted to identify the user.

   |image4|

Task 2: Setup APM Profile
-------------------------

#. Go to **Access -> Profiles / Policies -> Access Profiles (Per Session
   Policies) -> Create**

   |image5|

#. Enter the following values (leave others default) then click **Finished**

   - **Name:** ``social-ap``

   - **Profile Type:** ``All``

   - **Profile Scope:** ``Profile``

   - **Languages:** English

   |image6|

   |br|

   |image7|

#. Click **Edit** for social-ap, a new browser tab will open

   |image8|

#. Click the **+** between **Start** and **Deny**, select **OAuth Logon Page**
   from the **Logon** tab, click **Add Item**

   |image9|

   |br|

   |image10|

#. Set the **Type** on **Lines 2, 3, and 4** to none

   |image11|

#. Change the **Logon Page, Input Field #1** to "Choose a Social Logon Provider"

   |image12|

#. Click the **Values** column for **Line 1**, a new window will open.

   |image13|

   *Alternatively*, you may click **[Edit]** on the **Input Field #1 Values**
   line. Either item will bring you to the next menu.

   |image14|

#. Click the **X** to remove **F5, Ping, Custom, and ROPC**

   |image15|

#. Click **Finished**

   |image16|

   |br|

   |image17|

   .. NOTE:: The resulting screen is shown

#. Go to the **Branch Rules** tab and click the **X** to remove **F5**,
    **Ping**, **Custom**, **F5 ROPC**, and **Ping ROPC**

   |image18|

#. Click **Save**

   |image19|

#. Click **Apply Access Policy** in the top left and then close the browser tab

   |image20|

Task 3: Add the Access Policy to the Virtual Server
---------------------------------------------------

#. Go to **Local Traffic -> Virtual Servers -> social.f5agility.com-vs**

   |image21|

#. Modify the **Access Profile** setting from none to social-ap and click
   **Update**

   |image22|

#. Test access to https://social.f5agility.com from the jump host again, you
   should now see a logon page requiring you to select your authentication
   provider. Any attempt to authenticate will fail since we have only deny
   endings.

   |image23|

Task 4: Google (Built-In Provider)
----------------------------------

Setup a Google Project
~~~~~~~~~~~~~~~~~~~~~~

#. Login at https://console.developers.google.com

   |image24|

   .. NOTE:: This portion of the exercise requires a Google Account. You may use
      an existing one or create one for the purposes of this lab

#. Click **Create Project** and give it a name like "OAuth Lab" and click
   **Create**

   |image25|

   |image26|

   .. NOTE:: You may have existing projects so the menus may be slightly different.

   .. NOTE:: You may have to click on Google+ API under Social APIs

#. Go to the **Credentials** section on the left side.

   |image27|

   .. NOTE:: You may have navigate to your OAuth Lab project depending on your
      browser or prior work in Google Developer

#. Click **OAuth Consent Screen** tab, fill out the product name with
   "OAuth Lab", then click save

   |image28|

#. Go to the **Credentials** tab (if you are not taken there), click
   **Create Credentials** and select **OAuth Client ID**

   |image29|

#. Under the **Create Client ID** screen, select and enter the following
   values and click **Create**

   - **Application Type:** ``Web Application``

   - **Name:** ``OAuth Lab``

   - **Authorized Javascript Origins:** ``https://social.f5agility.com``

   - **Authorized Redirect URIs:** ``https://social.f5agility.com/oauth/client/redirect``

   |image30|

#. Copy the **Client ID** and **Client Secret** to notepad, or you can get it
   by clicking on the **OAuth Lab Credentials** section later if needed. You
   will need these when you setup Access Policy Manager (APM).

   |image31|

#. Click **Library** in the left-hand navigation section, then select
   **Google+ API** under **Social APIs** or search for it

   |image32|

#. Click **Enable** and wait for it to complete, you will now be able to view
   reporting on usage here

   |image33|

   |br|

   |image34|

#. For Reference: This is a screenshot of the completed Google project:

   |image35|

Configure Access Policy Manager (APM) to authenticate with Google
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. Configure the **OAuth Server** Object: Go to **Access -> Federation ->
   OAuth Client / Resource Server -> OAuth Server** and click **Create**

   |image36|

#. Enter the values as shown below for the **OAuth Server** and click
   **Finished**

   - **Name:** Google

   - **Mode:** ``Client + Resource Server``

   - **Type:** ``Google``

   - **OAuth Provider:** ``Google``

   - **DNS Resolver:** ``oauth-dns *(configured for you)*``

   - **Client ID:** ``<Client ID from Google>``

   - **Client Secret:** ``<Client Secret from Google>``

   - **Client’s ServerSSL Profile Name:** ``apm-default-serverssl``

   - **Resource Server ID:** ``<Client ID from Google>``

   - **Resource Server Secret:** ``<Client Secret from Google>``

   - **Resource Server’s ServerSSL Profile Name:** ``apm-default-serverssl``

   |image37|

#. Configure the VPE for Google: Go to **Access -> Profiles / Policies ->
   Access Profiles (Per Session Policies)** and click **Edit** on ``social-ap``,
   a new browser tab will open

   |image38|

#. Click the + on the **Google** provider’s branch after the
   **OAuth Logon Page**

   |image39|

#. Select **OAuth Client** from the **Authentication** tab and click
   **Add Item**

   |image40|

#. Enter the following in the **OAuth Client** input screen and click **Save**

   - **Name:** ``Google OAuth Client``

   - **Server:** ``/Common/Google``

   - **Grant Type:** ``Authorization Code``

   - **Authentication Redirect Request:** ``/Common/GoogleAuthRedirectRequest``

   - **Token Request:** ``/Common/GoogleTokenRequest``

   - **Refresh Token Request:** ``/Common/GoogleTokenRefreshRequest``

   - **Validate Token Request:** ``/Common/GoogleValidationScopesRequest``

   - **Redirection URI:** ``https://%{session.server.network.name}/oauth/client/redirect``

   - **Scope:** ``profile``

   |image41|

#. Click **+** on the **Successful** branch after the **Google OAuth Client**

   |image42|

#. Select **OAuth Scope** from the **Authentication** tab, and click **Add Item**

   |image43|

#. Enter the following on the **OAuth Scope** input screen and click **Save**

   - **Name:** ``Google OAuth Scope``

   - **Server:** ``/Common/Google``

   - **Scopes Request:** ``/Common/GoogleValidationScopesRequest``

- Click **Add New Entry**

   - **Scope Name:** ``https://www.googleapis.com/auth/userinfo.profile``

   - **Request:** ``/Common/GoogleScopeUserInfoProfileRequest``

   |image44|

#. Click the **+** on the **Successful** branch after the
    **Google OAuth Scope** object

   |image45|

#. Select **Variable Assign** from the **Assignment** tab, and click
    **Add Item**

   |image46|

#. Name it Google Variable Assign and click **Add New Entry** then **change**

   |image47|

#. Enter the following values and click **Finished**

   Left Side:

   - **Type:** ``Custom Variable``

   - **Security:** ``Unsecure``

   - **Value:** ``session.logon.last.username``

   Right Side:

   - **Type:** ``Session Variable``

   - **Session Variable:** ``session.oauth.scope.last.scope_data.userinfo.profile.displayName``

   |image48|

#. Review the **Google Variable Assign** object and click **Save**

   |image49|

#. Click **Deny** on the **Fallback** branch after the
   **Google Variable Assign** object, select **Allow** in the pop up window
   and click **Save**

   |image50|

#. Click **Apply Access Policy** in the top left and then close the tab

   |image51|

Test Configuration
~~~~~~~~~~~~~~~~~~

#. Test by opening Chrome in the jump host and browsing to
   ``https://social.f5agility.com``, select the provider and attempt logon.

   |image52|

   .. NOTE:: You are able to login and reach the app now, but SSO to the app has
      not been setup so you get an application error.

   .. NOTE:: You may also be prompted for additional security measures as you
      are logging in from a new location.

Task 5: Facebook (Built-In Provider)
------------------------------------

Setup a Facebook Project
~~~~~~~~~~~~~~~~~~~~~~~~

#. Go to https://developers.facebook.com and *Login*

   .. NOTE:: This portion of the exercise requires a Facebook Account. You may use
      an existing one or create one for the purposes of this lab

   |image53|

#. If prompted click, **Get Started** and accept the **Developer Policy.**
   Otherwise, click **Create App**

   |image54|

#. Click **Create App** and name (**Display Name**) your app (Or click the top
   left project drop down and create a new app, then name it). Then click
   **Create App ID**.

   .. NOTE:: For example the **Display Name** given here was "OAuth Lab". You
      may also be prompted with a security captcha

   |image55|

#. Click **Get Started** in the **Facebook Login** section (*Or click + Add
   Product and then Get Started for Facebook*)

   |image56|

#. From the *"Choose a Platform"* screen click on **WWW (Web)**

   |image57|

#. In the *"Tell Us about Your Website"* prompt, enter
   ``https://social.f5agility.com`` for the **Site URL** and click **Save**
   then click **Continue**

   |image58|

#. Click **Next** on the *"Set Up the Facebook SDK for Javascript"* screen

   |image59|

#. Click **Next** on the *"Check Login Status"* screen

   .. NOTE:: Additional screen content removed.

   |image60|

#. Click **Next** on the *"Add the Facebook Login Button"* screen

   |image61|

#. Click **Facebook Login** on the left side bar and then click **Settings**

   |image62|

#. For the **Client OAuth Settings** screen in the **Valid OAuth redirect URIs**
   enter ``https://social.f5agility.com/oauth/client/redirect`` and then
   click enter to create it, then **Save Changes**

   |image63|

#. Click **Dashboard** in the left navigation bar

   |image64|

#. Here you can retrieve your **App ID** and **App Secret** for use in Access
   Policy Manager (APM).

   |image65|

   *Screenshot of completed Facebook project*

   .. NOTE:: If you want Facebook Auth to work for users other than the developer
      you will need to publish the project

Configure Access Policy Manager (APM) to authenticate with Facebook
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. Configure the **OAuth** **Server** Object: Go to **Access -> Federation ->
   OAuth Client / Resource Server -> OAuth Server** and click **Create**

   |image66|

#. Enter the values as shown below for the **OAuth Server** and click
   **Finished**

   - **Name:** ``Facebook``

   - **Mode:** ``Client + Resource Server``

   - **Type:** ``Facebook``

   - **OAuth Provider:** ``Facebook``

   - **DNS Resolver:** ``oauth-dns`` *(configured for you)*

   - **Client ID:** ``<App ID from Facebook>``

   - **Client Secret:** ``<App Secret from Facebook>``

   - **Client’s ServerSSL Profile Name:** ``apm-default-serverssl``

   - **Resource Server ID:** `` App ID from Facebook>``

   - **Resource Server Secret:** ``<App Secret from Facebook>``

   - **Resource Server’s ServerSSL Profile Name:** ``apm-default-serverssl``

   |image67|

#. Configure the VPE for Facebook: Go to **Access -> Profiles / Policies ->
   Access Profiles (Per Session Policies)** and click **Edit** on
   ``social-ap``, a new browser tab will open

   |image68|

#. Click the + on the **Facebook** provider’s branch after the
   **OAuth Logon Page**

   |image69|

#. Select **OAuth Client** from the **Authentication** tab and click
   **Add Item**

   |image70|

#. Enter the following in the **OAuth Client** input screen and click **Save**

   - **Name:** ``Facebook OAuth Client``

   - **Server:** ``/Common/Facebook``

   - **Grant Type:** ``Authorization Code``

   - **Authentication Redirect Request:** ``/Common/FacebookAuthRedirectRequest``

   - **Token Request:** ``/Common/FacebookTokenRequest``

   - **Refresh Token Request:** ``None``

   - **Validate Token Request:** `` /Common/FacebookValidationScopesRequest``

   - **Redirection URI:** ``https://%{session.server.network.name}/oauth/client/redirect``

   - **Scope:** ``public_profile`` *(Note underscore)*

   |image71|

#. Click **+** on the **Successful** branch after the **Facebook OAuth Client**

   |image72|

#. Select **OAuth Scope** from the **Authentication** tab, and click **Add Item**

   |image73|

#. Enter the following on the **OAuth Scope** input screen and click **Save**

   - **Name:** ``Facebook OAuth Scope``

   - **Server:** ``/Common/Facebook``

   - **Scopes Request:** ``/Common/FacebookValidationScopesRequest``

   - Click **Add New Entry**

   - **Scope Name:** ``public_profile``

   - **Request:** ``/Common/FacebookScopePublicProfile``

   |image74|

#. Click the **+** on the **Successful** branch after the **Facebook OAuth Scope** object

   |image75|

#. Select **Variable Assign** from the **Assignment** tab, and click **Add Item**

   |image76|

#. Name it Facebook Variable Assign and click **Add New Entry** then **change**

   |image77|

#. Enter the following values and click **Finished**

   Left Side:

   - **Type:** ``Custom Variable``

   - **Security:** ``Unsecure``

   - **Value:** ``session.logon.last.username``

   Right Side:

   - **Type:** ``Session Variable``

   - **Session Variable:** ``session.oauth.scope.last.scope_data.public_profile.name``

   |image78|

#. Review the **Facebook Variable Assign** object and click **Save**

   |image79|

#. Click **Deny** on the **Fallback** branch after the
   **Facebook Variable Assign** object, select **Allow** in the pop up
   window and click **Save**

   |image80|

#. Click **Apply Access Policy** in the top left and then close the tab

   |image81|

Test Configuration
------------------

#. Test by opening Chrome in the jump host and browsing to
   ``https://social.f5agility.com``, select the provider and attempt logon.

   |image82|

   .. NOTE:: You are able to login and reach the app now, but SSO to the app has
      not been setup so you get an application error.

   .. NOTE:: You may also be prompted for additional security measures as you
      are logging in from a new location

   .. NOTE:: You may need to start a Chrome New Incognito Window so no session
      data carries over.

#. You should be prompted to authorize your request. Click **Continue as
   <Account>** (Where <Account> is your Facebook Profile name)

   |image83|

Task 6: LinkedIn (Custom Provider)
----------------------------------

#. Login at ``https://www.linkedin.com/secure/developer``

   |image84|

   .. NOTE:: This portion of the exercise requires a LinkedIn Account. You
      may use an existing one or create one for the purposes of this lab*

#. Click **Create Application**

   |image85|

#. In the **Create a New Application** screen fill in the required
   values and click **Submit**

   |image86|

   .. NOTE:: Generic values have been shown. You may use the values you
      deem appropriate

   .. NOTE:: An Application logo has been provided on your desktop ‘OAuth2.png’

#. In the *"Authentication Keys"* screen, check the boxes for
   ``r_basicprofile`` and ``r_emailaddress``. In the
   **Authorized Redirect URLs**, enter
   ``https://social.f5agility.com/oauth/client/redirect``

#. Click **Add**. Finally, click **Update** at the bottom of the screen.

   |image87|

Configure Access Policy Manager (APM) to authenticate with LinkedIn
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. Configure the **OAuth** **Server** Object: Go to **Access ->
   Federation -> OAuth Client / Resource Server -> Provider** and
   click **Create**

   |image88|

   .. NOTE:: You are creating a "Provider"

#. Enter the values as shown below for the **OAuth Provider** and
   click **Finished**

   - **Name:** ``LinkedIn``

   - **Type:** ``Custom``

   - **Authentication URI:** ``https://www.linkedin.com/oauth/v2/authorization``

   - **Token URI:** ``https://www.linkedin.com/oauth/v2/accessToken``

   - **Token Validation Scope URI:** ``https://www.linkedin.com/v1/people/~``

   |image89|

#. Configure the **OAuth** **Redirect** **Request** Profile Object: Go to
   **Access -> Federation -> OAuth Client / Resource Server -> Request**
   and click **Create**

   |image90|

#. Enter the values as shown for the **OAuth** **Request** and click
   **Finished**

   - **Name:** ``LinkedInAuthRedirectRequest``

   - **HTTP Method:** ``GET``

   - **Type:** ``auth-redirect-request``

   |image91|

#. Add the following request parameters and click **Add** after entering
   the values for each:

   - **Parameter Type:** ``custom``

   - **Parameter Name:** ``response_type``

   - **Parameter Value:** ``code``

   - **Parameter Type:** ``client-id``

   - **Parameter Name:** ``client_id``

   - **Parameter Type:** ``redirect-uri``

   - **Parameter Name:** ``redirect_uri``

   - **Parameter Type:** ``scope``

   - **Parameter Name:** ``scope``

   .. NOTE:: LinkedIn requires a state parameter, but we already insert it by
      default.

   |image92|

#. Configure the **OAuth** **Token** **Request** Profile Object: Go to
   **Access -> Federation -> OAuth Client / Resource Server -> Request**
   and click **Create**

   |image93|

#. Enter the values as shown for the **OAuth** **Request** and click
   **Finished**

   - **Name:** ``LinkedInTokenRequest``

   - **HTTP Method:** ``POST``

   - **Type:** ``token-request``

   |image94|

#. Add the following request parameters and click **Add** after entering the
   values for each:

   - **Parameter Type:** ``grant-type``

   - **Parameter Name:** ``grant_type``

   - **Parameter Type:** ``redirect-uri``

   - **Parameter Name:** ``redirect_uri``

   - **Parameter Type:** ``client-id``

   - **Parameter Name:** ``client_id``

   - **Parameter Type:** ``client-secret``

   - **Parameter Name:** ``client_secret``

   |image95|

#. Configure the **OAuth** **Validation Scopes Request** Profile Object:
   Go to **Access -> Federation -> OAuth Client / Resource Server -> Request**
   and click **Create**

   |image96|

#. Enter the values as shown for the **OAuth** **Request** and click
   **Finished**

   - **Name:** ``LinkedInValidationScopesRequest``

   - **HTTP Method:** ``GET``

   - **Type:** ``validation-scopes-request``

   |image97|

#. Add the following request parameters and click **Add** after entering the
   values for each:

   - **Parameter Type:** ``custom``

   - **Parameter Name:** ``oauth2_access_token``

   - **Parameter Value:** ``%{session.oauth.client.last.access_token}``

   - **Parameter Type:** ``custom``

   - **Parameter Name:** ``format``

   - **Parameter Value:** ``json``

   |image98|

#. Configure the **OAuth** **Scope Data Request** Profile Object: Go to
   **Access -> Federation -> OAuth Client / Resource Server -> Request**
   and click **Create**

   |image99|

#. Enter the values as shown for the **OAuth** **Request** and click
   **Finished**

   - **Name:** ``LinkedInScopeBasicProfile``

   - **HTTP Method:** ``GET``

   - **URI:** ``https://api.linkedin.com/v1/people/~``

   - **Type:** ``scope-data-request``

   |image100|

#. Add the following request parameters and click **Add** after entering the
   values for each:

   - **Parameter Type:** ``custom``

   - **Parameter Name:** ``  oauth2_access_token``

   - **Parameter Value:** ``%{session.oauth.client.last.access_token}``

   - **Parameter Type:** ``custom``

   - **Parameter Name:** ``format``

   - **Parameter Value:** ``json``

   |image101|

#. Configure the **OAuth** **Server** Object: Go to **Access -> Federation
   -> OAuth Client / Resource Server -> OAuth Server** and click **Create**

   |image102|

#. Enter the values as shown below for the **OAuth Server** and click
   **Finished**

   - **Name:** ``LinkedIn``

   - **Mode:** ``Client + Resource Server``

   - **Type:** ``Custom``

   - **OAuth Provider:** ``LinkedIn``

   - **DNS Resolver:** ``oauth-dns *(configured for you)*``

   - **Client ID:** ``<App ID from LinkedIn>``

   - **Client Secret:** ``<App Secret from LinkedIn >``

   - **Client’s ServerSSL Profile Name:** ``apm-default-serverssl``

   - **Resource Server ID:** ``<App ID from LinkedIn >``

   - **Resource Server Secret:** ``<App Secret from LinkedIn >``

   - **Resource Server’s ServerSSL Profile Name:** ``apm-default-serverssl``

   |image103|

#. Configure the VPE for LinkedIn: Go to **Access -> Profiles / Policies ->
   Access Profiles (Per Session Policies)** and click **Edit** on ``social-ap``,
   a new browser tab will open

   |image104|

#. Click on the link **OAuth Logon Page** as shown

   |image105|

#. Click on the **Values** area of **Line #1** as shown. A pop-up window will
   appear

   |image106|

#. Click **Add Option**. In the new **Line 3**, type LinkedIn in both the
   **Value** and **Text (Optional)** fields and click **Finished**

   |image107|

#. Click on the **Branch Rules** tab of the **OAuth Logon Page** screen

   |image108|

#. Click **Add Branch Rule**. In the resulting new line enter LinkedIn for
   the **Name** field and click the **Change** link on the **Expression** line

   |image109|

#. Click **Add Expression** on the **Simple** tab

   |image110|

#. Select OAuth Logon Page in the **Agent Sel:** drop down. Select OAuth
   provider type from the **Condition** drop down. In the **OAuth provider**
   field enter LinkedIn and then click **Add Expression**

   |image111|

#. Click **Finished** on the **Simple** Expression tab

   |image112|

#. Click **Save** on the completed **Branch Rules** tab

   |image113|

#. Click the + on the **LinkedIn** provider’s branch after the
   **OAuth Logon Page**

   |image114|

   .. NOTE:: If not still in the VPE: Go to
      **Access -> Profiles / Policies -> Access Profiles (Per Session Policies)**.
      Click **Edit** on **social-ap**, a new browser tab will open*

#. Select **OAuth Client** from the **Authentication** tab and click
   **Add Item**

   |image115|

#. Enter the following in the **OAuth Client** input screen and click **Save**

   - **Name:** ``LinkedIn OAuth Client``

   - **Server:** ``/Common/LinkedIn``

   - **Grant Type:** ``Authorization Code``

   - **Authentication Redirect Request:** ``/Common/LinkedInAuthRedirectRequest``

   - **Token Request:** ``/Common/LinkedInTokenRequest``

   - **Refresh Token Request:** ``None``

   - **Validate Token Request:** ``/Common/LinkedInValidationScopesRequest``

   - **Redirection URI:** ``https://%{session.server.network.name}/oauth/client/redirect``

   - **Scope:** ``r_basicprofile *(Note underscore)*``

   |image116|

#. Click **+** on the **Successful** branch after the **LinkedIn OAuth Client**

   |image117|

#. Select **OAuth Scope** from the **Authentication** tab, and click
   **Add Item**

   |image118|

#. Enter the following on the **OAuth Scope** input screen and click **Save**

   - **Name:** ``LinkedIn OAuth Scope``

   - **Server:** ``/Common/LinkedIn``

   - **Scopes Request:** ``/Common/LinkedInValidationScopesRequest``

   - Click **Add New Entry**

   - **Scope Name:** ``r_basicprofile``

   - **Request:** ``/Common/LinkedInScopeBasicProfile``

   |image119|

#. Click the **+** on the **Successful** branch after the
   **LinkedIn OAuth Scope** object

   |image120|

#. Select **Variable Assign** from the **Assignment** tab, and click
   **Add Item**

   |image121|

#. Name it LinkedIn Variable Assign and click **Add New Entry** then
   **change**

   |image122|

#. Enter the following values and click **Finished**

   Left Side:

   - **Type:** ``Custom Variable``

   - **Security:** ``Unsecure``

   - **Value:** ``session.logon.last.username``

   Right Side:

   - **Type:** ``Session Variable``

   - **Session Variable:** ``session.oauth.scope.last.firstName``

   |image123|

#. Review the **LinkedIn Variable Assign** object and click **Save**

   |image124|

#. Click **Deny** on the **Fallback** branch after the
   **LinkedIn Variable Assign** object, select **Allow** in the pop up
   window and click **Save**

   |image125|

#. Click **Apply Access Policy** in the top left and then close the tab

   |image126|

Test Configuration
~~~~~~~~~~~~~~~~~~

#. Test by opening Chrome in the jump host and browsing to
   ``https://social.f5agility.com``, select the provider and attempt logon.

   |image127|

   .. NOTE:: You are able to login and reach the app now, but SSO to the app has
      not been setup so you get an application error.

   .. NOTE:: You may also be prompted for additional security measures as you
      are logging in from a new location.

   .. NOTE:: You may need to start a Chrome New Incognito Window so no
      session data carries over.

#. You will be prompted to authorize your request. Click **Allow.**

   |image128|

Task 7: Add Header Insertion for SSO to the App
-----------------------------------------------

In this task you will create a policy that runs on every request. It
will insert a header into the serverside HTTP Requests that contains the
username. The application will use this to identify who the user is,
providing Single Sign On (SSO).

Configure the Per Request Policy
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. Go to **Access** -> **Profiles/Policies** -> **Per Request Policies** and
   click **Create**

   |image129|

#. Enter prp-x-user-insertion the Name field and click **Finished**

   |image130|

#. Click **Edit** on the **prp-x-user-insertion policy** line

   |image131|

#. Click the **+** symbol between **Start** and **Allow**

   |image132|

#. Under the **General Purpose** tab select **HTTP Headers** and click
   **Add Item**

   |image133|

#. Under the HTTP Header Modify section, click Add New Entry to add the
   following two headers and then click Save

   - **Header Operation:** ``replace``

   - **Header Name:** ``X-User``

   - **Header Value:** ``%{session.logon.last.username}``

   - **Header Operation:** ``replace``

   - **Header Name:** ``X-Provider``

   - **Header Value:** ``%{session.logon.last.oauthprovidertype}``

   |image134|

   .. NOTE:: Replace instead of Insert has been selected for Header Operation to
      improve security. A malicious user might insert their own X-User header. As
      using Insert would simply add another header. Using Replace will add a header
      if it does not exist, or replace one if it does.

   You do not need to Apply Policy on per request policies. You may simply
   close the browser tab

   |image135|

Add the Per Request Policy to the Virtual Server
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. Go to **Local Traffic -> Virtual Servers** and click on
   ``social.f5agility.com-vs``

   |image136|

#. Scroll to the **Access Policy** section of the Virtual Server and select
   ``prp-x-user-insertion`` from the **Per-Request Policy** drop down. Scroll
   to the bottom of the page and click **Update**

   |image137|

Test Configuration
~~~~~~~~~~~~~~~~~~

#. Go to https://social.f5agility.com in your browser and logon using one of
   the social logon providers. This time you should see your name appear in the
   top right corner. You can also click "Headers" in the webapp and look at the
   headers presented to the client. You will see x-user present here with your
   name as the value. You’ll also see the x-provider header you inserted
   indicating where the data is coming from.

   |image138|


.. |br| raw:: html

   <br />

.. |image1| image:: /_static/class2/image3.png
.. |image2| image:: /_static/class2/image4.png
.. |image3| image:: /_static/class2/image5.png
.. |image4| image:: /_static/class2/image6.png
.. |image5| image:: /_static/class2/image7.png
.. |image6| image:: /_static/class2/image8.png
.. |image7| image:: /_static/class2/image9.png
.. |image8| image:: /_static/class2/image10.png
.. |image9| image:: /_static/class2/image11.png
.. |image10| image:: /_static/class2/image12.png
.. |image11| image:: /_static/class2/image13.png
.. |image12| image:: /_static/class2/image14.png
.. |image13| image:: /_static/class2/image15.png
.. |image14| image:: /_static/class2/image16.png
.. |image15| image:: /_static/class2/image17.png
.. |image16| image:: /_static/class2/image18.png
.. |image17| image:: /_static/class2/image19.png
.. |image18| image:: /_static/class2/image20.png
.. |image19| image:: /_static/class2/image21.png
.. |image20| image:: /_static/class2/image22.png
.. |image21| image:: /_static/class2/image23.png
.. |image22| image:: /_static/class2/image24.png
.. |image23| image:: /_static/class2/image25.png
.. |image24| image:: /_static/class2/image26.png
.. |image25| image:: /_static/class2/image27.png
.. |image26| image:: /_static/class2/image28.png
.. |image27| image:: /_static/class2/image29.png
.. |image28| image:: /_static/class2/image30.png
.. |image29| image:: /_static/class2/image31.png
.. |image30| image:: /_static/class2/image32.png
.. |image31| image:: /_static/class2/image33.png
.. |image32| image:: /_static/class2/image34.png
.. |image33| image:: /_static/class2/image35.png
.. |image34| image:: /_static/class2/image36.png
.. |image35| image:: /_static/class2/image37.png
.. |image36| image:: /_static/class2/image38.png
.. |image37| image:: /_static/class2/image39.png
.. |image38| image:: /_static/class2/image10.png
.. |image39| image:: /_static/class2/image40.png
.. |image40| image:: /_static/class2/image41.png
.. |image41| image:: /_static/class2/image42.png
.. |image42| image:: /_static/class2/image43.png
.. |image43| image:: /_static/class2/image44.png
.. |image44| image:: /_static/class2/image45.png
.. |image45| image:: /_static/class2/image46.png
.. |image46| image:: /_static/class2/image47.png
.. |image47| image:: /_static/class2/image48.png
.. |image48| image:: /_static/class2/image49.png
.. |image49| image:: /_static/class2/image50.png
.. |image50| image:: /_static/class2/image51.png
.. |image51| image:: /_static/class2/image52.png
.. |image52| image:: /_static/class2/image53.png
.. |image53| image:: /_static/class2/image54.png
.. |image54| image:: /_static/class2/image55.png
.. |image55| image:: /_static/class2/image56.png
.. |image56| image:: /_static/class2/image57.png
.. |image57| image:: /_static/class2/image58.png
.. |image58| image:: /_static/class2/image59.png
.. |image59| image:: /_static/class2/image60.png
.. |image60| image:: /_static/class2/image61.png
.. |image61| image:: /_static/class2/image62.png
.. |image62| image:: /_static/class2/image63.png
.. |image63| image:: /_static/class2/image64.png
.. |image64| image:: /_static/class2/image65.png
.. |image65| image:: /_static/class2/image66.png
.. |image66| image:: /_static/class2/image67.png
.. |image67| image:: /_static/class2/image68.png
.. |image68| image:: /_static/class2/image69.png
.. |image69| image:: /_static/class2/image70.png
.. |image70| image:: /_static/class2/image41.png
.. |image71| image:: /_static/class2/image71.png
.. |image72| image:: /_static/class2/image72.png
.. |image73| image:: /_static/class2/image44.png
.. |image74| image:: /_static/class2/image73.png
.. |image75| image:: /_static/class2/image74.png
.. |image76| image:: /_static/class2/image47.png
.. |image77| image:: /_static/class2/image75.png
.. |image78| image:: /_static/class2/image49.png
.. |image79| image:: /_static/class2/image76.png
.. |image80| image:: /_static/class2/image77.png
.. |image81| image:: /_static/class2/image78.png
.. |image82| image:: /_static/class2/image79.png
.. |image83| image:: /_static/class2/image80.png
.. |image84| image:: /_static/class2/image81.png
.. |image85| image:: /_static/class2/image82.png
.. |image86| image:: /_static/class2/image83.png
.. |image87| image:: /_static/class2/image84.png
.. |image88| image:: /_static/class2/image85.png
.. |image89| image:: /_static/class2/image86.png
.. |image90| image:: /_static/class2/image87.png
.. |image91| image:: /_static/class2/image88.png
.. |image92| image:: /_static/class2/image89.png
.. |image93| image:: /_static/class2/image87.png
.. |image94| image:: /_static/class2/image90.png
.. |image95| image:: /_static/class2/image91.png
.. |image96| image:: /_static/class2/image87.png
.. |image97| image:: /_static/class2/image92.png
.. |image98| image:: /_static/class2/image93.png
.. |image99| image:: /_static/class2/image87.png
.. |image100| image:: /_static/class2/image94.png
.. |image101| image:: /_static/class2/image93.png
.. |image102| image:: /_static/class2/image95.png
.. |image103| image:: /_static/class2/image96.png
.. |image104| image:: /_static/class2/image69.png
.. |image105| image:: /_static/class2/image97.png
.. |image106| image:: /_static/class2/image98.png
.. |image107| image:: /_static/class2/image99.png
.. |image108| image:: /_static/class2/image100.png
.. |image109| image:: /_static/class2/image101.png
.. |image110| image:: /_static/class2/image102.png
.. |image111| image:: /_static/class2/image103.png
.. |image112| image:: /_static/class2/image104.png
.. |image113| image:: /_static/class2/image105.png
.. |image114| image:: /_static/class2/image106.png
.. |image115| image:: /_static/class2/image107.png
.. |image116| image:: /_static/class2/image108.png
.. |image117| image:: /_static/class2/image109.png
.. |image118| image:: /_static/class2/image44.png
.. |image119| image:: /_static/class2/image110.png
.. |image120| image:: /_static/class2/image111.png
.. |image121| image:: /_static/class2/image47.png
.. |image122| image:: /_static/class2/image112.png
.. |image123| image:: /_static/class2/image113.png
.. |image124| image:: /_static/class2/image114.png
.. |image125| image:: /_static/class2/image115.png
.. |image126| image:: /_static/class2/image116.png
.. |image127| image:: /_static/class2/image117.png
.. |image128| image:: /_static/class2/image118.png
.. |image129| image:: /_static/class2/image119.png
.. |image130| image:: /_static/class2/image120.png
.. |image131| image:: /_static/class2/image121.png
.. |image132| image:: /_static/class2/image122.png
.. |image133| image:: /_static/class2/image123.png
.. |image134| image:: /_static/class2/image124.png
.. |image135| image:: /_static/class2/image125.png
.. |image136| image:: /_static/class2/image126.png
.. |image137| image:: /_static/class2/image127.png
.. |image138| image:: /_static/class2/image128.png
