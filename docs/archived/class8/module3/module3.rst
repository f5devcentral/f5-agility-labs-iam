Lab 3: General Troubleshooting
================================

In this lab exercise, you will learn where to look and what to look at
when an Access Policy is not successfully allowing access or not
performing as intended.

Questions to ask yourself (LAB3)
--------------------------------

1. Do we have proper Network Connectivity?

2. Are there any Upstream/Downstream Firewall Rules preventing APM to be
   reachable or to reach destination targets it requires to access?

3. Do we have DNS setup properly?

4. Do we have NTP setup properly?

5. Are we receiving any Warnings or Error messages when we logon?

6. Are there any missing dependencies?

7. Time to check on our Sessions under Manage Session Menu

   a. What can we see from the Manage Session Menu?

   b. If we click the Session ID link what more information is
      available?

   c. Is Authentication Successful or is it Failing?

   d. Is the user receiving the proper ENDING ALLOW from the Policy?

8. Time to Review the Reports information for the Session in question

   a. What information is available from the ALL SESSIONS REPORT?

   b. Can we review the Session Variables for the user’s session from
      the ALL SESSION REPORT? If YES then Why however If NO then WHY?

9. Can the BIG-IP TMOS Resolve the AAA server by Hostname and by
   Hostname.Domain?

   a. Is the AAA reachable over the network, no Firewalls blocking
      communication from BIGIP Self-IP?

Verify DNS is setup from the CLI of the BIG-IP
----------------------------------------------

Perform the following steps to verify DNS is correctly configured:

|image26|

1. Click on the PuTTY (SSH client) to access the BIG-IP CLI

|image27|

2. Click on the **agilitylab** Saved Session and click Load

3. The click on **OPEN**

Alternatively, you can simply double-click on the **agilitylab** Saved
Session to open the session

|image28|

4. Logon as **root** with password **default** if necessary (you should logon automatically)

|image29|

5. From the CLI type **dig agilitylab.com** and then press enter

6. The following results should be reviewed and verified.

7. If DNS is properly configured you should receive the returned IP address of **10.128.20.100**

|image30|

8. From the CLI type **nslookup** and then press enter.

9. Type **agilitylab.com** and then press enter

10. The following results should be reviewed and verified.

11. If DNS is properly configured you should receive the returned IP address of **10.128.20.100**

12. Exit nslookup by typing **exit**

Verify NTP is setup from the CLI of the BIGIP
---------------------------------------------

Perform the following steps to verify NTP is correctly configured:

|image31|

1. From the CLI (via PuTTy –SSH Client) …. type **ntpq –pn** and then
   press enter.

2. The following results should be reviewed.

|image32|

3. | If time is out of sync by too much of an offset you can update the
     local time using the following command:
   | **date MMDDhhmmYYYY**

Manage Sessions within the Access Policy Manager menu
-----------------------------------------------------

We use the Manage Sessions menu to view general status of currently
logged in sessions, view their progress through a policy, and to kill
sessions when needed.

**STEP 1**

|image33|

1. Open a USER session to APM through a new browser window by navigating
   to your first Virtual Server IP Address created in LAB I
   (**10.128.10.100**)

|image34|

2. Did you receive an error message? If so, take note of the Session
   Reference Number

**TEST 1**

|image35|

1. In the browser window, you are using to manage the BIG-IP, navigate
   to Access  Overview > Active Sessions menu.

2. Review the Manage Sessions screen, is there an Active Session? If not
   then why?

**STEP 2**

|image36|

1. Now open the APM Visual Policy Editor (VPE) for the policy
   created/loaded in LAB I by navigating to Access  Profiles/Policies
   -> Access Profiles (Per-Session Policies) menu.

|image37|

2. Then click the Edit link in the row that has the name of your Access
   Profile you are working with currently.
   (**Agility-Lab-Access-Profile**)

|image38|

3. This will either launch a new browser or new tab depending on your
   browsers settings to display the APM Visual Policy Editor (VPE). The
   first policy we created was never edited to add any additional tasks
   that would instruct APM on what Actions it would need to take/enforce
   throughout a Policy Execution for the user’s Session. So we will now
   adjust the policy and retest to see if we receive some new results.

|image39|

4. Click on the **+** symbol between the Start and ending Deny objects.

|image40|

5. This will pop up the Actions window where we can select from several
   Actions we wish to associate with our policy. On the Logon tab select
   the **Logon Page** radio button and then click the **ADD ITEM**
   button at the bottom of the page.

|image41|

6. Click the **SAVE** button on the Logon Page properties window.

|image42|

7. Then click the **Apply Access Policy** link on the top left of the
   page.

**TEST 2**

|image43|

1. Restart your session to APM. (**https://10.128.10.100**)

|image44|

2. Did you receive and error this time? Or did you receive a Logon Page?

|image45|

3. Open your browser or tab for managing APM and open the Active
   Sessions menu again.

4. Is there now an Active Session displayed on the page? If you were
   already on this page you may need to click the Refresh Session Table
   button.

5. What does the Status Icon look like? Is it a Green Circle or a Blue
   Square?

6. Is your username displayed in the Logon column?

7. Click on the Session ID for your session, this will open up a Session
   Details window.

|image46|

8. In the Session Details window, we can see some information about the
   session up to the point that the policy has executed so far.

|image47|

9. Further down there is a reports section titled **Built-In Reports**,
   click that to open the list of built in reports.

|image48|

10. Scroll down to see the list of **Session Reports** and click the **Current Sessions** line and select **Run Report** from the pop up window.

|image49|

11. Do you see your Session ID displayed in the list of current sessions? If not then why?

**TEST 3**

|image50|

1. Return to the browser or tab you are using for access to
   **https://10.128.10.100**. Restart a new session if necessary.

2. Next logon to the APM Logon page with:

   -  Username: **student**
   -  Password: **password**

|image51|

3. Did you receive and error after logging on? If so note the Session
   Reference Number.

|image52|

4. Review the Manage Sessions menu, is your session listed?

|image53|

5. Navigate to Access -> Overview  Access Reports. When prompted Click
   Run Report.

|image54|

6. Do you see your Session ID listed in the list of All Sessions? Is the
   username listed in the Logon column?

|image55|

7. Click the Session ID to open the Session Details window.

8. Do you now see more information in this Sessions Details compared to
   the previous one we reviewed?

9. Is the username listed in the details?

10. In the Session Details screen we can see some important troubleshooting information, for example just below the username row we see a line that states that the Policy followed a path or branch called Fallback out of the Logon Page object to an Ending “Deny” thus the Access Policy Result was Logon\_Deny.

|image56|

11. Now click back on the All Sessions tab at the top.

12. In the row for this session look to the right of the Logon column. You will see the next column states that the session is not Active. Now click the View Session Variables link in the next column.

|image57|

13. Do you see a lot of information recorded for Session Variables for this session? If not, then why?

.. |image26| image:: /_static/class8/image33.png
   :width: 1.33004in
   :height: 0.80208in
.. |image27| image:: /_static/class8/image34.png
   :width: 5.25000in
   :height: 5.15331in
.. |image28| image:: /_static/class8/image36.png
   :width: 5.02778in
   :height: 1.68056in
.. |image29| image:: /_static/class8/image38.png
   :width: 5.30972in
   :height: 2.99931in
.. |image30| image:: /_static/class8/image39.png
   :width: 5.30000in
   :height: 0.98470in
.. |image31| image:: /_static/class8/image40.png
   :width: 5.30000in
   :height: 0.57609in
.. |image32| image:: /_static/class8/image42.png
   :width: 5.09722in
   :height: 0.65278in
.. |image33| image:: /_static/class8/image43.png
   :width: 5.30000in
   :height: 0.74486in
.. |image34| image:: /_static/class8/image44.png
   :width: 5.31250in
   :height: 5.79805in
.. |image35| image:: /_static/class8/image45.png
   :width: 5.24680in
   :height: 2.65625in
.. |image36| image:: /_static/class8/image47.png
   :width: 5.30972in
   :height: 1.95069in
.. |image37| image:: /_static/class8/image48.png
   :width: 5.30000in
   :height: 0.85074in
.. |image38| image:: /_static/class8/image49.png
   :width: 5.30000in
   :height: 1.51016in
.. |image39| image:: /_static/class8/image49.png
   :width: 5.30000in
   :height: 1.51016in
.. |image40| image:: /_static/class8/image51.png
   :width: 5.30972in
   :height: 4.78750in
.. |image41| image:: /_static/class8/image52.png
   :width: 5.27083in
   :height: 5.47535in
.. |image42| image:: /_static/class8/image53.png
   :width: 5.30000in
   :height: 1.47274in
.. |image43| image:: /_static/class8/image43.png
   :width: 5.30000in
   :height: 0.74486in
.. |image44| image:: /_static/class8/image54.png
   :width: 5.30000in
   :height: 4.27509in
.. |image45| image:: /_static/class8/image56.png
   :width: 5.30972in
   :height: 2.79931in
.. |image46| image:: /_static/class8/image58.png
   :width: 5.30972in
   :height: 0.71806in
.. |image47| image:: /_static/class8/image59.png
   :width: 5.30000in
   :height: 1.05629in
.. |image48| image:: /_static/class8/image60.png
   :width: 5.30000in
   :height: 1.88883in
.. |image49| image:: /_static/class8/image61.png
   :width: 5.30000in
   :height: 1.13638in
.. |image50| image:: /_static/class8/image62.png
   :width: 5.30000in
   :height: 3.50845in
.. |image51| image:: /_static/class8/image63.png
   :width: 5.31250in
   :height: 3.55414in
.. |image52| image:: /_static/class8/image64.png
   :width: 5.27045in
   :height: 3.28125in
.. |image53| image:: /_static/class8/image66.png
   :width: 5.30972in
   :height: 1.71875in
.. |image54| image:: /_static/class8/image67.png
   :width: 5.30000in
   :height: 0.95176in
.. |image55| image:: /_static/class8/image68.png
   :width: 5.28361in
   :height: 2.26042in
.. |image56| image:: /_static/class8/image69.png
   :width: 5.30000in
   :height: 0.95176in
.. |image57| image:: /_static/class8/image70.png
   :width: 5.30000in
   :height: 1.16637in
