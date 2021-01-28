Lab 4: Troubleshooting
======================

.. toctree::
   :maxdepth: 1
   :glob:

Welcome to the troubleshooting APM Policies lab.  This lab is optional.
The lab exercises will provide guidance on how to configure and troubleshoot
common Access Policy Manager (APM) issues as experienced by field engineers,
support engineers, and customers.  This guide is intended to serve as a
reference guide for students after the class as a basis for troubleshooting APM
within your own environment.  The following troubleshooting techniques will be
covered in this lab:

-  Message Boxes
-  Logs
-  SAML Tracer
-  F5 tcpdump and Wireshark


Task 1 - Jump Host
~~~~~~~~~~~~~~~~~~

Refer to the instructions and screen shots below:

+----------------------------------------------------------------------------------------------+
| 1. Login to your lab provided **Virtual Edition BIG-IP**                                     |
|     - On your jumphost launch Chrome and click the bigip1 link from the app shortcut menu    |
|     - Login with credentials admin/admin                                                     |
+----------------------------------------------------------------------------------------------+


Task 2: General Troubleshooting
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

In this lab exercise, you will learn where to look and what to look at when an Access Policy
is not successfully allowing access or not performing as intended.

+----------------------------------------------------------------------------------------------+
|**Questions to ask yourself?**                                                                |
|   - Do we have proper Network Connectivity?                                                  |
|                                                                                              |
|   - Are there any Upstream/Downstream Firewall Rules preventing APM to be reachable or to    |
|     reach destination targets it requires to access?                                         |
|                                                                                              |
|   - Do we have DNS setup properly?                                                           |
|                                                                                              |
|   - Do we have NTP setup properly?                                                           |
|                                                                                              |
|   - Are we receiving any Warnings or Error messages when we logon?                           |
|                                                                                              |
|   - Are there any missing dependencies?                                                      |
|                                                                                              |
|**Now it is time to check on our Sessions under Active Sessions Menu**                        |
|                                                                                              |
| 1. Go to **Access -> Overview -> Active Sessions**                                           |
|                                                                                              |
|   *Note:  There may not be active sessions within lab proceed to step 2 to generate a*       |
|           *session and examine the properties*                                               |
+----------------------------------------------------------------------------------------------+
| |image001|                                                                                   |
+----------------------------------------------------------------------------------------------+

+----------------------------------------------------------------------------------------------+
| 2. Open Chrome and go to **https://app.acme.com**                                            |
|                                                                                              |
| 3. Enter your credentials **User1/User1**                                                    |
+----------------------------------------------------------------------------------------------+
| |image002|                                                                                   |
+----------------------------------------------------------------------------------------------+

+----------------------------------------------------------------------------------------------+
| 4. Return to your BIG-IP **Access -> Overview -> Active Sessions**                           |
|                                                                                              |
| 5. Under Auto Refresh you can choose to Refresh or set how frequently to Auto Refresh        |
+----------------------------------------------------------------------------------------------+
| |image003|                                                                                   |
+----------------------------------------------------------------------------------------------+

+----------------------------------------------------------------------------------------------+
|   - What can we see from the Active Session tab?                                             |
|                                                                                              |
|   - If we click the Session ID link what more information is available?                      |
|                                                                                              |
|   - Is Authentication Successful or is it Failing?                                           |
|                                                                                              |
|   - Is the user receiving the proper ENDING ALLOW from the Policy?                           |
|                                                                                              |
|   - Try logging in with the wrong password.  What does the flow look like?                   |
+----------------------------------------------------------------------------------------------+

+----------------------------------------------------------------------------------------------+
| 6. Return to your BIG-IP **Access -> Overview -> Access Reports**                            |
|                                                                                              |
| 7. You can choose the amount of time you want to look at from here for the lab we will look  |
|    at the last 1 hour                                                                        |
+----------------------------------------------------------------------------------------------+
| |image004|                                                                                   |
|                                                                                              |
| |image005|                                                                                   |
+----------------------------------------------------------------------------------------------+

+----------------------------------------------------------------------------------------------+
| 8. Let's review the reports information for the sessions                                     |
|                                                                                              |
| 7. Pick a Session ID (your numbers will be different than the picture below)                 |
+----------------------------------------------------------------------------------------------+
| |image006|                                                                                   |
+----------------------------------------------------------------------------------------------+

+----------------------------------------------------------------------------------------------+
|   - What information is available from the ALL SESSIONS REPORT?                              |
|                                                                                              |
|   - What information can we see when you click on a Session ID?                              |
|                                                                                              |
|   - Can we review the Session Variables for the user’s session from the ALL SESSION          |
|     REPORT? If YES then Why however If NO then WHY?                                          |
+----------------------------------------------------------------------------------------------+

Task 3: Troubleshooting in the CLI
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

+----------------------------------------------------------------------------------------------+
|*Let's verify our routing on BIG-IP*                                                          |
|                                                                                              |
| 1. Locate the PuTTY (SSH Client) to access the BIG-IP                                        |
|                                                                                              |
| 2. Double click the BIG-IP1 PuTTY icon on the Desktop                                        |
+----------------------------------------------------------------------------------------------+
| |image007|                                                                                   |
+----------------------------------------------------------------------------------------------+

+----------------------------------------------------------------------------------------------+
| 3. run the command **netstat -rn**                                                           |
|     - What routes do we have?                                                                |
|     - How would the BIG-IP reach 10.1.20.6?                                                  |
|     - run **ip route get 10.1.20.6** to see if you were right                                |
+----------------------------------------------------------------------------------------------+
| |image008|                                                                                   |
|                                                                                              |
| |image009|                                                                                   |
+----------------------------------------------------------------------------------------------+

+----------------------------------------------------------------------------------------------+
| 4. run command **dig app.acme.com**                                                          |
|     - What IP is returned?                                                                   |
|     - Why that IP?                                                                           |
|     - try **dig app.acme.com**                                                               |
|     - **dig server1.acme.com**                                                               |
+----------------------------------------------------------------------------------------------+
| |image010|                                                                                   |
+----------------------------------------------------------------------------------------------+

+----------------------------------------------------------------------------------------------+
| 4. run command **ntpq -pn**                                                                  |
|     - ensure NTP is properly configured                                                      |
|                                                                                              |
| 5. run command **date**                                                                      |
|     - If time is out of sync by too much of an offset this can cause issues with sync in an  |
|       HA pair of devices                                                                     |
+----------------------------------------------------------------------------------------------+
| |image011|                                                                                   |
+----------------------------------------------------------------------------------------------+

Task 4: Managing Active Sessions
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

+----------------------------------------------------------------------------------------------+
| 1. In Chrome go to https://app.acme.com                                                      |
|     - Login  user1/user1                                                                     |
|                                                                                              |
| 2. Return to your BIG-IP GUI by clicking the app shortcut BIG-IP1 from Chrome                |
|     - Login admin\admin                                                                      |
|     - Go to **Access -> Overview -> Active Sessions**                                        |
|     - Do you see active sessions?  Are there in active sessions?                             |
|     - Check the box next to your all the sessions and **Kill Selected Session**              |
+----------------------------------------------------------------------------------------------+
| |image012|                                                                                   |
+----------------------------------------------------------------------------------------------+

Task 5: APM Logging
~~~~~~~~~~~~~~~~~~~

**Checking APM Logs**

APM Logs by default show the same information you can get from the Active Sessions menu, as well
as APM module-specific information.  Access Policy Manager uses syslog-ng to log events. The syslog-ng
utility is an enhanced version of the standard logging utility syslog.  APM log messages are stored in
the following file locations:  /var/log/access, /var/log/audit

When setting up logging you can customize the logs by designating the desired minimum severity level
or log level that you want the system to report when a type of event occurs. The minimum log level indicates
the minimum severity level at which the system logs that type of event.

Note:  Files are rotated daily if their file size exceeds 10MB.  Additionally, weekly rotations are enforced
if the rotated log file is a week old, regardless whether or not the file exceeds the 10MB threshold.  The
default log level for the BIG-IP APM access policy log is Notice, which does *not* log Session Variables.
Setting the access policy log level to Informational or Debug will cause the BIG-IP APM system to log Session
Variables, but it will also add additional system overhead.

If you need to log Session Variables on a production system, F5 recommends setting the access policy log
level to Debug temporarily while performing troubleshooting or debugging access related issues.

Task 6: SAML Tracer
~~~~~~~~~~~~~~~~~~~

Overview

SAML Tracer is a browser plugin debugger for viewing SAML messages and can be leveraged
for viewing SAML and WS-Federation messages sent through a browser during Single Sign-On and logout.
It is an essential tool for SAML debugging and is used extensively by SAML developers when analyzing
Authentication Requests and Responses during a SAML login process.   SAML Tracer is a browser Add-On
and is supported on Google Chrome and Firefox.    For this lab the SAML Tracer has already been
enabled within Google Chrome and students will launch SAML Tracer while simultaneously logging into
the server3.acme.com SAML enabled application.


#.  Establish an RDP connection to your Jump Host

#.  Launch Google Chrome

#.  On the top right menu bar click on the SAML Tracer object which will launch SAML Tracer

#.  Within Chrome type in https://app.acme.com

#.  It may help to minimize Chrome and move the SAML Tracer utility to the right side of Chrome
	in order to view the SAML request/response actions

#.  Log in to https://app.acme.com as user1/user1

#.  Within the SAML Tracer utility you should see a number of GET and POST responses

#.  Click on one of the GET requests within SAML Tracer and displayed below will be the
	details of the request. In general GET calls will display the request an application
	is sending to the IdP.   A POST call is often useful to display details such as whether
  	or not an X509 certificate is correct, but can be useful to display any number of variables
	depending on whether the call is SP-Initiated or IdP-Initiated.

 |image014|

Task 7: F5 TCPdump and Wireshark
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#.  This lab will cover the following topics:

	   - tcpdump switches and filters
	   - F5 specific tcpdump commands
	   - F5 Wireshark plugin
	   - Using the F5 Wireshark plugin
	   - ssldump command

**Using tcpdump switches and filters**

#.  Establish an RDP connection to your Jump Host

#.	The Jump Host has a shortcut link to Putty on the Desktop

#.	Log into BIG-IP1 or the Management IP Address 10.1.1.4 as admin/admin

#.	The tcpdump command has several switches with different purposes, and this exercise
	  will cover the most commonly used switches:

		- tcpdump -D  (this will list the available interfaces for packet captures

		- tcpdump -i  (to capture traffic on a specific interface use the following
						syntax:  tcpdump -i <interface name> i.e. tcpdump -i 0.0
						another example is tcpdump -i external
		- tcpdump -nn  (this syntax will disable name resolution of hostnames and port names)
		- tcpdump -X   (using tcpdump -X will display output including ASCII and hex)
		- tcpdump -w   (using tcpdump -w will write packet captures to a file i.e. tcpdump -w /var/tmp/capture.pcap)
		- tcpdump -s   (using tcpdump -s0 will capture full data packets.  The number following 's'
						indicates the number of bits to capture of each packet.  0 indicates all)

**Using the F5 Wireshark plugin**

The F5 Wireshark plugin has already been installed and enabled within Wireshark on the Jumphost

Now let's use Wireshark along with the F5 plugin and take a packet capture from the BIG-IP

#. List the destination address of a virtual server on the F5 using the following command:

#. tmsh list ltm virtual app.acme.com destination

#. Now take the destination address and compose a tcpdump command and track traffic to app.acme.com

#. tcpdump -nni 0.0:nnn -s0 -w /var/tmp/app.acme.com.pcap host 10.1.10.100

#. After starting the capture start Chrome and type in https://app.acme.com and login as user1/user1

#. Stop the tcpdump by using Ctrl+c

#. Now launch WinSCP and log into 10.1.1.4 and change the directory to /var/tmp

#. Locate app.acme.com.pcap

#. Copy the pcap to the jumpbox Desktop by dragging and dropping the file from the left pane to the Desktop
   folder on the right

|image015|

#. Now launch Wireshark, and click File, Open, and select the app.acme.com.pcap file (Or double click the file from the Desktop)

#. Explore the packet capture.  Can you find your initial SYN?  Do you see when you are routed to the IdP?

**ssldump command**

The ssldump utility is an SSL/TLS network protocol analyzer, which identifies TCP connections from a chosen packet
trace or network interface and attempts to interpret them as SSL/TLS traffic. When the ssldump utility identifies
SSL/TLS traffic, it decodes the records and displays them in text to standard output. If provided with the private
key that was used to encrypt the connections, the ssldump utility may also be able to decrypt the connections
and display the application data traffic.

- To begin this task let's use the /var/tmp/app.acme.com.pcap capture

- SSL connections are established on top of existing TCP connections using an SSL handshake

#. Launch a Putty session into 10.1.1.4 and cd to /var/tmp

#. Run the following command:  ssldump -nr app.acme.com.pcap

#. The SSL/TLS records printed by the ssldump utility should display the TCP connection, as well as SSL records
	 sent between the client and the server.   The output of each SSL record begins with a record line.   It contains
	 the connection number with which the record is associated as well as the sequence number of the record followed
	 by two timestamps.   The first timestamp is the time in seconds since the start of the connection,  The seconds
	 timestamp is the time in seconds since the previous record on the same connection.  By default the ssldump
	 utility decodes and displays useful details of some SSL record messages.
 


**This concludes Lab #4 basic troubleshooting steps and utilities**

.. |image001| image:: media/Lab4/image001.png
.. |image002| image:: media/Lab4/image002.png
.. |image003| image:: media/Lab4/image003.png
.. |image004| image:: media/Lab4/image004.png
.. |image005| image:: media/Lab4/image005.png
.. |image006| image:: media/Lab4/image006.png
.. |image007| image:: media/Lab4/image007.png
.. |image008| image:: media/Lab4/image008.png
.. |image009| image:: media/Lab4/image009.png
.. |image010| image:: media/Lab4/image010.png
.. |image011| image:: media/Lab4/image011.png
.. |image012| image:: media/Lab4/image012.png
.. |image013| image:: media/Lab4/image013.png
.. |image014| image:: media/Lab4/image014.png
   :width: 4.06in
   :height: 3.08in
.. |image015| image:: media/Lab4/image015.png
   :width: 5.56in
   :height: 3.57in
.. |image016| image:: media/Lab4/image016.png
   :width: 4.5in
   :height: 1.54in
.. |image017| image:: media/Lab4/image017.png
   :width: 4.5in
   :height: 1.29in
.. |image018| image:: media/Lab4/image018.png
   :width: 4.5in
   :height: 5.46in
.. |image019| image:: media/Lab4/image019.png
   :width: 4.5in
   :height: 2.13in
.. |image020| image:: media/Lab4/image020.png
   :width: 4.5in
   :height: 1.01in
.. |image021| image:: media/Lab4/image021.png
   :width: 4.5in
   :height: 1.93in
