Lab 4: ADFS Proxy using ADFS Authentication
=============================================


Task 1 - Setup Lab Environment
-----------------------------------

To access your dedicated student lab environment, you will require a web browser and Remote Desktop Protocol (RDP) client software. The web browser will be used to access the Lab Training Portal. The RDP client will be used to connect to the Jump Host, where you will be able to access the BIG-IP management interfaces (HTTPS, SSH).

#. Click **DEPLOYMENT** located on the top left corner to display the environment

#. Click **ACCESS** next to jumpohost.f5lab.local

   |image001|

#. Select your RDP resolution.

#. The RDP client on your local host establishes a RDP connection to the Jumphost.

#. Login with the following credentials:

         - User: **f5lab\\user1**
         - Password: **user1**

#. After successful logon the Chrome browser will auto launch opening the site https://portal.f5lab.local.  This process usually takes 30 seconds after logon.

#. Click the **Classes** tab at the top of the page.

	|image002|


#. Scroll down the page until you see **203 Microsoft Integrations** on the left

   |image003|

#. Hover over tile **ADFS Proxy using ADFS Authentication**. A start and stop icon should appear within the tile.  Click the **Play** Button to start the automation to build the environment

   +---------------+-------------+
   | |image004|    | |image005|  |
   +---------------+-------------+

#. The screen should refresh displaying the progress of the automation within 30 seconds.  Scroll to the bottom of the automation workflow to ensure all requests succeeded.  If you experience errors try running the automation a second time or open an issue on the `Access Labs Repo <https://github.com/f5devcentral/access-labs>`__.

   |image006|

Task 2 - Access the Microsoft ADFS guided configuration
------------------------------------------------------------

#. From the jumphost browser navigate to https://bigip1.f5lab.local

#. Login with the following credentials:

   - username **admin**
   - password **admin**

#. Click on the **Access** tab located on the left side.

    |image007|

#. Click **Guided Configuration**

    |image008|

#. Click **Microsoft Integration**

    |image009|

#. Click **ADFS Proxy**

    |image010|

#. Click **Next**

    |image011|

Task 3 - ADFS Proxy Settings
-----------------------------
#. Enter the Configuration Name **ADFS_PROXY**
#. Enter the ADFS FQDN **adfs.acme.com**
#. Select the Authenticatin Method **ADFS Authentication**
#. Click **Save & Next**

    |image012|


Task 4 - Virtual Server Properties
------------------------------------

#. Enter the Destination Address **10.1.10.101**
#. Select the Client SSL Certificate **acme.com-wildcard**
#. Select the Associated Private Key **acme.com-wilcard**
#. From the Trusted Certificate Authorities for Client Authentication dropdown select **ca.f5lab.local** 
#. Click **Save & Next**

    |image013|


Task 5 - ADFS Server Pool Properties
-------------------------------------

#. Enter the IP address **10.1.20.13**
#. Click **Save & Next**

    |image014|

Task 6 - Summary
-----------------

#. Click **Deploy**

    |image015|

#. Click **Establish Trust**

    |image016|

#. Enter the Username **admin**
#. Enter the Password **admin**
#. Click **Establish Trust**

    |image017|

#. A certificate appears under the **Establish Trust** section signifying the trust was successfully established. 
#. Click **Finish** 

    |image018|

#.  The configuration has been successfully deployed

    |image019|



Task 7 - Test username and password Authenticaiton
---------------------------------------------------


#. On the jumphost open a webbrowser and navigate to https://sp.acme.com.  You will redirected to https://adfs.acme.com
#. Enter the username **user1@f5lab.local**
#. Enter the password **user1**
#. Click **Sign in**

    |image020|

#.  After successful login at ADFS you redirected to http://sp.acme.com

    |image021|

    


Task 8 - Test Certificate authentication
-----------------------------------------

#. Close the browser completely from the previous test or open a new tab in ingonito(private) view
#.  On the jumphost open a webbrowser and navigate to https://sp.acme.com.  You will redirected to https://adfs.acme.com
#. Select **Sign in using an X.509 Certificate**

    |image022|

#. Select the **user1** certificate
#. Click **OK**

    |image023|

#.  After successful login at ADFS you redirected to http://sp.acme.com

    |image021|

Task 9 - Lab Cleanup
---------------------

#. From the jumphost browser navigate to https://bigip1.f5lab.local

#. Login with the following credentials:

   - username **admin**
   - password **admin**

#. Navigate to **Access -> Guided Configuration** in the left-hand menu. 

    |image008|

                                                                        
#. Click the **Undeploy** button  

    |image024|

                                                                            
#. Click **OK** when asked, "Are you sure you want to undeploy this configuration?"   

    |image025|       

#. Click the **Delete** button once the deployment is undeployed    

    |image026|

#. Click **OK** when asked, "Are you sure you want to delete this configuration?"     

    |image027|       

#. The Configuration section should now be empty  

    |image028|

#. From a browser on the jumphost navigate to https://portal.f5lab.local                     
                                                                                            
#. Click the **Classes** tab at the top of the page.  

    |image002|

#. Scroll down the page until you see **203 - Microsoft Integration** on the left     

    |image003|

#. Hover over the tile **AADFS Authentication**. A start and stop icon should appear within the tile.  Click the **Stop** Button to start the automation to delete any prebuilt objects                                                                  

    +---------------+-------------+
    | |image004|    | |image029|  |
    +---------------+-------------+

#. The screen should refresh displaying the progress of the automation within 30 seconds. Scroll to the bottom of the automation workflow to ensure all requests succeeded. If you you experience errors try running the automation a second time or open an issue on the `Access Labs Repo <https://github.com/f5devcentral/access-labs>`__.                      

    |image030|

#. This concludes Lab 2.   

    |image000|


.. |image000| image:: ./media/lab02/000.png
.. |image001| image:: ./media/lab02/001.png
.. |image002| image:: ./media/lab02/002.png
.. |image003| image:: ./media/lab02/003.png
.. |image004| image:: ./media/lab02/004.png
.. |image005| image:: ./media/lab02/005.png
.. |image006| image:: ./media/lab02/006.png
.. |image007| image:: ./media/lab02/007.png
.. |image008| image:: ./media/lab02/008.png
.. |image009| image:: ./media/lab02/009.png
.. |image010| image:: ./media/lab02/010.png
.. |image011| image:: ./media/lab02/011.png
.. |image012| image:: ./media/lab02/012.png
.. |image013| image:: ./media/lab02/013.png
.. |image014| image:: ./media/lab02/014.png
.. |image015| image:: ./media/lab02/015.png
.. |image016| image:: ./media/lab02/016.png
.. |image017| image:: ./media/lab02/017.png
.. |image018| image:: ./media/lab02/018.png
.. |image019| image:: ./media/lab02/019.png
.. |image020| image:: ./media/lab02/020.png
.. |image021| image:: ./media/lab02/021.png
.. |image022| image:: ./media/lab02/022.png
.. |image023| image:: ./media/lab02/023.png
.. |image024| image:: ./media/lab02/024.png
.. |image025| image:: ./media/lab02/025.png
.. |image026| image:: ./media/lab02/026.png
.. |image027| image:: ./media/lab02/027.png
.. |image028| image:: ./media/lab02/028.png
.. |image029| image:: ./media/lab02/029.png
.. |image030| image:: ./media/lab02/030.png

