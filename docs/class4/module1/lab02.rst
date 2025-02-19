Lab 2: Access Policy Manager HTTP Connector with Open Policy Agent
==================================================================

HTTP Connector is a feature in BIG-IP Access Policy Manager that allows BIG-IP APM to make HTTP requests to another resource to update information or make additional access decision to a resource. This lab demonstrates using HTTP Connector with Open Policy Agent to enforce fine-grained user access policies.

The HTTP Connector is made up of two parts. The first part is called the HTTP Connector Transport, and it defines settings related to SSL, DNS, timeouts, and payload sizes. The second part is the HTTP Connector Request which contains specific details such as HTTP Method, URL, message body, and how to handle the HTTP responses.

The following tasks will be walked through or configured by the lab attendee:  

Task 1 - Configure a JWE token for access 

Task 2 - Create a Client Application to serve as an OAuth Client 

Task 3 - Create a Resource Server  

Task 4 - Create a OAuth Profile 

Task 5 - Create an OAuth Server to grant authentication 

Task 6 - Create an Advanced Web Application Firewall policy to protect APIs via OpenAPI file  

Expected time to complete: **40 minutes**

Task 1 - Creating a Per-Session Policy
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

You will create a Per-Session Policy that allows all access. This allows us to establish a session for connectivity and then apply a more granular per-request policy to process the authentication and authorization to the individual applications.  


#. In the BIG-IP GUI --> Click on **Access** --> Click on **Profiles/Policies** --> Click **Access Profiles (Per-Session Policies)**  

   |image1|

#. Click **Create**

   |image2|

#. In the new Per-Session policy, add the following configurations:

**Name:** opa_access_connector 

**Profile:** All 

**Profile Scope:** Profile 

**Language Settings:** Select English and move it to left (scroll down to the bottom of the page) 


The rest of the settings, we will keep the default settings. Click **Finished**. 

   |image3|

   |image4|


#. Edit the Per-Session policy to allow all access 


   |image5|

#. In the Visual Policy Editor --> Click **Deny Ending**, and change it to **Allow** --> Click **Save**

   |image6|

#. The policy should look the like the diagram below.  Click on the **Apply Access Policy** button at the top left hand corner. Close the policy using the green **Close** button at the top right hand corner 

   |image7|


Task 2 - Create HTTP Connector Transport
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. Click on **Access** --> Click on **Authentication** --> Click on **HTTP Connector** --> Click on **HTTP Connector Transport** 

    |image8|

#. Click on **Create** button at the right-hand corner 

    |image9|

#. In the new HTTP Connector Transport Properties, set the following configurations:  

**Name:** connector_transport 
**DNS Resolver:** select **/Common/f5-aws-dns** from the drop down list 
Keep the default settings for the rest of fields, and click **Save**. 

    |image10|

Task 3 - Create HTTP Connector Request
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. Click on **Access** --> Click on **Authentication** --> Click on **HTTP Connector** --> Click on **HTTP Connector_Request**

   |image11|
   
#. Click on **Create**

   |image12|

#. Under **General Properties**, set the following configurations: 

**Name:** opa_call 
**HTTP Connector Transport:** select **/Common/connector_transport** from the drop list 
**URL:** http://10.1.20.12:8181/v1/data/backend/access/allow 
**Method:** POST 
**Request Headers:** Content-Type: application/json 
**Request Body:**  

Insert the following into the Request Body.

..   code:: JSON

   { 

      "input": { 

      "user": "%{subsession.logon.last.username}", 

      "app": "%{subsession.server.custom_landinguri}" 

      } 

   }
**Response Action:** Select **Parse** from the drop down list
Click **Save** 

   |image13|

Task 4 - Create Per-request policy
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. Click on **Access** -->  Click on **Profiles / Policies** --> Click on **Per-Request Policies** 

    |image14|

#. Click **Create** 

  |image15|

#. In the new Per-Request policy, set the following configurations. 

**Name:** opa_access_prp 
**Policy Type:** All 
**Incomplete Action:** Deny 
**Language:** select English, and move it under the Accepted Language column 
Click **Finished**

   |image16|

#. Click on **Edit**  

   |image17|

#. Create a subroutine for Logon, Authentication, and HTTP Connector. Click on **Add New Subroutine** 

   |image18|

#. In the subroutine box type the name **ad_connector** and click **Save** 
 
   |image19|

#. Expand **Subroutine: ad_connector** by click on the **+** sign 

   |image20|

#. Click on the **+** sign to add a resource to the policy 

   |image21|


#. There are couple of ways to find Group/Resources to add to the Visual Policy Editor. This first method we’ll use the search feature. In the search box, type the word variable to search for “Variable Assign” resource. We will create a variable assign to retrieve the application uri into the per-request path. 

#. Click on **Variable Assign** to select the resource, and click **Add Item** 

   |image22|

#. In the **Variable Assign** properties, click on **Add new entry**, and then click on **change** in the variable Assignment section. 

   |image23|

#. In the **Custom Variable** box on the left-hand side type in the following variable 

   subsession.server.custom_landinguri 

   |image24|

#. In the **Custom Expression** box on the right-hand side click on the drop down box and select **Session Variable**, and enter the following variable  

   perflow.category_lookup.result.url 

   |image25|

   The finished variable should look like the following screenshot. Click **Finished**. 

   |image26|

   Click **Save** on the next window 

   |image27|

#. Click on the **+** sign located after Variable Assign to add another resource. 

   |image28|

#. Another method to find Group/Resources is to click through the tabs for the pertinent resource. The next item we need to add is Ad Auth. Click on **Authentication** tab, and select **AD Auth**. Click **Add Item**.  

   |image29|

#. In the AD Auth properties window, click on the drop down arrow next to **Server**, and select **/Common/oauth_as.app/oauth_as_ad-server**. Click **Save**. 

   |image30|

#. Search for **HTTP Connector** resource, and add it to the Visual Policy Editor. 

   |image31|

#. In the HTTP Connector properties, click on the **HTTP Connector Request** and select **/Common/opa_request** 

   |image32|

#. Click on Branch Rules tab, in the **Name** field, change it to **Access_Allowed**, and then click on **change** link in the Expression box. 

   |image33|

#. In the next window, click on the **Advanced** tab.  
#. Remove the expression inside the box, and replace it with the following expression. Click **Finish** 

   expr { [mcget {subsession.http_connector.body.result}] == true }

   |image34|

#. After clicking Finish, you should be at the screen below. Click **Save**.

   |image35|

#. Next you will add two message boxes to the flow. One after the Access_Allowed flow, and another after the Fallback flow. Click the **+** sign next to Access_Allowed flow. For ease, type in message in the search box to bring up the Message Box. Select **Message Box**, and click **Add Item**

   |iamge36|

#. In the Message box properties, copy and paste the following  

**Title:** Access Allowed 

**Description (optional):** User %{subsession.last.logon.username} is allowed to access Application %{subsession.server.custom_landinguri} 

Click **Save** 

   |image37|

#. Add another **Message box** for the fallback branch. 

   |image38|

#. In the Message Box properties copy and paste the following 

**Title:** Access Denied 

**Description (optional):** User %{subsession.last.logon.username} is not allowed to access Application %{subsession.server.custom_landinguri} 

Click **Save** 

   |image39|

#. The policy endings are currently set to Allow. We will need to adjust these appropriately. Click on **Edit Terminals**. 

   |image40|

#. In the Terminal properties, click on **Add Terminal**. Change the **Name** of the first terminal, Terminal 1 to **Reject**. Change the second terminal Name from Out to **Allow**. Click **Save**. 

   |image41|

#. Double click on the Allow ending after Message Box (1) and change it to **Reject**. Click **Save**. Do the same thing for the third Allow. 

   |image42|

   |image43|

#. The completed subroutine should look like the screenshot below 

   |image44|

#. We will now attach the subroutine to the main Per-Request policy. Click the **+** sign after the word fallback in the main policy. 

   |image45|



#. In the **Group/Resource** box, go the last tab, **Subroutines**. Select the subroutine call **ad_connector**, and click on **Add Item**. 

   |image47|

#. Next we will need to add a Category Lookup for the URI. Click on the + sign between Start and ad_connector. Search for Category Lookup and add the item to the policy. 

   |image48|

#. In the Category Lookup property window, change the Categorization Input to User HTTP URI (cannot be used for SSL Bypass decisions). Click Save. 

   |image49|

#. Double check the terminal endings. Does Reject flow into the Reject ending? Does the Allow/Out flow in to Allow ending? If not adjust the terminal endings so they match the flow. See the screenshot below for reference. 

   |image50|

Task 5 - Create a Virtual Server
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. Back in the BIG-IP GUI, click on **Local Traffic** --> **Virtual Servers** --> **Virtual Server List** 

   |image51|

#. Click **Create**

   |image52|

#. Set the following configurations for the virtual server.  

**Name:** opa_access_vs 
**Destination Address/Mask:** 10.1.10.101 
**Service Port:** 443 
**HTTP Profile (Client):** http 
**SSL Profile Client:** clientssl-insecure-compatible 
**Source Address Translation:** Auto Map 
**Access Profile:** opa_access_connector 
**Per-Request Policy:** opa_access_prp 
Click **Finish**

   |image53|
   |image54|
   |image55|
   |image56|

#. Create a pool to assign to the virtual server. We will omit creating a node, as one is already pre-defined because it's a shared backend server running multiple applications for this lab environment.  

Click on **Pools** --> **Pool List**

   |image57|

#. Click **Create**

   |image58|

#. Set the following configuration settings for the pool  

**Name:** backend_pool 
**Health Monitors:** http 
**Node List:** click the drop down list, and select **10.1.20.5** 
**Service Port:** 8888 
Click **Add** 
Click **Finished**

   |image59|

#. Attach the pool to the virtual server. Click on **Virtual Server** --> **Virtual Server List** --> Click on **opa_access_vs** virtual server. 

   |image60|

#. Click on the **Resources** tab of the Virtual Server, click on the drop down arrow for **Default Pool**, and select **backend_pool**. Click **Update**. 

   |image61|

Task 6 - Test the policy
~~~~~~~~~~~~~~~~~~~~~~~~

#. Open Google Chrome. In the browser bookmark bar, there are shortcuts to App1 and App2.   

In the OPA policy, the users below have access to the specific apps.  

Test logging on as user1 to App1. Were you successful? Why? 

Try logging as user2 to App1. Were you successful? Why? 

**Username:** user1
**Password:** user@dMin_1234

**Username:** user2
**Password:** user@dMin_1234 


#. This concludes lab 2.



.. |image1| image:: media/lab02/image1.png
.. |image2| image:: media/lab02/image2.png
.. |image3| image:: media/lab02/image3.png
.. |image4| image:: media/lab02/image4.png
.. |image5| image:: media/lab02/image5.png
.. |image6| image:: media/lab02/image6.png
.. |image7| image:: media/lab02/image7.png
.. |image8| image:: media/lab02/image8.png
.. |image9| image:: media/lab02/image9.png
.. |image10| image:: media/lab02/image10.png
.. |image11| image:: media/lab02/image11.png
.. |image12| image:: media/lab02/image12.png
.. |image13| image:: media/lab02/image13.png
.. |image14| image:: media/lab02/image14.png
.. |image15| image:: media/lab02/image15.png
.. |image16| image:: media/lab02/image16.png
.. |image17| image:: media/lab02/image17.png
.. |image18| image:: media/lab02/image18.png
.. |image19| image:: media/lab02/image19.png
.. |image20| image:: media/lab02/image20.png
.. |image21| image:: media/lab02/image21.png
.. |image22| image:: media/lab02/image22.png
.. |image23| image:: media/lab02/image23.png
.. |image24| image:: media/lab02/image24.png
.. |image25| image:: media/lab02/image25.png
.. |image26| image:: media/lab02/image26.png
.. |image27| image:: media/lab02/image27.png
.. |image28| image:: media/lab02/image28.png
.. |image29| image:: media/lab02/image29.png
.. |image30| image:: media/lab02/image30.png
.. |image31| image:: media/lab02/image31.png
.. |image32| image:: media/lab02/image32.png
.. |image33| image:: media/lab02/image33.png
.. |image34| image:: media/lab02/image34.png
.. |image35| image:: media/lab02/image35.png
.. |image36| image:: media/lab02/image36.png
.. |image37| image:: media/lab02/image37.png
.. |image38| image:: media/lab02/image38.png
.. |image39| image:: media/lab02/image39.png
.. |image40| image:: media/lab02/image40.png
.. |image41| image:: media/lab02/image41.png
.. |image42| image:: media/lab02/image42.png
.. |image43| image:: media/lab02/image43.png
.. |image44| image:: media/lab02/image44.png
.. |image45| image:: media/lab02/image45.png
.. |image46| image:: media/lab02/image46.png
.. |image47| image:: media/lab02/image47.png
.. |image48| image:: media/lab02/image48.png
.. |image49| image:: media/lab02/image49.png
.. |image50| image:: media/lab02/image50.png
.. |image51| image:: media/lab02/image51.png
.. |image52| image:: media/lab02/image52.png
.. |image53| image:: media/lab02/image53.png
.. |image54| image:: media/lab02/image54.png
.. |image55| image:: media/lab02/image55.png
.. |image56| image:: media/lab02/image56.png
.. |image57| image:: media/lab02/image57.png
.. |image58| image:: media/lab02/image58.png
.. |image59| image:: media/lab02/image59.png
.. |image60| image:: media/lab02/image60.png
.. |image61| image:: media/lab02/image61.png
.. |image62| image:: media/lab02/image62.png
.. |image63| image:: media/lab02/image63.png

