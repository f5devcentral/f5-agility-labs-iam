Publish and protect Vanilla app
###############################

Let's continue with ``Vanilla`` application. Reminder, Vanilla application as ``Authentication`` enabled with Kerberos auth. So, we will need to enable ``Kerberos Constrained Delegation``. 

#. Connect to BIG-IP HTTPS user interface from UDF as ``admin`` and password ``admin``
#. In ``Access`` > ``Guided Configuration``, select ``Microsoft Integration`` > ``Azure AD application`` 

   .. note :: As you can notice, we deploy one template per application

   .. image:: ../pictures/AGC.png
      :align: center

Configuration Properties
************************

#. Click ``Next`` and start the configuration
#. Configure the page as below

   #. Configuration Name : ``IIS-Vanilla-<My Name>``  Why my name ? Because this app will be created in Azure AD tenant. And we need to differentiate all apps. 
   #. Enable ``Single Sign-on (SSO)``

        .. image:: ../pictures/module2/SSO.png
           :align: center
           :scale: 50%
      

   #. In ``Azure Service Account Details``, Select ``Copy Account Info form Existing Configuration``, and select ``IIS-baseline``, then click ``Copy``

      .. image:: ../pictures/module2/IIS-baseline.png
         :align: center
         :scale: 50%

      
      .. note:: In a real world, you will set here the values from the Azure Service Application created for APM. You have to create an Azure Application so that APM get access to Microsoft Graph API. But for **security concerns**, I can't show in this lab the application secret.

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

      .. image:: ../pictures/module2/test_conn.png
         :scale: 50%

   #. Click Next


Service Provider
****************

#. Configure the page as below

   #. Host ``vanilla.f5access.onmicrosoft.com``
   #. Entity ID is auto-filled ``https://vanilla.f5access.onmicrosoft.com/IIS-Bluesky-my name>``

      .. image:: ../pictures/module2/SP.png
         :scale: 50%

   #. Click ``Save & Next``


Azure Active Directory
**********************

#. Select ``Azure BIG-IP APM Azure AD...`` template

   .. note :: As you can notice, there are several templates available for different applications. Here, in this lab, we will publish a generic app. So we select the first template.

#. Click ``Add``
#. In the new screen, configure as below.

   #. Signing Key : ``default.key``
   #. Signing Certificate : ``default.crt``
   #. Signing Key Passphrase : ``F5twister$``

      .. image:: ../pictures/module2/signing.png
         :scale: 50%

   #. In ``User And User Groups``, click ``Add``

      .. note :: We have to assign Azure AD users/group to this app, so that they can be allowed to connect to it.

      #. In the list, click ``Add`` for the user ``user1``. If you can't find it, search for it in the ``search`` field.
         
         .. image:: ../pictures/module2/user.png
            :align: center
         

      #. Click ``Close``
      #. You can see ``user1`` in the list.

         .. image:: ../pictures/module2/user1.png
            :align: center

      #. Click ``Save & Next``

Virtual Server Properties
*************************

#. Configure the VS as below

   #. IP address : ``10.1.10.103``
   #. ``ClientSSL`` profile. We will get a TLS warning in the browser, but it does not matter for this lab.

   .. image:: ../pictures/module2/VS.png
      :align: center

#. Click ``Save & Next``


Pool Properties
***************

#. Select ``Create New``
#. In Pool Servers, select ``/Common/10.1.20.9`` This is the IIS server.

   .. image:: ../pictures/module2/pool.png
      :align: center


Single Sign-On Settings
***********************

#. In ``Selected Single Sign-on Type``, select ``Kerberos``, and select ``Advanced Settings``

    .. image:: ../pictures/module2/SSO1.png
       :align: center    

#. In ``Credentials Source``, fill as below

    #. Username Source : ``session.saml.last.identity``
    #. Delete User Realm Source value - keep it empty. The domain is similar between Azure AD and on-prems AD.

#. In ``SSO Method Configuration``, fill as below

    #. Kerberos Realm : ``f5access.onmicrosoft.com``
    #. Account name : ``host/apm-deleg.f5access.onmicrosoft.com``
    #. Account Password : ``F5twister$``
    #. KDC : ``10.1.20.8``
    #. UPN Support : ``Enaled``
    #. SPN Pattern : ``HTTP/%s@f5access.onmicrosoft.com``

        .. image:: ../pictures/module2/SSO2.png
           :align: center  

#. Click ``Save & Next``



Session Management Properties
*****************************

#. Nothing to change, click ``Save & Next``

Deploy your app template
************************

#. Click ``Deploy``

   .. image:: ../pictures/module2/deploy.png
      :align: center
   

#. Behind the scene, the deployment creates an ``Azure Enterprise Application`` for ``Bluesky``. We can see it in ``Azure portal`` (you don't have access in this lab). With this Enterprise Application, Azure knows where to redirect you when authenticated. And this app has the certificate and key used to sign the SAML assertion.

   .. image:: ../pictures/module2/azure_portal.png
      :align: center
      :scale: 50%


Test your deployment
********************

#. RDP to Win10 machine as ``user`` and password ``user``
#. Open ``Microsoft Edge`` browser - icon is on the Desktop
#. Click on the ``bookmark`` ``Vanilla``
#. You will be redirected to Azure AD login page - only if your previous session with ``Bluesky`` expired in APM. Login as ``user1@f5access.onmicrosoft.com``, and for the password please ask to your instructor (if you are prompted). But as you already authenticated against Azure AD, you still have a session in Azure AD.

   .. image:: ../pictures/module1/login.png
      :align: center
      :scale: 50%
   

#. You are redirected to APM with a SAML assertion, and can access to Vanilla application.
#. APM did ``Single Sign-on`` with Vanilla application (Kerberos Constrained Delegation)

    .. image:: ../pictures/module2/vanilla.png
      :align: center
      :scale: 50%
    

#. Click ``Bluesky`` bookmark, you can access ``Bluesky`` application as well.
#. Extra lab, enable ``Inspect mode`` in Edge, and follow the SAML redirections to understand the workflow.
