Lab 3: LTM+APM Per Request Policies
==========================================

.. toctree::
   :maxdepth: 1
   :glob:

The purpose of this lab is to familiarize the Student with Per Request Policies.  
The F5 Access Policy Manager (APM) provides two types of policies.

Access Policy - The access policy runs when a client initiates a session.   Depending
on the actions you include in the access policy, it can authenticate the user
and perform group or class queries to populate session variables with data for
use throughout the session.

Per-Request Policy - After a session starts, a per-request policy runs each time
the client makes an HTTP or HTTPS request.  A per-request policy can include a
subroutine, which starts a subsession.  Multiple subsessions can exist at one
time. One access policy and one per-request are specified within a virtual server.

**It's important to note that APM first executes a per-session policy when a client
attempts to connect to a resource.   After the session starts then a per-request 
policy runs on each HTTP/HTTPS request.  Per-Request policies can be utilized in a 
number of different scenarios; however, in the interest of time this lab will only 
demonstrate one method of leveraging Per-Request policies**

This lab will only focus on configuring Per-Request policies for controlling access
to external URL categories.   


Objective:

-  Gain an understanding of Per Request policies

-  Gain an understanding of Step-up Authentication

-  Gain an understanding of Group Control


Lab Requirements:

-  All lab requirements will be noted in the tasks that follow

Estimated completion time: 20 minutes

TASK 1 – Configure a new Per-Request Policy
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Creating a per-request policy

#	On the Main tab, click Access, Profiles, Per-Request Policies.
#	Click Create
#	In the Name field, type the following name for the policy - URL_Filter_User_Group
#	Leave the Policy Type set to All
#	In the Languages setting, select English
#	Click Finished


Modifying the URL_Filter_User_Group policy

#  On the Main tab, click Access, Profiles, Per-Request Policies

#  Click the Edit link for the URL_Filter_User_Group Per-Request policy

#  Click the + button, and click on the Classification tab and select the Category Lookup item

#  Click finished

#  Now click the plus sign to the right of Category Lookup

#  On the Authentication tab select AD Group Lookup

#  Click on the Branch Rules tab

#  Click Add Branch Rule

#  The first Branch Rule will be named "Users Primary Group ID Sales Engineering"

#  For the first Branch Rule click on the change which will open a new window

#  Click on Add Expression, the click on the Advanced tab

#  Copy the following: expr {[mcget {session.ad.last.attr.primaryGroupID}] == Sales Engineering}

#  Click Finished

#  Now click Add Branch Rule

#  Click on the Advanced tab and copy the following: expr {[mcget {session.ad.last.attr.primaryGroupID}] == Sales}

#  Click Finished and then click Save

#  On the "User Primary Group ID Sales Engineering Branch click the plus sign

#  Click the Classification tab item and click Add Item

#  Within the URL Filter drop down menu select /Common/basic-security

#  Click Save

#  Now click on the plus sign to the right of AD Group Lookup title "User Primary Group ID Sales"

#  Click the Classification tab and select URL Filter Assign, and within URL Filter select /Common/allow-allow

#  Click Save

#  Ensure the Fallback branch for both URL Filter Assign objects is configured for Allow with fallback set to Reject



# On the Main tab, click Access, Per Session Policies and click create

# Name the Policy AD_Auth

# Ensure the Profile Type is set to All while leaving all other defaults and click Finished

# Now we will Edit the AD_Auth Per Session Policy

# Click the Edit button

# Click the + sign to the right of Start

# Click the Authentication tab, and click on the AD Auth item and click Add Item

# Under the Active Directory settings select the /Common/pre-built-ad-servers

# Ensure the "Show Extended Error" setting is set to Disabled

# Ensure the Successful Branch is set to Allow


** At this point you should now have a Per-Request Policy and a Per-Session Policy**






