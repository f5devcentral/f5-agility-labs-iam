Lab 5: Command Line Tools
===========================

This lab will show you how to make use of some of the Command Line
Utilities for troubleshooting Access Policy Manager when dealing with
Authentication issues that you could experience.

Questions to ask yourself (LAB5)
--------------------------------

-  What should I expect in the Logs with Default Settings?

-  Can I review the APM configuration from TMSH?

-  Can I review Session Data from the CLI?

-  How can I test if the AAA server responds to Authentication Tests
   using CLI Tools?

-  How can I test if the AAA server respond to Query Tests using CLI
   Tools?

-  How can I change the Logging Level for more Verbose details?

-  How can I use iRules for Troubleshooting Assistance?

-  How can I use TCPDump for Troubleshooting Assistance?

What’s Not Covered but we will discuss
--------------------------------------

-  VDI Troubleshooting/Debug Logging

-  SAML Troubleshooting Tools – SAML Tracer (Not CLI based)







.. |image130| image:: /_static/class8/image143.png
   :width: 5.30000in
   :height: 1.16923in
.. |image131| image:: /_static/class8/image145.png
   :width: 5.30972in
   :height: 4.63194in
.. |image132| image:: /_static/class8/image147.png
   :width: 5.30972in
   :height: 6.07083in
.. |image133| image:: /_static/class8/image148.png
   :width: 5.30000in
   :height: 1.12308in
.. |image134| image:: /_static/class8/image149.png
   :width: 5.30000in
   :height: 0.93846in
.. |image135| image:: /_static/class8/image150.png
   :width: 5.29570in
   :height: 3.03125in
.. |image136| image:: /_static/class8/image151.png
   :width: 5.30000in
   :height: 0.98462in
.. |image137| image:: /_static/class8/image152.png
   :width: 5.30000in
   :height: 0.98025in
.. |image138| image:: /_static/class8/image153.png
   :width: 5.30000in
   :height: 0.90810in
.. |image139| image:: /_static/class8/image154.png
   :width: 5.30000in
   :height: 1.37069in
.. |image140| image:: /_static/class8/image155.png
   :width: 5.30000in
   :height: 1.09365in
.. |image141| image:: /_static/class8/image156.png
   :width: 5.30000in
   :height: 0.91667in
.. |image142| image:: /_static/class8/image157.png
   :width: 5.30000in
   :height: 0.62207in
.. |image143| image:: /_static/class8/image158.png
   :width: 5.30972in
   :height: 2.10556in
.. |image144| image:: /_static/class8/image159.png
   :width: 5.30972in
   :height: 1.06944in
.. |image145| image:: /_static/class8/image160.png
   :width: 5.30972in
   :height: 4.00625in
.. |image146| image:: /_static/class8/image34.png
   :width: 5.30000in
   :height: 5.20239in
.. |image147| image:: /_static/class8/image162.png
   :width: 5.30000in
   :height: 1.79246in
.. |image148| image:: /_static/class8/image62.png
   :width: 5.20855in
   :height: 3.44792in
.. |image149| image:: /_static/class8/image163.png
   :width: 5.30650in
   :height: 2.30208in
.. |image150| image:: /_static/class8/image165.png
   :width: 5.30972in
   :height: 3.97778in
.. |image151| image:: /_static/class8/image166.png
   :width: 5.30874in
   :height: 2.17708in
.. |image152| image:: /_static/class8/image167.png
   :width: 5.36458in
   :height: 5.70163in
.. |image153| image:: /_static/class8/image168.png
   :width: 5.30000in
   :height: 1.03609in
.. |image154| image:: /_static/class8/image169.png
   :width: 5.30000in
   :height: 0.62673in
.. |image155| image:: /_static/class8/image170.png
   :width: 5.30000in
   :height: 0.44278in
.. |image156| image:: /_static/class8/image171.png
   :width: 5.30863in
   :height: 2.36458in
.. |image157| image:: /_static/class8/image167.png
   :width: 5.30000in
   :height: 5.63299in
.. |image158| image:: /_static/class8/image172.png
   :width: 5.30000in
   :height: 1.03018in
.. |image159| image:: /_static/class8/image173.png
   :width: 5.30000in
   :height: 0.84903in
.. |image160| image:: /_static/class8/image174.png
   :width: 5.30000in
   :height: 0.93630in
.. |image161| image:: /_static/class8/image175.png
   :width: 5.35417in
   :height: 3.94587in
.. |image162| image:: /_static/class8/image176.png
   :width: 5.28105in
   :height: 2.06250in
.. |image163| image:: /_static/class8/image177.png
   :width: 5.33333in
   :height: 4.00000in
.. |image164| image:: /_static/class8/image178.png
   :width: 5.30000in
   :height: 1.08922in
.. |image165| image:: /_static/class8/image179.png
   :width: 5.30000in
   :height: 1.44665in
.. |image166| image:: /_static/class8/image180.png
   :width: 5.30000in
   :height: 0.62353in
.. |image167| image:: /_static/class8/image171.png
   :width: 5.31250in
   :height: 2.36631in
.. |image168| image:: /_static/class8/image181.png
   :width: 5.30000in
   :height: 3.32850in
.. |image169| image:: /_static/class8/image182.png
   :width: 5.30000in
   :height: 0.66085in
.. |image170| image:: /_static/class8/image47.png
   :width: 5.30972in
   :height: 1.95069in
.. |image171| image:: /_static/class8/image184.png
   :width: 5.30972in
   :height: 1.00139in
.. |image172| image:: /_static/class8/image186.png
   :width: 5.30972in
   :height: 2.29722in
.. |image173| image:: /_static/class8/image188.png
   :width: 5.30972in
   :height: 2.81458in
.. |image174| image:: /_static/class8/image189.png
   :width: 5.30000in
   :height: 0.65717in
.. |image175| image:: /_static/class8/image171.png
   :width: 5.33201in
   :height: 2.37500in
.. |image176| image:: /_static/class8/image190.png
   :width: 5.30000in
   :height: 3.00185in
.. |image177| image:: /_static/class8/image191.png
   :width: 4.73405in
   :height: 7.02083in
.. |image178| image:: /_static/class8/image192.png
   :width: 4.19722in
   :height: 0.55208in
.. |image179| image:: /_static/class8/image193.png
   :width: 4.20764in
   :height: 0.53125in
.. |image180| image:: /_static/class8/image194.png
   :width: 4.16597in
   :height: 0.51042in
.. |image181| image:: /_static/class8/image195.png
   :width: 7.12500in
   :height: 3.23000in
.. |image182| image:: /_static/class8/image196.png
   :width: 2.70833in
   :height: 3.44092in
.. |image183| image:: /_static/class8/image197.png
   :width: 5.30000in
   :height: 1.98962in
.. |image184| image:: /_static/class8/image198.png
   :width: 5.30000in
   :height: 0.45050in
.. |image185| image:: /_static/class8/image199.png
   :width: 5.30000in
   :height: 0.43945in
.. |image186| image:: /_static/class8/image200.png
   :width: 5.31250in
   :height: 7.78721in
