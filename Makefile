.PHONY: help clean clean-pyc clean-build list test test-all coverage docs release newenv syncenv
PYTHON ?= python3.8

help:
	@echo "clean-build - remove build artifacts"
	@echo "clean-pyc - remove Python file artifacts"
	@echo "lint - check style with flake8"
	@echo "test - run tests quickly with the default Python"
	@echo "test-all - run tests on every Python version with tox"
	@echo "coverage - check code coverage quickly with the default Python"
	@echo "docs - generate Sphinx HTML documentation, including API docs"
	@echo "release - package and upload a release"
	@echo "newenv - create a new development environment with venv"
	@echo "syncenv - synchronize your venv requirements"

clean: clean-build clean-pyc

clean-build:
	rm -fr build/
	rm -fr dist/
	rm -fr *.egg-info

clean-pyc:
	find . -name '*.pyc' -exec rm -f {} +
	find . -name '*.pyo' -exec rm -f {} +
	find . -name '*~' -exec rm -f {} +

lint:
	flake8 aobadiscordbot test

test:
	py.test

test-all:
	tox

coverage:
	coverage run --source aobadiscordbot setup.py test
	coverage report -m
	coverage html
	open htmlcov/index.html

docs:
	rm -f docs/aobadiscordbot.rst
	rm -f docs/modules.rst
	sphinx-apidoc -o docs/ aobadiscordbot
	$(MAKE) -C docs clean
	$(MAKE) -C docs html
	open docs/_build/html/index.html

release: clean syncenv
	$(PYTHON) setup.py sdist bdist_wheel
	$(PYTHON) -m twine upload --repository testpypi dist/* --config-file .pypirc

# Development environment
newenv:
	rm -rf .venv
	$(PYTHON) -m venv --clear .venv
	.venv/bin/pip install -U pip setuptools
	$(MAKE) syncenv

syncenv:
	.venv/bin/pip install -Ur requirements.txt