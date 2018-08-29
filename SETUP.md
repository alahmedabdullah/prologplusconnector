PROLOGPLUS Smart Connector
==========================

Setup
-----
1. Install Chiminey (https://github.com/chiminey/docker-chiminey)
2. Go to docker-chiminey directory
```
	$ cd docker-chiminey
```
3. Enter into the Chiminey container
```
	$ ./chimineyterm
```
4. Go to chiminey directory
```
	$ cd /opt/chiminey/current/chiminey
```
5. Modify the SMART_CONNECTORES dictionary in settings_change.py file to have following:
```
        'prologplus':   {'init': 'chiminey.prologplusconnector.initialise.PrologplusInitial',
                         'name': 'prologplus',
                         'description': 'The PrologPlus Model Checker',
                         'payload': '/opt/chiminey/current/chiminey/prologplusconnector/payload_prologplus'
                        },
```
6. Modify the INPUT_FIELDS dictionary in settings_change.py file to have following:
```
	'prologplus':  SCHEMA_PREFIX + "/input/prologplus",
```
7. Clone the git repository https://github.com/alahmedabdullah/prologconnector.git in /opt/chiminey/current/chiminey
```
	$ git clone https://github.com/alahmedabdullah/prologplusconnector.git
```
8. Change ownership of the newly created prologplusconnector directory
```
	$ chown -R chiminey.nginx prologplusconnector
```
9. Exit from the chiminey container
```
	$ exit
```
10. Restart the chiminey container
```
	$ docker-compose restart chiminey
```
11. Check that prolog connector is listed in available smart connectors list
```
	$ ./listscs
```
12. Activate the prolog connector and follow the prompts
```
	$ ./activatesc prologplus
```
