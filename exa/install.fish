#!/usr/bin/env fish

set log_prefix "  [exa]"
source (status dirname)/../utils.fish

set --local exa_version "v0.10.1"

if ! type --quiet exa
	set --local arch (architecture)

	if test -n $arch
		info "Installing exa"
			sudo apt install exa 
		or fatal "Failed to install exa"
		info "Exa has been installed"
	else
		error "Cannot install exa. Unsupported architecture "(arch)
	end
end

create_link (realpath (status dirname)/conf.d/exa.fish) $__fish_config_dir/conf.d/exa.fish