Publish and protect Bluesky app
###############################

Let's start with ``Bluesky`` application. Reminder, Bluesky does not have any ``Authentication`` enabled. 

#. Connect to BIG-IP HTTPS user interface from UDF as ``admin`` and password ``admin``
#. In ``Access`` > ``Guided Configuration``, select ``Microsoft Integration`` > ``Azure AD application`` 

   .. image:: ../pictures/AGC.png
      :align: center

Configuration Properties
************************

#. Click ``Next`` and start the configuration
#. Configure the page as below

   #. Configuration Name : ``IIS-Bluesky-<My Name>``  Why my name ? Because this app will be created in Azure AD tenant. And we need to differentiate all apps. Example : ``IIS-Bluesky-Matt``
   #. In ``Azure Service Account Details``, Select ``Copy Account Info form Existing Configuration``, and select ``IIS-baseline``, then click ``Copy``

      .. image:: ../pictures/module1/IIS-baseline.png
         :align: center
         :scale: 50%

      
      .. note:: In a real world, you will set here the values from the Azure Service Application created for APM. You have to create an Azure Application so that APM gets access to Microsoft Graph API. But for **security concerns**, I can't show in this lab the application secret.

      .. note:: The steps to create this Azure applications are below

         #. In Azure AD, create a service application under your organization's tenant directory using App Registration.
         #. Register the App as Azure AD only single-tenant.
         #. Request permissions for Microsoft Graph APIs and assign the following permissions to the application:
            
            #. Application.ReadWrite.All
            #. Application.ReadWrite.OwnedBy
            #. Directory.Read.All
            #. Group.Read.All
            #. Policy.Read.All
            #. Policy.ReadWrite.ApplicationConfiguration
            #. User.Read.All
         #. Grant admin consent for your organization's directory.
         #. Copy the Client ID, Client Secret, and Tenant ID and add them to the Azure AD Application configuration.

   #. Click ``Test Connection`` button --> Connection is valid

      .. image:: ../pictures/module1/test_conn.png
         :scale: 50%

   #. Click ``Next``


Service Provider
****************

#. Configure the page as below

   #. Host ``bluesky.f5access.onmicrosoft.com``
   #. Entity ID is auto-filled ``https://bluesky.f5access.onmicrosoft.com/IIS-Bluesky-my name>``

      .. image:: ../pictures/module1/SP.png
         :scale: 50%

   #. Click ``Save & Next``


Azure Active Directory
**********************

#. Select ``Azure BIG-IP APM Azure AD...`` template

   .. note :: As you can notice, there are several templates available for different applications. Here, in this lab, we will publish a generic app. So we select the first template.

#. Click ``Add``
#. In the new screen, configure as below

   #. Signing Key : ``default.key``
   #. Signing Certificate : ``default.crt``
   #. Signing Key Passphrase : ``F5twister$``

      .. image:: ../pictures/module1/signing.png
         :scale: 50%

   #. In ``User And User Groups``, click ``Add``

      .. note :: We have to assign Azure AD users/group to this app, so that they can be allowed to connect to it.

      #. In the list, click ``Add`` for the user ``user1``. If you can't find it, search for it in the ``search`` field.
         
         .. image:: ../pictures/module1/user.png
            :align: center
         

      #. Click ``Close``
      #. You can see ``user1`` in the list.

         .. image:: ../pictures/module1/user1.png
            :align: center
         

      #. Click ``Save & Next``

Virtual Server Properties
*************************

#. Configure the VS as below

   #. IP address : ``10.1.10.104``
   #. ``ClientSSL`` profile. We will get a TLS warning in the browser, but it does not matter for this lab.

   .. image:: ../pictures/module1/VS.png
      :align: center

#. Click ``Save & Next``


Pool Properties
***************

#. Select ``Create New``
#. In Pool Servers, select ``/Common/10.1.20.9`` This is the IIS server.

   .. image:: ../pictures/module1/pool.png
      :align: center


Session Management Properties
*****************************

#. Nothing to change, click ``Save & Next``

Deploy your app template
************************

#. Click ``Deploy``

   .. image:: ../pictures/module1/deploy.png
      :align: center
   

#. Behind the scene, the deployment creates an ``Azure Enterprise Application`` for ``Bluesky``. We can see it in ``Azure portal`` (you don't have access in this lab). With this Enterprise Application, Azure knows where to redirect the user when authenticated. And this app has the certificate and key used to sign the SAML assertion.

   .. image:: ../pictures/module1/azure_portal.png
      :align: center
      :scale: 50%


Test your deployment
********************

#. RDP to Win10 machine as ``user`` and password ``user``
#. Open ``Microsoft Edge`` browser - icon is on the Desktop
#. Click on the ``bookmark`` ``Bluesky``
#. You will be redirected to Azure AD login page. Login as ``user1@f5access.onmicrosoft.com``, and for the password please ask to the instructor.

   .. warning :: Don't reset or change the password so that all students can use it.

   .. image:: ../pictures/module1/login.png
      :align: center
      :scale: 50%
   

#. You are redirected to APM with a SAML assertion, and can access to Bluesky application

   .. image:: ../pictures/module1/bluesky.png
      :align: center
      :scale: 50%
