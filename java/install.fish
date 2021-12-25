#!/usr/bin/env fish

set log_prefix "  [java]"
source (status dirname)/../utils.fish


if ! type --quiet java
	info "Adding corretto repository"
	curl --silent --show-error --fail --location https://apt.corretto.aws/corretto.key |
		sudo apt-key add -
		or fatal "Failed to add corretto key"
	sudo add-apt-repository 'deb https://apt.corretto.aws stable main'
		or fatal "Failed to add corretto repository"
	info "Corretto repository has been added"

	info "Installing corretto jdk"
	sudo apt-get update
		or fatal "Failed to update apt"
	sudo apt-get install --yes java-11-amazon-corretto-jdk
		or fatal "Failed to install corretto"
	info "Corrteto jdk has been installed"
end