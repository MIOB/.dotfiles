#!/usr/bin/env fish

set log_prefix "  [maven]"
source (status dirname)/../utils.fish

set --local maven_version "3.8.4"

if ! type --quiet mvn
	info "Installing maven"
	rm --recursive --force /tmp/maven
		or fatal "Failed to delete /tmp/maven"
	mkdir --parent /tmp/maven
		or fatal "failed to create /tmp/maven"
	curl --silent --show-error --fail --location "https://dlcdn.apache.org/maven/maven-3/$maven_version/binaries/apache-maven-$maven_version-bin.tar.gz" |
		tar --extract --gzip --directory /tmp/maven
		or fatal "Failed to download maven"

	rm --recursive --force ~/.local/opt/maven
		or fatal "Failed to remove ~/.local/opt/maven"
    mkdir --parent ~/.local/opt
        or fastal "Failed to create ~/.local/opt"
	mv /tmp/maven/apache-maven-$maven_version ~/.local/opt/maven
		or fatal "Failed to move maven to ~/.local/opt/maven"
	rm --recursive --force /tmp/maven

	info "Maven has been installed"
end

create_link (realpath (status dirname)/conf.d/maven.fish) $__fish_config_dir/conf.d/maven.fish
