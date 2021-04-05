Class 3 - Leverage Azure AD to protect Cloud Apps
#################################################

In this class, we will check that ``user1`` can access any cloud app federated with Azure AD.

The current config
******************

In a real world, companies deploy applications ``on-prems`` and in ``public clouds``. If the company uses **Azure AD as IDaaS**, it will federate all cloud apps with this Azure AD tenant.

This is what we prepared for you in this lab. This application is **federated** with our Azure AD tenant.

You have **nothing** to configure on APM side, as everything is dealed between the ``cloud app`` and ``Azure AD``. In Azure portal, we configured ``Oauth`` for the cloud app, so that every user reaching this app will be redirected to Azure login page.

   .. image:: ./pictures/OIDC.png
      :align: center
      :scale: 50%

Test your deployment
********************

#. RDP to Win10 machine as ``user`` and password ``user``
#. Open ``Microsoft Edge`` browser - icon is on the Desktop
#. Click on the ``bookmark`` ``Wordpress Cloud App``
#. You will be redirected to Azure AD login page (it can take a while - look at the address bar). Login as ``user1@f5access.onmicrosoft.com``, and password ``F5twister$``, if prompted. You already have a session up and running in Azure AD, from previous class.
#. You are redirected to the ``cloud app`` in Azure cloud, and can access to Wordpress-UDF application.

   .. image:: ./pictures/WP.png
      :align: center
      :scale: 50%

