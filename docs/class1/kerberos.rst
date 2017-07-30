Reference: Kerberos AAA Object
==============================

The following is an example of the AAA Server object used in **Lab 3:
Kerberos to SAML Lab** (the **/Common/apm-krb-aaa** used in Task 1).

AD User and Keytab
~~~~~~~~~~~~~~~~~~

#. Create a new user in Active Directory
#. In this example, the User Logon Name *kerberos* has been created

   |image113|

#. From the Windows command line, run the KTPASS command to generate a keytab
   file for the previously created user object

   ``ktpass /princ HTTP/kerberos.acme.com@ACME.COM /mapuser acme\kerberos /ptype KRB5_NT_PRINCIPAL /pass password /out c:\file.keytab``

   +-------------------------+-----------------------+
   | FQDN of virtual server: | ``kerberos.acme.com`` |
   +-------------------------+-----------------------+
   | AD Domain (UPN format): | ``@ACME.COM``         |
   +-------------------------+-----------------------+
   | Username:               | ``acme\kerberos``     |
   +-------------------------+-----------------------+
   | Password:               | ``password``          |
   +-------------------------+-----------------------+

#. Review the changes to the AD User object

   |image114|

Kerberos AAA Object
~~~~~~~~~~~~~~~~~~~

#. Create the AAA object by navigating to **Access ‑> Authentication ->
   Kerberos**

#. Specify a **Name**

#. Specify the **Auth Realm** (Ad Domain)

#. Specify a **Service Name** (This should be *HTTP* for http/https services)

#. Browse to locate the **Keytab File**

#. Click **Finished** to complete creation of the AAA object

   |image115|

#. Review the AAA server configuration at **Access ‑> Authentication**

.. |image113| image:: /_static/class1/image100.png
.. |image114| image:: /_static/class1/image101.png
.. |image115| image:: /_static/class1/image102.png
.. |image116| image:: /_static/class1/image103.png
