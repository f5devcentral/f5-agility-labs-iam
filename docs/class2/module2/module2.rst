Lab 2 - API Protection
======================================

.. toctree::
   :maxdepth: 1
   :glob:

Purpose
-------

This section will teach you how to configure a Big-IP (#1) as a Resource
Server protecting an API with OAuth and another Big-IP (#2) as the
Authorization Server providing the OAuth tokens.

Task 1: Setup Virtual Server for the API
----------------------------------------

.. |br| raw:: html

   <br />

.. |image139| image:: media/image129.png
.. |image140| image:: media/image130.png
.. |image141| image:: media/image131.png
.. |image142| image:: media/image132.png
.. |image143| image:: media/image133.png
.. |image144| image:: media/image134.png
.. |image145| image:: media/image135.png
.. |image146| image:: media/image136.png
.. |image147| image:: media/image137.png
.. |image148| image:: media/image138.png
.. |image149| image:: media/image139.png
.. |image150| image:: media/image140.png
.. |image151| image:: media/image141.png
.. |image152| image:: media/image142.png
.. |image153| image:: media/image143.png
.. |image154| image:: media/image144.png
.. |image155| image:: media/image7.png
.. |image156| image:: media/image145.png
.. |image157| image:: media/image146.png
.. |image158| image:: media/image147.png
.. |image159| image:: media/image148.png
.. |image160| image:: media/image149.png
.. |image161| image:: media/image150.png
.. |image162| image:: media/image151.png
.. |image163| image:: media/image152.png
.. |image164| image:: media/image153.png
.. |image165| image:: media/image154.png
.. |image166| image:: media/image155.png
.. |image167| image:: media/image156.png
.. |image168| image:: media/image157.png
.. |image169| image:: media/image158.png
.. |image170| image:: media/image159.png
.. |image171| image:: media/image160.png
.. |image172| image:: media/image161.png
.. |image173| image:: media/image162.png
.. |image174| image:: media/image163.png
.. |image175| image:: media/image164.png
.. |image176| image:: media/image165.png
.. |image177| image:: media/image166.png
.. |image178| image:: media/image167.png
.. |image179| image:: media/image168.png
.. |image180| image:: media/image169.png
.. |image181| image:: media/image170.png
.. |image182| image:: media/image171.png
.. |image183| image:: media/image172.png
.. |image184| image:: media/image173.png
.. |image185| image:: media/image174.png
.. |image186| image:: media/image175.png
.. |image187| image:: media/image176.png
.. |image188| image:: media/image177.png
.. |image189| image:: media/image178.png
.. |image190| image:: media/image176.png
.. |image191| image:: media/image179.png
.. |image192| image:: media/image180.png
.. |image193| image:: media/image181.png
.. |image194| image:: media/image182.png
.. |image195| image:: media/image183.png
.. |image196| image:: media/image184.png
.. |image197| image:: media/image185.png
.. |image198| image:: media/image186.png
.. |image199| image:: media/image187.png
.. |image200| image:: media/image188.png
.. |image201| image:: media/image132.png
.. |image202| image:: media/image133.png
.. |image203| image:: media/image189.png
.. |image204| image:: media/image190.png
.. |image205| image:: media/image191.png
.. |image206| image:: media/image192.png
.. |image207| image:: media/image193.png
.. |image208| image:: media/image194.png
.. |image209| image:: media/image195.png
.. |image210| image:: media/image196.png
.. |image211| image:: media/image197.png
.. |image212| image:: media/image198.png
.. |image213| image:: media/image199.png
.. |image214| image:: media/image200.png
.. |image215| image:: media/image201.png
.. |image216| image:: media/image200.png
.. |image217| image:: media/image202.png
.. |image218| image:: media/image203.png
.. |image219| image:: media/image201.png
.. |image220| image:: media/image204.png
