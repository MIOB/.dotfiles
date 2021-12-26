#!/usr/bin/env fish

set log_prefix "[bootstrap]"
source utils.fish


info "Bootstraping dotfiles in $dotfiles_root"

if ! grep (command --search fish) /etc/shells > /dev/null
	command --search fish | sudo tee --append /etc/shells
		or fatal "Failed to add fish into /etc/shells"
	info "Fish has been added into /etc/shells"
end

if test (awk -F : -v user=$USER '$1 == user {print $7}' /etc/passwd) != (command --search fish)
	info "Setting fish as default shell"
	chsh --shell (command --search fish)
		or fatal "Failed to set fish as default shell"
	info "Fish has been set as default shell"
end

if test -z (git config --global --get user.email)
	info "Bootstraping .gitconfig"
	set --local user_email (user_input "What is your github author name?")
	set --local user_name (user_input "What is your github author email?")

	if test -z $user_email
		fatal  "git email is mandatory"
	end
	
	git config --global user.name  $user_name
		and git config --global user.email $user_email
		or fatal "Cannot configure git"
	info ".gitconfig has been bootstraped"
end

for installer in */install.fish
	set --local name (basename (realpath (dirname $installer))) 
	info "Bootstraping "(set_color --bold blue)"$name"(set_color normal)
	$installer
		or fatal "Failed to bootstrap $name"
	info "$name has been bootstraped"
end

for installer in extensions/*/install.fish
	set --local name (basename (realpath (dirname $installer))) 
	info "Bootstraping extension "(set_color --bold yellow)"$name"(set_color normal)
	$installer
		or fatal "Failed to bootstrap $name"
	info "Extension $name has been bootstraped"
end

info "Bootstraping dotfiles has been finished"