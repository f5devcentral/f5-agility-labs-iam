Lab 1: VMware Horizon integration
==================================


UDF Blueprint:
---------------
https://udf.f5.com/b/d68f4a6c-31cf-4b9a-8224-80ebba818a16#documentation



.. image:: pictures/pcoip-proxy-config-example-updated_1.png
   :align: center
   :scale: 50%
   :class: with-shadow
   
.. Note:: For this Horizon Environment to Stabilize it takes approx 20 minutes after starting the deployment for all of the horizon brokers/agents to normalize.
    


.. Note:: VMware UAGs are not apart of this lab.


Lab devices: 
---------------

+---------------------------------+------------+
| Hostname                        | IP address |
+=================================+============+
| horizon-ltm.f5demos.local       | 10.1.20.100|
+---------------------------------+------------+
| horizon-apm.f5demos.local       | 10.1.20.105|
+---------------------------------+------------+



Demo script:
---------------

1. After Starting the Lab  and is fully started WAIT 5 minutes for everything to boot completely and stabalize (this will ensure ansible code will execute correctly)
2. Launch the Ansible Builders Web Shell  -  Ansible Builder --> Access --> Web Shell
3. Change directory to the provisioning folder -
        cd /git/f5-bd-horizon-lab-udf/
4. Launch Code to start building process (this can take 10-20 minutes) -
        ansible-playbook setup_horizon.yaml

You can make a demo with Horizon VMware view client:

1. Click on VMware view client and add server (horizon-apm.f5demos.local)
2. Login as "horizon\horizon_user" and password "H0rIzoN!"
3. Click on any apps or desktop.
