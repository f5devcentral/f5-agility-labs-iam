Reference: Kerberos AAA Object
==============================

The following is an example of the AAA Server object used in **Lab 3:
Kerberos to SAML Lab** (the **/Common/apm-krb-aaa** used in Task 1).

AD User and Keytab
~~~~~~~~~~~~~~~~~~

1. Create a new user in Active Directory
2. In this example, the User Logon Name *kerberos* has been created

|image113|

2. From the Windows command line, run the KTPASS command to generate a keytab file for the previously created user object

``ktpass /princ HTTP/kerberos.acme.com@ACME.COM /mapuser acme\kerberos /ptype KRB5_NT_PRINCIPAL /pass password /out c:\file.keytab``

+-------------------------+---------------------+
| FQDN of virtual server: | *kerberos.acme.com* |
+-------------------------+---------------------+
| AD Domain (UPN format): | *@ACME.COM*         |
+-------------------------+---------------------+
| Username:               | *acme\\kerberos*    |
+-------------------------+---------------------+
| Password:               | *password*          |
+-------------------------+---------------------+

3. Review the changes to the AD User object

|image114|

Kerberos AAA Object
~~~~~~~~~~~~~~~~~~~

1. Create the AAA object by navigating to **Access ‑> Authentication -> Kerberos**
2. Specify a **Name**
3. Specify the **Auth Realm** (Ad Domain)
4. Specify a **Service Name** (This should be *HTTP* for http/https services)
5. Browse to locate the **Keytab File**
6. Click **Finished** to complete creation of the AAA object

|image 115|

7. Review the AAA server configuration at **Access ‑> Authentication**

.. |image113| image:: media/image100.png
.. |image114| image:: media/image101.png
.. |image115| image:: media/image102.png
.. |image116| image:: media/image103.png
