Environment Overview
=====================


UDF Blueprint
-----------------

Access Labs & Solutions (Version 17.5.1)

Lab Topology
--------------

|image000|


The following components have been included in your lab environment:


.. Note:: BIG-IP2  and BIG-IP6 are offline by default.  Only boot these BIG-IPs when the lab specifies to do so.


- 1 x F5 BIG-IP VE (v17.5.1)
- 1 x Windows 11 - Jumphost
- 1 x Guacamole - Web-based RDP
- 1 x Windows 2019 Server - ADDS (AD, DNS) adds.f5access.onmicrosoft.com
- 1 x Windows 2019 Server - IIS (IIS) iis.f5access.onmicrosoft.com

Lab Components
--------------------

The following table lists VLANS, IP Addresses and Credentials for all
components:


+------------------------+-------------------------+-----------------------------+
| Component              | VLAN/IP Address(es)     |           Credentials       |
+========================+=========================+================+============+
| win11-jumpbox          | - Management 10.1.1.7   | Username       | Password   |
|                        | - Front      10.1.10.5 +----------------+------------+
|                        | - Back   (Not used)     | f5access\\user  |  user     |                  
|                        |                         +----------------+------------+
|                        |                         | f5access\\user1 |  user1    |    
+------------------------+-------------------------+----------------+------------+
| bigip1.f5lab.local     | - Management 10.1.1.4   |  admin         |  admin     |
|                        | - Front      10.1.10.4   +----------------+------------+
|                        | - Back       10.1.20.4  |                             |
+------------------------+-------------------------+----------------+------------+
| adds.f5access          | - Management 10.1.1.8   | f5access\\user |  user      |
|                        | - Front   (Not used)    +----------------+------------+  
|                        | - Back    10.1.20.8     |                             |
+------------------------+-------------------------+----------------+------------+
| iis.f5access           | - Management 10.1.1.9   | f5access\\user |  user      |
|                        | - Front   (Not used)    +----------------+------------+                         
|                        | - Back       10.1.20.9  |                             |
+------------------------+-------------------------+----------------+------------+
| superjump              | - Management 10.1.1.5  |      user       |   user     |                  
+------------------------+-------------------------+-----------------------------+

.. |image000| image:: media/intro/000.png



