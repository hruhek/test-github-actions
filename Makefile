TAG ?= WINSEC-INGEST-v0.0.0
VERSION = WINSEC-INGEST-v$(shell poetry version --short)

.PHONY: help
help:
	@echo Makefile targets:
	@echo init - install dependencies
	@echo test - runs coverage with pytest
	@echo lint - runs mypy, flake8, black check, pylint
	@echo create_version_tag - create git tag with current project version
	@echo check_tag_version - this is used from GitHub Worfklow to check if tag and project versiona are in sync

.PHONEY: init
init:
	poetry install

test: init
	poetry run coverage run -m pytest
	poetry run coverage report
	poetry run coverage html

.PHONEY: lint
lint: init
	poetry run mypy src
	poetry run flake8 src
	poetry run black src --check
	poetry run pylint src

.PHONEY: check_tag_version
check_tag_version:
ifneq ($(TAG), $(VERSION))
	@echo "Tag $(TAG) is different from project version $(VERSION)"
	@exit 1
else
	@echo "Tag and project version match"
endif

.PHONEY: create_version_tag
create_version_tag:
ifeq ($(shell git rev-parse --abbrev-ref HEAD), main)
	@echo "$(VERSION)"
	git tag $(VERSION)
	git push origin $(VERSION)
else
	@echo "Current branch is not 'main'"
	@exit 1
endif
