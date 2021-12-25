#!/usr/bin/env fish

set log_prefix "  [kubectx]"
source (status dirname)/../utils.fish

set --local kubectx_version "v0.9.4"

function install --argument-names name arch v
	info "Installing $name $arch $v"
	set --local url "https://github.com/ahmetb/kubectx/releases/download/$v/$name""_$v""_linux_$arch.tar.gz"
	sudo mkdir -p /opt/$name
		or fatal "Cannot create directory /opt/$name"
	curl --silent --show-error --fail --location $url |
		sudo tar --extract --gzip --directory /opt/$name
		or fatal "Failed to download $name binary"
	sudo ln --symbolic --force /opt/$name/$name /usr/bin/$name
		or fatal "Failed to create symlink from /opt/$name/$name to /usr/bin/$name" 
	info "$name has been installed"
end

if ! type --quiet kubectx
	set --local arch (architecture)

	if test -n $arch
		install "kubectx" $arch $kubectx_version
		install "kubens" $arch $kubectx_version
	else
		error "Cannot install kubenctx and kubens. Unsupported architecture "(arch)
	end
end

create_link (realpath (status dirname)/conf.d/kubectx.fish) $__fish_config_dir/conf.d/kubectx.fish
create_link (realpath (status dirname)/conf.d/kubens.fish) $__fish_config_dir/conf.d/kubens.fish