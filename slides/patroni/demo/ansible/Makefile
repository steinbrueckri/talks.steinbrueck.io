create_pipenv:
	PIPENV_VENV_IN_PROJECT=1 pipenv --python 3.11 && source .venv/bin/activate.fish

sync_pipenv:
	pipenv sync

install_ansible_dependencies:
	ansible-galaxy install -r requirements.yml

# TODO: install dopy to the global python because ansible dont respect the venv
