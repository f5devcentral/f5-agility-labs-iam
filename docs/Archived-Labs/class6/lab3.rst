Lab 3: oAuth and OpenID Connect Lab (Google)
============================================

The purpose of this lab is to better understand the F5 use cases OAuth2
and OpenID Connect by deploying a lab based on a popular 3rd party
login: Google. Google supports OpenID Connect with OAuth2 and JSON Web
Tokens. This allows a user to securely log in, or to provide a secondary
authentication factor to log in. Archive files are available for the
completed Lab 2.

Objective:
----------

-  Gain a better understanding of the F5 use cases OAuth2 and OpenID
   Connect.

-  Develop an awareness of the different deployment models that OAuth2,
   OpenID Connect and JSON Web Tokens (JWT) open up

Lab Requirements:
-----------------

-  All Lab requirements will be noted in the tasks that follow

-  Estimated completion time: 25 minutes

Lab 3 Tasks:
------------

TASK 1: Setup Google’s API Credentials 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Refer to the instructions and screen shots below:

+----------------------------------------------------------------------------------------------+
| *Note: If you do not have Google/gMail account, you will need to set one up. Navigate to:*   |
|                                                                                              |
| * https://console.developers.google.com/apis/credentials & follow the directions for setup.* |
+----------------------------------------------------------------------------------------------+ 
| |image60|                                                                                    |
| |image61|                                                                                    |
+----------------------------------------------------------------------------------------------+ 
   
+----------------------------------------------------------------------------------------------+
| 1. Navigate to https://console.developers.google.com/apis/credentials and log in with your   |
|                                                                                              |
|    developer account.                                                                        |
+----------------------------------------------------------------------------------------------+
| |image62|                                                                                    |
+----------------------------------------------------------------------------------------------+

+----------------------------------------------------------------------------------------------+
| 2. You will be redirected to the Google API’s screen. If you are previously familiar with    |
|                                                                                              |
|    Google API’s you can create a new Project.                                                |
|                                                                                              |
| 3. If you have not been you will be prompted to create a New Project.                        |
|                                                                                              |
| 4. Click **Create** in the dialogue box provided.                                            |
+----------------------------------------------------------------------------------------------+
| |image64|                                                                                    |
+----------------------------------------------------------------------------------------------+

+----------------------------------------------------------------------------------------------+
| 5. In the **New Project** window, provide a **Project Name**. The suggested value is:        |
|                                                                                              |
|    **F5 Federation oAuth**                                                                   |
|                                                                                              |
| *Note: If you have exceeded your project quota you may have to delete a project or*          |
|                                                                                              |
| *create a new account*                                                                       |
+----------------------------------------------------------------------------------------------+
| |image65|                                                                                    |
+----------------------------------------------------------------------------------------------+

+----------------------------------------------------------------------------------------------+
| 6. In the next screen, select **OAuth Client ID** for the **Credentials** type and           |
|                                                                                              |
|    click **Create Credentials**                                                              |
+----------------------------------------------------------------------------------------------+
| |image66|                                                                                    |
+----------------------------------------------------------------------------------------------+
 
+----------------------------------------------------------------------------------------------+
| 7. If you have not previously accepted a Consent Screen you may be prompted to do so.        |
|                                                                                              |
|    Click **Configure Consent Screen**.                                                       |
+----------------------------------------------------------------------------------------------+
| |image67|                                                                                    |
+----------------------------------------------------------------------------------------------+

+----------------------------------------------------------------------------------------------+
| 8. On the **OAuth Consent Screen** tab, enter the **email address** of your developer        |
|                                                                                              |
|    account (pre-populated) for the **Email Address**.                                        |
|                                                                                              |
| 9. For the **Product Name Shown to Users** enter **app.f5demo.com**.                         |
|                                                                                              |
| 10. Click **Save**.                                                                          |
+----------------------------------------------------------------------------------------------+
| |image68|                                                                                    |
+----------------------------------------------------------------------------------------------+

+----------------------------------------------------------------------------------------------+
| 11. In the **Create OAuth Client ID*** screen select or enter the following values:          |
|                                                                                              |
|  -  **Application Type:** **Web Application**                                                |
|                                                                                              |
|  -  **Name**: **app.f5demo.com**                                                             |
|                                                                                              |
|  -  **Authorized JavaScript Engine:** **https://app.f5demo.com**                             |
|                                                                                              |
|  -  **Authorized Redirect URIs:** **https://app.f5demo.com/oauth/client/redirect**           |
|                                                                                              |
| 12. Click **Create**.                                                                        |
+----------------------------------------------------------------------------------------------+
| |image69|                                                                                    |
+----------------------------------------------------------------------------------------------+

+----------------------------------------------------------------------------------------------+
| 13. In the **OAuth Client** pop-up window copy and paste your **Client ID** and              |
|                                                                                              |
|    **Client Secret** in Gedit text editor provided on your desktop.                          |
+----------------------------------------------------------------------------------------------+
| |image70|                                                                                    |
+----------------------------------------------------------------------------------------------+

TASK 2: Setup F5 OAuth Provider 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Refer to the instructions and screen shots below:

+----------------------------------------------------------------------------------------------+
| 1. Create the **OAuth Provider** by navigating to **Access** -> **Federation** ->            |
|                                                                                              |
|   **OAuth Client/Resource Server** -> **Provider** and clicking **Create**.                  |
+----------------------------------------------------------------------------------------------+
| |image71|                                                                                    |
+----------------------------------------------------------------------------------------------+

+----------------------------------------------------------------------------------------------+
| 2. Using the following values to complete the OAuth Provider                                 |
|                                                                                              |
| -  **Name:** **Google\_Provider**                                                            |
|                                                                                              |
| -  **Type:** **Google**                                                                      |
|                                                                                              |
| -  **Trusted Certificate Authorities:** **ca-bundle.crt**                                    |
|                                                                                              |
| -  **Allow Self-Signed JWK Config:**  **checked**                                            |
|                                                                                              |
| -  **Use Auto-discovered JWT:** **checked**                                                  |
|                                                                                              |
| 3. Click **Discover**.                                                                       |
|                                                                                              |
| 4. Accept all other defaults.                                                                |
|                                                                                              |
| 5. Click **Save**.                                                                           |
+----------------------------------------------------------------------------------------------+
| |image72|                                                                                    |
+----------------------------------------------------------------------------------------------+

TASK 3: Setup F5 OAuth Server (Client) 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Refer to the instructions and screen shots below:

+----------------------------------------------------------------------------------------------+
| 1. Create the **OAuth Server (Client)** by navigating to **Access** -> **Federation** ->     |
|                                                                                              |
|    **OAuth Client/Resource Server** -> **OAuth Server** and clicking **Create**.             |
+----------------------------------------------------------------------------------------------+
| |image73|                                                                                    |
+----------------------------------------------------------------------------------------------+

+----------------------------------------------------------------------------------------------+
| 2. Using the following values to complete the OAuth Provider                                 |
|                                                                                              |
| -  **Name:** **Google\_Server**                                                              |
|                                                                                              |
| -  **Mode:** **Client**                                                                      |
|                                                                                              |
| -  **Type:** **Google**                                                                      |
|                                                                                              |
| -  **OAuth Provider:** **Google\_Provider**                                                  |
|                                                                                              |
| -  **DNS Resolver:** **proxy\_dns\_resolver**                                                |
|                                                                                              |
| -  **Client ID:** **<your client id>**                                                       |
|                                                                                              |
| -  **Client Secret:** **<your client secret>**                                               |
|                                                                                              |
| -  **Client’s Server SSL Profile Name:** **serverssl**                                       |
|                                                                                              |
| 3. Click **Finished**.                                                                       |
+----------------------------------------------------------------------------------------------+
| |image74|                                                                                    |
+----------------------------------------------------------------------------------------------+

TASK 4: Setup F5 Per Session Policy (Access Policy) 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Refer to the instructions and screen shots below:

+----------------------------------------------------------------------------------------------+
| 1. Create the **Per Session Policy** by navigating to **Access -> Profile/Policies** ->      |
|                                                                                              |
|    **Access Profiles (Per Session Policies)** and clicking **Create**.                       |
+----------------------------------------------------------------------------------------------+
| |image75|                                                                                    |
+----------------------------------------------------------------------------------------------+

+----------------------------------------------------------------------------------------------+
| 2. In the **New Profile** dialogue window enter the following values                         |
|                                                                                              |
| -  **Name:** **Google\_OAuth**                                                               |
|                                                                                              |
| -  **Profile Type:** **All**                                                                 |
|                                                                                              |
| -  **Profile Scope:** **Profile**                                                            |
|                                                                                              |
| -  **Language:** **English**                                                                 |
|                                                                                              |
| 3. Click **Finished**.                                                                       |
+----------------------------------------------------------------------------------------------+
| |image76|                                                                                    |
+----------------------------------------------------------------------------------------------+

+----------------------------------------------------------------------------------------------+
| 4. Click **Edit** link on for the **Google\_OAuth** Access Policy.                           |
+----------------------------------------------------------------------------------------------+
| |image77|                                                                                    |
+----------------------------------------------------------------------------------------------+

+----------------------------------------------------------------------------------------------+
| 5. In the **Google\_OAuth** Access Policy, click the “\ **+**\ ” between **Start** & **Deny**|
|                                                                                              |
| 6. Click the **Authentication** tab in the events window.                                    |
|                                                                                              |
| 7. Scroll down and click the radio button for **OAuth Client**.                              |
|                                                                                              |
| 8. Click **Add Item**.                                                                       |
+----------------------------------------------------------------------------------------------+
| |image78|                                                                                    |
+----------------------------------------------------------------------------------------------+

+----------------------------------------------------------------------------------------------+
| 9. In the ***OAuth\_Client*** window enter the following values as shown:                    |
|                                                                                              |
| -  **Server:** **/Common/Google\_Server**                                                    |
|                                                                                              |
| -  **Grant Type:** **Authorization code**                                                    |
|                                                                                              |
| -  **OpenID Connect:** **Enabled**                                                           |
|                                                                                              |
| -  **OpenID Connect Flow Type:** **Authorization code**                                      |
|                                                                                              |
| -  **Authentication Redirect Request:** **/Common/GoogleAuthRedirectRequest**                |
|                                                                                              |
| -  **Token Request:** **/Common/GoogleTokenRequest**                                         |
|                                                                                              |
| -  **Refresh Token Request:** **/Common/GoogleTokenRefreshRequest**                          |
|                                                                                              |
| -  **OpenID Connect UserInfo Request:** **/Common/GoogleUserinfoRequest**                    |
|                                                                                              |
| -  **Redirection URI:** **https://%{session.server.network.name}/oauth/client/redirect**     |
|                                                                                              |
| -  **Scope:** **openid profile email**                                                       |
|                                                                                              |
| 10. Click **Save**.                                                                          |
+----------------------------------------------------------------------------------------------+
| |image79|                                                                                    |
+----------------------------------------------------------------------------------------------+

+----------------------------------------------------------------------------------------------+
| 11. Click on the **Deny** link, in the **Select Binding**, select the **Allow** radio button |
|                                                                                              |
|    and click **Save**.                                                                       |
+----------------------------------------------------------------------------------------------+
| |image80|                                                                                    |
+----------------------------------------------------------------------------------------------+

+----------------------------------------------------------------------------------------------+
| 12. Click on the ***Apply Access Policy*** link in the top left-hand corner.                 |
|                                                                                              |
| *Note: Additional actions can be taken in the Per Session policy (Access Policy).*           |
|                                                                                              |
| *The lab is simply completing authorization. Other access controls can be implemented based* |
|                                                                                              |
| *on the use case*.                                                                           |
+----------------------------------------------------------------------------------------------+
| |image81|                                                                                    |
+----------------------------------------------------------------------------------------------+

TASK 5: Associate Access Policy to Virtual Server 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Refer to the instructions and screen shots below:

+----------------------------------------------------------------------------------------------+
| 1. Navigate to **Local Traffic** -> **Virtual Servers** -> **Virtual Server List** and click |
|                                                                                              |
|    on the **app.f5demo.com** Virtual Server link.                                            |
|                                                                                              |
| 2. Scroll to the **Access Policy** section.                                                  |
+----------------------------------------------------------------------------------------------+
| |image82|                                                                                    |
+----------------------------------------------------------------------------------------------+

+----------------------------------------------------------------------------------------------+
| 3. Use the **Access Profile** drop down to change the **Access Profile** to **Google\_OAuth**|
|                                                                                              |
| 4. Use the **Per-Request Policy** drop down to change the **Per-Request Policy** to          |
|                                                                                              |
|    **Google\_oauth\_policy**                                                                 |
|                                                                                              |
| 5. Scroll to the bottom of the **Virtual Server** configuration and click **Update**         |
+----------------------------------------------------------------------------------------------+
| |image83|                                                                                    |
+----------------------------------------------------------------------------------------------+

TASK 6: Test app.f5demo.com
~~~~~~~~~~~~~~~~~~~~~~~~~~~

Refer to the instructions and screen shots below:

+----------------------------------------------------------------------------------------------+
| 1. Navigate in your provided browser to **https://app.f5demo.com**                           |
+----------------------------------------------------------------------------------------------+
| |image84|                                                                                    |
+----------------------------------------------------------------------------------------------+

+----------------------------------------------------------------------------------------------+
| 2. Authenticate with the account you established your Google Developer account with.         |
+----------------------------------------------------------------------------------------------+
| |image85|                                                                                    |
+----------------------------------------------------------------------------------------------+

+----------------------------------------------------------------------------------------------+
| 3. Did you successfully redirect to the Google?                                              |
|                                                                                              |
| 4. After successful authentication, were you returned to the app.f5demo.com?                 |
|                                                                                              |
| 5. Did you successfully pass your OAuth Token?                                               |
+----------------------------------------------------------------------------------------------+
| |image86|                                                                                    |
+----------------------------------------------------------------------------------------------+

TASK 7: Per Request Policy Controls
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Refer to the instructions and screen shots below:

+----------------------------------------------------------------------------------------------+
| 1. In the application page for **https://app.f5demo.com** click the **Admin Link** shown     |
+----------------------------------------------------------------------------------------------+
| |image87|                                                                                    |
+----------------------------------------------------------------------------------------------+

+----------------------------------------------------------------------------------------------+
| 2. You will receive an **Access to this page is blocked** (customizable) message with a      |
|                                                                                              |
|    reference. You have been blocked because you do not have access on a per request basis.   |                                                                      
|                                                                                              |
| 3. Press the **Back** button in your browser to return to **https://app.f5demo.com**.        |
+----------------------------------------------------------------------------------------------+
| |image88|                                                                                    |
+----------------------------------------------------------------------------------------------+

+----------------------------------------------------------------------------------------------+
| 4. Navigate to **Local Traffic** -> **iRules** -> **Datagroup List** and click on the        |
|                                                                                              |
|    **Allowed\_Users** datagroup.                                                             |
|                                                                                              |
| 5. Enter your **Google Account** used for this lab as the **String** value.                  |
|                                                                                              |
| 6. Click **Add** then Click **Update**.                                                      |
|                                                                                              |
| *Note: We are using a DataGroup control to minimize lab resources and steps. AD or LDAP*     |
|                                                                                              |
| *Group memberships, Session variables, other user attributes and various other access*       |
|                                                                                              |
| *control mechanisms can be used to achieve similar results.*                                 |
+----------------------------------------------------------------------------------------------+
| |image89|                                                                                    |
+----------------------------------------------------------------------------------------------+

+----------------------------------------------------------------------------------------------+
| 7. You should now be able to successfully to access the Admin Functions by clicking on the   |
|                                                                                              |
|    **Admin Link**.                                                                           |
|                                                                                              | 
| *Note: Per Request Policies are dynamic and do not require the same “Apply Policy” action as*|
|                                                                                              |
| *Per Session Policies.*                                                                      |
+----------------------------------------------------------------------------------------------+
| |image90|                                                                                    |
+----------------------------------------------------------------------------------------------+

+----------------------------------------------------------------------------------------------+
| 8. To review the Per Request Policy, navigate to **Access Profiles/Policies** ->             |
|                                                                                              |
|   **Per Request Policies** and click on the **Edit** link for the **Google\_oauth\_policy**. |
+----------------------------------------------------------------------------------------------+
| |image91|                                                                                    |
+----------------------------------------------------------------------------------------------+

+----------------------------------------------------------------------------------------------+
| 9. The various Per-Request-Policy actions can be reviewed                                    |
|                                                                                              |
| *Note: Other actions like Step-Up Auth controls can be performed in a Per-Request Policy.*   |
+----------------------------------------------------------------------------------------------+
| |image92|                                                                                    |
+----------------------------------------------------------------------------------------------+

TASK 8: Review OAuth Results 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Refer to the instructions and screen shots below:

+----------------------------------------------------------------------------------------------+
| 1. Review your Active Sessions (**Access** -> **Overview** -> **Active Sessions**).          |
|                                                                                              |
| 2. You can review Session activity or session variable from this window or kill the          |
|                                                                                              |
|    selected Session.                                                                         |
+----------------------------------------------------------------------------------------------+
| |image93|                                                                                    |
+----------------------------------------------------------------------------------------------+

+----------------------------------------------------------------------------------------------+
| 3. Review your Access Report Logs (**Access** -> **Overview** -> **Access Reports**).        |
+----------------------------------------------------------------------------------------------+
| |image94|                                                                                    |
+----------------------------------------------------------------------------------------------+

+----------------------------------------------------------------------------------------------+
| 4. In the **Report Parameters window** click **Run Report**.                                 |
+----------------------------------------------------------------------------------------------+
| |image95|                                                                                    |
+----------------------------------------------------------------------------------------------+

+----------------------------------------------------------------------------------------------+
| 5. Look at the **SessionID** report by clicking the **Session ID** Link.                     |
+----------------------------------------------------------------------------------------------+
| |image96|                                                                                    |
+----------------------------------------------------------------------------------------------+

+----------------------------------------------------------------------------------------------+
| 6. Look at the **Session Variables** report by clicking the **View Session Variables** link. |
|                                                                                              |
|    Pay attention to the OAuth Variables.                                                     |
|                                                                                              |
| *Note: Any of these session variables can be used to perform further actions to improve*     |
|                                                                                              |
| *security or constrain access with logic in the Per-Session or Per Request VPE policies or*  |
|                                                                                              |
| *iRules/iRulesLX.*                                                                           |
+----------------------------------------------------------------------------------------------+
| |image97|                                                                                    |
+----------------------------------------------------------------------------------------------+
 
+----------------------------------------------------------------------------------------------+
| 7. Review your Access Report Logs (**Access** -> **Overview** -> **OAuth Reports** ->        |
|                                                                                              |
|    **Client/Resource Server**).                                                              |
+----------------------------------------------------------------------------------------------+
| |image98|                                                                                    |
+----------------------------------------------------------------------------------------------+


.. |image58| image:: media/image60.png
   :width: 2.23039in
   :height: 2.36979in
.. |image59| image:: media/image61.png
   :width: 3.49268in
   :height: 1.22650in
.. |image60| image:: media/image62.png
   :width: 1.37500in
   :height: 1.42298in
.. |image61| image:: media/image63.png
   :width: 1.83333in
   :height: 1.44662in
.. |image62| image:: media/image64.png
   :width: 3.61350in
   :height: 0.25904in
.. |image63| image:: media/image65.png
   :width: 1.32012in
   :height: 1.27746in
.. |image64| image:: media/image66.png
   :width: 3.45577in
   :height: 1.25767in
.. |image65| image:: media/image67.png
   :width: 3.08125in
   :height: 1.94452in
.. |image66| image:: media/image68.png
   :width: 3.16458in
   :height: 1.63370in
.. |image67| image:: media/image69.png
   :width: 3.18021in
   :height: 1.10982in
.. |image68| image:: media/image70.png
   :width: 2.88720in
   :height: 2.00521in
.. |image69| image:: media/image71.png
   :width: 3.28125in
   :height: 2.26534in
.. |image70| image:: media/image72.png
   :width: 3.33125in
   :height: 1.39217in
.. |image71| image:: media/image73.png
   :width: 3.43558in
   :height: 1.07255in
.. |image72| image:: media/image74.png
   :width: 3.49738in
   :height: 4.78430in
.. |image73| image:: media/image75.png
   :width: 3.58125in
   :height: 0.63905in
.. |image74| image:: media/image76.png
   :width: 3.38575in
   :height: 2.95455in
.. |image75| image:: media/image77.png
   :width: 3.59729in
   :height: 0.47370in
.. |image76| image:: media/image78.png
   :width: 3.58653in
   :height: 2.84049in
.. |image77| image:: media/image79.png
   :width: 3.55864in
   :height: 0.65031in
.. |image78| image:: media/image80.png
   :width: 3.64514in
   :height: 1.52147in
.. |image79| image:: media/image81.png
   :width: 3.59509in
   :height: 1.58711in
.. |image80| image:: media/image82.png
   :width: 3.55215in
   :height: 1.16329in
.. |image81| image:: media/image83.png
   :width: 3.53374in
   :height: 1.34193in
.. |image82| image:: media/image84.png
   :width: 3.50234in
   :height: 2.68712in
.. |image83| image:: media/image85.png
   :width: 3.49738in
   :height: 1.72209in
.. |image84| image:: media/image86.png
   :width: 3.57570in
   :height: 0.25694in
.. |image85| image:: media/image87.png
   :width: 3.24109in
   :height: 2.82822in
.. |image86| image:: media/image88.png
   :width: 3.16168in
   :height: 2.42702in
.. |image87| image:: media/image89.png
   :width: 2.86751in
   :height: 2.21224in
.. |image88| image:: media/image90.png
   :width: 2.80941in
   :height: 1.35399in
.. |image89| image:: media/image91.png
   :width: 3.15971in
   :height: 2.33461in
.. |image90| image:: media/image92.png
   :width: 3.40586in
   :height: 1.10658in
.. |image91| image:: media/image93.png
   :width: 3.42307in
   :height: 1.50171in
.. |image92| image:: media/image94.png
   :width: 3.45192in
   :height: 1.33345in
.. |image93| image:: media/image95.png
   :width: 3.59450in
   :height: 1.52876in
.. |image94| image:: media/image96.png
   :width: 2.06848in
   :height: 1.53438in
.. |image95| image:: media/image97.png
   :width: 3.52761in
   :height: 0.80655in
.. |image96| image:: media/image98.png
   :width: 3.64074in
   :height: 1.05961in
.. |image97| image:: media/image99.png
   :width: 3.62160in
   :height: 1.84971in
.. |image98| image:: media/image100.png
   :width: 3.60694in
   :height: 2.16776in

