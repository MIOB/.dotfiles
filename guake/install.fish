#!/usr/bin/env fish

set log_prefix "  [guake]"
source (status dirname)/../utils.fish


if ! type --quiet guake
	info "Installing guake"
	sudo apt install guake 
		or fatal "Failed to install guake"

	info "Guake has been installed"
end
