#!/usr/bin/env fish

set log_prefix "  [minikube]"
source (status dirname)/../utils.fish

function install_minikube --argument-names url
	set --local tmp_dir (mktemp --directory)
		or fatal "Failed to delete /tmp/minikube"
	curl --silent --show-error --fail --location $url --output $tmp_dir
		or fatal "Failed to download minikube from $url"
	sudo install $tmp_dir /usr/local/bin/minikube
		or fatal "Failed to install minikube"
	rm $tmp_dir

end 

if ! type --quiet minikube
	info "Installing minikube for architecture "(arch)
	switch (arch)
		case "x86_64"
			install_minikube "https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64"
		case "armv7*"
			install_minikube "https://storage.googleapis.com/minikube/releases/latest/minikube-linux-arm"
		case "*"
			fatal "Unsupported architecture"
	end
	info "Minikube has been installed"
end

create_link (realpath (status dirname)/conf.d/minikube.fish) $__fish_config_dir/conf.d/minikube.fish