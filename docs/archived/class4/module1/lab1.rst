Lab 1.1: Create a SAML Identity Provider 
----------------------------------------

.. graphviz::

   digraph breadcrumb {
      rankdir="LR"
      ranksep=.4
      node [fontsize=10,style="rounded,filled",shape=box,color=gray72,margin="0.05,0.05",height=0.1]
      fontsize = 10
      labeljust="l"
      subgraph cluster_provider {
         style = "rounded,filled"
         color = lightgrey
         height = .75
         label = "BIG-IP APM"
         idp [label="IDP",color="steelblue1"]
         spconnector [label="SP Connector"]
         bind [label="Bind Connectors"]
         resource [label="SAML Resource"]
         webtop [label="Webtop"]
         profile [label="Access Profile"]
         vs [label="VS"]
         test [label="Test"]
         idp -> spconnector -> bind -> resource -> webtop -> profile -> vs -> test

      }
   }

Task 1 - Create a Local IdP Service
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

In this lab we will create the local Identity Provider service. This
service is responsbile for handling the authentication for the SaaS
application.

.. NOTE:: This guide may require you to Copy/Paste information from the
   guide to your jumphost.  To make this easier you can open a copy of the
   guide by using the **Lab Guide** bookmark in Chrome.

a. Navigate to :menuselection:`Access --> Federation --> SAML Identity Provider --> Local IdP Services`
b. Click the :menuselection:`+` sign

    |image1|

c. Configure the :guilabel:`General Settings`:

    +------------------+------------------------+
    | Property         | Value                  |
    +==================+========================+
    | IdP Service Name | idp.f5demo.com         |
    +------------------+------------------------+
    | IdP Entity Id    | https://idp.f5demo.com |
    +------------------+------------------------+

    |image2|

d. Configure the :guilabel:`Assertiion Settings`:

    +-------------------------+--------------------------------+
    | Property                | Value                          |
    +=========================+================================+
    | Assertion Subject Value | %{session.logon.last.username} |
    +-------------------------+--------------------------------+

    |image3|

e. Configure the :guilabel:`Security Settings`:

    +---------------------+------------------------+
    | Property            | Value                  |
    +=====================+========================+
    | Signing Key         | idp.f5demo.com.key     |
    +---------------------+------------------------+
    | Signing Certificate | idp.f5demo.com.crt     |
    +---------------------+------------------------+

    |image4|

f. Click the :guilabel:`OK` button.


.. |image1| image:: /_static/class4/image1.png
.. |image2| image:: /_static/class4/image2.png
.. |image3| image:: /_static/class4/image3.png
.. |image4| image:: /_static/class4/image4.png
