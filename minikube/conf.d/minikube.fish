#!/usr/bin/env fish

function docker-minikube
	if minikube status
    	minikube -p minikube docker-env | source
    else
    	echo (set_color --bold red)Minikube is not running
    end
end
function docker-local
    set --erase DOCKER_TLS_VERIFY
    set --erase DOCKER_HOST
    set --erase DOCKER_CERT_PATH
    set --erase MINIKUBE_ACTIVE_DOCKERD
end
