.PHONY: all upload

all:
	PYTHONPATH="" dev_appserver.py app

update:
	PYTHONPATH="" appcfg.py update app
