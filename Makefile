pip=.venv/bin/pip
galaxy=.venv/bin/ansible-galaxy
playbook=.venv/bin/ansible-playbook

.PHONY: all
all: .venv/ galaxy/

.venv/: requirements.txt
	python3 -m venv $@
	$(pip) install -r requirements.txt
	touch $@

galaxy/: .venv requirements.yml
	$(galaxy) install -r requirements.yml
	touch $@

.PHONY: clean
clean:
	rm -rf .venv
