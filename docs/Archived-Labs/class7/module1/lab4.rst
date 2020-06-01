Lab 4 – Configuring an APM Webtop
---------------------------------

In this lab, we will add a Webtop resource to the Access Policy
created in the previous lab.


.. NOTE::
  Lab Requirements:

  - Working HTTPS Virtual Server created in Lab 1 with Access Policy created in Lab 2 (Lab 2 successfully completed).


Task – Create a Webtop resource
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. Expand the **Access** tab from the main menu on the left and navigate
   to **Webtops** > **Webtop Lists**.

#. Click **Create** to create a new Webtop called **MyFullWebtop**,
   select Type “\ **Full**\ ”, uncheck “\ **Minmize To Tray**\ ” and
   click **Finished**.

   |image38|



Task – Enable “Content Rewrite” on the Virtual Server
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#. Browse to **Local Traffic** > **Virtual Servers >** **Virtual Server
   List** and click on the name of your VPN Virtual Server called
   **MyVPNPolicy\_vs**.

#. Scroll down to the “Content Rewrite” section, select
   “\ **rewrite**\ ” for the “Rewrite Profile” field and click **Update**.

   |image39|



Task – Add Webtop resource to existing Access Policy
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. Browse to **Access** > **Profiles / Policies > Access Profiles
   (Per-Session Policies)**, click on **Edit** for **MyVPNPolicy**. A
   new tab should open to the Visual Policy Editor for **MyVPNPolicy**.

   |image40|

#. Select the **Advanced Resource Assign** object.

#. Click **Add/Delete**.

#. | Click on the **Webtop** tab, select the radio button for
     **MyFullWebtop**, then click the **Update** button at the bottom of
     the screen.

   |image41|

#. Click **Save**.

#. | At the top left of the browser window, click on “\ **Apply Access
     Policy**\ ”, then close the tab.
   |

   |image42|




Task – Testing
~~~~~~~~~~~~~~

#. Open a web browser to the virtual server created in the previous lab
   by navigating to **https://myvpn.f5demo.com**. You will be presented
   with a Logon page similar to the one from the last lab.

#. Enter the following credentials:

   Username: **user**

   Password: **Agility1**

#. Click **Logon**.

   This will open the APM Webtop landing page that shows the resources you
   are allowed to access. In this lab, we’ve only configured one resource:
   **Network Access**, but you can add as many as you want and they will
   appear on this Webtop page.

   |image43|



.. |image38| image:: media/image39.png
   :width: 3.59097in
   :height: 2.50000in
.. |image39| image:: media/image40.png
   :width: 3.69861in
   :height: 2.96356in
.. |image40| image:: media/image41.png
   :width: 4.66142in
   :height: 1.48031in
.. |image41| image:: media/image42.png
   :width: 3.89583in
   :height: 0.98194in
.. |image42| image:: media/image43.png
   :width: 1.90000in
   :height: 0.40000in
.. |image43| image:: media/image44.png
   :width: 3.83333in
   :height: 2.16875in
