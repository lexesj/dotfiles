#!/usr/bin/env zsh

function add_to_path() {
	export PATH="${1}:${PATH//$1:/}"
}
