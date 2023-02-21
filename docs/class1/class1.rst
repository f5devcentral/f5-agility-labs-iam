100 Series: Zero Trust Application Access (ZTAA) 
======================================================

We can think of the ZTAA use cases as two main sections, Identity Aware Proxy (IAP) and Virtual Desktop Infrastructure (VDI):

Identity Aware Proxy (IAP)
- Identity Aware Proxy. 
- Federation F5 as Idp (Identity Provider). 
- Federation F5 as SP (Service Provider). 
- Microsoft Integration (AzureAD Easy button).

Virtual Desktop Infrastructure (VDI)
- Citrix integration. 
- VMware Horizon integration.

.. Note:: For SSL Profiles to appear in the Access Guided Configurations make sure to enable default SNI for server under SSL profiles options.

101 - Zero Trust - Identity Aware Proxy
-----------------------------------------  

.. toctree::
   :maxdepth: 1
   :caption: Version 16.1 Labs:
   :glob:

   module2/intro.rst
   module2/lab*

102 - Federation (F5 APM as Idp (Identity Provider) and SP (Service Provider))
-------------------------------------------------------------------------------
.. toctree::
   :maxdepth: 1
   :glob:

   module3/intro.rst
   module3/lab*

    
103 - Microsoft Integration (AzureAD Easy button)
---------------------------------------------------
.. toctree::
   :maxdepth: 1
   :glob:

   module4/intro.rst
   module4/lab*
   
   
104 - Citrix integration
---------------------------------------------------
.. toctree::
   :maxdepth: 1
   :glob:

   module5/intro.rst

105 - VMware Horizon integration
---------------------------------------------------
.. toctree::
   :maxdepth: 1
   :glob:

   module6/intro.rst
