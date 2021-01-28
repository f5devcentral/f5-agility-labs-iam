Getting Started
---------------


To access your dedicated student lab environment, you will require a web browser and Remote Desktop Protocol (RDP) client software. The web browser will be used to access the Lab Training Portal. The RDP client will be used to connect to the Jump Host, where you will be able to access the BIG-IP management interfaces (HTTPS, SSH).

#. Click **DEPLOYMENT** located on the top left corner to display the environment

#. Click **ACCESS** next to jumpbox.f5lab.local

|image1|


#. Select your RDP solution.  

#. The RDP client on your local host establishes a RDP connection to the Jump Host.

#.  login with the following credentials:
         - User: **f5lab\\user1**
         - Password: **user1**

#. Once logged on to the jumphost, you can access BIG-IP1's GUI via Chrome using bookmarks or by typing https://10.1.1.4 

#. Login into the BIG-IP Configuration Utility with the following credentials:
         - User: **admin**
         - Password: **admin**

.. NOTE::
	 All work for this lab will be performed exclusively from the Windows
	 jumphost. No installation or interaction with your local system is
	 required.

Lab Topology
~~~~~~~~~~~~

|image0|


The following components have been included in your lab environment:

- 2 x F5 BIG-IP VE (v15.1)
- 1 x Windows Jumphost- Server 2016
- 1 x Windows 2016 Server hosting AD, CA, OCSP & DNS
- 1 x Windows 2016 Server hosting IIS
- 1 x Ubuntu 16.04 LTS 
- 1 x Centos 7

Lab Components
^^^^^^^^^^^^^^

The following table lists VLANS, IP Addresses and Credentials for all
components:

+------------------------+-------------------------+--------------------------+
| Component              | VLAN/IP Address(es)     | Credentials              |
+========================+=========================+==========================+
| jumpbox.f5lab.local    | - Management 10.1.1.10  | - user1/user1            |
|                        | - External   10.1.10.10 | - user2/user2            |
|                        | - Internal   10.1.20.10 |                          |
+------------------------+-------------------------+--------------------------+
| BIG-IP1.f5lab.local    | - Management 10.1.1.4   | - admin/admin            |
|                        | - External   10.1.10.4  |                          |
|                        | - Internal   10.1.20.4  |                          |
+------------------------+-------------------------+--------------------------+
| BIG-IP2.f5lab.local    | - Management 10.1.1.5   | - admin/admin            |
|                        | - External   10.1.10.5  |                          |
|                        | - Internal   10.1.20.5  |                          |
+------------------------+-------------------------+--------------------------+
| dc.f5lab.local         | - Management 10.1.1.7   | - admin/admin            |
|                        | - Internal   10.1.20.7  |                          |
+------------------------+-------------------------+--------------------------+
| iis.f5lab.local        | - Management 10.1.1.6   | - admin/admin            |
|                        | - Internal              |                          |
|                        |    - 10.1.20.6          |                          |
|                        |    - 10.1.20.16         |                          |
+------------------------+-------------------------+--------------------------+
| web.f5lab.local        | - Management 10.1.1.9   |                          |
|                        | - Internal              |                          |
|                        |    - 10.1.20.9          |                          |
|                        |    - 10.1.20.19         |                          |
+------------------------+-------------------------+--------------------------+
| radius.f5lab.local     | - Management 10.1.1.8   |                          |
|                        | - Internal              |                          |
|                        |    - 10.1.20.8          |                          |
|                        |    - 10.1.20.18         |                          |
+------------------------+-------------------------+--------------------------+

.. |image0| image:: media/image000.png
.. |image1| image:: media/image001a.png

