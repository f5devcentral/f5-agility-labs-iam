Lab Information
===============

Login instructions
------------------

Please follow the instructions provided by the instructor to start your
lab and access your jump host.

To access your dedicated student lab environment, you will require a web browser and Remote
Desktop Protocol (RDP) client software. The web browser will be used to
access the Lab Training Portal. The RDP client will be used to connect
to the Jump Host, where you will be able to access the BIG-IP management
interfaces (HTTPS, SSH).

#. Establish an RDP connection to your Jump Host and login with the following credentials:

   - User: **user**

   - Password: **Agility1**

#. Access the **BIG-IP** GUI **https://10.128.1.245** (you can double-click on the red “f5 Big-IP” shortcut icon on the Windows desktop).

#. Login into the BIG-IP Configuration Utility with the following credentials:

   - User: **admin**

   - Password: **admin**


.. NOTE::
         All work for this lab will be performed exclusively from the Windows
         jumphost. No installation or interaction with your local system is
         required.


Lab Topology
------------

|image0|


The following components have been included in your lab environment:

- 1 x F5 BIG-IP VE v13.1 (provisioned for Local Traffic Manager and Access Policy Manager)
- 1 x Windows Server running Active Directory and Web services
- 1 x Windows Jumphost

.. NOTE::
  The following entries have been added in the local hosts file of your Jumphost:

  - 10.128.10.10 www.f5demo.com
  - 10.128.10.11 myvpn.f5demo.com
  - 10.128.20.200 www2.f5demo.com
  - 10.128.10.11 webtop.f5demo.com
  - 10.128.10.12 forms.f5demo.com
  - 10.128.10.12 forms.f5demo.com
  - 10.128.10.13 basic.f5demo.com
  - 10.128.10.13 app1.f5demo.com
  - 10.128.10.13 app2.f5demo.com
  - 10.128.10.13 app3.f5demo.com
  - 10.128.1.245 bigip1.f5demo.com


Lab Components
--------------

The following table lists VLANS, IP Addresses and Credentials for all
components:

.. list-table::
   :widths: 20 40 40
   :header-rows: 1

   * - **Component**
     - **VLAN/IP Address(es)**
     - **Credentials**
   * - BIG-IP
     - - **Management:** 10.128.1.245
       - **Internal:** 10.128.20.245
       - **External:** 10.128.10.245
     - ``admin``/``admin``
   * - Jumphost
     - - **Management:** 10.128.1.5
       - **External:** 10.128.10.5
     - ``user``/``Agility1``
   * - Lab Server
     - - **Internal:** 10.128.20.201
     - ``administrator``/``Agility2018``


Labs Timing/Duration
--------------------

The time it takes to perform each lab varies and is mostly dependent on accurately completing steps. Below is an estimate of how long it will take for each lab:

+-------------------------------------------------------+------------------+
| Lab name (Description)                                | Time Allocated   |
+=======================================================+==================+
| Lab 1 - Deploy a simple reverse proxy service         | 10 minutes       |
+-------------------------------------------------------+------------------+
| Lab 2 – Create My First Policy                        | 15 minutes       |
+-------------------------------------------------------+------------------+
| Lab 3 – Configuring a VPN Policy                      | 20 minutes       |
+-------------------------------------------------------+------------------+
| Lab 4 – Configuring an APM Webtop                     | 10 minutes       |
+-------------------------------------------------------+------------------+
| Lab 5 – FORMS Based Authentication                    | 15 minutes       |
+-------------------------------------------------------+------------------+
| Lab 6 – BASIC Authentication                          | 15 minutes       |
+-------------------------------------------------------+------------------+
| Lab 7 – Single-Sign-On Across Authentication Domains  | 20 minutes       |
+-------------------------------------------------------+------------------+


.. |image0| image:: media/image2.png
  :width: 5.30972in
  :height: 3.44931in
