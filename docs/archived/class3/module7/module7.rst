Lab 7: SSL Visibility for DLP (ICAP)
====================================

In this lab exercise, you will send decrypted traffic to an ICAP-based
Data Loss Prevention (DLP) service for inspection. The DLP will block
HTTP POSTs (uploads) of certain content such as credit cards numbers and
documents with Top Secret data classification labels.

Estimated completion time: 15 minutes

**Objectives:**

-  Re-configure the SWG iApp to send unencrypted HTTP and decrypted
   HTTPS traffic to an ICAP (DLP) server

-  Verify that the DLP service is able to see SWG proxy traffic and
   block if a policy violation occurs

**Lab Requirements:**

-  Working SWG iApp deployment

Task 1 – Re-configure SWG iApp to enable ICAP inspection
--------------------------------------------------------

-  Browse to **iApps >> Application Services > Applications**

-  Click on **SWG**

-  Click **Reconfigure**

-  Scroll down to the **ICAP Configuration** section

-  Change the ICAP option to **Yes, create a new ICAP DLP
   deployment**

-  Enter **10.1.20.150** as the IP address of the DLP
   server (the default port of **1344** is correct).

   |image37|

-  Browse to the bottom and click **Finished**

Task 2 – Testing
----------------

-  Open Internet Explorer on your Jump Host client machine

-  Browse to **http://dlptest.com**

-  If you are prompted for authentication, login as ``user1`` with
   password ``AgilityRocks!``

-  Click on the **HTTP Post** link at the top of the page.

-  Fill in the **Subject** and **Message** fields with some random text
   and then add a credit card numbers such as **4111 1111 1111
   1111**.

-  Click on the **Submit** button to see if the DLP service detects
   this. ***Hint:** You should receive a blocking page message.*

-  Go back to the previous page try submitting again but with the words
   **top secret**. Again, you should receive a blocking page from
   the DLP service.

-  Now, go back to the previous page and click on the **HTTPS Post**
   link at the top of the page.

-  Perform the credit card number and **top secret** submissions
   again. You should again see the blocking pages since SWG is
   decrypting the HTTPS connection and sending the decrypted POST data
   to the DLP service for inspection.

-  If you want to see the DLP policy violations, browse to
   **https://10.1.20.150/logs**. Log in as ``mydlp`` with password
   ``mydlp``.

.. |image37| image:: /_static/class3/image39.png
   :width: 6.04375in
   :height: 2.25347in
