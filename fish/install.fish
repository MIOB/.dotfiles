#!/usr/bin/env fish

set log_prefix "  [fish]"
source (status dirname)/../utils.fish


create_link (realpath (status dirname)/conf.d/fish.fish) $__fish_config_dir/conf.d/fish.fish