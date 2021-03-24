Lab 1: Building a Basic Access Policy
=====================================

Objectives
----------
In this lab we will work through the building blocks of Access Policy Manager. Much like the majority of the other modules around LTM they are policy based meaning you are binding a Profile
to the virtual server in question that you want to provide enhanced functionality. In this case those come in the form of Per-Session and Per-Request Policies

Setup Lab Environment
-----------------------------------

To access your dedicated student lab environment, you will require a web browser and Remote Desktop Protocol (RDP) client software. The web browser will be used to access the Lab Training Portal. The RDP client will be used to connect to the Jump Host, where you will be able to access the BIG-IP management interfaces (HTTPS, SSH).

#. Click **DEPLOYMENT** located on the top left corner to display the environment

#. Click **ACCESS** next to jumpohost.f5lab.local

   |accessjh|

#. Select your RDP solution.

#. The RDP client on your local host establishes a RDP connection to the Jump Host.

#. Login with the following credentials:

         - User: **f5lab\\user1**
         - Password: **user1**

#. After successful logon the Chrome browser will auto launch opening the site https://portal.f5lab.local.  This process usually takes 30 seconds after logon.

#. Click the **Classes** tab at the top of the page.

	|accessportal|


#. Scroll down the page until you see **102 Access Building Blocks** on the left

   |102intro|

#. Hover over tile **Building a Basic Acces Policy**. A start and stop icon should appear within the tile.  Click the **Play** Button to start the automation to build the environment

   |guioverview|

#. The screen should refresh displaying the progress of the automation within 30 seconds.  Scroll to the bottom of the automation workflow to ensure all requests succeeded.  If you experience errors try running the automation a second time or open an issue on the `Access Labs Repo <https://github.com/f5devcentral/access-labs>`__.

Task 1: Intro to Per-Session Policy
---------------------------------------
The per-session policy runs when a client initiates a session. (A per-session policy is also known as an access policy.)

Depending on the actions you include in the access policy, it can authenticate the user and perform other actions that populate session variables with data for use throughout the session.


Objectives
----------

The lab has a pre-configured test Virtual Server which will be used throughout the lab.  You will the Visual Policy Editor (VPE)
to create and attach a simple Access Profile which performs user authentication.

Lab Requirements
----------------

-  A pre existing virtual server at 10.1.10.101 or https://app.acme.com

Task 1: Define an Authentication Server
---------------------------------------

Before we can create an access profile, we must create the necessary AAA
server profile for our Active Directory.

1. From the main screen, browse to **Access > Authentication > Active
   Directory**

2. Click **Create...** in the upper right-hand corner

3. Configure the new server profile as follows:

    Name: **Lab\_SSO\_AD\_Server**

    Domain Name: **f5lab.local**

    Server Connection: **Direct**

    Domain Controller: **10.1.20.7**

    User Name: **f5lab\\admin**

    Password: **admin**



4. Click **Finished**

Note: If you wish you can simply use the **pre-built-ad-servers**.

Task 2: Create a Simple Access Profile
--------------------------------------

1. Navigate to **Access > Profiles / Policies > Access Profiles
   (Per-Session Policies)**

   |Lab1-Image1|

2. From the Access Profiles screen, click **Create...** in the upper
   right-hand corner

3. In the Name field, enter **MyAccessPolicy** and for the **Profile Type**,
   select the dropdown and choose **All**

   |Lab1-Image2|

4. Under "Language Settings", choose **English** and click the
    **<<** button to slide over to the **Accepted Languages** column.

   |Lab1-Image3|

5. Click **Finished**, which will bring you back to the Access Profiles
   screen.

6. On the Access Profiles screen, click the **Edit** link under the
   Per-Session Policy column.

   |Lab1-Image4|

   The Visual Policy Editor (VPE) will open in a new tab.

7. On the VPE page, click the **+** icon on the **fallback** path,
   to the right of the **Start** object.

   |Lab1-Image5|

8. On the popup menu, choose the **Logon Page** radio button under the
   Logon tab and click **Add Item**

   |Lab1-Image6|

   |Lab1-Image7|

9. Accept the defaults and click **Save**

Now let's authenticate the client using the credentials to be provided
via the **Logon Page** object.

1. Between the **Logon Page** and **Deny** objects, click the **+**
   icon, select **AD Auth** found under the **Authentication** tab,
   and click the **Add Item** button

   |Lab1-Image8|

   |Lab1-Image9|

2. Accept the default for the **Name** and in the **Server** drop-down
   menu select the AD server created above:
   **/Common/LAB\_SSO\_AD\_Server**, then click **Save**

   |Lab1-Image10|

3. On the **Successful** branch between the **AD Auth** and **Deny**
   objects, click on the word **Deny** to change the ending

   |Lab1-Image11|

4. Change the **Successful** branch ending to **Allow**, then click **Save**

   |Lab1-Image12|

   |Lab1-Image13|

5. In the upper left-hand corner of the screen, click on the **Apply
   Access Policy** link, then close the window using the **Close**
   button in the upper right-hand. Click **Yes** when asked **Do you
   want to close this tab?**

   |Lab1-Image14|

   |Lab1-Image15|

Task 3: Associate Access Policy to Virtual Servers
--------------------------------------------------

Now that we have created an access policy, we must apply it to the
appropriate virtual server to be able to use it.

1. From the **Local Traffic** menu, navigate to the **Virtual Servers
   List** and click the name of the virtual server created previously:
   **demo-vs-https**.

2. Scroll down to the **Access Policy** section, then for the **Access
   Profile** dropdown, select **MyAccessPolicy**

   |Lab1-Image16|

3. Click **Update** at the bottom of the screen

Task 4: Testing
---------------

Now you are ready to test.

1. Open a new browser window and open the URL for the virtual server
   that has the access policy applied:
   **https://server1.acme.com**
   You will be presented with a login window

   |Lab1-Image17|

2. Enter the following credentials and click **Logon**:
   Username: **user1**
   Password: **user1**

   You will see a screen similar to the following:

   |Lab1-Image18|


Task 5: Troubleshooting tips
----------------------------

You can view active sessions by navigating Access/Overview/Active Sessions

You will see a screen similar to the following:

Click on the session id for the active session. If the session is active it will show up as a green in the status.

|Lab1-Image19|

Click on the "session ID" next to the active session. Note every session has a unique session id. Associated with it.
This can be used for troubleshooting specific authentication problem.

Once you click on the session id you will be presented with a screen that is similar to the following.

|Lab1-Image20|

Note that the screen will show all of the log messages associated with the session. This becomes useful if there is a problem authenticating users.

The default log level shows limited "informational" messages but you can enable debug logging in the event that you need to increase the verbosity of the logging
on the APM policy. Note you should always turn off debug logging when you are finished with trouble shooting as debug level logging can
generate a lot of messages that will fill up log files and could lead to disk issues in the event that logging is set to log to the
local Big-IP.

Please review the following support article that details how to enable debug logging.

https://support.f5.com/csp/article/K45423041

Lab 1 is now complete.









..
.. |Lab1-Image1| image:: /class1/module2/media/Lab1-Image1.png
.. |Lab1-Image2| image:: /class1/module2/media/Lab1-Image2.png
   :width: 2.49705in
   :height: 2.49047in
.. |Lab1-Image3| image:: /class1/module2/media/Lab1-Image3.png
   :width: 2.81496in
   :height: 2.04331in
.. |Lab1-Image4| image:: /class1/module2/media/Lab1-Image4.png
   :width: 3.35694in
   :height: 1.17083in
.. |Lab1-Image5| image:: /class1/module2/media/Lab1-Image5.png
   :width: 5.30972in
   :height: 1.96914in
.. |Lab1-Image6| image:: /class1/module2/media/Lab1-Image6.png
   :width: 5.30625in
   :height: 1.20139in
.. |Lab1-Image7| image:: /class1/module2/media/Lab1-Image7.png
   :width: 3.67708in
   :height: 1.59375in
.. |Lab1-Image8| image:: /class1/module2/media/Lab1-Image8.png
   :width: 5.30972in
   :height: 2.99543in
.. |Lab1-Image9| image:: /class1/module2/media/Lab1-Image9.png
   :width: 4.09422in
   :height: 4.25486in
.. |Lab1-Image10| image:: /class1/module2/media/Lab1-Image10.png
   :width: 2.75000in
   :height: 1.32500in
.. |Lab1-Image11| image:: /class1/module2/media/Lab1-Image11.png
   :width: 2.83858in
   :height: 4.42520in
.. |Lab1-Image12| image:: /class1/module2/media/Lab1-Image12.png
   :width: 5.05208in
   :height: 2.44710in
.. |Lab1-Image13| image:: /class1/module2/media/Lab1-Image13.png
   :width: 4.80000in
   :height: 1.40000in
.. |Lab1-Image14| image:: /class1/module2/media/Lab1-Image14.png
   :width: 2.17708in
   :height: 2.73681in
.. |Lab1-Image15| image:: /class1/module2/media/Lab1-Image15.png
   :width: 4.51887in
   :height: 1.56041in
.. |Lab1-Image16| image:: /class1/module2/media/Lab1-Image16.png
   :width: 2.14583in
   :height: 0.73958in
.. |Lab1-Image17| image:: /class1/module2/media/Lab1-Image17.png
   :width: 2.00000in
   :height: 0.67921in
.. |Lab1-Image18| image:: /class1/module2/media/Lab1-Image18.png
   :width: 2.40945in
   :height: 3.52362in
.. |Lab1-Image19| image:: /class1/module2/media/Lab1-Image19.png
   :width: 2.13489in
   :height: 1.96875in
.. |Lab1-Image20| image:: /class1/module2/media/Lab1-Image20.png
   :width: 5.07751in
   :height: 2.84357in
.. |accessjh| image:: /class1/module2/media/accessjh.png
.. |accessportal| image:: /class1/module2/media/accessportal.png
.. |102intro| image:: /class1/module2/media/102intro.png
