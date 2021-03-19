Lab 3: Server-Side Single Sign-On
=====================================

The purpose of this lab is to demonstrate Single Sign-On capabilities
of APM.    The SSO Credential Mapping action enables users to forward
stored user names and passwords to applications and servers automatically,
without having to input credentials repeatedly.   This allows single
sign-on (SSO) functionality for secure user access.  As different applications
and resources support different authentication mechanisms, the SSO system
may be required to store and transform credentials to meet these requirements.
For example, username and password may be transformed into forms-based
authentication, a SAML assertion into Kerberos or Kerberos authentication into
SAML.

Although a number of different SSO methods exist, this lab will demonstrate access
single SSO method, the Kerberos to SAML method.

Objective:

-  Gain an understanding of SSO Token User Name Caching and SSO Token Password
   Caching.

-  Gain an understanding of the Kerberos to SAML relationship and its
   component parts.

-  Develop an awareness of the different deployment models that Kerberos
   to SAML authentication opens up

Lab Requirements:

-  All Lab requirements will be noted in the tasks that follow

Estimated completion time: 15 minutes

|Lab3-Image1|

A user is prompted to select their certificate.
The validation of the user certificates is controlled via CA bundles selected in the Client-side SSL Profile.
The certificate is validated by OCSP if the user presents a certificate issued by a trusted CA
The othername field is extracted from the certificate
A LDAP query is performed to collect the sAMAccountName of the user
The domain and username variables are set
The user is granted access via the Allow Terminal
If the LDAP Query is unsuccessful, the user proceeds down the fallback branch to the Deny Terminal
If the OCSP check is unsuccessful, the user proceeds down the fallback branch to the Deny Terminal
If the user fails to present a certificate, the user proceeds down the fallback branch to the Deny Terminal


Policy Agent Configuration

- The On-Demand Cert Auth Agent uses the default settings

|Lab3-Image2|

- The OCSP Agent validates the certificate against the OCSP responder configured

|Lab3-Image3|

- The othername field is extracted from the certificate and saved as session variable session.custom.upn

|Lab3-Image4|

- The LDAP query connects to the LDAP server to the dc=f5lab,dc=local DN for a user that contains the userPrincipalName matching the value stored in session.custom.upn

- The LDAP query requests the sAMAccountName attribute if the user is found

|Lab3-Image5|

- The branch rule was modified to only require a LDAP Query passed condition

|Lab3-Image6|

Two session variables are set
session.logon.last.username is populated with the value of the sAMAccountName returned in the LDAP query
session.logon.last.domain is populated with a static value for the Active Directory domain F5LAB.LOCAL

|Lab3-Image7|

Customized LTM Profile settings

The Client-side SSL profile Client Authentication section has been modified to support certificate authentication
  Trusted Certificate Authorities has been set to ca.f5lab.local
    The bundle validates client certificates by these issuers
    The bundle must include all CAs in the chain
Advertised Certificate Authorities has ben set to ca.f5lab.local
  The bundle controls which certificates are displayed to a user when they are prompted to select their certificate

  |Lab3-Image8|

  Customized APM Profile Settings
The SSO/Auth Domains of the APM profile is configured with the Kerberos SSO Profile needed to authenticate to the server.

  |Lab3-Image9|

  Supporting APM Objects
AAA OCSP Responder
The OCSP Responder has been configured with the following settings

- URL: this field is only used if you check the Ignore AIA field
- Certificate Authority File: contains the root ca bundle
- Certificate Authority Path: this field is only used if you check the Ignore AIA field

|Lab3-Image10|

AAA LDAP Object

A single LDAP server of 10.1.20.7 has been configured with a admin service account to support queries

|Lab3-Image11|

Kerberos SSO Object
- The Username Source field has been modified from the default to reference the sAMAccountName stored in session.logon.last.username
- Kerberos Realm has been set to the Active Directory domain (realms should always be in uppercase)
- The service account used for Kerberos Constrained Delegation (Service Account Names should be in SPN format)
- SPN Pattern has been hardcoded to HTTP/solution6.acme.com (This is only necessary if the SPN doesn’t match the FQDN typed in the web browser by the user)

|Lab3-Image12|

The Policy from a user’s perspective
User1
User1 is prompted to select their certificate

|Lab3-Image13|

If successful the user is granted access to the application

|Lab3-Image14|

Lab 3 is now complete.

.. |Lab3-Image1| image:: /class1/module2/media/Lab3-Image1.png
.. |Lab3-Image2| image:: /class1/module2/media/Lab3-Image2.png
.. |Lab3-Image3| image:: /class1/module2/media/Lab3-Image3.png
.. |Lab3-Image4| image:: /class1/module2/media/Lab3-Image4.png
.. |Lab3-Image5| image:: /class1/module2/media/Lab3-Image5.png
.. |Lab3-Image6| image:: /class1/module2/media/Lab3-Image6.png
.. |Lab3-Image7| image:: /class1/module2/media/Lab3-Image7.png
.. |Lab3-Image8| image:: /class1/module2/media/Lab3-Image8.png
.. |Lab3-Image9| image:: /class1/module2/media/Lab3-Image9.png
.. |Lab3-Image10| image:: /class1/module2/media/Lab3-Image10.png
.. |Lab3-Image11| image:: /class1/module2/media/Lab3-Image11.png
.. |Lab3-Image12| image:: /class1/module2/media/Lab3-Image12.png
.. |Lab3-Image13| image:: /class1/module2/media/Lab3-Image13.png
.. |Lab3-Image14| image:: /class1/module2/media/Lab3-Image14.png
