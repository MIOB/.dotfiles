#!/usr/bin/env fish

set log_prefix "  [nvim]"
source (status dirname)/../utils.fish

if ! type --quiet nvim
	if type --quiet vim
		info "Removing vim"
		sudo apt remove vim
			or fatal "Failed to remove vim"
		sudo apt autoremove
	end
	info "Installing neovim"
	sudo apt-get install neovim
		or fatal "Failed to install neovim"
	mkdir --parent ~/.config/nvim
		or fatal "Failed to create .config/nvim"
	curl --silent --show-error --fail --location "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" --create-dirs --output ~/.local/share/nvim/site/autoload/plug.vim 
		or fatal "Failed to install vim-plug"
	info "Neovim has been installed"
end

create_link (realpath (status dirname)/init.vim) ~/.config/nvim/init.vim