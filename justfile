export PATH := justfile_directory() + "/env/bin:" + env_var("PATH")

@default:
	just --list

init:
	sudo apt install python3-venv python3-pip --no-install-recommends

ansible-setup:
	python3 -m venv env
	pip install -r ansible/dev-requirements.txt
	cd ansible/ && ansible-galaxy install -r galaxy-requirements.yml --force

terraform +ARGS:
	#!/usr/bin/env bash
	cd terraform/

	set -a
	source ./.env || true
	set +a

	terraform {{ ARGS }}

ansible-deploy *ARGS:
	cd ansible/ && ansible-playbook local.yml --vault-password=~/.secrets/vault-password -K {{ ARGS }}

yamllint:
	yamllint -s .

ansible-lint:
	#!/usr/bin/env bash
	cd ansible/
	ansible-lint -p
	ansible-playbook local.yml --syntax-check

lint: ansible-lint
