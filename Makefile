.PHONY: help

help: ## This help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help

install-k3d: ## Installs k3d from Rancher
	curl -s https://raw.githubusercontent.com/rancher/k3d/master/install.sh | bash

provision-kubernetes: ## Deploys a kubernetes cluster with k3d
	k3d create --name="demo" --workers="2" --publish="8000:80"
	export KUBECONFIG="$(k3d get-kubeconfig --name='demo')"
