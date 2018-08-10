Lab 1.3: Bind SP Connectors
-----------------------------------

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
         idp [label="IDP",color="palegreen"]
         spconnector [label="SP Connector",color="palegreen"]
         bind [label="Bind Connectors",color="steelblue1"]
         resource [label="SAML Resource"]
         webtop [label="Webtop"]
         profile [label="Access Profile"]
         vs [label="VS"]
         test [label="Test"]
         idp -> spconnector -> bind -> resource -> webtop -> profile -> vs -> test

      }
   }

Once we have the Identity Provider and Service Provider objects
configured, we need to link them together.

Task 1 - Bind the IdP and SP Connector
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

a. Navigate to :menuselection:`Access --> Federation --> SAML Identity Provider --> Local IdP Services`

    |image1|

b. Check the radio button next to :guilabel:`idp.f5.demo.com`

c. Click on the :guilabel:`Bind/Unbind SP Connectors` button

d. Check the box next to :guilabel:`/Common/app.f5demo.com`

    |image9|

e. Click the :guilabel:`OK` button.

.. |image1| image:: /_static/class4/image1.png
.. |image9| image:: /_static/class4/image9.png
