Lab 1.5: Create a Webtop
------------------------

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
         webtop [label="Webtop",color="steelblue1"]
         profile [label="Access Profile"]
         vs [label="VS"]
         test [label="Test"]
         idp -> spconnector -> bind -> resource -> webtop -> profile -> vs -> test

      }
   }

Task 1 - Create the SAML Webtop
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

a. Navigate to :menuselection:`Access --> Webtops --> Webtop Lists`
b. Click the :guilabel:`+` sign

    |image12|

c. Configure the following settings:

    +-------------------+-------------+
    | Property          | Value       |
    +===================+=============+
    | Name              | saml_webtop |
    +-------------------+-------------+
    | Type              | full        |
    +-------------------+-------------+

    |image13|

3. Click the :guilabel:`Finished` button.

.. |image12| image:: /_static/class4/image12.png
.. |image13| image:: /_static/class4/image13.png
