
XenDesktop and XenApp demo with :

    Xen DDC 7.14

    Storefront 3.11

    Active Directory Domain Controler

    Windows client

    BIGIP 13.1 with Storefront protocol support. The VDI profile has been modified in order to support the Storefront protocol in the "WITHOUT Storefront" use case.

First of all:

    check if SQL express server service is running. Else, start it.
    check that all Citrix services are up and running on Xen DDC and Storefront. If it is not the case, start all of them.
    How-to start services : https://youtu.be/50YB5Fx2ASU

SQL server must be up and running first. Else Citrix service will start but will fail. So please restart citrix services if SQL was not running.

If the Storefront fails, just reboot it and wait 5 minutes. Sometime, the Storefront starts before the ADDC and XenApp server and you can see the message "Cannot complete your request" after SSO.

Then, check the license and renew it if needed: https://youtu.be/8Uh5mhSeHkU
WARNING : for the licensing, Request a Xen Desktop license and enter XenApp1 as Server Hostname.

Demo script:

    With Storefront:

    RDP to Win client machine as "ITC\user1" and password "user1"
    Launch Chrome browser
    Click on the bookmark "With Storefront"
    Authenticate to APM with "user" / "user"
    Then click on a Citrix ressource
    Logout from the start menu if you click on the Windows 2017 machine.

    Without Storefront (Storefront replacement)

    RDP to Win client machine as "ITC\user1" and password "user1"
    Launch Chrome browser
    Click on the bookmark "Without Storefront"
    Authenticate to APM with "user" / "user"
    Then click on a Citrix ressource
    Logout from the start menu if you click on the Windows 2017 machine.

You can make a demo with Citrix Receiver Initiated.

    Click on Receiver icon in the taskbar
    Login as itc\user1 and password user1
    Click on any apps or desktop.

Receiver initiated works only in "WITHOUT Storefront" (due to XenApp and BIGIP configuration).
