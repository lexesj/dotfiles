#!/usr/bin/env zsh

function sesh-sessions() {
	{
		exec </dev/tty
		exec <&1
		local session
		session=$(sesh list --tmux --config --zoxide --hide-duplicates | fzf --height 40% --reverse --border-label ' sesh ' --border --prompt '⚡  ')
		zle reset-prompt >/dev/null 2>&1 || true
		[[ -z "$session" ]] && return
		sesh connect $session
	}
}

zle -N sesh-sessions
bindkey -M vicmd '\es' sesh-sessions
bindkey -M viins '\es' sesh-sessions
