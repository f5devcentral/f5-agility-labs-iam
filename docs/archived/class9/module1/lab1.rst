Lab – Pre-Work
--------------

Estimated completion time: **10 minutes**


Task - Create AWS Account
--------------------------

+-------------------------------------------+-----------------------------------------------+
| 1. Go to AWS page                         | https://console.aws.amazon.com/console/home   |
+-------------------------------------------+-----------------------------------------------+
| 2. Click create new AWS account           | |image3|                                      |
+-------------------------------------------+-----------------------------------------------+
|                                           | |image4|                                      |
+-------------------------------------------+-----------------------------------------------+
| 3. Complete all of the required fields.   |                                               |
+-------------------------------------------+-----------------------------------------------+

Note
~~~~

.. NOTE::
   **Payment information** – Default Usage tier is **free for 1 year** with 750 hours a month compute (we will not be using any compute for this lab) and 5GB storage (``we will not be using any storage for this lab``).

Task - Create Salesforce Account
--------------------------------

+-------------------------------------------+-------------------------------------------+
| 1. Go to Salesforce page                  | https://developer.salesforce.com/signup   |
+-------------------------------------------+-------------------------------------------+
| 2. Click create new Salesforce account    | |image5|                                  |
+-------------------------------------------+-------------------------------------------+
| 3. Complete all of the required fields.   |                                           |
+-------------------------------------------+-------------------------------------------+

Task - Create (or use an existing) public domain
-----------------------------------------------------

+---------------------------------------------------------------------------+-----------------------------------------------------+
| 1. You can use **my.freenom** to create a new public domain               | https://my.freenom.com                              |
+---------------------------------------------------------------------------+-----------------------------------------------------+
| 2. Go to **Services**, and then, **Register a New Domain**.               | |image6|                                            |
+---------------------------------------------------------------------------+-----------------------------------------------------+
| 3. | Introduce your new domain **mytestvlab.tk** (``select your own``),   | |image7|                                            |
|    | and check availability.                                              |                                                     |
+---------------------------------------------------------------------------+-----------------------------------------------------+
| 4. At the bottom, click **Checkout**                                      | |image8|                                            |
+---------------------------------------------------------------------------+-----------------------------------------------------+
| 5. | Click in “\ **Use DNS**\ ”, and then “\ **Use your own DNS**\ ”      | |image9|                                            |
|    | and introduce the hostnames : “\ **art.ns.cloudflare.com**\ ” and “\ |                                                     |
|    | **ines.ns.cloudflare.com**\ ”.                                       |                                                     |
|    | Select also a Period of 12 Months (``Free``)                         |                                                     |
+---------------------------------------------------------------------------+-----------------------------------------------------+
| 6. | Finish the configuration signing in or registering with a personal   |                                                     |
|    | account                                                              |                                                     |
+---------------------------------------------------------------------------+-----------------------------------------------------+

Task - Download Google Authenticator and DUO
--------------------------------------------

+-----------------------------------------------------------------+----------------------------------------------------------------------------------------------+
| 1. Download **Google Authenticator** client to your smartphone. | a. Android                                                                                   |
|                                                                 |                                                                                              |
|                                                                 |    i. https://support.google.com/accounts/answer/1066447?co=GENIE.Platform%3DAndroid&hl=en   |
|                                                                 |                                                                                              |
|                                                                 | b. iOS                                                                                       |
|                                                                 |                                                                                              |
|                                                                 |    i. https://itunes.apple.com/us/app/google-authenticator/id388497605?mt=8                  |
+-----------------------------------------------------------------+----------------------------------------------------------------------------------------------+
| 2. Download **DUO** client to your smartphone                   | a. iOS                                                                                       |
|                                                                 |                                                                                              |
|                                                                 |    i. https://itunes.apple.com/us/app/duo-mobile/id422663827?mt=8                            |
|                                                                 |                                                                                              |
|                                                                 | b. Android                                                                                   |
|                                                                 |                                                                                              |
|                                                                 |    i. https://play.google.com/store/apps/details?id=com.duosecurity.duomobile&hl=en          |
+-----------------------------------------------------------------+----------------------------------------------------------------------------------------------+

Task - Create a DUO account
---------------------------

+--------------------------------------------------------------------------------+----------------------------------------------------------+
| 1. Sign up for a **DUO account**.                                              | |image10|                                                |
+--------------------------------------------------------------------------------+----------------------------------------------------------+
| 2. | Log in to the **Duo Admin Panel** and navigate to **Applications**,       | |image11|                                                |
|    | then click **Protect an Application** and locate **F5 BIG-IP APM**        |                                                          |
|    | in the applications list.                                                 | |image12|                                                |                                                                                                                                                                                       
+--------------------------------------------------------------------------------+----------------------------------------------------------+
| 3. | Click **Protect this Application** to get your ``Integration Key``,       | |image13|                                                |
|    | ``Secret Key``, and ``API hostname``. We will use this information later. |                                                          |
+--------------------------------------------------------------------------------+----------------------------------------------------------+

Task - Log in to Ravello
------------------------

+-----------------------------------------------------------------------------------------------------+------------------------------------------------------+
| 1. | Go to the **URL** provided by the instructor and login using the ``username`` and ``password`` | http://tbctrainingportal-xxxxxxsrv.ravcloud.com      |
|    | assigned to you.                                                                               |                                                      |                                            
|    |                                                                                                | a. Username = ``latam_studentXX``                    |
|    |                                                                                                | b. Password = ``f5DEMOs4u``                          |
+-----------------------------------------------------------------------------------------------------+------------------------------------------------------+
| 2. | Search **LATAM\_MFA\_Cloud\_Apps\_Agility** environment, then click on the link and            |                                                      |
|    | verify that the VMs are running.                                                               |                                                      |
+-----------------------------------------------------------------------------------------------------+------------------------------------------------------+
| 3. | Connect to **Windows 7 External** VM. You can use either Console shortcut or a RDP client.     | |image14|                                            |
|    | Then verify **time settings** and modify if it is necessary.                                   |                                                      |
+-----------------------------------------------------------------------------------------------------+------------------------------------------------------+
| 4. | Open a **RDP** connection to AD Server ``10.1.1.251`` in order to verify time settings         | |image15|                                            |
|    | and modify if it is necessary.                                                                 |                                                      |
+-----------------------------------------------------------------------------------------------------+------------------------------------------------------+
| 5. Verify the **time settings** in the **Big IP** and modify if it is necessary.                    | |image16|                                            |
+-----------------------------------------------------------------------------------------------------+------------------------------------------------------+

.. |image3| image:: /_static/class9/image3.png
.. |image4| image:: /_static/class9/image4.png
.. |image5| image:: /_static/class9/image5.png
.. |image6| image:: /_static/class9/image6.png
.. |image7| image:: /_static/class9/image7.png
.. |image8| image:: /_static/class9/image8.png
.. |image9| image:: /_static/class9/image9.png
.. |image10| image:: /_static/class9/image10.png
.. |image11| image:: /_static/class9/image11.png
.. |image12| image:: /_static/class9/image12.png
.. |image13| image:: /_static/class9/image13.png
.. |image14| image:: /_static/class9/image14.png
.. |image15| image:: /_static/class9/image15.png
.. |image16| image:: /_static/class9/image16.png
