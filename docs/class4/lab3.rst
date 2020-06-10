Lab 3: OAuth and AzureAD Lab
============================

The purpose of this lab is to familiarize students with using APM in
conjunction with Microsoft AzureAD. In the lab, Microsoft AzureAD is
leveraged as an OAuth Authorization Server (AS) while BIG-IP, through
the APM configuration is leveraged as an OAuth Client/Resource Server. 
Students will configure various OAuth/OpenID aspects to log in to APM
front-ended application.

Objective:
----------

-  Gain additional understanding of F5 OAuth features & functionality

-  Deploy a standard configuration using F5 APM and Microsoft AzureAD    

Lab Requirements:
-----------------

-  All lab requirements will be noted in the tasks that follow

-  Estimated completion time: 25 minutes

Lab 3 Tasks:
------------

TASK 1: Create/Review New Application Registration
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

+----------------------------------------------------------------------------------------------+
| **Note:** *The following Task 1 steps are to be "REVIEWED". Setting up a free Azure*         |
|                                                                                              |
| *developer account requires multiple steps (like the entry of billing information) which*    |
|                                                                                              |
| *are beyond the need and scope of this lab given the available time.  As such, the AzureAD*  |
|                                                                                              |
| *environment has been pre-configured for the lab exercises that follow.*                     |
+----------------------------------------------------------------------------------------------+

+----------------------------------------------------------------------------------------------+
| **[REVIEW ONLY]**                                                                            |
|                                                                                              |
| 1. Log into the Microsoft Azure Dashboard and click  **Azure Active Directory** in the left  |
|                                                                                              |
|    navigation menu.                                                                          |
+----------------------------------------------------------------------------------------------+
| |image034|                                                                                   |
+----------------------------------------------------------------------------------------------+

+----------------------------------------------------------------------------------------------+
| **[REVIEW ONLY]**                                                                            |
|                                                                                              |
| 2. Click on **App Registration** on the resulting menu and then **New Registration** in the  |
|                                                                                              |
|    horizontal menu.                                                                          |
+----------------------------------------------------------------------------------------------+
| |image035|                                                                                   |
+----------------------------------------------------------------------------------------------+

+----------------------------------------------------------------------------------------------+
| **[REVIEW ONLY]**                                                                            |
|                                                                                              |
| 3. In the pop-up window for **Register an application**, enter the following values          |
|                                                                                              |
|    * **Name:** **app.acme.com**                                                              |
|                                                                                              |
|    * **Supported account types:** **Accounts in this organizational directory only** (radio) |
|                                                                                              |
|    * **Redirect URI:** **https://app.acme.com/oauth/client/redirect**                        |
|                                                                                              |
| 4. Click **Register**.                                                                       |
+----------------------------------------------------------------------------------------------+
| |image036|                                                                                   |
+----------------------------------------------------------------------------------------------+
 
+----------------------------------------------------------------------------------------------+
| **[REVIEW ONLY]**                                                                            |
|                                                                                              |
| 5. In the resulting **app.acme.com** Registered App window, note & copy the **Application**  |
|                                                                                              |
|    **(client) ID** and **Directory (tenant) ID** as these will be used later in the setup.   |
+----------------------------------------------------------------------------------------------+
| |image037|                                                                                   |
+----------------------------------------------------------------------------------------------+

+----------------------------------------------------------------------------------------------+
| **[REVIEW ONLY]**                                                                            |
|                                                                                              |
| 6. Click **Certificates & Secrets** in the left navigation window and then click **New**     |
|                                                                                              |
|    **client secret** in the **Client Secrets** section.                                      |
+----------------------------------------------------------------------------------------------+
| |image038|                                                                                   |
+----------------------------------------------------------------------------------------------+

+----------------------------------------------------------------------------------------------+
| **[REVIEW ONLY]**                                                                            |
|                                                                                              |
| 7. In the **Add a client secret** pop-up window, enter the following values                  |
|                                                                                              |
| -  **Description:** **app.acme.com-secret**                                                  |
|                                                                                              |
| -  **Expires:** **In 2 Years**                                                               |
|                                                                                              |
| 8. Click **Add**.                                                                            |
+----------------------------------------------------------------------------------------------+
| |image039|                                                                                   |
+----------------------------------------------------------------------------------------------+

+----------------------------------------------------------------------------------------------+
| **[REVIEW ONLY]**                                                                            |
|                                                                                              |
| 9. In the resulting window, note and copy the **Client Secret** in the **Client secrets**    |
|                                                                                              |
|    section of the window. This will be used later in the APM portion of the setup.           |
+----------------------------------------------------------------------------------------------+
| |image040|                                                                                   |
+----------------------------------------------------------------------------------------------+
 
+----------------------------------------------------------------------------------------------+
| **[REVIEW ONLY]**                                                                            |
|                                                                                              |
| 10. In the left navigation menu select **API permissions**. In the updated panel note the    |
|                                                                                              |
|     assigned permissions.  These can be altered/expanded as needed based on needs.           |
+----------------------------------------------------------------------------------------------+
| |image041|                                                                                   |
+----------------------------------------------------------------------------------------------+

+----------------------------------------------------------------------------------------------+
| **[REVIEW ONLY]**                                                                            |
|                                                                                              |
| 11. In the left navigation window, click **Manifest**.                                       |
|                                                                                              |
| 12. In the **Manifest** panel, edit the **groupMembershipClaims** line (line 12) from        |
|                                                                                              |
|     **null** to **“All”** (note quotes are required).                                        |
|                                                                                              |
| 13. Click **Save**.                                                                          |
|                                                                                              |
| **Note:** *You can also update groupMembershipClaims to be "SecurityGroup".*                 |
+----------------------------------------------------------------------------------------------+
| |image042|                                                                                   |
+----------------------------------------------------------------------------------------------+

TASK 2: Create OAuth Token Request
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

+----------------------------------------------------------------------------------------------+
| 1. Create the **OAuth Request** by navigating to **Access** -> **Federation** ->             |
|                                                                                              |
|    **OAuth Client/Resource Server** -> **Request**.                                          |
+----------------------------------------------------------------------------------------------+
| |image001|                                                                                   |
+----------------------------------------------------------------------------------------------+

+----------------------------------------------------------------------------------------------+
| 2. Find the **AzureADTokenRequestByAuthzCode** row and click the **Copy** link.              |
|                                                                                              |
|    **Note:** *This should be the 6th row down.*                                              |
+----------------------------------------------------------------------------------------------+
| |image002|                                                                                   |
+----------------------------------------------------------------------------------------------+

+----------------------------------------------------------------------------------------------+
| 3. In the resulting **Copy Request** window, input **AzureADTokenRequest_ACME** for the      |
|                                                                                              |
|    **New Request Name** and then click the **Copy** button.                                  |
+----------------------------------------------------------------------------------------------+
| |image003|                                                                                   |
+----------------------------------------------------------------------------------------------+

+----------------------------------------------------------------------------------------------+
| 4. In the resulting **AzureADTokenRequest_ACME** window, click the                           |
|                                                                                              |
|    **custom | resource | <Enter_resource_name_here>** row in the **Request Parameters**      |
|                                                                                              |
|    section under **Request Settings** and then clieck the **Edit** button.                   |
|                                                                                              |
| 5. The edited row will now populate the **Parameter Type**, **Parameter Name** and           |
|                                                                                              |
|    **Parameter Value** fields.                                                               |
|                                                                                              |
| 6. Ensure the following values are in the indicated fields:                                  |
|                                                                                              |
|    * **Parameter Type:** **custom**                                                          |
|                                                                                              |
|    * **Parameter Name:** **resource**                                                        |
|                                                                                              |
|    * **Parameter Value:** **dd4bc4c7-2e90-41c9-9c41-b7eab5ab68b7**                           |
+----------------------------------------------------------------------------------------------+
| |image004|                                                                                   |
+----------------------------------------------------------------------------------------------+

+----------------------------------------------------------------------------------------------+
| 7. Once the value a verified correct, click the **Add** button which will move the values    |
|                                                                                              |
|    back to the **Request Parameters** section.                                               |
|                                                                                              |
| 8. Scroll to the bootom of the window and click the **Update** button.                       |
+----------------------------------------------------------------------------------------------+
| |image005|                                                                                   |
+----------------------------------------------------------------------------------------------+

TASK 3: Create OAuth Token Refresh Request
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

+----------------------------------------------------------------------------------------------+
| 1. Return to the **OAuth Client/Resouce Server Request** list by navigating to **Access**    |
|                                                                                              |
|    -> **Federation** -> **OAuth Client/Resource Server** -> **Request**.                     |
|                                                                                              |
| **Note:** *You may still be at this window if you did not navigate away.*                    |
+----------------------------------------------------------------------------------------------+
| |image001|                                                                                   |
+----------------------------------------------------------------------------------------------+

+----------------------------------------------------------------------------------------------+
| 2. Find the **AzureADTokenRefreshRequest** row and click the **Copy** link.                  |
|                                                                                              |
|    **Note:** *This should be the 5th row down.*                                              |
+----------------------------------------------------------------------------------------------+
| |image006|                                                                                   |
+----------------------------------------------------------------------------------------------+

+----------------------------------------------------------------------------------------------+
| 3. In the resulting **Copy Request** window, input **AzureADTokenRefreshRequest_ACME** for   |
|                                                                                              |
|    the **New Request Name** and then click the **Copy** button.                              |
+----------------------------------------------------------------------------------------------+
| |image007|                                                                                   |
+----------------------------------------------------------------------------------------------+

+----------------------------------------------------------------------------------------------+
| 4. In the resulting **AzureADTokenRefreshRequest_ACME** window, click the                    |
|                                                                                              |
|    **custom | resource | <Enter_resource_name_here>** row in the **Request Parameters**      |
|                                                                                              |
|    section under **Request Settings** and then clieck the **Edit** button.                   |
|                                                                                              |
| 5. The edited row will now populate the **Parameter Type**, **Parameter Name** and           |
|                                                                                              |
|    **Parameter Value** fields.                                                               |
|                                                                                              |
| 6. Ensure the following values are in the indicated fields:                                  |
|                                                                                              |
|    * **Parameter Type:** **custom**                                                          |
|                                                                                              |
|    * **Parameter Name:** **resource**                                                        |
|                                                                                              |
|    * **Parameter Value:** **dd4bc4c7-2e90-41c9-9c41-b7eab5ab68b7**                           |
+----------------------------------------------------------------------------------------------+
| |image008|                                                                                   |
+----------------------------------------------------------------------------------------------+

+----------------------------------------------------------------------------------------------+
| 7. Once the value a verified correct, click the **Add** button which will move the values    |
|                                                                                              |
|    back to the **Request Parameters** section.                                               |
|                                                                                              |
| 8. Scroll to the bootom of the window and click the **Update** button.                       |
+----------------------------------------------------------------------------------------------+
| |image009|                                                                                   |
+----------------------------------------------------------------------------------------------+

+----------------------------------------------------------------------------------------------+
| 9. In the **OAuth Client/Resouce Server Request** list both the newly created requests       |
|                                                                                              |
|    should now be listed. **AzureADTokenRequest_ACME** & **AzureADTokenRefreshRequest_ACME**. |
+----------------------------------------------------------------------------------------------+
| |image010|                                                                                   |
+----------------------------------------------------------------------------------------------+

TASK 4: Create OAuth Provider
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

+----------------------------------------------------------------------------------------------+
| 1. Create the **OAuth Provider** by navigating to **Access** -> **Federation** ->            |
|                                                                                              |
|    **OAuth Client/Resource Server** -> **Provider** and clicking **Create**.                 |
+----------------------------------------------------------------------------------------------+
| |image011|                                                                                   |
+----------------------------------------------------------------------------------------------+

+----------------------------------------------------------------------------------------------+
| 2. In the resulting window, input the following values to create the Provider:               |
|                                                                                              |
| -  **Name**: **azure\_AD\_provider**                                                         |
|                                                                                              |
| -  **Type**: **AzureAD**  (select from dropdown)                                             |
|                                                                                              |
| -  **OpenID URI:** (replace **\_tennantID\_** with the following tenantID                    |
|                                                                                              |
|    **f5agilitydemogmail.onmicrosoft.com** )                                                  |
|                                                                                              |
| Resulting URI should be as follows:                                                          |
|                                                                                              |
| https://login.windows.net/f5agilitydemogmail.onmicrosoft.com/.well-known/openid-configuration|
|                                                                                              |
| 3. Click **Discover**.                                                                       |
|                                                                                              |
| 4. Scroll to the bottom of the window and then click **Save**.                               |
|                                                                                              |
| **Note:** *If using another account you can find you TenantID by navigating to the "Azure*   |
|                                                                                              |
| *Portal" and clicking "Azure Active Directory". The tenant ID is the "default directory"*    |
|                                                                                              |
| *The full name of the TenantID will be your "TenantID.onmicrosoft.com".*                     |
+----------------------------------------------------------------------------------------------+
| |image012|                                                                                   |
+----------------------------------------------------------------------------------------------+

+----------------------------------------------------------------------------------------------+
| 9. In the **OAuth Client/Resouce Server Provider** list the newly created provider should    |
|                                                                                              |
|    now be listed **azure_AD_provider**.                                                      |
+----------------------------------------------------------------------------------------------+
| |image013|                                                                                   |
+----------------------------------------------------------------------------------------------+

TASK 5: Create OAuth Server
~~~~~~~~~~~~~~~~~~~~~~~~~~~

+----------------------------------------------------------------------------------------------+
| 1. Create the **OAuth Server (Client)** by navigating to **Access** -> **Federation** ->     |
|                                                                                              |
|    **OAuth Client/Resource Server** -> **OAuth Server** and clicking the **+ (Plus Symbol)** |
|                                                                                              |
| **Note:** *If you miss clicking the plus sign, simply click the create button on the right.* |
+----------------------------------------------------------------------------------------------+
| |image014|                                                                                   |
+----------------------------------------------------------------------------------------------+

+----------------------------------------------------------------------------------------------+
| 2. In the resulting window, input the following values to create the Server:                 |
|                                                                                              |
| -  **Name:** **azure\_AD\_Server**                                                           |
|                                                                                              |
| -  **Mode:** **Client** (Select from dropdown)                                               |
|                                                                                              |
| -  **Type:** **AzureAD** (Select from dropdown)                                              |
|                                                                                              |
| -  **OAuth Provider:** **azure\_AD\_provider** (Select from dropdown)                        |
|                                                                                              |
| -  **DNS Resolver:** **prebuilt\_dns\_resolver** (Select from dropdown)                      |
|                                                                                              |
| -  **Client ID:** **dd4bc4c7-2e90-41c9-9c41-b7eab5ab68b7**                                   |
|                                                                                              |
| -  **Client Secret:** **:RbLK?50]:aVZvomaZ6IC61_j/D=tXet**                                   |
|                                                                                              |
| -  **Client’s Server SSL Profile Name:** **serverssl** (Select from dropdown)                |
|                                                                                              |
| 3. Click **Finished**.                                                                       |
+----------------------------------------------------------------------------------------------+
| |image015|                                                                                   |
+----------------------------------------------------------------------------------------------+

+----------------------------------------------------------------------------------------------+
| 9. In the **OAuth Client/Resouce Server - OAuth Server** list the newly created provider     |
|                                                                                              |
|    should now be listed. **azure_AD_server**.                                                |
+----------------------------------------------------------------------------------------------+
| |image016|                                                                                   |
+----------------------------------------------------------------------------------------------+

TASK 6: Setup F5 Per Session Policy (Access Policy) 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

+----------------------------------------------------------------------------------------------+
| 1. Edit the existing **azure_oauth** Per Session Policy by navigating to **Access** ->       |
|                                                                                              |
|    **Profile/Policies** -> **Access Profiles (Per Session Policies)**.                       |
|                                                                                              |
| 2. Locate the **azure_oauth** policy row (should be 4th row) and click the **Edit** link.    |
+----------------------------------------------------------------------------------------------+
| |image017|                                                                                   |
+----------------------------------------------------------------------------------------------+

+----------------------------------------------------------------------------------------------+
| 3. In the resulting Visual Policy Editor window for the **azure_oauth** policy, click the    |
|                                                                                              |
|    **+ (Plus Symbol)** on the **fallback** branch between **Start** and **Allow**.           |
+----------------------------------------------------------------------------------------------+
| |image018|                                                                                   |
+----------------------------------------------------------------------------------------------+

+----------------------------------------------------------------------------------------------+
| 4. In the resulting pop-up window, click the **Authentication** tab and then click the radio |
|                                                                                              |
|    button for **OAuth Client**.                                                              |
|                                                                                              |
| 5. Scroll to the bottom of the window and click **Add Item**.                                |
+----------------------------------------------------------------------------------------------+
| |image019|                                                                                   |
+----------------------------------------------------------------------------------------------+

+----------------------------------------------------------------------------------------------+
| 6. In the **OAuth\_Client** window enter the following values as shown:                      |
|                                                                                              |
| -  **Server:** **/Common/azure\_AD\_server** (Select from dropdown)                          |
|                                                                                              |
| -  **Grant Type:** **Authorization code** (Select from dropdown)                             |
|                                                                                              |
| -  **OpenID Connect:** **Enabled** (Select from dropdown)                                    |
|                                                                                              |
| -  **OpenID Connect Flow Type:** **Authorization code** (Select from dropdown)               |
|                                                                                              |
| -  **Authentication Redirect Request:** **/Common/AzureADAuthRedirectRequest**  (dropdown)   |
|                                                                                              |
| -  **Token Request:** **/Common/AzureADTokenRequest_ACME**                                   |
|                                                                                              |
| -  **Refresh Token Request:** **/Common/AzureADTokenRefreshRequest_ACME** (dropdown)         |
|                                                                                              |
| -  **OpenID Connect UserInfo Request:** **None** (Select from dropdown)                      |
|                                                                                              |
| -  **Redirection URI:** **https://%{session.server.network.name}/oauth/client/redirect**     |
|                                                                                              |
| 10. Click **Save**.                                                                          |
+----------------------------------------------------------------------------------------------+
| |image020|                                                                                   |
+----------------------------------------------------------------------------------------------+

+----------------------------------------------------------------------------------------------+
| 11. In the Visual Policy Editor window for the **azure_oauth** policy, click the             |
|                                                                                              |
|     **+ (Plus Symbol)** on the **Successful** branch following the **OAuth Client** action.  |
|                                                                                              |
| 12. In the resulting pop-up window, click the **Assignment** tab and then click the radio    |
|                                                                                              |
|     button for **Variable Assign**.                                                          |
|                                                                                              |
| 13. Scroll to the bottom of the window and click **Add Item**.                               |
+----------------------------------------------------------------------------------------------+
| |image021|                                                                                   |
+----------------------------------------------------------------------------------------------+

+----------------------------------------------------------------------------------------------+
| 14. In the **Variable Assign** window click the **Add new entry** button.                    |
+----------------------------------------------------------------------------------------------+
| |image022|                                                                                   |
+----------------------------------------------------------------------------------------------+

+----------------------------------------------------------------------------------------------+
| 15. In the resulting window click the, input **session.logon.last.username** into the left   |
|                                                                                              |
|     pane.                                                                                    |
|                                                                                              |
| 16. For the right pane, use the top dropdown to select **Session Variable**.                 |
|                                                                                              |
| 17. In the **Session Variable** field presented input the following variable value:          |
|                                                                                              |
|     **session.oauth.client.last.id_token.upn**.                                              |
|                                                                                              |
| 18. Click the **Finished** button.                                                           |
+----------------------------------------------------------------------------------------------+
| |image023|                                                                                   |
+----------------------------------------------------------------------------------------------+

+----------------------------------------------------------------------------------------------+
| 19. In the resulting window, review the Assignment expression and click the **Save** button. |
+----------------------------------------------------------------------------------------------+
| |image024|                                                                                   |
+----------------------------------------------------------------------------------------------+

+----------------------------------------------------------------------------------------------+
| 20. Click on the **Apply Access Policy** link in the top left-hand corner.                   |
+----------------------------------------------------------------------------------------------+
| |image025|                                                                                   |
+----------------------------------------------------------------------------------------------+

TASK 7: Testing the OAuth Configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

+----------------------------------------------------------------------------------------------+
| 1. Open Firefox from the Jumphost desktop and click on the **app.acme.com** link in the      |
|                                                                                              |
|    bookmark toolbar.                                                                         |
+----------------------------------------------------------------------------------------------+
| |image026|                                                                                   |
+----------------------------------------------------------------------------------------------+

+----------------------------------------------------------------------------------------------+
| 2. Once redeirected to **https://login.microsoftonline.com** sign in with                    |
|                                                                                              |
|    **demouser@f5agilitydemogmail.onmicrosoft.com**, and then click **Next**                  |
+----------------------------------------------------------------------------------------------+
| |image027|                                                                                   |
+----------------------------------------------------------------------------------------------+

+----------------------------------------------------------------------------------------------+
| 3. In the updated browser window, input **F5!2020!** and click **Sign in**.                  |
+----------------------------------------------------------------------------------------------+
| |image028|                                                                                   |
+----------------------------------------------------------------------------------------------+

+----------------------------------------------------------------------------------------------+
| 4. In the updated browser window, check the checkbox for **Don't show this again** and click |
|                                                                                              |
|    the **Yes** button.                                                                       |
+----------------------------------------------------------------------------------------------+
| |image029|                                                                                   |
+----------------------------------------------------------------------------------------------+

+----------------------------------------------------------------------------------------------+
| 5. The browser window should now update, and return successfully the application portal for  |
|                                                                                              |
|    **https://app.acme.com**.                                                                 |
+----------------------------------------------------------------------------------------------+
| |image030|                                                                                   |
+----------------------------------------------------------------------------------------------+

TASK 8: Review OAuth Session 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

+----------------------------------------------------------------------------------------------+
| 1. Navigate to **Access -> Overview -> Active Sessions** on **bigip1**                       |
|                                                                                              |
| 2. Click on the **View** link for the currently active session row.                          |
|                                                                                              |
| **Note:** *If mutiple sessions are present, delete all sessions and restart testing.*        |
+----------------------------------------------------------------------------------------------+
| |image031|                                                                                   |
+----------------------------------------------------------------------------------------------+

+----------------------------------------------------------------------------------------------+
| 3. In the resulting **Session Variable** window, review all the available **oauth.client**   |
|                                                                                              |
|    variables resulting from the access just performed.                                       |
+----------------------------------------------------------------------------------------------+
| |image032|                                                                                   |
+----------------------------------------------------------------------------------------------+

TASK 9: Review OAuth Reports 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

+----------------------------------------------------------------------------------------------+
| 1. Navigate to **Access -> Overview -> OAuth Reports -> Client/Resource Server** on          |
|                                                                                              |
|    **bigip1**.                                                                               |
|                                                                                              |
| 2. Review and hover over the available reports.                                              |
+----------------------------------------------------------------------------------------------+
| |image033|                                                                                   |
+----------------------------------------------------------------------------------------------+

TASK 10: End of Lab3
~~~~~~~~~~~~~~~~~~~~

+----------------------------------------------------------------------------------------------+
| 1. This concludes Lab3, feel free to review and test the configuration.                      |
+----------------------------------------------------------------------------------------------+
| |image000|                                                                                   |
+----------------------------------------------------------------------------------------------+

.. |image000| image:: media/image001.png
   :width: 800px
.. |image001| image:: media/lab3-001.png
   :width: 800px
.. |image002| image:: media/lab3-002.png
   :width: 800px
.. |image003| image:: media/lab3-003.png
   :width: 800px
.. |image004| image:: media/lab3-004.png
   :width: 800px
.. |image005| image:: media/lab3-005.png
   :width: 800px
.. |image006| image:: media/lab3-006.png
   :width: 800px
.. |image007| image:: media/lab3-007.png
   :width: 800px
.. |image008| image:: media/lab3-008.png
   :width: 800px
.. |image009| image:: media/lab3-009.png
   :width: 800px
.. |image010| image:: media/lab3-010.png
   :width: 800px
.. |image011| image:: media/lab3-011.png
   :width: 800px
.. |image012| image:: media/lab3-012.png
   :width: 800px
.. |image013| image:: media/lab3-013.png
   :width: 800px
.. |image014| image:: media/lab3-014.png
   :width: 800px
.. |image015| image:: media/lab3-015.png
   :width: 800px
.. |image016| image:: media/lab3-016.png
   :width: 800px
.. |image017| image:: media/lab3-017.png
   :width: 800px
.. |image018| image:: media/lab3-018.png
   :width: 800px
.. |image019| image:: media/lab3-019.png
   :width: 800px
.. |image020| image:: media/lab3-020.png
   :width: 800px
.. |image021| image:: media/lab3-021.png
   :width: 800px
.. |image022| image:: media/lab3-022.png
   :width: 800px
.. |image023| image:: media/lab3-023.png
   :width: 800px
.. |image024| image:: media/lab3-024.png
   :width: 800px
.. |image025| image:: media/lab3-025.png
   :width: 800px
.. |image026| image:: media/lab3-026.png
   :width: 800px
.. |image027| image:: media/lab3-027.png
   :width: 800px
.. |image028| image:: media/lab3-028.png
   :width: 800px
.. |image029| image:: media/lab3-029.png
   :width: 800px
.. |image030| image:: media/lab3-030.png
   :width: 800px
.. |image031| image:: media/lab3-031.png
   :width: 800px
.. |image032| image:: media/lab3-032.png
   :width: 800px
.. |image033| image:: media/lab3-033.png
   :width: 800px
.. |image034| image:: media/lab3-034.png
   :width: 800px
.. |image035| image:: media/lab3-035.png
   :width: 800px
.. |image036| image:: media/lab3-036.png
   :width: 800px
.. |image037| image:: media/lab3-037.png
   :width: 800px
.. |image038| image:: media/lab3-038.png
   :width: 800px
.. |image039| image:: media/lab3-039.png
   :width: 800px
.. |image040| image:: media/lab3-040.png
   :width: 800px
.. |image041| image:: media/lab3-041.png
   :width: 800px
.. |image042| image:: media/lab3-042.png
   :width: 800px
.. |image043| image:: media/lab3-043.png
   :width: 800px
.. |image044| image:: media/lab3-044.png
   :width: 800px
.. |image045| image:: media/lab3-045.png
   :width: 800px
.. |image046| image:: media/lab3-046.png
   :width: 800px
.. |image047| image:: media/lab3-047.png
   :width: 800px


