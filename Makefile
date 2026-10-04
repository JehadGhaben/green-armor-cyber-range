SHELL := /bin/bash

.PHONY: start stop reset status shell test logs config

start:
	./start.sh

stop:
	./stop.sh

reset:
	./reset.sh

status:
	./status.sh

shell:
	./shell.sh

test:
	./tests/self-test.sh

logs:
	docker compose logs -f

config:
	docker compose config
