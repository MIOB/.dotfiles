#!/usr/bin/env fish

set log_prefix "  [docker]"
source (status dirname)/../utils.fish

if ! type --quiet docker
	info "Installing docker deps"
	sudo apt-get update 
		or fatal "Failed to update apt"
	sudo apt-get install ca-certificates curl gnupg lsb-release
		or fatal "Failed to install docker deps"
	info "Docker deps have been installed"

	info "Adding docker repository"
	curl --silent --show-error --fail --location https://download.docker.com/linux/ubuntu/gpg | 
		sudo gpg --dearmor --output /usr/share/keyrings/docker-archive-keyring.gpg
		or fatal "Failed to add gpg key"

	echo "deb [arch="(dpkg --print-architecture)" signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu "(lsb_release -cs)" stable" |
		sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
		or fatal "Failed to add docker repository"
	info "Docker repository has been added"

	info "Installing docker"
	sudo apt-get update
		or fatal "Failed to update apt"
 	sudo apt-get install docker-ce docker-ce-cli containerd.io
 		or fatal "Failed install docker"
 	info "Docker has been installed"
end