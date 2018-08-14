Lab Topology & Environments
===========================

All pre-built environments implement the Lab Topology shown below.
Please review the topology first, then find the section matching the
lab environment you are using for connection instructions.

**Using Your Lab Environment**

You will be using Ravello for this lab. We will be working with a
Linux jumpbox, a BIG-IP Virtual Edition version 13.1, and a simulated
SaaS application. We will be using the Linux desktop as our desktop for
accessing the applications on the BIG-IP.

This diagram shows the topology of the network as it is currently
configured:

.. nwdiag:: labtopology.diag
   :width: 800
   :caption: Lab Topology
   :name: lab-topology-diagram
   :scale: 110%

The following table lists VLANS, IP Addresses and Credentials for all
components:

.. list-table::
   :widths: 15 30 30 30
   :header-rows: 1


   * - **Component**
     - **Management IP**
     - **VLAN/IP Address(es)**
     - **Credentials**
   * - Linux Jumphost
     - 10.1.1.10
     - **External:** 10.1.10.10
     - ``f5student/f5DEMOs4u``
   * - BIG-IP VE v13.1
     - 10.1.1.245
     - **External:** 10.1.10.245
       
       **Internal:** 10.1.20.245

     - ``admin/admin``

       ``root/default``
   * - SaaS Application
     - 10.1.1.55
     - **Internal:** 10.1.20.55
     - 

**How to Access the Labs**

You will receive instructions from your proctor on how to access the workstation in the lab.
On this workstation, you will have the following applications:

- Firefox Web Browser – For testing the applications we create and BIG-IP management access.
  Links are bookmarked just below the address bar.
- Putty SSH Client – For accessing the BASH and TMSH command line of the BIG-IP. The BIG-IP
  properties have been saved to the session labeled *BIG-IP*.

