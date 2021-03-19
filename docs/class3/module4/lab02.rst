Lab 2: Additional Security - Bot Defense and WAF
========================================================

The API protection profile provides authorization and basic WAF policy to protect an API. This module will demonstrate how to layer on additional protections to further validate what is accessing the API and that the client is behaving within the norms of the API.


Section 2.1 - Setup Lab Environment
----------------------------------------

By default, security events are not logged, in this lab the student will create a security logging profile with Application Security, Bot Defense and DOS Protection enabled.
The student will also place the waf policy in trasnparent to show the difference in behavior when client traffic that is deemed malicious is and is not blocked.


Task 1 - Import Postman Collection
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. From the Jumpbox, open **Postman** via the desktop shortcut or toolbar at the bottom

    |image001|

#. Click **Yes** if prompted for "Do you want to allow this app to make changes to your device?"

    |image002|

#. Click **Import** located on the top left of the Postman application

    |image003|

#.  Click **Upload Files** 

    |image004|

#. Navigate to C:\\access-labs\\class3\\module4\\student_files, select **student-class3-module4-lab02.postman_collection.json**, and click **Open**

    |image005|

#.  Click **Import**

    |image006|

#. A collection called **student-class3-module4-lab02** will appear on the left side in Postman


Task 2 - Add Vulnerable API 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. note:: Ensure you are logged into BIGIP1

#. From the web browser, navigate to Access >> API Protection >> Profile.  Click **Profile** to modify the existing profile **api-protection** Profile (not the + Plus symbol)

   |image48|

#. Click **Edit** Under Per-Request Policy

   |image49|

#. Click the **+ (Plus Symbol)** located between Start and OAuth Scope Check AuthZ

   |image101|

#. Select the **Classification** tab
#. Select **Request Classification**
#. Click **Add Item**

   |image102|

#. Select **Branch Rules**
#. Click **Add Branch Rule**
#. Enter name **GET /vulnerable**
#. Click **Change**

   |image103|

#. Click **Add Expression**

   |image104|

#. Select **Request** from the Context dropdown

#. Click **Add Expression**

   |image105|

#. Click **Add Expression** on the AND line

   |image106|

#. Select **Path (value)** from the Request dropdown
#. Enter **/vulnerable** in the empty text box
#. Click **Add Expression**

   |image107|

#. Click **Finished**

   |image108|

#. Click **Save**

   |image109|

#. Click the **+ Plus Symbol** on the GET /vulnerable branch

   |image110|

#. Click **API Server Selection**
#. Click **Add Item**

   |image111|

#. Select **api-protection_server1** from the dropdown
#. Click **Save**

   |image112|

#. Click the **Reject** terminal at the end of API Server Selection

   |image113|

#. Select **Allow**
#. Click **Save**

   |image114|

#. The completed policy should look like the below.

   |image115|


Section 2.2 - Create and Assign Profiles
-------------------------------------------

Task 1 - Create and assign a Security Logging Profile to the virtual
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. From the web browser, click on the **Security -> Event Logs -> Logging Profile** and click **Create**.


#. For the Profile Name enter **api.acme.com_logprofile**.

   |module2Lab1Task2-image1|


#. Enable **Application Security**, an Application Security configuration menu will open up at the bottom. Change the Request Type from Illegal requests only to **All requests**.

   |module2Lab1Task2-image2|

#. Enable **DoS Protection**, a DoS Protection configuration menu will open up at the bottom. Enable **Local Publisher**

   |module2Lab1Task2-image3|


#. Enable **Bot Defense**, a Bot Defense configuration menu will open up at the bottom. Enable **Local Publisher** and all other checkboxes, leave Remote Publisher set to none.

   |module2Lab1Task2-image4|

#. Click **Create**

#. Apply the log profile to the api.acme.com virtual by navigating to **Local Traffic -> Virtual Servers -> api.acme.com -> Security -> Policies** and after choosing "Enabled" from the dropdown, set the Selected Log Profile to **api.acme.com_logprofile**.

   |module2Lab1Task2-image5|

#. Click **Update**. The virtual will now log Application Security, DoS and Bot related events under **Security -> Event Logs** when an appropriate security profiles have been applied to the virtual.


Task 2 - Set the WAF policy to Transparent and assign it to the virtual
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. From the web browser, click on the Security -> Application Security -> Security Policies -> Policies List. Click  **api-protection**. Scroll down and you'll notice the Enforcement Mode is set to **Blocking**. Set the Enforcement Mode to **Transparent**. Be sure to click **Save**, then **Apply Policy**.

   |module2Lab1Task3-image1|

#. Apply the waf policy to the api.acme.com virtual by navigating to **Local Traffic -> Virtual Servers -> api.acme.com -> Security -> Policies** and set the Application Security Policy to enabled and the Policy to  **api-protection**.

   |module2Lab1Task3-image2|

#. Click **Update**.



Task 3 - Create and assign a Bot Defense Profile
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

An api's clients, unlike a typical web application, will often be non-human, maybe even exclusively.
This leaves bot defense more difficult to configure in an api protection scenario, for instance javascript such as captcha cannot be used to proactively determine whether the client is human.
In this lab, we demonstrate some scenarios the admin may encounter and how to address them.

.. note:: Ensure you are logged into BIGIP1

#. From the web browser, click on the **Security -> Bot Defense -> Bot Defense Profiles** and click **Create**.


#. For the name enter **api.acme.com_botprofile**, leave all other settings at their defaults.

   |module2Lab2Task1-image1|

#. Click **Save**

   The bot profile is left in transparent mode to demonstrate the logging behavior and behavior differences to the client.

#. Apply the bot profile to the api.acme.com virtual by navigating to **Local Traffic -> Virtual Servers -> api.acme.com -> Security -> Policies**.

For **Bot Defense Profile** select **Enabled** and select **api.acme.com_botprofile** as the Profile. Click **Update**.

   |module2Lab2Task1-image2|




Section 2.3 - Test Bot Protection
-------------------------------------------


Task 1 - Test Bot Protection in Transparent Mode
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


#. Now we will test the Bot Defense Profile to see how it affects clients. Go to **Postman**, expand the collection **student-class3-module4-lab02** and select the request **Request 1: Retrieve Attributes** and click **Send**.

#. Return to the bigip01 gui and navigate to **Security -> Event Logs -> Bot Defense -> Bot Requests** and find the request to the /vulnerable uri as shown below

   |module2Lab2Task1-image4|


   .. note:: The student should pay special attention to the Request Status, Mitigation Action and Bot Class. Bot Class will be one of the categories found in **Security -> Bot Defense -> Bot Defense Profiles -> api.acme.com_botprofile -> Bot Mitigation Settings** under **Mitigation Settings**.


Task 2 - Place Bot Profile in blocking and allow appropriate clients
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The bot profile was left in transparent to demonstrate the behavior, now we will configure the bot profile to 
block bot traffic. Keep in mind that the bot profile allows for fine-grained control of categories of bots, which bot fits in those categories. We will explore this later.

#. Navigate back to **Security -> Bot Defense -> Bot Defense Profiles -> api.acme.com_botprofile**, change the **Enforcement Mode** to  **Blocking** and click **Save**.

   |module2Lab2Task2-image1| 

#. Go back to **Postman** once again and select the request **Request 1: Retrieve Attributes** and click **Send** another time.

#.  Return to the bigip01 gui and navigate to **Security -> Event Logs -> Bot Defense -> Bot Requests** and find the 2nd request to the /vulnerable uri as shown below

   |module2Lab2Task2-image3| 

   .. note:: Why was this request not blocked? To understand this, we must take a closer look at the Mitigation Settings.
   
#. Navigate to **Security -> Bot Defense -> Bot Defense Profiles -> api.acme.com_botprofile -> Bot Mitigation Settings** and examine the **Unknown** categorization, note that bots that are of category Unknown are simply rate limited.

   |module2Lab2Task2-image4|

#. Go back to **Postman** once again, click on the **Arrow** in the right corner of the collection **student-class3-module4-lab02** collection to open **Runner**.  

   |image007|

#. Click Run

#. Configure Runner so  **iterations** is set to **100** and the only request selected is  **Request 1: Retrieve Attributes**.

#. Click **Run student-class...**.  

   |image008|

#. Notice all responses are 200 OKs.

   |image009|

#. Return to the bigip01 gui and navigate to **Security -> Event Logs -> Bot Defense -> Bot Requests** and find the Denied request to the /vulnerable uri as shown below.

   |module2Lab2Task2-image7|

#. We will recategorize the Postman client so that it is a trusted client, this is done via bot signatures. Navigate to **Security -> Bot Defense -> Bot Signatures -> Bot Signatures Categories List** and click **Create**.

#. Fill in the Bot Signature Category Name of **Trusted Development Tools** and select **Trusted Bot** from the Bot Class dropdown.

   |module2Lab2Task2-image12|

#. Navigate to **Security -> Bot Defense -> Bot Signatures -> Bot Signatures List** and click **Create**.

   |module2Lab2Task2-image8|

#. Fill in the Bot Name, Bot Category and Rule (User Agent) with the following, leaving all other values at their defaults.

   |module2Lab2Task2-image9|

#. Click **Save**.

#. Go back to Postman once again and select the request **Request 1: Retrieve Attributes** and click **Send** another time. Note this is done at the main Postman window, not in Runner.


#. Navigate to **Security -> Event Logs -> Bot Defense -> Bot Requests** and find the Trusted Bot categorized request to the /vulnerable uri as shown below


   |module2Lab2Task2-image11|


Section 2.4 - Layer on WAF to provide additional security
----------------------------------------------------------------------------


APIs are a collection of technologies just like any other application, in the lab the api is built on top of a windows server using powershell. This lab demonstrate how to tune the WAF policy to use attack signatures and meta-character enforcement to provide additional protection against malicious clients.

Meta-character enforcement allows the WAF admin to enforce which characters are allowed into a web application, whether it be in the header, url or parameter. In this lab we examine parameter meta-character enforcement.


Task 1 - Configure Attack Signatures and Change WAF Policy to Blocking
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. Open a command prompt on the jumphost (a shortcut is on the desktop) 

   |module2Lab3Task1-image2|

#. Run the following command **curl -k "https://api.acme.com/vulnerable?Inject=|powershell%20badprogram.ps1" -v**

	.. note:: Pay special attention to the double quotes ("") around the url.

#. Navigate to **Security -> Event Logs -> Application -> Requests** and find this latest request. Locate the parameter value **|powershell badprogram.ps1**. Click the parameter and then hover over the parameter value and additional details will describe this part of the attack.

   |module2Lab3Task1-image3|

   .. note:: The **Enforcement Action** is None

	The F5 WAF highlights the part of the request it detects as malicious based on the policy's configuration. This can be very useful for learning and troubleshooting purposes.

#. Next hover over the **User-Agent** portion of the request.

   |module2Lab3Task1-image4|

	Notice the user-agent is curl, which may be a legitimate client. Make note of this.

	Ideally we want to block any malicious request, in this case the powershell execution attempt, but want to allow curl as it's a legitimate client in our case. What about the %20 meta character, should it be allowed? Depending on the application, this could be legitimate.
	
	In your environment, you must decide what is legitimate and what is illegitimate traffic, the F5 WAF can guide you via learning and help eliminate noise using Bot Defense, however to increase security beyond a basic WAF policy, understanding the application is needed.

#. Click on the  **Security -> Application Security -> Policy Building -> Learning and Blocking Settings -> Attack Signatures** and click Change

   |module2Lab3Task1-image5|

#. Enable **Command Execution Signatures** and click **Change**

   |module2Lab3Task1-image6|

#. Scroll to the bottom anc click **Save**.

   |module2Lab3Task1-image7|

#. Navigate to Security -> Application Security -> Security Policies -> **Policies List**.

#. Click  **api-protection** 

#. Click **Attack Signatures** 

#. Click the filter icon to easily locate the **Automated client access "curl"** signature.

   |module2Lab3Task1-image8| 

#. For the Attack Signature Name enter **Automated client access "curl"** and click **Apply Filter**.

   |module2Lab3Task1-image9|

   The result is

   |module2Lab3Task1-image10|

#. Select this signature and click **Disable**

   |module2Lab3Task1-image11|

#. Click **General Settings** and scroll down to "Enforcement Mode" and change it to "Blocking." Click Save and then Apply the Policy

   |module2Lab3Task1-image12|

#. Once again run the following command **curl -k "https://api.acme.com/vulnerable?Inject=|powershell%20badprogram.ps1" -v**

   **Pay special attention to the double quotes ("") around the url.**

#. Navigate to **Security -> Event Logs -> Application -> Requests** and find this latest request.

   |module2Lab3Task1-image13|

   Notice the enforcement action is still **None** but also notice the user-agent curl is no longer highlighted (since the signature was disabled). We changed the Policy to Blocking so why wasn't the request blocked? Hint: Click the "1" under Occurrences and you'll see the current status of the Attack Signature.

#. Hover over the highlighted payload and notice that the powershell attack signature is triggered.

   |module2Lab3Task1-image14|

   Powershell execution via http parameters is now mitigated. If you noticed in the request, that the **|** is considered illegal.
   What if that character was a legitimate value for a parameter?

   |module2Lab3Task1-image15|

#. Go back to the command prompt on the jumphost and run

   **curl -k "https://api.acme.com/vulnerable?param1=|legitimate%20value" -v**
   |

#. Navigate to **Security -> Event Logs -> Application -> Requests** and find this latest request. Notice the **|** is considered illegal. However its not blocked, the Enforcement Action is None

   |module2Lab3Task1-image16|

#. To see why this parameter character violation is not being blocked, but is being logged (alarmed). Navaigate to **Security -> Application Security -> Policy Building -> Learning and Blocking Settings -> Parameters** and enable the **Block** column for the **Illegal meta character in value** under the Parameters Section

   |module2Lab3Task1-image17|

#. Click **Save** then **Apply Policy**

#. Go back to the command prompt on the jumphost and run 

   **curl -k "https://api.acme.com/vulnerable?param1=|legitimate%20value" -v**
   |

#. Navigate to **Security -> Event Logs -> Application -> Requests** and find this latest request. Notice the **|** is considered illegal and is now blocked.

   |module2Lab3Task1-image18|


Task 2 - Implement Static Parameter values
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. From Postman, click "Send" on the **Request 2: SSRF Attack-Google* request.  Notice you get content from restapiexammple.com via api.acme.com/vulnerable.  This endpoint is vulnerable to Server Side Request Forgery attacks

   |image118|

#. From Postman, run **Request 3: SSRF Attack-unprotected-json**. This site contains example ID and keys in JSON format.  Hackers will uses your servers as a jump off point to gain access to internal resources 

   |image119|

#. Navigate to **Security -> Event Logs -> Application -> Requests** and find both requests.  Notice nothing appears malicious about these requests except for the destinations. 

   |image120|

#.  We are going to secure the the uri parameter, so it only allows access to restapiexample, but not access to the internal private data.

#. Navigate to **Security -> Application Security -> Parameters -> Parameters List**.  Click the **+ Plus Symbol**

   |image121|

#. Enter the Name **uri**
#. Uncheck **Perform Staging**
#. From the Parameter Value Type dropdown select **Static Content Value**
#. Enter **https://www.google.com** for the New Static Value 
#. Click **Add**
#. Click **Create**

   |image122|

#. Click **Apply Policy**

#. From Postman, run **Request 2: SSRF Attack-Google**.  Access to Google is still allowed.

#. From Post, run **Request 3: SSRF Attack-unprotected-json**. This site is now blocked as intended

   |image123|

#. Navigate to **Security -> Event Logs -> Application -> Requests** and find the latest blocked request.  The uri parameter is highlighted due to Illegal Static Parameter Value.

   |image124|


.. |image001| image:: media/lab02/001.png
.. |image002| image:: media/lab02/002.png
.. |image003| image:: media/lab02/003.png
.. |image004| image:: media/lab02/004.png
.. |image005| image:: media/lab02/005.png
.. |image006| image:: media/lab02/006.png
.. |image007| image:: media/lab02/007.png
.. |image008| image:: media/lab02/008.png
.. |image009| image:: media/lab02/009.png


.. |image48| image:: media/lab02/image048.png
.. |image49| image:: media/lab02/049.png
.. |image64| image:: media/lab02/image064.png
.. |image101| image:: media/lab02/101.png
	:width: 800px
.. |image102| image:: media/lab02/image102.png
	:width: 800px
.. |image103| image:: media/lab02/image103.png
.. |image104| image:: media/lab02/image104.png
.. |image105| image:: media/lab02/image105.png
.. |image106| image:: media/lab02/image106.png
.. |image107| image:: media/lab02/image107.png
.. |image108| image:: media/lab02/image108.png
.. |image109| image:: media/lab02/image109.png
.. |image110| image:: media/lab02/110.png
.. |image111| image:: media/lab02/image111.png
.. |image112| image:: media/lab02/image112.png
.. |image113| image:: media/lab02/113.png
	:width: 1200px
.. |image114| image:: media/lab02/image114.png
.. |image115| image:: media/lab02/115.png
	:width: 1200px

.. |image116| image:: media/lab02/image116.png
	:width: 400px
.. |image117| image:: media/lab02/image117.png
	:width: 400px
.. |image118| image:: media/lab02/118.png
	:width: 800px
.. |image119| image:: media/lab02/119.png
	:width: 800px
.. |image120| image:: media/lab02/image120.png
	:width: 800px
.. |image121| image:: media/lab02/image121.png
	:width: 800px
.. |image122| image:: media/lab02/image122.png
	:width: 800px
.. |image123| image:: media/lab02/image123.png
	:width: 800px
.. |image124| image:: media/lab02/image124.png
	:width: 800px


..  |module2Lab1Task3-image2| image:: media/lab02/module2Lab1Task3-image2.png
        :width: 800px
..  |module2Lab1Task3-image1| image:: media/lab02/module2Lab1Task3-image1.png
        :width: 800px
..  |module2Lab1Task2-image5| image:: media/lab02/module2Lab1Task1-image5.png
        :width: 400px
..  |module2Lab1Task2-image4| image:: media/lab02/module2Lab1Task1-image4.png
        :width: 400px
..  |module2Lab1Task2-image3| image:: media/lab02/module2Lab1Task1-image3.png
        :width: 400px
..  |module2Lab1Task2-image2| image:: media/lab02/module2Lab1Task1-image2.png
        :width: 800px
..  |module2Lab1Task2-image1| image:: media/lab02/module2Lab1Task1-image1.png

..  |module2Lab2Task1-image1| image:: media/lab02/module2Lab2Task1-image1.png
        :width: 800px
..  |module2Lab2Task1-image2| image:: media/lab02/module2Lab2Task1-image2.png
        :width: 800px
..  |module2Lab2Task1-image3| image:: media/lab02/module2Lab2Task1-image3.png
        :width: 800px
..  |module2Lab2Task1-image4| image:: media/lab02/module2Lab2Task1-image4.png
        :width: 800px
..  |module2Lab2Task2-image1| image:: media/lab02/module2Lab2Task2-image1.png
        :width: 800px
..  |module2Lab2Task2-image2| image:: media/lab02/module2Lab2Task2-image2.png
        :width: 800px
..  |module2Lab2Task2-image3| image:: media/lab02/module2Lab2Task2-image3.png
        :width: 800px
..  |module2Lab2Task2-image4| image:: media/lab02/module2Lab2Task2-image4.png
        :width: 800px
..  |module2Lab2Task2-image5| image:: media/lab02/module2Lab2Task2-image5.png
        :width: 800px
..  |module2Lab2Task2-image6| image:: media/lab02/module2Lab2Task2-image6.png
        :width: 800px
..  |module2Lab2Task2-image7| image:: media/lab02/module2Lab2Task2-image7.png
        :width: 800px
..  |module2Lab2Task2-image8| image:: media/lab02/module2Lab2Task2-image8.png
        :width: 800px
..  |module2Lab2Task2-image9| image:: media/lab02/module2Lab2Task2-image9.png
        :width: 800px
..  |module2Lab2Task2-image10| image:: media/lab02/module2Lab2Task2-image10.png
        :width: 800px
..  |module2Lab2Task2-image11| image:: media/lab02/module2Lab2Task2-image11.png
        :width: 800px

..  |module2Lab2Task2-image12| image:: media/lab02/module2Lab2Task2-image12.png
        :width: 800px

..  |module2Lab3Task1-image18| image:: media/lab02/module2Lab3Task1-image18.png
        :width: 800px
..  |module2Lab3Task1-image17| image:: media/lab02/module2Lab3Task1-image17.png
        :width: 800px
..  |module2Lab3Task1-image16| image:: media/lab02/module2Lab3Task1-image16.png
        :width: 400px
..  |module2Lab3Task1-image15| image:: media/lab02/module2Lab3Task1-image15.png
        :width: 400px
..  |module2Lab3Task1-image14| image:: media/lab02/module2Lab3Task1-image14.png
        :width: 400px
..  |module2Lab3Task1-image13| image:: media/lab02/module2Lab3Task1-image13.png
        :width: 800px
..  |module2Lab3Task1-image12| image:: media/lab02/module2Lab3Task1-image12.png
        :width: 800px
..  |module2Lab3Task1-image11| image:: media/lab02/module2Lab3Task1-image11.png
        :width: 800px
..  |module2Lab3Task1-image10| image:: media/lab02/module2Lab3Task1-image10.png
        :width: 800px
..  |module2Lab3Task1-image9| image:: media/lab02/module2Lab3Task1-image9.png
        :width: 800px
..  |module2Lab3Task1-image8| image:: media/lab02/module2Lab3Task1-image8.png
        :width: 100px
..  |module2Lab3Task1-image7| image:: media/lab02/module2Lab3Task1-image7.png
        :width: 200px
..  |module2Lab3Task1-image6| image:: media/lab02/module2Lab3Task1-image6.png
        :width: 800px
..  |module2Lab3Task1-image5| image:: media/lab02/module2Lab3Task1-image5.png
        :width: 800px
..  |module2Lab3Task1-image4| image:: media/lab02/module2Lab3Task1-image4.png
        :width: 400px
..  |module2Lab3Task1-image3| image:: media/lab02/module2Lab3Task1-image3.png
        :width: 800px
..  |module2Lab3Task1-image2| image:: media/lab02/module2Lab3Task1-image2.png
        :width: 100px
..  |module2Lab3Task1-image1| image:: media/lab02/module2Lab3Task1-image1.png
        :width: 800px





