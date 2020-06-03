Module: Additional Information and Troubleshooting Tips
=======================================================

It is possible to implement an APM profile in front of the ADFS server.
The deployment guide covers requirements, or you can select to deploy an
APM profile in the iApp and it will handle everything including the
required selective APM bypass iRule and SSO into ADFS.

When logging in to the default APM logon page, you do not need to
specify the domain like you do on the ADFS logon page, just typing
“user” (the samAccountName) will be sufficient. You can customize the
APM logon page to accept samAccountName, UPN, or domain\\username if
desired.

The service that handles the MS-ADFSPIP trust relationship is
adfs\_proxy. You can restart this service if needed with the following
CLI command: bigstart restart adfs\_proxy.

If you cannot establish trust, it could be because the primary ADFS
server is offline. The primary ADFS server in the farm must be
functioning or new WAPs/Proxies cannot establish trust.

Microsoft provides a service called ClaimsXRay at
https://adfshelp.microsoft.com that is very useful for troubleshooting
ADFS related issues. There is a shortcut to it on your Chrome browser.
The shortcut is configured to populate the values for ClaimsXRay for
this lab environment so that you do not need to enter them into the
webpage manually. It will redirect to your ADFS environment, where you
can authenticate, then send you to ClaimsXRay where you can examine the
claims.

For more information on this solution, go here:
https://devcentral.f5.com/articles/ad-fs-proxy-replacement-on-f5-big-ip-30191

For the deployment guide, go here:
https://f5.com/solutions/deployment-guides/microsoft-active-directory-federation-services-big-ip-v11-ltm-apm
