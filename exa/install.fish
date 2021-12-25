#!/usr/bin/env fish

set log_prefix "  [exa]"
source (status dirname)/../utils.fish

set --local exa_version "v0.10.1"

if ! type --quiet exa
	set --local arch (architecture)

	if test -n $arch
		info "Installing exa for architecture $arch"
		curl --silent --show-error --fail --location "https://github.com/ogham/exa/releases/download/$exa_version/exa-linux-$arch-$exa_version.zip" --output /tmp/exa.zip
			or fatal "Failed to download exa binary"
		sudo unzip -q -o -d /opt/exa /tmp/exa.zip
			or fatal "Failed to unzip exa"
		rm --force /tmp/exa.zip 
		sudo ln --symbolic --force /opt/exa/bin/exa /usr/bin/exa
			or fatal "Failed to create symlink from /opt/exa/bin/exa to /usr/bin/exa" 
		sudo ln --symbolic --force /opt/exa/man/exa.1 /usr/share/man/man1/exa.1
			or fatal "Failed to create symlink from /opt/exa/man/exa.1 to /usr/share/man/man1/exa.1"
		sudo ln --symbolic --force /opt/exa/completions/exa.fish /usr/share/fish/vendor_completions.d/exa.fish
			or fatal "Failed to create symlink from /opt/exa/completions/exa.fish to /usr/share/fish/vendor_completions.d/exa.fish"
		info "Exa has been installed"
	else
		error "Cannot install exa. Unsupported architecture "(arch)
	end
end

create_link (realpath (status dirname)/conf.d/exa.fish) $__fish_config_dir/conf.d/exa.fish