F5 Agility Lab Template
=======================

Introduction
------------

This repo contains a template that should be used when creating lab
documentation for F5's Agility Labs.  

Setup 
-----

#. Download or ``git clone`` the f5-agility-lab-template
#. Download and install Docker CE (https://docs.docker.com/engine/installation/)
#. Build the sample docs ``./containthedocs-build.sh``

   .. NOTE::
      The first time you build a container (~1G in size) will be downloaded 
      from Docker Hub. 

#. Open the ``docs/_build/html/index.html`` file on you system in a web browser

Configuration & Use
-------------------

To use this template:

#. Copy contents of this repo to a new directory ``cp -Rf . /path/to/your/docs``
#. ``cd /path/to/your/docs``
#. Edit ``docs/conf.py``
#. Modify the following lines:

   - ``classname = "Your Class Name"``
   - ``github_repo = "https://github.com/f5devcentral/your-class-repo"``

#. Build docs ``./containthedocs-build.sh``
#. Open the ``docs/_build/html/index.html`` file on you system in a web browser
#. Edit the ``*.rst`` files as needed for your class
#. Rebuild docs as needed using ``./containthedocs-build.sh``

