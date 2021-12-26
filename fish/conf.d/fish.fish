#!/usr/bin/env fish

if status is-interactive
	stty intr ^J
	bind \cj cancel-commandline
end