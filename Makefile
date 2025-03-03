SHELL := /usr/bin/env bash -o errexit -o pipefail
ROOT_DIR := $(shell dirname $(abspath $(lastword $(MAKEFILE_LIST))))

GREEN  := $(shell tput -Txterm setaf 2)
YELLOW := $(shell tput -Txterm setaf 3)
WHITE  := $(shell tput -Txterm setaf 7)
CYAN   := $(shell tput -Txterm setaf 6)
RESET  := $(shell tput -Txterm sgr0)

## Help:
help: ## Show this help.
	@echo ''
	@echo 'Usage:'
	@echo '  ${CYAN}make${RESET} ${YELLOW}<target>${RESET}'
	@echo ''
	@echo 'Targets:'
	@awk 'BEGIN {FS = ":.*?## "} { \
		if (/^[a-zA-Z_-]+:.*?##.*$$/) {printf "    ${CYAN}%-24s${GREEN}%s${RESET}\n", $$1, $$2} \
		else if (/^## .*$$/) {printf "  ${YELLOW}%s${RESET}\n", substr($$1,4)} \
		}' $(MAKEFILE_LIST)
## Build: 
clean: ## Clear out dist/ directory.
	rm -rf dist/

install-deps:	scripts-executable ## Install dependencies listed in build/scripts/install_deps.sh
	$(ROOT_DIR)/build/scripts/install_deps.sh

scripts-executable: ## Make all scripts under build/scripts executable
	chmod -R u+x $(ROOT_DIR)/build/scripts

build-all: ## Builds project for all platforms
	$(ROOT_DIR)/build/scripts/build.sh

lint: ## Runs linter
	$(ROOT_DIR)/build/scripts/lint.sh