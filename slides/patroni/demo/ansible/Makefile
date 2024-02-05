create_pipenv:
	PIPENV_VENV_IN_PROJECT=1 pipenv --python 3.11 && source .venv/bin/activate.fish

sync_pipenv:
	pipenv sync

install_ansible_dependencies:
	ansible-galaxy install -r requirements.yml

create_demo_env:
	ansible-playbook 1_create_vms.yaml

# Definiere die Hosts aus der Ausgabe von ansible-inventory
HOSTS := $(shell ansible-inventory -i inventory/digital_ocean.py --list | jq -r '.consul_server.hosts[]')

# Standardziel, das alle SSH-Verbindungen mit xpanes aufbaut
ssh:
	xpanes -c "ssh root@{}" $(HOSTS)

# TODO: install dopy to the global python because ansible dont respect the venv
