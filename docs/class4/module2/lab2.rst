Lab 2.2: Test Access Control
----------------------------

Now that you have your IdP configured we need to test it to make sure
it is working as expected.

Task 1 - Test with an Authorized User
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. Open Chromium and navigate to https://app.f5demo.com

#. Login with the test credentials

    =========== ========
    Username    Password
    =========== ========
    alice       agility
    =========== ========

#. You should now see a demo application.  

    |image25|

#. Click the user icon in the top right of the app and logout

Task 2 - Test with an Unauthorized User
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. Navigate to https://app.f5demo.com (you can click the bookmark)

#. Login with the test credentials 

    =========== ========
    Username    Password
    =========== ========
    john        agility
    =========== ========

#. You should now see an error page since John is not a member of the sales group

    |image28|

8. Close the Chromium browser

.. |image25| image:: /_static/class4/image25.png
.. |image28| image:: /_static/class4/image28.png

