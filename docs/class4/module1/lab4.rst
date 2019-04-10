Lab 1.4: Create SAML Resource
-----------------------------

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
         bind [label="Bind Connectors",color="palegreen"]
         resource [label="SAML Resource",color="steelblue1"]
         webtop [label="Webtop"]
         profile [label="Access Profile"]
         vs [label="VS"]
         test [label="Test"]
         idp -> spconnector -> bind -> resource -> webtop -> profile -> vs -> test

      }
   }

Task 1 - Create SAML Resource
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

a. Navigate to :menuselection:`Access --> Federation --> SAML Resource` and click the :guilabel:`+` sign

   |image10|

b. Configure the following settings:

   ================= ================
   Property          Value     
   ================= ================
   Name              app.f5demo.com 
   SSO Configuration idp.f5demo.com 
   Caption           app       
   ================= ================

   |image11|

c. Click the :guilabel:`Finished` button.

.. |image10| image:: /_static/class4/image10.png
.. |image11| image:: /_static/class4/image11.png
