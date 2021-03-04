.DEFAULT_GOAL := venv-update
.PHONY: venv-update

VIRTUAL_ENV ?= envproj

requirements: ./requirements.txt

./requirements.txt: ./requirements/base.in
	pip-compile --output-file $@ $<

$(VIRTUAL_ENV)/.venv.touch: ./requirements/base.txt
	./venv-update venv= $(VIRTUAL_ENV) -p `which python` install= -r $<
	touch $@

venv-update : $(VIRTUAL_ENV)/.venv.touch

upgrade:
	-rm requirements.txt
	$(MAKE) requirements
	pre-commit autoupdate
