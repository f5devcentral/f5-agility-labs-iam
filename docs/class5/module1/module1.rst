Module 1 - Implement C3D with APM Enhancements
===============================================

As organizations move towards MFA to secure their enterprise applications, they often struggle when implementing Single Sign-On (SSO). Implementation of MFA at the proxy layer, while allowing for Single-Sign On, often requires usage of a less secure authentication method to the backend resource due to the introduction of service accounts requiring passwords. However, if an organization choses to implement MFA directly at the application, SSO is lost.

The F5 Client Certificate Constrained Delegation (C3D) feature allows the best of both worlds by allowing MFA at the proxy layer while maintaining strong security when performing SSO between the proxy and backend resource.


.. toctree::
   :maxdepth: 1
   :glob:

   lab*