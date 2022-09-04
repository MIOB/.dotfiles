#!/usr/bin/env fish

set log_prefix "  [zoxide]"
source (status dirname)/../utils.fish


if ! type --quiet zoxide
	info "Installing zoxide"
	sudo apt install zoxide
		or fatal "Failed to install zoxide"
	
	info "Zoxide has been installed"
end

create_link (realpath (status dirname)/conf.d/zoxide.fish) $__fish_config_dir/conf.d/zoxide.fish