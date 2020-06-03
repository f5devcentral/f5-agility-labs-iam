Lab 2: API Protection
=====================

Purpose
-------

This section will teach you how to configure a Big-IP (#1) as a Resource
Server protecting an API with OAuth and another Big-IP (#2) as the
Authorization Server providing the OAuth tokens.

Task 1: Setup Virtual Server for the API
----------------------------------------

.. Note:: This task is performed on Big-IP #1 (RS)

Create the Virtual Server
~~~~~~~~~~~~~~~~~~~~~~~~~

#. Go to **Local Traffic -> Virtual Servers** and click on **Create**

   |image139|

#. Enter the following values *(leave others default)* then scroll
   down to **Resources**

   - **Name:** ``api.f5agility.com-vs``

   - **Destination Address:** ``10.1.20.112``

   - **Service Port:** ``443``

   - **HTTP Profile:** ``http``

   - **SSL Profile (Client):** ``f5agility-wildcard-self-clientssl``

   - **Source Address Translation:** ``Auto Map``

   |image140|

#. In the **Resources** section, select following value *(leave others
   default)* then click **Finished**

   **Default Pool:** ``api-pool``

   |image141|

Test Configuration
~~~~~~~~~~~~~~~~~~

#. On the Jump Host, launch **Postman** from the desktop icon

   |image142|

#. The request should be prefilled with the settings below. If not change as
   needed or select **TEST API Call** from the **API Collection** and
   click **Send**

   **Method:** ``GET``

   **Target:** ``https://api.f5agility.com/department``

   **Authorization:** ``No Auth``

   **Headers:** (none should be set)

   |image143|

#. You should receive a 200 OK, 4 headers and the body should contain a list
   of departments.

   |image144|

   .. NOTE:: This request is working because we have not yet provided any
      protection for the API.*

   .. NOTE:: If you get "Could not get any response" then Postman’s settings
      may be set to verify SSL Certificates (default). Click **File -> Settings**
      and turn ``SSL Certificate Verification`` to **Off**.*

Task 2: Authorization Server
----------------------------

.. Note:: This task is performed on Big-IP #2 (AS)

Configure the Database Instance
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. Go to **Access -> Federation -> OAuth Authorization Server -> Database Instance**
   and click **Create**

   |image145|

#. Enter oauth-api-db for the **Name** field and click **Finished**.

   |image146|

Configure the Scope
~~~~~~~~~~~~~~~~~~~

#. Go to **Access** -> Federation -> **OAuth Authorization Server -> Scope**
   and click **Create**

   |image147|

#. Enter the following values and and click **Finished**.

   - **Name:** ``oauth-scope-username``

   - **Scope Name:** ``username``

   - **Scope Value:** ``%{session.logon.last.username}``

   - **Caption:** ``username``

   |image148|

   .. NOTE:: This scope is requested by the Resource Server and the information
      here is provided back. You can hardcode a value or use a variable as we
      have here. So if the scope username is requested, we will supply back
      the username that was used to login at the Authorization Server (AS).*

Configure the Client Application
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. Go to **Access** -> Federation -> **OAuth Authorization Server -> Client Application**
   and click **Create**

   |image149|

#. Enter the following values and click **Finished**.

   - **Name:** ``oauth-api-client``

   - **Application Name:** ``HR API``

   - **Caption:** ``HR API``

   - **Authentication Type:** ``Secret``

   - **Scope:** ``oauth-scope-username``

   - **Grant Type:** ``Authorization Code``

   - **Redirect URI(s):** ``https://www.getpostman.com/oauth2/callback``

   **Remember to click Add**

   |image150|

   .. NOTE:: The Redirect URI above is a special URI for the Postman client
      you’ll be using. This would normally be a specific URI to your client

Configure the Resource Server
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. Go to **Access -> Federation -> OAuth Authorization Server -> Resource Server**
   and click **Create**

   |image151|

#. Enter the following values and click **Finished**.

   - **Name:** ``oauth-api-rs``

   - **Application Type:** ``Secret``

   |image152|

Configure the OAuth Profile
~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. Go to **Access -> Federation -> OAuth Authorization Server -> OAuth Profile**
   and click **Create**

   |image153|

#. Enter the following values and click **Finished**.

   - **Name:** ``oauth-api-profile``

   - **Client Application:** ``oauth-api-client``

   - **Resource Server:** ``oauth-api-rs``

   - **Database Instance:** ``oauth-api-db``

   |image154|

Configure the APM Per Session Policy
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. Go to **Access -> Profiles/Policies -> Access Profiles (Per Session Policies)**
   and click **Create**

   |image155|

#. In the **General Properties** section enter the following values

   - **Name:** ``oauthas-ap``

   - **Profile Type:** ``All``

   - **Profile Scope:** ``Profile``

   |image156|

#. In the **Configurations** section select the following value from the
   **OAuth Profile** drop down menu.

   - **OAuth Profile:** ``oauth-api-profile``

   |image157|

#. In the **Language Settings** section enter the following value and
   then click **Finished**.

   - **Languages:** ``English``

   |image158|

#. Click **Edit** on the **oauthas-ap** policy, a new browser tab will open.

   |image159|

#. Click the **+** between **Start** and **Deny**

   |image160|

#. Select **Logon Page** from the **Logon** tab, and click **Add Item**

   |image161|

#. Accept the defaults on the **Logon Page** and click **Save**

   |image162|

#. Click the **+** between **Logon Page** and **Deny**

   |image163|

#. Select **OAuth Authorization** from the **Authentication** tab
   and click **Add Item**

   |image164|

#. Accept the defaults for the **OAuth Authorization**
   and click **Save**

   |image165|

#. Click **Deny** on the **Successful** branch after the
   **OAuth Authorization** object, select **Allow**,
   click **Save**

   |image166|

#. Click **Apply Access Policy** in the top left and then close
   the tab

   |image167|

   .. NOTE:: We are not validating the credentials entered on the Logon Page,
      so you can enter anything you want. In a production deployment you would
      most likely include some process for validating credentials such as an
      LDAP Auth or AD Auth object, or perhaps limiting access by IP or client
      certificate

   .. NOTE:: This policy might also set some variables that get used as
      scope values. Thus, you could determine what the scope values are by
      utilizing the policy here.*

Create the Authorization Virtual Server
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. Go to **Local Traffic -> Virtual Servers** and click **Create**

   |image168|

#. Enter the following values for the Authorization Server Virtual Server

   - **Name:** ``oauthas.f5agility.com-vs``

   - **Destination Address:** ``10.1.20.110``

   - **Service Port:** ``443``

   - **HTTP Profile:** ``http``

   - **SSL Profile (Client):** ``f5agility-wildcard-self-clientssl``

   - **Source Address Translation:** ``Auto Map``

   |image169|

#. Scroll to the **Access Policy** section, select oauthas-ap from the
   **Access Profile** drop down menu and then click **Finished** at the
   bottom of the screen.

   |image170|

Task 3: Resource Server
------------------------

.. Note:: This task is performed on Big-IP #1 (RS)

Configure the OAuth Provider
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. Go to **Access -> Federation -> OAuth Client/Resource Server -> Provider**
   and click **Create**

   |image171|

#. Enter the following values for the Authorization Server Virtual Server
   and then click **Finished**

   - **Name:** ``oauthas.f5agility.com-provider``

   - **Type:** ``F5``

   - **Authentication URI:** ``https://oauthas.f5agility.com/f5-oauth2/v1/authorize``

   - **Token URI:** ``https://oauthas.f5agility.com/f5-oauth2/v1/token``

   - **Token Validation Scope:** ``https://oauthas.f5agility.com/f5-oauth2/v1/introspect``

   |image172|

Configure the OAuth Server
~~~~~~~~~~~~~~~~~~~~~~~~~~

#. Go to **Access** -> Federation -> **OAuth Client/Resource Server -> OAuth Server**
   and click **Create**

   |image173|

#. Enter the following values for the Authorization Server Virtual Server and
   then click **Finished**

   - **Name:** ``api-resource-server``

   - **Mode:** ``Resource Server``

   - **Type:** ``F5``

   - **OAuth Provider:** ``oauthas.f5agility.com-provider``

   - **DNS Resolver:** ``oauth-dns``

   - **Resource Server ID:** (see step 5) *<Get this from Big-IP 2 -> Access
     -> Federation -> OAuth Authorization Server -> Resource Server ->
     oauth-api-rs>*

   - **Resource Server Secret:** (see step 5) *<Get this from Big-IP 2
     -> Access -> Federation -> OAuth Authorization Server -> Resource Server
     -> oauth-api-rs>*

   - **Resource Server’s Server SSL Profile Name:** apm-allowuntrusted-serverssl

   |image174|

   .. NOTE:: We are using a custom serverssl profile to allow negotiation with
      an untrusted certificate. This is needed because our Authorization Server
      is using a self-signed certificate. In production for proper security you
      should leverage a trusted certificate (most likely publicly signed) and
      the apm-default-serverssl profile (or other as appropriate)*

#. The values for step 4 above can be obtained by accessing Big-IP 2 and
   navigating to **Access -> Federation -> OAuth Authorization Server -> Resource Server -> oauth-api-rs**
   as shown.

   |image175|

#. To configure the **APM Per Session Policy** go to
   **Access -> Profiles / Policies -> Access Profiles (Per Session Policies)**
   and then click **Create**

   |image176|

#. Enter the following values and then click **Finished**

   |image177|

   - **Name:** ``api-ap``

   - **Profile Type:** ``OAuth-Resource-Server``

   - **Profile Scope:** ``Profile``

   - **Languages:** ``English``

   .. NOTE:: User Identification Method is set to OAuth Token and you cannot
      change it for this profile type.

#. Click **Edit** on the new api-ap policy and a new window will open

   |image178|

#. Click **Deny** on the fallback branch after **Start**, select **Allow**
   and click **Save**

   |image179|

#. Click **Apply Access Policy** in the top left and then close the tab

   |image180|

#. To configure the **APM Per Request Policy** go to
   **Access -> Profiles / Policies -> Per Request Policies**
   and then click **Create**

   |image181|

#. Enter api-prp for the **Name** and click **Finished**

   |image182|

#. Click **Edit** on the **api-prp** policy and a new window will appear

   |image183|

#. Click **Add New Subroutine**

   |image184|

#. Leave the ``Select Subroutine template`` as Empty. Enter RS Scope
   Check for the **Name** and then click **Save**

   |image185|

#. Click the **+** next to the **RS Scope Check**

   |image186|

#. Click Edit Terminals on the RS Scope Check Subroutine

   |image187|

#. First, rename **Out** to Success, then click **Add Terminal** and
   name it Failure

   |image188|

#. Go to the **Set Default** tab and select **Failure** then click Save

   |image189|

#. Click **Edit Terminals** again *(it will ignore the order settings if
   you do this in one step without saving in between)*

   |image190|

#. Move **Success** to the top using the up arrow on the right side
   then click **Save**

   |image191|

#. Click the **+** between **In** and **Success**, a new window will
   appear

   |image192|

#. Select **OAuth Scope** from the **Authentication** tab and click
   **Add Item**

   |image193|

#. Enter the following values and then click **Save**

   - **Server:** ``/Common/api-resource-server``

   - **Scopes Request:** /Common/F5ScopesRequest

   |image194|

#. Verify that the **Successful** branch terminates in **Success** and
   the **Fallback** branch terminates in **Failure**

   |image195|

#. In the main policy, click **+** between the **Start** and **Allow**

   |image196|

#. Select **RS Scope Check** from the **Subroutines** tab and
   click **Add Item**

   |image197|

#. Verify that the Success branch terminates in Allow and the Fallback
   branch terminates in Reject

   |image198|

   .. NOTE:: You do not need to "Apply Policy " on Per Request Policies*

#. To add the APM Policies to the API Virtual Server, go to
   **Local Traffic -> Virtual Servers** and click on
   **api.f5agility.com-vs**

   |image199|

#. Scroll down to the **Access Policy** section. Change **Access Profile**
   from **None** to api-ap

   |image200|

#. Change **Per-Request Policy** from **None** to api-prp and
   then click **Update**

Task 3: Verify
--------------

#. On the Jump Host, launch **Postman** from the desktop icon

   |image201|

#. The request should be prefilled with the settings below (same as earlier).
   If not change as needed or select **TEST API Call** from the
   **API Collection** and click **Send**

   |image202|

   - **Method:** ``GET``

   - **Target:** ``https://api.f5agility.com/department``

   - **Authorization:** ``No Auth``

   - **Headers:** ``(none should be set)``

#. You should receive a ``401 Unauthorized`` and **3 headers**,
   including ``WWW-Authenticate: Bearer``. The body will be empty.

   |image203|

   .. NOTE:: Your API call failed because you are not providing an
      OAuth token. Both tabs shown

   |image204|

#. Click the **Authorization** tab and change the **Type** from
   **No Auth** to OAuth 2.0

   |image205|

#. If present, select any existing tokens on the left side and delete
   them on the right side. Click **Get New Access Token**

   |image206|

#. In the **Get New Access Token** window, if the values do not match
   then adjust as needed, and click **Request Token**

   - **Token Name:** <Anything is fine here>

   .. NOTE:: If you’re doing this lab on your own machine and using
      self signed certificates you must add the certs to the trusted
      store on your computer. If you’ve just done this, you must close
      Postman and reopen. You also need to go to File -> Settings in
      Postman and turn SSL certificate validation to off.

   - **Auth URL:** ``https://oauthas.f5agility.com/f5-oauth2/v1/authorize``

   - **Access Token URL:** ``https://oauthas.f5agility.com/f5-oauth2/v1/token``

   - **Client ID:** <Get this from Big-IP 2 -> Access -> Federation ->
     OAuth Authorization Server -> Client Application -> oauth-api-client>

   - **Client Secret:** <Get this from Big-IP 2 -> Access -> Federation
     -> OAuth Authorization Server -> Client Application -> oauth-api-client>

   - **Scope:**

   - **Grant Type:** ``Authorization Code``

   - **Request access token locally:** ``checked``

   |image207|

#. Logon with any credentials, such as user/password

   |image208|

#. Authorize the HR API by clicking **Authorize**

   |image209|

#. You now have received an OAuth Token. Click the **name of your
   token** under **Existing Tokens** (left) and your token will
   appear on the right

   |image210|

#. Change the **Add token to** drop down to Header and the click
   **Use Token**. You will note that the **Header** tab (in the section
   tabs just above) now has one header in the **Header** tab which contains
   your **Authorization Header** of type **Bearer** with a string value.

   |image211|

   *The Header tab data is shown in the screenshot*

   |image212|

#. Click **Send** at the top of the Postman screen

   |image213|

#. You should receive a **200 OK**, **5 headers** and the **body**
   should contain a list of departments

   |image214|

   .. NOTE:: This time the request was successful because you presented a valid
      OAuth token to the resource server (the Big-IP), so it allowed the traffic
      to the API server on the backend.

Task 4: Testing Session and Token States
----------------------------------------

.. Note:: Parts of this task are performed on both Big-IP devices. Check
  each step to make sure you are working on the correct device.

Invalidate the Session
~~~~~~~~~~~~~~~~~~~~~~

#. Go to **Big-IP 1 (OAuth C/RS) -> Access -> Overview -> Active Sessions**.
   Select the existing sessions and click **Kill Selected Sessions**, then
   confirm by clicking **Delete**

   |image215|

#. Go back to **Postman** and click **Send** with your current OAuth token
   still inserted into the header. You should still receive a 200 OK,
   5 headers and the body should contain a list of departments.

   |image216|

   .. NOTE:: You were still able to reach the API because you were able to
      establish a new session with your existing valid token*.

Invalidate both the Current Session and Token
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. Go Big-IP 2 (OAuth AS) -> **Access -> Overview -> OAuth Reports -> Tokens**.
   Change the **DB Instance** to oauth-api-db.

   |image217|

#. Select all tokens, click **Checkbox** left in title bar and the click
   **Revoke** in the top right

   |image218|

#. Go to **Big-IP 1 (OAuth C/RS) -> Access -> Overview -> Active Sessions**.
   Select the existing sessions and click **Kill Selected Sessions**, then
   confirm by clicking **Delete**

   |image219|

#. Go back to **Postman** and click Send with your
   *current OAuth token still inserted* into the header. You should receive
   a ``401 Unauthorized``, **3 headers**, no body, and the ``WWW-Authenticate``
   header will provide an error description indicating the token is not active.

   |image220|

.. NOTE:: You can remove the header, delete the token, and start over getting
   a new token and it will work once again.*

.. NOTE:: This time you were no longer able to reach the API because you no
   longer had a valid token to establish your new session with. Getting a
   new token will resolve the issue.

.. |br| raw:: html

   <br />

.. |image139| image:: /_static/class2/image129.png
.. |image140| image:: /_static/class2/image130.png
.. |image141| image:: /_static/class2/image131.png
.. |image142| image:: /_static/class2/image132.png
.. |image143| image:: /_static/class2/image133.png
.. |image144| image:: /_static/class2/image134.png
.. |image145| image:: /_static/class2/image135.png
.. |image146| image:: /_static/class2/image136.png
.. |image147| image:: /_static/class2/image137.png
.. |image148| image:: /_static/class2/image138.png
.. |image149| image:: /_static/class2/image139.png
.. |image150| image:: /_static/class2/image140.png
.. |image151| image:: /_static/class2/image141.png
.. |image152| image:: /_static/class2/image142.png
.. |image153| image:: /_static/class2/image143.png
.. |image154| image:: /_static/class2/image144.png
.. |image155| image:: /_static/class2/image7.png
.. |image156| image:: /_static/class2/image145.png
.. |image157| image:: /_static/class2/image146.png
.. |image158| image:: /_static/class2/image147.png
.. |image159| image:: /_static/class2/image148.png
.. |image160| image:: /_static/class2/image149.png
.. |image161| image:: /_static/class2/image150.png
.. |image162| image:: /_static/class2/image151.png
.. |image163| image:: /_static/class2/image152.png
.. |image164| image:: /_static/class2/image153.png
.. |image165| image:: /_static/class2/image154.png
.. |image166| image:: /_static/class2/image155.png
.. |image167| image:: /_static/class2/image156.png
.. |image168| image:: /_static/class2/image157.png
.. |image169| image:: /_static/class2/image158.png
.. |image170| image:: /_static/class2/image159.png
.. |image171| image:: /_static/class2/image160.png
.. |image172| image:: /_static/class2/image161.png
.. |image173| image:: /_static/class2/image162.png
.. |image174| image:: /_static/class2/image163.png
.. |image175| image:: /_static/class2/image164.png
.. |image176| image:: /_static/class2/image165.png
.. |image177| image:: /_static/class2/image166.png
.. |image178| image:: /_static/class2/image167.png
.. |image179| image:: /_static/class2/image168.png
.. |image180| image:: /_static/class2/image169.png
.. |image181| image:: /_static/class2/image170.png
.. |image182| image:: /_static/class2/image171.png
.. |image183| image:: /_static/class2/image172.png
.. |image184| image:: /_static/class2/image173.png
.. |image185| image:: /_static/class2/image174.png
.. |image186| image:: /_static/class2/image175.png
.. |image187| image:: /_static/class2/image176.png
.. |image188| image:: /_static/class2/image177.png
.. |image189| image:: /_static/class2/image178.png
.. |image190| image:: /_static/class2/image176.png
.. |image191| image:: /_static/class2/image179.png
.. |image192| image:: /_static/class2/image180.png
.. |image193| image:: /_static/class2/image181.png
.. |image194| image:: /_static/class2/image182.png
.. |image195| image:: /_static/class2/image183.png
.. |image196| image:: /_static/class2/image184.png
.. |image197| image:: /_static/class2/image185.png
.. |image198| image:: /_static/class2/image186.png
.. |image199| image:: /_static/class2/image187.png
.. |image200| image:: /_static/class2/image188.png
.. |image201| image:: /_static/class2/image132.png
.. |image202| image:: /_static/class2/image133.png
.. |image203| image:: /_static/class2/image189.png
.. |image204| image:: /_static/class2/image190.png
.. |image205| image:: /_static/class2/image191.png
.. |image206| image:: /_static/class2/image192.png
.. |image207| image:: /_static/class2/image193.png
.. |image208| image:: /_static/class2/image194.png
.. |image209| image:: /_static/class2/image195.png
.. |image210| image:: /_static/class2/image196.png
.. |image211| image:: /_static/class2/image197.png
.. |image212| image:: /_static/class2/image198.png
.. |image213| image:: /_static/class2/image199.png
.. |image214| image:: /_static/class2/image200.png
.. |image215| image:: /_static/class2/image201.png
.. |image216| image:: /_static/class2/image200.png
.. |image217| image:: /_static/class2/image202.png
.. |image218| image:: /_static/class2/image203.png
.. |image219| image:: /_static/class2/image201.png
.. |image220| image:: /_static/class2/image204.png
