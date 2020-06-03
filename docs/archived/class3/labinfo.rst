Lab Environment
---------------

In the interest of time, the following components have been set up with
basic configurations for you in a cloud-based virtual lab environment
with:

-  Windows Jump Host – Provides remote access the virtual lab
       environment via RDP (note: you will need to connect to it using
       your Remote Desktop Client for Windows/Mac). This will also be
       your test client.

-  BIG-IP Virtual Edition (VE) – Pre-licensed and provisioned for Access
       Policy Manager (APM) and Secure Web Gateway (SWG)

-  BIG-IQ Centralized Management (CM) VE – BIG-IQ console

-  BIG-IQ Data Collection Device (DCD) VE – BIG-IQ logging node

-  Windows Server – Active Directory and DNS services

-  DLP Server – ICAP mode

Each student’s lab environment is independent.

Lab Environment Diagram
~~~~~~~~~~~~~~~~~~~~~~~

The following diagram illustrates the lab environment’s
network configuration and will be useful if you wish to replicate these
exercises in your personal lab environment:

|image0|

Timing for Labs
~~~~~~~~~~~~~~~

The time it takes to perform each lab varies and is mostly dependent on
accurately completing steps. Below is an estimate of how long it will
take for each lab:

Lab Timing

+----------------------------------------------------------+------------------+
| Lab name (Description)                                   | Time Allocated   |
+==========================================================+==================+
| **Use Case: Enterprise Web Filtering**                   |                  |
+----------------------------------------------------------+------------------+
| Lab 1: SWG iApp - Explicit Proxy for HTTP and HTTPS      | 30 minutes       |
+----------------------------------------------------------+------------------+
| Lab 2: URL Category-based Decryption Bypass              | 25 minutes       |
+----------------------------------------------------------+------------------+
| Lab 3: Explicit Proxy Authentication - NTLM              | 25 minutes       |
+----------------------------------------------------------+------------------+
| **Use Case: Access Reporting**                           |                  |
+----------------------------------------------------------+------------------+
| Lab 4: SWG Reporting with BIG-IQ                         | 15 minutes       |
+----------------------------------------------------------+------------------+
| **Use Case: Guest Access Web Filtering**                 |                  |
+----------------------------------------------------------+------------------+
| Lab 5: SWG iApp – Transparent Proxy for HTTP and HTTPS   | 15 minutes       |
+----------------------------------------------------------+------------------+
| Lab 6: Captive Portal Authentication                     | 25 minutes       |
+----------------------------------------------------------+------------------+
| **Use Case: SSL Visibility**                             |                  |
+----------------------------------------------------------+------------------+
| Lab 7: SSL Visibility for DLP (ICAP)                     | 15 minutes       |
+----------------------------------------------------------+------------------+
|                                                          |                  |
+----------------------------------------------------------+------------------+

General Notes
~~~~~~~~~~~~~

Provisioning Secure Web Gateway (SWG) requires Access Policy Manager
(APM to also be provisioned.

When working with iApp templates for the first time, you should change
the BIG-IP Configuration Utility’s default “\ **Idle Time Before
Automatic Logout**\ ” setting to a larger value. This has already been
done for you in the lab environment to save time.

Accessing the Lab Environment
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

To access the lab environment, you will require a web browser and Remote
Desktop Protocol (RDP) client software. The web browser will be used to
access the Lab Training Portal. The RDP client will be used to connect
to the Jump Host, where you will be able to access the BIG-IP management
interfaces using HTTPS and SSH. You will also be using the Jump Host as
a test client.

You class instructor will provide additional lab access details.

1. Establish an RDP connection to your Jump Host and login with the
       following credentials:

-  User: JUMPBOX\\external\_user

-  Password: password

1. Use Firefox to access the BIG-IP GUI (https://10.1.1.10).

2. Login into the BIG-IP Configuration Utility with the following
       credentials:

-  User: admin

-  Password: admin

.. |image0| image:: /_static/class3/image2.png
   :width: 7.10764in
   :height: 3.26458in
