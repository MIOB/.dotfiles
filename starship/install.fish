#!/usr/bin/env fish

set log_prefix "  [starship]"
source (status dirname)/../utils.fish

if ! type --quiet starship
	info "Installing starship"
	curl --silent --show-error --fail --location https://starship.rs/install.sh | bash 
		or fatal "Failed to install starship"
	info "Starship has been installed"
end

create_link (realpath (status dirname)/conf.d/starship.fish) $__fish_config_dir/conf.d/starship.fish

create_link (realpath (status dirname)/config.toml) ~/.config/starship.toml