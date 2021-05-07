Lab 1: Azure AD Easy Button integration
#####################################################

Publish and protect on-prems apps with Azure AD as identity provider
********************************************************************

.. warning :: For any remark or mistake in this lab, please send a Teams chat to Matthieu DIERICK.

In this lab, you will learn how to connect APM to Azure AD as IDaaS. Since v15.1, you can enable APM as SAML SP and Azure AD as SAML IDP. 
In this lab, we will use the new **Easy Button** Guided Configuration template. This template:

#. Publish on-prems apps
#. Enable Single Sign on
#. Interconnect (SAML binding) APM with Azure AD tenant

.. note :: You will notice we will never connect to Azure AD interface. APM will use Microsoft Graph API to configure AAD tenant accordingly.

.. image:: AAD-APM-archi.png
   :align: center
   :scale: 70%

|

In the video below, you can see the use case. This is **not** the **lab video**, it is the public facing use case demo.

.. raw:: html

    <div style="text-align: center; margin-bottom: 2em;">
    <iframe width="896" height="504" src="https://www.youtube.com/embed/6NDUaDz7NQE" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>



.. toctree::
   :maxdepth: 2
   :caption: Contents:
   :glob:

   class*/class*

