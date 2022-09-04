#!/usr/bin/env fish

set log_prefix "  [java]"
source (status dirname)/../utils.fish


if ! type --quiet java

	info "Installing java for architecture "(arch)
	switch (arch)
		case "x86_64"
			info "Adding corretto repository"
			curl --silent --show-error --fail --location https://apt.corretto.aws/corretto.key |
				sudo apt-key add -
				or fatal "Failed to add corretto key"
			sudo add-apt-repository 'deb https://apt.corretto.aws stable main'
				or fatal "Failed to add corretto repository"
			info "Corretto repository has been added"

			info "Installing corretto jdk"
			sudo apt update
				or fatal "Failed to update apt"
			sudo apt install --yes java-17-amazon-corretto-jdk
				or fatal "Failed to install corretto"
			info "Corrteto jdk has been installed"
		case "armv7*"
			info "Installing default jdk"
			sudo apt update
				or fatal "Failed to update apt"
			sudo apt install default-jdk
				or fatal "Failed to install default jdk"
			info "Dfeault jdk has been installed"
		case "*"
			fatal "Unsupported architecture"
	end

	
end