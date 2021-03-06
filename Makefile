.PHONY: help

help: ## This help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help

install-k3d: ## Installs k3d from Rancher
	curl -s https://raw.githubusercontent.com/rancher/k3d/master/install.sh | bash

provision-kubernetes: deploy-kubernetes-cluster set-kubernetes-config ## Deploys a kubernetes cluster with k3d


deploy-kubernetes-cluster: ## Being called from provision-kubernetes, deploys the cluster
	k3d create --name="demo" --workers="2" --publish="8000:80"
	sleep 5

set-kubernetes-config: ## Being called from provision-kubernetes, sets the config
	export KUBECONFIG="$(k3d get-kubeconfig --name='demo')"

pull: ## Pulls docker images
	docker pull postgres:11.5
	docker pull gitea/gitea:1.8.1
	docker pull drone/drone:1
	docker pull drone/agent:1
