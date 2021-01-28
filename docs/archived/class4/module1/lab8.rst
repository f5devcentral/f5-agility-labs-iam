Lab 1.8: Test the SAML Configuration
------------------------------------

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
         resource [label="SAML Resource",color="palegreen"]
         webtop [label="Webtop",color="palegreen"]
         profile [label="Access Profile",color="palegreen"]
         vs [label="VS",color="palegreen"]
         test [label="Test",color="steelblue1"]
         idp -> spconnector -> bind -> resource -> webtop -> profile -> vs -> test

      }
   }

Now that we have all the pieces configured, the only thing left is to
test and validate our setup to make sure it's working as expected.

Task 1 - Test SAML IdP
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

1. Open Chromium and navigate to https://app.f5demo.com

2. Notice how we've been redirected to the authentication page at https://...

3. Login with the test credentials below:

    =========== ========
    Username    Password
    =========== ========
    alice       agility
    =========== ========
4. You should now see a demo application.  If not, please step back through the configuration and make sure you did not mistype one of the settings

    |image25|

5. Close the Chromium browser

.. |image25| image:: /_static/class4/image25.png
