Introduction
============

The Privileged User Authentication (PUA) solution is made up of three
parts.

1. WebSSH2 Client Plugin

2. Ephemeral Authentication Plugin

3. Access Policy Manager (APM) policy configuration

Requirements
------------

-  BIG-IP with TMOS v13.1.0.2 or greater.

-  2-5 IP addresses for virtual servers (see `Resource
   Table <#_Resource_Table>`__)

Prerequisites
-------------

BIG-IP with at least APM and iRules LX licensed and provisioned

The “\ **build\_pua.zip**\ ” or “\ **build\_pua\_offline.zip**\ ”
installation script found here:

    https://raw.githubusercontent.com/billchurch/f5-pua/master/build_pua.zip

    https://raw.githubusercontent.com/billchurch/f5-pua/master/build_pua_offline.zip

Installation Overview
---------------------

The installation will consist of installing and testing (in order)

1. BIG-IP Preparation

2. Script download and execution

3. Customization of APM policy

Script Options
--------------

Two options exist for installing the PUA solution, **build\_pua** and
**build\_pua\_offline**.

build\_pua
~~~~~~~~~~

Fetches the most recent plugins and policies from the internet ad run
time.

build\_pua\_offline
~~~~~~~~~~~~~~~~~~~

Contains all plugins and policies embedded in the script for complete
off-line use

Automation Options
------------------

See the details inside
https://github.com/billchurch/f5-pua/blob/master/pua_config.sh for tips
on how you can further automate the installation process.

Resource Table
--------------

Use the following table to plan your deployment

+-------------------------+------------------------------------------------------------------+-------------+
| **Resource**            | **Description**                                                  | **Value**   |
+=========================+==================================================================+=============+
| WebSSH\_proxy\_vs\_IP   | Virtual server IP Address of WebSSH2 service. **EXCLUSIVE IP**   |             |
+-------------------------+------------------------------------------------------------------+-------------+
| APM\_Portal\_vs\_IP     | Virtual server IP Address of APM portal for authentication       |             |
+-------------------------+------------------------------------------------------------------+-------------+
| RADIUS\_proxy\_vs\_IP   | Virtual server IP address of RADIUS proxy service                |             |
+-------------------------+------------------------------------------------------------------+-------------+
| LDAP\_proxy\_vs\_IP     | Virtual server IP address of LDAP proxy service                  |             |
+-------------------------+------------------------------------------------------------------+-------------+
| LDAPS\_proxy\_vs\_IP    | Virtual server IP address of LDAPS proxy service                 |             |
+-------------------------+------------------------------------------------------------------+-------------+
| LDAP\_server\_IP        | IP Address of site LDAP or AD server (required for LDAP use)     |             |
+-------------------------+------------------------------------------------------------------+-------------+
| RADIUS\_server\_IP      | IP Address of site RADIUS server (if RADIUS bypass is used)      |             |
+-------------------------+------------------------------------------------------------------+-------------+
