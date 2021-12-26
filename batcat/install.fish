#!/usr/bin/env fish

set log_prefix "  [batcat]"
source (status dirname)/../utils.fish


if ! type --quiet bat
	info "Installing batcat"
	sudo apt install bat 
		or fatal "Failed to install batcat"
	mkdir --parent ~/.local/bin
		or fatal "Failed to create ~/.local/bin"
	create_link /usr/bin/batcat ~/.local/bin/bat

	info "Batcat has been installed"
end

create_link (realpath (status dirname)/conf.d/batcat.fish) $__fish_config_dir/conf.d/batcat.fish
