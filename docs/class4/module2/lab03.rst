Lab 3: Add a Webtop link to an existing Webtop
==============================================


In this lab your will learn about the API calls necessary to modify an existing webtop by adding a new link to the Access Policy .  The graphic below depicts the basic flow required for modifying the existing policy via API.

    |image100|

Access Lab Environment
-------------------------

To access your dedicated student lab environment, you will need a web browser and Remote Desktop Protocol (RDP) client software. The web browser will be used to access the Unified Demo Framework (UDF) Training Portal. The RDP client will be used to connect to the jumphost, where you will be able to access the BIG-IP management interfaces (HTTPS, SSH).

#. Click **DEPLOYMENT** located on the top left corner to display the environment

#. Click **ACCESS** next to jumphost.f5lab.local

    |image101|

#. Select your RDP resolution.

#. The RDP client on your local host establishes a RDP connection to the Jumphost.

#. Login with the following credentials:

         - User: **f5lab\\user1**
         - Password: **user1**


Task 1 - Import Postman Collections
-----------------------------------------------------------------------

#. From the Jumpbox, open **Postman** via the desktop shortcut or toolbar at the bottom

    .. note::  Dismiss any prompts to update Postman.

    |image001|

#. Click **Yes** if prompted for "Do you want to allow this app to make changes to your device?"

    |image002|

#. Click **Import** located on the top left of the Postman application

    |image003|

#.  Click **Upload Files**

    |image004|

#. Navigate to C:\\access-labs\\class4\\module2\\student_files, select **student-class4-module2-lab3.postman_collection.json**, and click **Open**

    |image005|

#.  Click **Import**

    |image006|

#. A collection called **student-class4-module2-lab3** will appear on the left side in Postman


Task 2 - Create A Webtop Policy
-----------------------------------------------------------------------

#.  Hover over the collection name **student-class4-module2-lab3** with your mouse and click the **Arrow** icon.

    |image007|

#. Click the **Create Policy** folder.

    |image008|

#.  Click the blue **Run** button and Postman Runner will open.

    |image009|

#. Click the blue button **Run student-class...** and the API requests will start being sent to the BIG-IP.

    |image010|

#. The **Pass** circle will display a value 10.
#. Close Runner by clicking the **X** in the top right corner.

    |image011|

#. From the jumphost, ppen a browser and navigate to https://bigip1.f5lab.local

#. Login to the BIG-IP GUI with the following credentials:

        - Username: **admin**
        - Password: **admin**

#. Navigate to Access>>Profiles/Policies>>Access Profiles (Per-Session Policies).  Do not click the **+** (plus symbol).

    |image012|

#. The policy **class4-module2-lab3-psp** you created via automation is displayed.  Click **Edit** to view the policy in Visual Policy Editor(VPE).

    |image013|

#. The policy was successfully deployed using SAML Authenticaiton and an Advanced Resource Assign. Click on the **Advanced Resource Assign** action.

    |image014|

#. The Advanced Resource Assign contains a webtop and a single webtop link.

    |image015|


Task 3 - Create a Webtop Link
-----------------------------------------------------------------------

#. From Postman, expand the **student-class4-module2-lab3** collection and then the **Create Webtop Link** subfolder.

    |image016|

#. Click the request **bigip-create-customization group-resource** and then **Body**.  The body of this request specifies that we will be creating a webtop link resource.

    .. note:: One thing to note, all webtop link resources use "/Common/standard" as the source type even if the policy is using "/Common/Modern".

    |image017|

#. Click the blue **send** button in the upper right corner.  You will receive a 200 OK status code with a response body.  This is an indication that the customization group was created.

    |image018|

#. Click the request **bigip-create-webtop-link** and then **Body**.  The body of this request creates the webtop link Resource.  The applicationUri JSON key contains the resource destination.  The Postman Variable ((DNS3_NAME)) is set to server2.acme.com

    |image019|

#. Click the blue **send** button in the upper right corner.  You will receive a 200 OK status code with a response body.  This is an indication that the webtop link resource was created.

    |image020|

Task 4 - Add a webtop to an Advanced Resource Assign
-----------------------------------------------------------------------

    .. note::  When creating or modifying a policy it must be performed within a transaction.  A transaction occurs in multiple steps.  First, you create the transaction by receiving a transaction ID from the BIG-IP.  Next, you pass subsequent configuration requests that contain the transaction ID header to the BIG-IP.  The BIG-IP does not process these requests.  Instead it holds those requests until the transaction is commited in the final step.  It's important to understand that transactions have an all or nothing approach.  Either every request in the transaction is processed sucessfully or none of the configuration changes are made.  This is extremely important to ensure all the required information is there for building a working policy. To understand more about transactions please review :ref:`The Explore the icontrolRest Endpoints of lab 1<class4-module2-lab1-endpoints>`



#. Expand the **Modify Policy** folder.  Since the only change to the policy is the addition of a single webtop link you will only review that single request. Expand the **Modify Advanced Resource Assign** subfolder.

    |image021|

#.  Click **bigip-create-agent-adv resource assign** and then **Body**.

#.  The request method is a PATCH since the advanced resource assign agent exists.  We do not want to create the agent, but modify an existing agent.

#. The request body is the same as the request used to create the advanced resource assign agent.  The only difference is the addition of the new webtop resource.

    |image022|

#.  Hover over the Collection name **student-class4-module2-lab3** with your mouse and click the **Arrow** icon.

    |image023|

 #. Click **student-class4-module2-lab3** to return to the main folder if you are not already there.

    |image033|

#. Click the **Modify Policy** folder. You will see four subfolders in the folder.

    |image024|

#.  Click the blue **Run** button and Postman Runner will open.

    |image025|

#. Click the blue button **Run student-class...** and the API requests will start being sent to the BIG-IP.

    |image026|

#. The **Pass** circle will display a value 2.
#. Close Runner by clicking the **X** in the top right corner.

    |image027|

#. From the jumphost, open a browser and navigate to https://bigip1.f5lab.local

#. Login to the BIG-IP GUI with the following credentials:

        - Username: **admin**
        - Password: **admin**

#. Navigate to Access>>Profiles/Policies>>Access Profiles (Per-Session Policies).  Do not click the **+** (plus symbol).

    |image012|

#. Click **Edit**  to the right of **class4-module2-lab3-psp** to view the policy in Visual Policy Editor(VPE).

    |image013|

#. Click on the **Advanced Resource Assign** action to display the changes.

    |image014|

#.  The Advanced Resource Assign now has two Webtop Links.  If we wanted to remove the link we would simply send a new request using the PATCH method that didn't contain the resource inside a transaction.

    |image028|


Task 4 - Lab Cleanup
------------------------

#.  Hover over the Collection name **student-class4-module2-lab3** with your mouse and click the **Arrow** icon.

    |image023|

 #. Click **student-class4-module2-lab3** to return to the main folder if you are not already there.

    |image034|


#. Click the **Lab Cleanup** folder.

    |image029|

#.  Click the blue **Run** button and Postman Runner will open.

    |image030|

#. Click the blue button **Run student-class...** and the API requests will start being sent to the BIG-IP.

    |image031|

#. The **Pass** circle will display a value 7.

    |image032|

#. From Postman, Click the **3 dots** on the bottom right of the student-class4-module2-lab3 Collection.

#. Click **Delete**

    |image035|

This concludes our lab on modifying a webtop via automation.


   |image000|



.. |image000| image:: media/lab03/000.png
.. |image001| image:: media/lab03/001.png
.. |image002| image:: media/lab03/002.png
.. |image003| image:: media/lab03/003.png
.. |image004| image:: media/lab03/004.png
.. |image005| image:: media/lab03/005.png
.. |image006| image:: media/lab03/006.png
.. |image007| image:: media/lab03/007.png
.. |image008| image:: media/lab03/008.png
.. |image009| image:: media/lab03/009.png
.. |image010| image:: media/lab03/010.png
.. |image011| image:: media/lab03/011.png
.. |image012| image:: media/lab03/012.png
.. |image013| image:: media/lab03/013.png
.. |image014| image:: media/lab03/014.png
.. |image015| image:: media/lab03/015.png
.. |image016| image:: media/lab03/016.png
.. |image017| image:: media/lab03/017.png
.. |image018| image:: media/lab03/018.png
.. |image019| image:: media/lab03/019.png
.. |image020| image:: media/lab03/020.png
.. |image021| image:: media/lab03/021.png
.. |image022| image:: media/lab03/022.png
.. |image023| image:: media/lab03/023.png
.. |image024| image:: media/lab03/024.png
.. |image025| image:: media/lab03/025.png
.. |image026| image:: media/lab03/026.png
.. |image027| image:: media/lab03/027.png
.. |image028| image:: media/lab03/028.png
.. |image029| image:: media/lab03/029.png
.. |image030| image:: media/lab03/030.png
.. |image031| image:: media/lab03/031.png
.. |image032| image:: media/lab03/032.png
.. |image033| image:: media/lab03/033.png
.. |image034| image:: media/lab03/034.png
.. |image035| image:: media/lab03/035.png
.. |image100| image:: media/lab03/100.png
.. |image101| image:: media/lab03/101.png
