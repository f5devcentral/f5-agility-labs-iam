Getting Started
===============

Lab Network Setup
~~~~~~~~~~~~~~~~~

In the interest of focusing as much time as possible configuring and
performing lab tasks, we have provided some resources and basic setup
ahead of time. These are:

-  Cloud-based lab environment complete with a Windows Server 2016 Jump Host, two Virtual BIG-IP 
   systems, a Windows Server 2016 Domain Controller, a Centos 7 server running NGINX, an Ubuntu
   16.04 server running Radius, and a Windows Server 2016 Server running IIS.

-  Two Virtual BIG-IP systems have been have been pre-licensed and provisioned with Access
   Policy Manager (APM); however, for this lab we will only be using big-ip1.f5lab.local.

-  Pre-staged configurations to speed up lab time, reducing repetitive
   tasks to focus on key learning elements.

If you wish to replicate these labs in your environment you will need to
perform these steps accordingly. Additional lab resources are provided
as illustrated in the diagram below:

Timing for labs
~~~~~~~~~~~~~~~

The time it takes to perform each lab varies and is mostly dependent on
accurately completing steps. This can never be accurately predicted but
we strived to provide an estimate based on several people, each having a
different level of experience. Below is an estimate of how long it will
take for each lab:

+-----------------------------------------+----------------------+
| **Lab Description**                     | **Time Allocated**   |
+=========================================+======================+
| LAB I Client-Side Authentication Lab    | 20 minutes           |
+-----------------------------------------+----------------------+
| LAB II SSO Lab Client to Server Side    | 15 minutes           |
+-----------------------------------------+----------------------+
| LAB III LTM+APM Per-Request Policy Lab  | 20 minutes           |
+-----------------------------------------+----------------------+
| LAB IV Troubleshooting Lab (optional)   | TBD                  |
+-----------------------------------------+----------------------+

Authentication – Credentials
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The following credentials will be utilized throughout this Lab guide.

Hostname	               Platform	                              Credentials	

Big-ip1.f5lab.local	   BIG-IP TMOS 15.1	                     Admin/admin	

Big-ip3.f5lab.local	   BIG-IP TMOS 15.1	                     Admin/admin	

Jumphost.f5lab.local	   Windows Server 2016	                  f5lab\user1 user1	f5lab\user2 user2

iis.f5lab.local	      Windows Server 2016 IIS Server	      Administrator\ PKmUPdwv	

dc.f5lab.local	         Windows Server 2016 Domain Controller	Admin/admin	

Radius.f5lab.local	   Ubuntu 16.04 LTS		

web.f5lab.local	      Centos 7	                              Root\My$SQL	

Network Topology		

External	10.1.10.0/24		

Internal	10.1.20.0/24		

Management	10.1.1.0/24		


Utilized Browsers
~~~~~~~~~~~~~~~~~

The preferred browsers for this lab are Firefox and Internet Explorer.
Shortcut links have been provided to speed access to targeted resources
and assist you in your tasks. Except where noted, either browser can be
used for all lab tasks.

General Notes
~~~~~~~~~~~~~

As noted previously, environment staging has been done to speed up lab
time, reducing repetitive tasks to focus on key learning elements. Where
possible steps that have been optimized have been called out with links
and references provided in the *Additional Information* section for
additional clarification. The intention being that the lab guide truly
serves as a resource guide for all your future federation deployments.
