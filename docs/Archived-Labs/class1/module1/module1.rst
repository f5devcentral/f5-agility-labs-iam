Lab 1: SAML Service Provider (SP) Lab
=====================================

.. toctree::
   :maxdepth: 1
   :glob:

The purpose of this lab is to configure and test a SAML Service
Provider. Students will configure the various aspects of a SAML Service
Provider, import and bind to a SAML Identity Provider and test
SP‑Initiated SAML Federation.

Objective:

-  Gain an understanding of SAML Service Provider(SP) configurations and
   its component parts

-  Gain an understanding of the access flow for SP-Initiated SAML

Lab Requirements:

-  All Lab requirements will be noted inƒ the tasks that follow

Estimated completion time: 25 minutes

TASK 1 ‑ Configure the SAML Service Provider (SP)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

SP Service
----------

#. Begin by selecting: **Access -> Federation -> SAML Service Provider -> Local SP Services**
#. Click the **Create** button (far right)

   |image1|

#. In the **Create New SAML SP Service** dialog box click **General Settings**
   in the left navigation pane and key in the following as shown:

   +------------+----------------------------+
   | Name:      | ``app.f5demo.com``         |
   +------------+----------------------------+
   | Entity ID: | ``https://app.f5demo.com`` |
   +------------+----------------------------+

#. Click **OK** on the dialogue box

   |image2|

   .. NOTE:: The yellow box on Host will disappear when the Entity ID is entered.

IdP Connector
-------------

#. Click on **Access ‑> Federation ‑> SAML Service Provider ‑> External IdP
   Connectors** *or* click on the **SAML Service Provider** tab in the
   horizontal navigation menu and select **External IdP Connectors**

#. Click specifically on the **Down Arrow** next to the **Create** button
   (far right)

#. Select **From Metadata** from the drop down menu

   |image3|

#. In the **Create New SAML IdP Connector** dialogue box, click **Browse**
   and select the **idp.partner.com‑app_metadata.xml** file from the Desktop
   of your jump host.

#. In the **Identity Provider Name** field enter *idp.partner.com*:

#. Click **OK** on the dialog box

   |image4|

   .. NOTE:: The idp.partner.com-app_metadata.xml was created previously.
      Oftentimes, IdP providers will have a metadata file representing their IdP
      service.  This can be imported to save object creation time as it has been
      done in this lab

#. Click on the **Local SP Services** from the **SAML Service Providers** tab
   in the horizontal navigation menu

#. Click the **checkbox** next to the previously created *app.f5demo.com* and
   click **Bind/Unbind IdP Connectors** at the bottom of the GUI

   |image5|

#. In the **Edit SAML IdP's that use this SP** dialogue box, click the
    **Add New Row** button
#. In the added row, click the **Down Arrow** under **SAML IdP Connectors** and
   select the */Common/idp.partner/com* SAML IdP Connector previously created

#. Click the **Update** button and the **OK** button at the bottom of the
   dialog box

   |image6|

#. Under the **Access ‑> Federation ‑> SAML Service Provider ‑>
   Local SP Services** menu you should now see the following (as shown):

   +----------------------+---------------------+
   | Name:                | ``app.f5demo.com``  |
   +----------------------+---------------------+
   | SAML IdP Connectors: | ``idp.partner.com`` |
   +----------------------+---------------------+

   |image7|

TASK 2 ‑ Configure the SAML SP Access Policy
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. Begin by selecting **Access ‑> Profiles/Policies ‑>
   Access Profiles (Per‑Session Policies)**

#. Click the **Create** button (far right)

   |image8|

#. In the **New Profile** window, key in the following:

   +----------------+---------------------------+
   | Name:          | ``app.f5demo.com‑policy`` |
   +----------------+---------------------------+
   | Profile Type:  | ``All`` (from drop down)  |
   +----------------+---------------------------+
   | Profile Scope: | ``Profile`` (default)     |
   +----------------+---------------------------+

#. Scroll to the bottom of the **New Profile** window to the
   **Language Settings**
#. Select *English* from the **Factory Built‑in Languages** on the right,
   and click the **Double Arrow (<<)**, then click the **Finished** button.

   |image9|

   |br|

   |image10|

#. From the **Access ‑> Profiles/Policies ‑> Access Profiles
   (Per‑Session Policies)** screen, click the **Edit** link on the previously
   created ``app.f5demo.com‑policy`` line

   |image11|

#. In the Visual Policy Editor window for ``/Common/app.f5demo.com‑policy``,
   click the **Plus (+) Sign** between **Start** and **Deny**

   |image12|

#. In the pop‑up dialog box, select the **Authentication** tab and then click
   the **Radio Button** next to **SAML Auth**

#. Once selected, click the **Add Item** button

   |image13|

#. In the **SAML Auth** configuration window, select ``/Common/app.f5demo.com``
   from the **AAA Server** drop down menu

#. Click the **Save** button at the bottom of the window

   |image14|

#. In the **Visual Policy Editor** window for ``/Common/app.f5demo.com‑policy``,
   click the **Plus (+) Sign** on the **Successful** branch following
   **SAML Auth**

   |image15|

#. In the pop-up dialog box, select the **Assignment** tab, and then click
   the **Radio Button** next to **Variable Assign**

#. Once selected, click the **Add Item** buton

   |image16|

#. In the **Variable Assign** configuration window, click the
   **Add New Entry** button

#. Under the new **Assignment** row, click the **Change** link

#. In the pop‑up window, configure the following:

   +-------------------+--------------------------------------------+
   | Left Pane                                                      |
   +===================+============================================+
   | Variable Type:    | ``Custom Variable``                        |
   +-------------------+--------------------------------------------+
   | Security:         | ``Unsecure``                               |
   +-------------------+--------------------------------------------+
   | Value:            | ``session.logon.last.username``            |
   +-------------------+--------------------------------------------+

   +-------------------+----------------------------------------------+
   | Right Pane                                                       |
   +===================+==============================================+
   | Variable Type:    | ``Session Variable``                         |
   +-------------------+----------------------------------------------+
   | Session Variable: | ``session.saml.last.attr.name.emailaddress`` |
   +-------------------+----------------------------------------------+

#. Click the **Finished** button at the bottom of the configuration window

#. Click the **Save** button at the bottom of the **Variable Assign**
   dialog window

   |image17|

#. In the **Visual Policy Editor** select the **Deny** ending along the
   **fallback** branch following the **Variable Assign**

   |image18|

#. From the **Select Ending** dialog box, select the **Allow** button and
   then click **Save**

   |image19|

#. In the **Visual Policy Editor** click **Apply Access Policy** (top left)
   and close the **Visual Policy Editor**

   |image20|

TASK 3 ‑ Create the SP Virtual Server & Apply the SP Access Policy
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. Begin by selecting **Local Traffic -> Virtual Servers**

#. Click the **Create** button (far right)

   |image21|

#. In the **New Virtual Server** window, key in the following as shown:

   +---------------------------+----------------------------+
   | General Properties                                     |
   +===========================+============================+
   | Name:                     | ``app.f5demo.com``         |
   +---------------------------+----------------------------+
   | Destination Address/Mask: | ``10.1.10.100``            |
   +---------------------------+----------------------------+
   | Service Port:             | ``443``                    |
   +---------------------------+----------------------------+

   +---------------------------+------------------------------+
   | Configuration                                            |
   +===========================+==============================+
   | HTTP Profile:             | ``http`` (drop down)         |
   +---------------------------+------------------------------+
   | SSL Profile (Client)      | ``app.f5demo.com‑clientssl`` |
   +---------------------------+------------------------------+

   +-----------------+---------------------------+
   | Access Policy                               |
   +=================+===========================+
   | Access Profile: | ``app.f5demo.com‑policy`` |
   +-----------------+---------------------------+

   +---------+-----------------------+
   | Resources                       |
   +=========+=======================+
   | iRules: | ``application‑irule`` |
   +---------+-----------------------+

#. Scroll to the bottom of the configuration window and click **Finished**

   |image22|

   |br|

   |image23|

   |br|

   |image24|

   .. NOTE:: The iRule is being added in order to simulate an application
      server to validate successful access.

TASK 4 ‑ Test the SAML SP
~~~~~~~~~~~~~~~~~~~~~~~~~

#. Using your browser from the jump host, navigate to the SAML SP you just
   configured at ``https://app.f5demo.com`` (or click the provided bookmark)

   |image25|

#. Did you successfuly redirect to the IdP?

#. Log in to the IdP. Were you successfully authenticated?

   .. NOTE:: Use the credentials provided in the Authentication section at
      the beginning of this guide (user/Agility1)

#. After successful authentication, were you returned to the SAML SP?

#. Were you successfully authenticated to the app in the SAML SP?

#. Review your Active Sessions **(Access ‑> Overview ‑> Active Sessions­­­)**

#. Review your Access Report Logs **(Access ‑> Overview ‑> Access Reports)**

.. |br| raw:: html

   <br />

.. |image1| image:: /_static/class1/image3.png
.. |image2| image:: /_static/class1/image4.png
.. |image3| image:: /_static/class1/image5.png
.. |image4| image:: /_static/class1/image6.png
.. |image5| image:: /_static/class1/image7.png
.. |image6| image:: /_static/class1/image8.png
.. |image7| image:: /_static/class1/image9.png
.. |image8| image:: /_static/class1/image10.png
.. |image9| image:: /_static/class1/image11.png
.. |image10| image:: /_static/class1/image12.png
.. |image11| image:: /_static/class1/image13.png
.. |image12| image:: /_static/class1/image14.png
.. |image13| image:: /_static/class1/image15.png
.. |image14| image:: /_static/class1/image16.png
.. |image15| image:: /_static/class1/image17.png
.. |image16| image:: /_static/class1/image18.png
.. |image17| image:: /_static/class1/image19.png
.. |image18| image:: /_static/class1/image20.png
.. |image19| image:: /_static/class1/image21.png
.. |image20| image:: /_static/class1/image22.png
.. |image21| image:: /_static/class1/image23.png
.. |image22| image:: /_static/class1/image24.png
.. |image23| image:: /_static/class1/image25.png
.. |image24| image:: /_static/class1/image26.png
.. |image25| image:: /_static/class1/image27.png
