#!/usr/bin/env fish

set --global dotfiles_root (realpath (status dirname))

function info
	set --query log_prefix
		or set --local log_prefix [(status basename)]
	echo (set_color --bold green)$log_prefix(set_color normal) $argv
end

function error
	set --query log_prefix
		or set --local log_prefix [(status basename)]
	echo (set_color --bold red)$log_prefix(set_color normal) $argv
end

function user_input
	read --prompt="echo (set_color --bold blue)\"$argv\"(set_color normal)'> '"
end

function fatal
	error $argv
	exit 1
end

function on_exit --on-event fish_exit
	if test $argv != 0
		error "Bootstraping wasn't finished"
	end
end

function fish_command_not_found
	fatal Unknown command: $argv
end 


function create_link --argument-names target link
	if test -e $link
		set link_file (realpath $link)
		if test $link_file = $target
			info "Skipping link $link"
			return
		else
			mv $link $link.backup
				or fatal "Failed to backup $link to $link.backup"
			info "Successfully backuped $link"
		end
	end
	mkdir -p (dirname $link)
		and ln --symbolic --force $target $link
		or fatal "Failed to link $target to $link"
	info "Successfully linked $target to $link"
end

function architecture
	switch (arch)
		case "x86_64"
			echo "x86_64" 
		case "armv7*"
			echo "armv7"
	end
end
