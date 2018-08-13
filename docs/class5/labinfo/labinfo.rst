Getting Started
---------------

Please follow the instructions provided by the instructor to start your
lab and access your jump host.

.. NOTE::
	 All work for this lab can be performed exclusively from the Windows
	 jumphost. No installation or interaction with your local system is
	 required.

Lab Topology
~~~~~~~~~~~~

The following components have been included in your lab environment:

- 1 x F5 BIG-IP VE (v13.1)
- 5 x Windows Server 2016

Lab Components
^^^^^^^^^^^^^^

The following table lists VLANS, IP Addresses and Credentials for all
components:

.. list-table::
    :widths: 20 50 20 40
    :header-rows: 1

    * - **Component**
      - **VLAN/IP Address(es)**
      - **Credentials**
      - **Notes**
    * - BIGIP
      - - **Management:** 10.1.1.4
      	- **Internal:** 10.1.20.4
      	- **External:** 10.1.10.4
      	- **ADFS Proxy Virtual Server IP:** 10.1.10.100
      	- **ADFS Load Balancing Virtual Server IP:** 10.1.20.100
      - - ``admin``/``admin``
        - ``root``/``default``
      - Licensed with Best bundle, provisioned with LTM and APM. BIG-IP Version 13.1.
    * - Client
      - - **Internal** 10.1.20.8
      - ``user``/``user``
      - This is the client/jumphost used in the lab, it is domain joined. Windows Server 2016.
    * - DC
      - - **Internal** 10.1.20.5
      - ``admin``/``admin``
      - This is the domain controller and certificate authority. Windows Server 2016.
    * - App
      - - **Internal** 10.1.20.10
      - ``admin``/``admin``
      - Runs IIS with a claims app that is federated to ADFS. Windows Server 2016.
    * - ADFS-1
      - - **Internal** 10.1.20.6
      - ``admin``/``admin``
      - Primary ADFS farm node. Windows Server 2016.
    * - ADFS-2
      - - **Internal** 10.1.20.7
      - ``admin``/``admin``
      - Secondary ADFS farm node. Windows Server 2016.
