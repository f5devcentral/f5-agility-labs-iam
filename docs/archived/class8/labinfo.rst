
Lab Environment
===============

Accessing the Lab Environment
-----------------------------

To access the lab environment, you will require a web browser and Remote
Desktop Protocol (RDP) client software. The web browser will be used to
access the Lab Training Portal. The RDP client will be used to connect
to the Jump Host, where you will be able to access the BIG-IP management
interfaces (HTTPS, SSH).

Your class instructor will provide additional lab access details.

Lab Network Setup
-----------------

In the interest of focusing as much time as possible configuring and
troubleshooting APM, we have provided some resources and basic setup
ahead of time. These are:

-  Cloud-based lab environment complete with Jump Host, Virtual BIG-IP
   (VE) and Lab Server

-  Duplicate Lab environments for each student for improved
   collaboration

-  Virtual BIG-IP has been pre-licensed and provisioned for Access
   Policy Manager (APM)


.. NOTE::
   All work for this lab will be performed exclusively from the Windows
   jump host. No installation or interaction with your local system is
   required.

If you wish to replicate these lab exercises in your own lab environment, you will need to
perform these steps accordingly. Additional lab resources are provided
as illustrated in the diagram below:

LAB Environment Diagram
-----------------------

|image0|

Lab Components
--------------
The following components have been included in your lab environment:

- 1 x Windows Jump Host
- 1 x F5 BIG-IP VE (v13.1)
- 1 x Windows Lab Server (AD/DNS/App)

The following table lists VLANS, IP Addresses and Credentials for all components:

.. list-table::
    :widths: 20 40 40
    :header-rows: 1

    * - **Component**
      - **VLAN/IP Address(es)**
      - **Credentials**
    * - Jump Host
      - - **Management:** 10.128.1.1
        - **Internal:** 10.128.20.1
        - **External:** 10.128.10.1
      - ``agility``/``Agility1``
    * - BIG-IP VE
      - - **Management:** 10.128.1.245
        - **Internal:** 10.118.20.245
        - **External:** 10.118.10.245
      - ``admin``/``admin``
    * - Lab Server
      - - **Internal:** 10.128.20.100
      - ``none``

.. |image0| image:: /_static/class8/image2.png
	 :width: 6.48475in
	 :height: 4.17870in
