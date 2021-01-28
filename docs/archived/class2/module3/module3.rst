Lab 3: Reporting and Session Management
=======================================

Task 1: Big-IP as Authorization Server (Big-IP 2)
-------------------------------------------------

#. You can see reporting on OAuth traffic at
   **Access -> Overview -> OAuth Reports -> Server**

   |image221|

#. You can see the session logs by going to
   **Access**-> **Overview**-> **Active Sessions** and click on the
   active session, or for past sessions under
   **Access -> Overview -> Access Reports -> All Sessions Report**
   *(it runs by default and asks for a time period)*

   |image222|


Task 2: Big-IP as Client / Resource Server (Big-IP 1)
-----------------------------------------------------

#. After logging in Go to **Access -> Overview -> Active Sessions** and note
   that the "User" field is populated with the name from your social account
   *(from social account labs).* This happens because we took the relevant
   variable from the OAuth response and put it into the variable
   *session.logon.last.username*.

   |image223|

#. There are more session variables retrieved from the provider you can
   examine. To see them click on **View** under **Variables** for the
   session. Search for variables that start with "session.oauth.scope.last".
   The scope will determine what the Authorization Server returns to you.

   |image224|

   .. NOTE:: You can terminate this session if desired at the Active
      Sessions screen*

   |image225|

#. You can see reporting on OAuth traffic at
   **Access -> Overview -> OAuth Reports -> Client** / **Resource Server**

   |image226|

#. You can see the session logs by going to
   **Access**-> **Overview**-> **Active Sessions** and click on the active
   session, or for past sessions under
   **Access -> Overview -> Access Reports -> All Sessions Report**
   *(it runs by default and asks for a time period)*

   |image227|

.. |image221| image:: /_static/class2/image205.png
.. |image222| image:: /_static/class2/image206.png
.. |image223| image:: /_static/class2/image207.png
.. |image224| image:: /_static/class2/image208.png
.. |image225| image:: /_static/class2/image209.png
.. |image226| image:: /_static/class2/image210.png
.. |image227| image:: /_static/class2/image211.png
