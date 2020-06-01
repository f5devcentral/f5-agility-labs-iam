Getting Started
---------------

All lab prep is already completed if you are working in the Ravello blueprint. 
The following information will be critical for operating your lab. Additional information can be found in the Learn More section of this guide for setting up your own lab.

Please follow the instructions provided by the instructor to start your
lab and access your jump box.

.. NOTE::
	 All work for this lab will be performed exclusively from the Windows
	 **Jumpbox**. No installation or interaction with your local system is
	 required.

Lab Topology
~~~~~~~~~~~~

The following components have been included in your lab environment:

- **1 x F5 BIG-IP VE_13** ``(10.1.1.245)``

  - Provisioned with APM
- **1 x Windows 7** ``(10.1.1.199)``

  - Jumpbox machine
  - Jumpbox user (external_user)
- **1 X Windows Server 2008** ``(10.1.1.245)``

  - AAA server (Active Directory)
  - User (administrator)
- **1 X Windows 7 Internal** ``(10.1.1.198)``

  - Internal server used to demo SSO to RDP servers
- **1 X Linux LAMP Webserver**

  - Internal Portal

Lab Components
^^^^^^^^^^^^^^

The following credentials will be utilized throughout this Lab guide:

.. list-table::
    :widths: 20 40 40
    :header-rows: 1

    * - **HOST/RESOURCE**
      - **USERNAME**
      - **PASSWORD**
    * - BIG-IP Configuration Utility (GUI)
      - ``admin``
      - ``password``
    * - BIG-IP CLI Access (SSH)
      - ``root``
      - ``password``
    * - Jumphost Access
      - ``external_user``
      - ``password``
    * - Windows Server 2008 (AD) Access
      - ``administrator``
      - ``password``
    * - Sales User
      - ``sales_user``
      - ``sales``
    * - Sales Manager User
      - ``sales_manager``
      - ``manager``
    * - Partner User
      - ``partner_user``
      - ``partner``
