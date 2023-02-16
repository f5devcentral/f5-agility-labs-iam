Lab 2: Onboard a Second Application(15.1)
======================================================

Guided Configuration supports more than a single application per Identity Aware Proxy Deployment.  In this module you will learn how to modify an existing IAP deployment  to onboard new authentication methods, SSO methods, and applications.

This Module also introduces the **Application Group** (skipped in the previous module) to provide different contextual access controls on parts of a website.



Section 2.1 - Access Guided Configuration
--------------------------------------------

To onboard a new application to the IAP, you will first access the Guided Configuration menu.

Task 1 - Access the Zero Trust IAP guided configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. From the web browser, click on the **Access** tab located on the left side.

   |image0|

#. Click **Guided Configuration**

   |image1|

#. Click **IAP_DEMO**

   |image2|


Section 2.2 - User Identity
------------------------------------------------

Adding an additional User Identity to IAP is just a few simple steps.

Task 1 - Configure Certificate Authentication with OCSP
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. Click **User Identity** in the Ribbon

    |image3|

#. Click **Add** to create a new User Identity

    |image4|

#. Enter Name **ocsp**
#. Select **On-Demand Certificate Authentication** from the Authentication Type dropdown
#. Select **OCSP Responder** from the Authentication Server Type dropdown
#. Select **ocsp-servers** from the Authentication Server dropdown
#. Leave **Request** selected under Choose Auth Mode
#. Click **Save**

    |image5|

#. Verify the **ocsp** object was created

    |image6|


Section 2.3 - SSO & HTTP Header
------------------------------------------------

In this section, you will create a custom header value to pass to the web server.

Task 1 - Create Custom Header
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. Click **SSO & HTTP Header** from the Ribbon.

   |image7|

#. Click **Add** to create a new header object.

   |image8|

#. Enter Name **header_sso**
#. Change radio button for Type to **HTTP Headers**
#. In the **SSO Headers** section, enter **userID** in the Header Name Field
#. Click **Save**

   |image9|

#. Verify the **header_sso** object was created

   |image10|


Section 2.4 - Applications
------------------------------------------------

In this section you will define a second application with subpaths.

Task 1 - Configure Application header.acme.com
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. Click the **Applications** icon from the ribbon.

   |image11|

#. Click **Add** to create a new application

   |image12|

#. Click **Show Advanced Setting** in the top right corner to see additional properties
#. Enter Name **header.acme.com**
#. Enter FQDN **header.acme.com**
#. Enter Subpath Pattern **/admin.php**
#. Under Pool Configuration, you will create a node by entering **10.1.20.6** in the IP Address/Node name field. **Note** This may already exist in the drop down menu.
#. Verify the pool member properties of Port **443** and Protocol **HTTPS**
#. Click **Save**

	.. note:: Subpaths are used in Application Groups to define contextual access on 	portions of an application (separate from the default contextual Access Policy).  	If necessary, an application can be split up into multiple Application Groups to 	meet an organization's access control needs.

    |image13|

#. On the Applications menu, enter Auth Domain **iap1.acme.com**
#. Verify **header.acme.com** was created.

   |image14|


Section 2.5 - Application Groups
------------------------------------------------

In this section you will configure two Application groups to enforce different policies on parts of the header.acme.com website.

Task 1 - Create header-ad Group
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. Click **Application Groups** from the ribbon.

   |image15|

#. Check **Enable Application Groups**

  |image16|

#. Enter Name **header-ad**
#. Under Applications List, select **/** and click the arrow to move it into the Selected box
#. Click **Save**

   |image17|

Task 2 - Create header-ocsp Group
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. Click **Add** to create a second application group

   |image18|

#. Enter Name **header-ocsp**
#. Under Applications List, select **/admin.php** and click the arrow to move it into the Selected box
#. Click **Save**

   |image19|

#. Verify both applications groups have been created.
#. Click **Save & Next**

   |image20|

Section 2.6 - Contextual Access
------------------------------------------------

In this section you will configure Contextual Access for the previously created Application Groups


Task 1 - Configure Contextual Access for header_ad Group
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. Click **Contextual Access** from the ribbon

   |image21|

#. Click **Add**

   |image22|

#. Enter Name **header-ad**
#. Select **Application Group** from the Resource Type dropdown
#. Select **header-ad** from the Resource dropdown
#. Select **ad** from the Primary Authentication dropdown
#. Select **header_sso** from the HTTP_Header dropdown
#. Click **Save**

   |image23|

Task 2 - Configure Contextual Access for header-ocsp Group
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. Click **Add**

   |image24|

#. Enter Name **header-ocsp**
#. Select **Application Group** from the Resource Type dropdown
#. Select **header-ocsp** from the Resource dropdown
#. Select **ad** from the Primary Authentication dropdown
#. Select **header_sso** from the HTTP_Header dropdown
#. Check **Enable Additional Checks**

   |image25|

#. Click **Add** to add a Trigger Rule

   |image26|

#. Enter Name **webadmin-group**
#. Check **User Group Check**
#. Locate the **Website Admin** group

   .. tip:: Try using the filter field to search

#. Click **Add** under the Action column

   |image28|

#. Select **Step Up** from the Match Action dropdown
#. Select **ocsp** from the Step Up Authentication dropdown
#. Click **Save**
#. Click **Save** again to save the Contextual Access Properties for ocsp-header-iap.acme.com

   |image29|

#. Click **Deploy** located under the ribbon. Deployment will take a few moments.

   |image27|


Section 2.7 - Testing
-----------------------

In this section you will use user1's credentials to default website header.acme.com.  However, when you attempt to access the admin page you will be prompted for certificate based authentication.  After a successful login you will close your browser and login to default website using user2's credentials.  User2 will be denied due to not having the correct AD groups.

Task 1 - Login to header.acme.com using user1
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. Open a new browser tab
#. Access the site https://header.acme.com
#. At the logon page enter the Username: **user1** and Password: **user1**
#. Click **Logon**

   |image30|

#. Notice the custom header **UserID** has a value of user1

   |image31|

#. Access the **admin** portion of the website https://header.acme.com/admin.php
#. Select the certificate **user1**
#. Click **OK**

   |image33|

#. You should be successfully logged into the **admin** portion of the site.

   |image37|

#. Close the browser completely.

Task 2 - Login to header.acme.com using user2
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. Open a new browser window.
#. Access the site https://header.acme.com
#. At the logon page enter the Username: **user2** and Password: **user2**
#. Click **Logon**

   |image34|

#. Notice the custom header **UserID** has a value of user2

   |image35|

#. Access the **admin** portion of the website https://header.acme.com/admin.php
#. You receive a **Access Denied** page due to not having the correct group membership

   |image36|

#. This concludes lab 2.

   |image100|



.. |image100| image:: ./media/lab01/100.png

.. |image0| image:: ./media/lab02/image000.png
	:width: 800px
.. |image1| image:: ./media/lab02/image001.png
.. |image2| image:: ./media/lab02/image002.png
	:width: 800px
.. |image3| image:: ./media/lab02/image003.png
	:width: 1000px
.. |image4| image:: ./media/lab02/image004.png
.. |image5| image:: ./media/lab02/image005.png
.. |image6| image:: ./media/lab02/image006.png
.. |image7| image:: ./media/lab02/image007.png
.. |image8| image:: ./media/lab02/image008.png
.. |image9| image:: ./media/lab02/image009.png
.. |image10| image:: ./media/lab02/image010.png
.. |image11| image:: ./media/lab02/image011.png
.. |image12| image:: ./media/lab02/image012.png
.. |image13| image:: ./media/lab02/image013.png
.. |image14| image:: ./media/lab02/image014.png
.. |image15| image:: ./media/lab02/image015.png
.. |image16| image:: ./media/lab02/image016.png
.. |image17| image:: ./media/lab02/image017.png
.. |image18| image:: ./media/lab02/image018.png
.. |image19| image:: ./media/lab02/image019.png
.. |image20| image:: ./media/lab02/image020.png
.. |image21| image:: ./media/lab02/image021.png
.. |image22| image:: ./media/lab02/image022.png
.. |image23| image:: ./media/lab02/image023.png
.. |image24| image:: ./media/lab02/image024.png
.. |image25| image:: ./media/lab02/image025.png
.. |image26| image:: ./media/lab02/image026.png
.. |image27| image:: ./media/lab02/image027.png
.. |image28| image:: ./media/lab02/image028.png
.. |image29| image:: ./media/lab02/image029.png
.. |image30| image:: ./media/lab02/image030.png
.. |image31| image:: ./media/lab02/image031.png
.. |image32| image:: ./media/lab02/image032.png
.. |image33| image:: ./media/lab02/image033.png
.. |image34| image:: ./media/lab02/image034.png
.. |image35| image:: ./media/lab02/image035.png
.. |image36| image:: ./media/lab02/image036.png
.. |image37| image:: ./media/lab02/image037.png
