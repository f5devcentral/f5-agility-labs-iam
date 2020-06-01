Lab 1.6: Configure the Access Profile
------------------------------------------------

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
         profile [label="Access Profile",color="steelblue1"]
         vs [label="VS"]
         test [label="Test"]
         idp -> spconnector -> bind -> resource -> webtop -> profile -> vs -> test

      }
   }

The Access Profile defines the characteristics of how we authenticate
and authorize a user using the BIG-IP platform. It controls things like
what type logon page is presented to the user (if any at all), what
language any dialog messages should be presented in, and -- most
importantly -- the flow through which we limit access and assign
resources.

F5 BIG-IP Access Policy Manager supports two types of Access Policies:

1. Per-Session access policies
2. Per-Request access policies

The difference centers around how frequently a policy is evaluated,
either once at time of initial logon or after every single HTTP
request.

Task 1 - Create the Access Profile Object
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

a. Navigate to :menuselection:`Access --> Profiles/Policies --> Access Profiles (Per-Session Policies)`
b. Click the :guilabel:`+` sign

    |image14|

c. Configure the following settings:

    +-------------------+-----------------------+
    | Property          | Value                 |
    +===================+=======================+
    | Name              | idp.f5demo.com-policy |
    +-------------------+-----------------------+
    | Profile Type      | All                   |
    +-------------------+-----------------------+
    | Languages         | English (en)          |
    +-------------------+-----------------------+

    |image15|

    |image16|

d. Click the :guilabel:`Finished` button.

Task 2 - Configure the Access Policy Using the Visual Policy Editor
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The Visual Policy Editor (VPE) is where the administrator configures
the heart of the Access Policy. Using a flow chart methodology, it is
easy to create robust policies without adding burdensome management
overhead. Even significant policies can be easily read and understood.

1. Open the Visual Policy Editor
    a. Navigate to :menuselection:`Access --> Profiles/Policies --> Access Profiles (Per-Session Policies)`
    b. Click the :guilabel:`Edit...` link and the VPE will open in a new window

        |image20|

    We'll build a policy like the one below:

        |image17|

2. Add a Logon Page
    a. Click on the :guilabel:`+` link after the :guilabel:`Start` node
    b. Select the :guilabel:`Logon Page` tab and click the :guilabel:`Add Item` button
    c. Use the default settings and click the :guilabel:`Save` button

3. Add an Authentication Mechanism
    a. Click on the :guilabel:`+` link after the :guilabel:`Logon Page` node
    b. Select the :guilabel:`Authentication` tab and select :guilabel:`LocalDB Auth` then click the :guilabel:`Add Item` button
    c. Configure the following settings:

    +-------------------+-----------------------+
    | Property          | Value                 |
    +===================+=======================+
    | LocalDB Instance  | /Common/agility       |
    +-------------------+-----------------------+

    |image18|

      .. NOTE:: The administrator can select from a variety of
         Authentication Mechanisms, including Active Directory and LDAP,
         among others. In this lab, the :guilabel:`LocalDB Auth` has been
         pre-configured.

    d. Click the :guilabel:`Save` button.

4. Add Advanced Resource Assign
    a. Click on the :guilabel:`+` link on the successful branch after the :guilabel:`LocalDB Auth` node
    b. Select the :guilabel:`Assignment` tab and select :guilabel:`Advanced Resource Assign` then click the :guilabel:`Add Item` button
    c. Click the :guilabel:`Add New Entry` button
    d. Click the :guilabel:`Add/Delete` link
    e. Select the :guilabel:`Webtop` tab and select the :guilabel:`/Common/saml_webtop`
    f. Select the :guilabel:`SAML` tab and select the :guilabel:`/Common/app.f5demo.com`
    g. Click the :guilabel:`Update` button, then click the :guilabel:`Save` button


    |image19|

5. Change the ending to Allow
    a. Click on the :guilabel:`Deny` ending after the :guilabel:`Advanced Resource Assign`
    b. Select :guilabel:`Allow`
    c. Click :guilabel:`Save`

6. Apply Policy Changes
    a. Click the :guilabel:`Apply Access Policy` in top left next to the F5 red ball
    b. Close browser tab


.. |image14| image:: /_static/class4/image14.png
.. |image15| image:: /_static/class4/image15.png
.. |image16| image:: /_static/class4/image16.png
.. |image17| image:: /_static/class4/image17.png
.. |image18| image:: /_static/class4/image18.png
.. |image19| image:: /_static/class4/image19.png
.. |image20| image:: /_static/class4/image20.png
