Lab 2 - API Protection
======================

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

.. |image139| image:: /_static/class2/image129.png
.. |image140| image:: /_static/class2/image130.png
.. |image141| image:: /_static/class2/image131.png
.. |image142| image:: /_static/class2/image132.png
.. |image143| image:: /_static/class2/image133.png
.. |image144| image:: /_static/class2/image134.png
.. |image145| image:: /_static/class2/image135.png
.. |image146| image:: /_static/class2/image136.png
.. |image147| image:: /_static/class2/image137.png
.. |image148| image:: /_static/class2/image138.png
.. |image149| image:: /_static/class2/image139.png
.. |image150| image:: /_static/class2/image140.png
.. |image151| image:: /_static/class2/image141.png
.. |image152| image:: /_static/class2/image142.png
.. |image153| image:: /_static/class2/image143.png
.. |image154| image:: /_static/class2/image144.png
.. |image155| image:: /_static/class2/image7.png
.. |image156| image:: /_static/class2/image145.png
.. |image157| image:: /_static/class2/image146.png
.. |image158| image:: /_static/class2/image147.png
.. |image159| image:: /_static/class2/image148.png
.. |image160| image:: /_static/class2/image149.png
.. |image161| image:: /_static/class2/image150.png
.. |image162| image:: /_static/class2/image151.png
.. |image163| image:: /_static/class2/image152.png
.. |image164| image:: /_static/class2/image153.png
.. |image165| image:: /_static/class2/image154.png
.. |image166| image:: /_static/class2/image155.png
.. |image167| image:: /_static/class2/image156.png
.. |image168| image:: /_static/class2/image157.png
.. |image169| image:: /_static/class2/image158.png
.. |image170| image:: /_static/class2/image159.png
.. |image171| image:: /_static/class2/image160.png
.. |image172| image:: /_static/class2/image161.png
.. |image173| image:: /_static/class2/image162.png
.. |image174| image:: /_static/class2/image163.png
.. |image175| image:: /_static/class2/image164.png
.. |image176| image:: /_static/class2/image165.png
.. |image177| image:: /_static/class2/image166.png
.. |image178| image:: /_static/class2/image167.png
.. |image179| image:: /_static/class2/image168.png
.. |image180| image:: /_static/class2/image169.png
.. |image181| image:: /_static/class2/image170.png
.. |image182| image:: /_static/class2/image171.png
.. |image183| image:: /_static/class2/image172.png
.. |image184| image:: /_static/class2/image173.png
.. |image185| image:: /_static/class2/image174.png
.. |image186| image:: /_static/class2/image175.png
.. |image187| image:: /_static/class2/image176.png
.. |image188| image:: /_static/class2/image177.png
.. |image189| image:: /_static/class2/image178.png
.. |image190| image:: /_static/class2/image176.png
.. |image191| image:: /_static/class2/image179.png
.. |image192| image:: /_static/class2/image180.png
.. |image193| image:: /_static/class2/image181.png
.. |image194| image:: /_static/class2/image182.png
.. |image195| image:: /_static/class2/image183.png
.. |image196| image:: /_static/class2/image184.png
.. |image197| image:: /_static/class2/image185.png
.. |image198| image:: /_static/class2/image186.png
.. |image199| image:: /_static/class2/image187.png
.. |image200| image:: /_static/class2/image188.png
.. |image201| image:: /_static/class2/image132.png
.. |image202| image:: /_static/class2/image133.png
.. |image203| image:: /_static/class2/image189.png
.. |image204| image:: /_static/class2/image190.png
.. |image205| image:: /_static/class2/image191.png
.. |image206| image:: /_static/class2/image192.png
.. |image207| image:: /_static/class2/image193.png
.. |image208| image:: /_static/class2/image194.png
.. |image209| image:: /_static/class2/image195.png
.. |image210| image:: /_static/class2/image196.png
.. |image211| image:: /_static/class2/image197.png
.. |image212| image:: /_static/class2/image198.png
.. |image213| image:: /_static/class2/image199.png
.. |image214| image:: /_static/class2/image200.png
.. |image215| image:: /_static/class2/image201.png
.. |image216| image:: /_static/class2/image200.png
.. |image217| image:: /_static/class2/image202.png
.. |image218| image:: /_static/class2/image203.png
.. |image219| image:: /_static/class2/image201.png
.. |image220| image:: /_static/class2/image204.png
