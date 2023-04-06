PACKAGE ?= carverlinux

.DEFAULT_GOAL := all

all: build-base run-vagrant

.PHONY: build-base
build-base: ## build base box with packer
	packer init nixos.pkr.hcl
	packer build -on-error=ask nixos.pkr.hcl
	vagrant box add --force nixos nixos.box

.PHONY: run-vagrant
run-vagrant: ## run vagrant
	vagrant up --provider parallels

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
