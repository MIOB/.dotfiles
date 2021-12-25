#!/usr/bin/env fish

set log_prefix "  [fisher]"
source (status dirname)/../utils.fish

if ! type --quiet fisher
	"Installing fisher"
	curl --silent --location https://git.io/fisher | source 
		and fisher install jorgebucaran/fisher 
		or fatal "Failed to install fisher"
	info "Fisher has been installed"
end

create_link (realpath (status dirname)/fish_plugins) $__fish_config_dir/fish_plugins

info "Updating fisher"
fisher update > /dev/null
	or fatal "Failed to update fisher"
info "Fisher has been updated"