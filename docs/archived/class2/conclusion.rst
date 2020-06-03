Conclusion
==========

Learn More
----------

**Links & Information**

-  **Access Policy Manager (APM) Operations Guide:**

   https://support.f5.com/content/kb/en-us/products/big-ip_apm/manuals/product/f5-apm-operations-guide/_jcr_content/pdfAttach/download/file.res/f5-apm-operations-guide.pdf

-  **Access Policy Manager (APM) Authentication & Single Sign On Concepts:**

   https://support.f5.com/kb/en-us/products/big-ip_apm/manuals/product/apm-authentication-sso-13-0-0.html

-  **OAuth Overview:**

   https://support.f5.com/kb/en-us/products/big-ip_apm/manuals/product/apm-authentication-sso-13-0-0/35.html#guid-c1b617a7-07b5-4ad6-9b84-29d6ecd789b4

-  **OAuth Client & Resource Server:**

   https://support.f5.com/kb/en-us/products/big-ip_apm/manuals/product/apm-authentication-sso-13-0-0/36.html#guid-c6db081e-e8ac-454b-84c8-02a1a282a888

-  **OAuth Authorization Server:**

   https://support.f5.com/kb/en-us/products/big-ip_apm/manuals/product/apm-authentication-sso-13-0-0/37.html#guid-be8761c9-5e2f-4ad8-b829-871c7feb2a20

-  Troubleshooting Tips

   -  **OAuth Client & Resource Server:**

      https://support.f5.com/kb/en-us/products/big-ip_apm/manuals/product/apm-authentication-sso-13-0-0/36.html#guid-774384bc-cf63-469d-a589-1595d0ddfba2

   -  **OAuth Authorization Server:**

      https://support.f5.com/kb/en-us/products/big-ip_apm/manuals/product/apm-authentication-sso-13-0-0/37.html#guid-8b97b512-ec2b-4bfb-a6aa-1af24842ee7a

Lab Reproduction
----------------

If you are building your own, here is some important information about
the environment not covered in the lab. This lab environment requires
two Big-IPs. One will act as an OAuth Client and Resource (Client/RS)
Server. The other will act as an OAuth Authorization Server (AS). Both
must be licensed and provisioned for Access Policy Manager (APM).

On the OAuth Client/RS Big-IP you will need backend pools for the two
virtual servers, the lab expects a webapp behind the Social VS that
accepts a header named x-user and reposts it back to the user. The lab
expects an API behind the API VS that can respond with a list of
departments to a request to /department. Also, a DNS Resolver must be
configured on this Big-IP, in our case we don’t have a local DNS server
to respond for the names used, so we are also leveraging an iRule and VS
to answer DNS requests for specific names. You will need a browser for
testing the social module and Postman for testing the API module.