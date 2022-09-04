#!/usr/bin/env fish

set log_prefix "  [exa]"
source (status dirname)/../utils.fish

set --local gradle_version "7.5.1"

if ! type --quiet gradle
	info "Installing gradle"
	curl --silent --show-error --fail --location "https://services.gradle.org/distributions/gradle-$gradle_version-bin.zip" --output /tmp/gradle.zip
		or fatal "Failed to download gradle binary"
	rm --recursive --force /tmp/gradle
		or fatal "Cannot delete /tmp/gradle/folder"
	unzip -q -o -d /tmp/gradle /tmp/gradle.zip
		or fatal "Failed to unzip gradle"
	rm --force /tmp/gradle.zip 

	rm --recursive --force ~/.local/opt/gradle
		or fatal "Failed to delete ~/.local/opt/gradle"
    mkdir --parent ~/.local/opt
        or fatal "Failed to create ~/.local/opt"
	mv /tmp/gradle/gradle-$gradle_version ~/.local/opt/gradle
		or fatal "Failed to move gradle to ~/.local/opt/gradle"
	rm --recursive --force /tmp/gradle/

	info "Gradle has been installed"
end

create_link (realpath (status dirname)/conf.d/gradle.fish) $__fish_config_dir/conf.d/gradle.fish
