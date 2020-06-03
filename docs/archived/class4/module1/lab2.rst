Lab 1.2: Create an External SP Connector
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
         idp [label="IDP",color="palegreen"]
         spconnector [label="SP Connector",color="steelblue1"]
         bind [label="Bind Connectors"]
         resource [label="SAML Resource"]
         webtop [label="Webtop"]
         profile [label="Access Profile"]
         vs [label="VS"]
         test [label="Test"]
         idp -> spconnector -> bind -> resource -> webtop -> profile -> vs -> test

      }
   }

Now that we have the Identity Provider configured, we need to configure
the BIG-IP so it is aware of the Service Provider (the SaaS
application). We do this by defining an External SP Connector using the
metadata provided by the SaaS application, importing it into the
BIG-IP, and setting the appropriate cryptographic controls.

Task 1 - Obtain the SAML Service Provider Metadata
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

In a common deployment the metadata is provided by the application.
This lab is no different, but the access method will vary. Follow the
listed steps below to obtain the necessary XML file.

a. Open a browser and nagivate to https://app.f5demo.com/metadata.xml
b. Save the file as ``app.f5demo.com.xml``

Task 2 - Create an External SP Connector
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

In this task we will create the External SP Connector object.

a. Navigate to :menuselection:`Access --> Federation --> SAML Identity Provider --> External SP Connector`
b. Click on the triangle on the right side of the :guilabel:`Create` button and select :guilabel:`From Metadata`
    
    |image5|

c. Enter the following information:

    +-----------------------+------------------------------+
    | Property              | Value                        |
    +=======================+==============================+
    | Select File           | app.f5demo.com.xml           |
    +-----------------------+------------------------------+
    | Service Provider Name | app.f5demo.com               |
    +-----------------------+------------------------------+

    |image6|

d. Click the :guilabel:`OK` button

Task 3 - Modify the SP Connector Settings
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Finally, for security purposes, we'll configure the External SP
Connector object to require that resposes are cryptographically signed.
This prevents an attacker from manipulating the response and
potentially gaining unauthorized access.


a. Click the checkbox next to :guilabel:`app.f5demo.com` and click the :guilabel:`Edit` button

b. Modify the following :guilabel:`Security Settings`:

    +---------------------------------------+-----------+
    | Property                              | Value     |
    +=======================================+===========+
    | Response must be signed               | checked   |
    +---------------------------------------+-----------+

    |image7|

c. Click the :guilabel:`OK` button.

.. |image5| image:: /_static/class4/image5.png
.. |image6| image:: /_static/class4/image6.png
.. |image7| image:: /_static/class4/image7.png
