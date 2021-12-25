#!/usr/bin/env fish

set log_prefix "  [fzf]"
source (status dirname)/../utils.fish


if ! type --quiet fzf
	info "Installing fzf"
	sudo apt-get install fzf
	
	info "Fzf has been installed"
end
