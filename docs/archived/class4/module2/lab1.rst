Lab 2.1: Modify the Access Profile 
----------------------------------

Task 1 - Launching the Visual Policy Editor 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. Navigate to :menuselection:`Access --> Profiles/Policies --> Access
   Profiles (Per-Session Policies)`
#. Click the :guilabel:`Edit...` link
   
   |image20|

Task 2 - Add a LocalDB Query
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. Click on the :guilabel:`+` sign after :guilabel:`LocalDB Auth` on the `Successful` branch
#. In the search field type `local`
#. Select :guilabel:`Local Database` and click the :guilabel:`Add Item` button
#. Configure the following settings:

   ======================= ===================
   Property                Value
   ======================= ===================
   LocalDB Instance        /Common/Agility
   ======================= ===================

#. Click the :guilabel:`Add new entry button`
#. Configure the following settings:

   ======================= ======================
   Property                Value
   ======================= ======================
   Action                  read
   Destination             session.localdb.groups
   Source                  groups
   ======================= ======================

#. Click the :guilabel:`Save` button

Task 3 - Modify the Advance Resource Assignment
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. Click on :guilabel:`Advance Resource Assign`
#. Click on the :guilabel:`change` link

   |image26|

#. Click the :guilabel:`Add Expression` button
#. Configure the following settings:

   ======================= ===================
   Property                Value
   ======================= ===================
   Agent Sel               LocalDB Group Check
   Condition               LocalDB Query
   User is a member of     Sales
   ======================= ===================

#. Click the :guilabel:`Add Expression` button

   |image27|

#. Click the :guilabel:`Finished` button
#. Click the :guilabel:`Save` button
#. Click the :guilabel:`Apply Access Policy` link in top left next to
   the F5 red ball

.. |image20| image:: /_static/class4/image20.png
.. |image26| image:: /_static/class4/image26.png
.. |image27| image:: /_static/class4/image27.png

