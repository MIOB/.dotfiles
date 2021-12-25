#!/usr/bin/env fish

set log_prefix "  [kubectl]"
source (status dirname)/../utils.fish


if ! type --quiet kubectl
	info "Adding kubectl repository"
	curl --silent --show-error --fail --location https://packages.cloud.google.com/apt/doc/apt-key.gpg |
		sudo apt-key add -
		or fatal "Failed to add kubectl key"
	echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | 
		sudo tee --append /etc/apt/sources.list.d/kubernetes.list
		or fatal "Failed to add kubectl repository"
	info "Kubectl repository has been added"

	info "Installing kubectl"
	sudo apt-get update
		or fatal "Failed to update apt"
	sudo apt-get install --yes kubectl
		or fatal "Failed to install kubectl"
	info "Kubectl has been installed"
end

create_link (realpath (status dirname)/conf.d/kubectl.fish) $__fish_config_dir/conf.d/kubectl.fish