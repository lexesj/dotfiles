new_devbox() {
	local fe=0
	local name=""

	for arg in "$@"; do
		case "$arg" in
		--fe) fe=1 ;;
		--help | -h)
			echo "Usage: new_devbox [--fe] <name>"
			echo ""
			echo "Arguments:"
			echo "  <name>   Name of the devbox (required)"
			echo "  --fe     Include the dashboard-fe-srv/base graph"
			return 0
			;;
		-*) echo "Unknown option: $arg" && return 1 ;;
		*) name="$arg" ;;
		esac
	done

	if [[ -z "$name" ]]; then
		echo "Error: devbox name is required"
		echo ""
		echo "Usage: new_devbox [--fe] <name>"
		return 1
	fi

	local cmd=(pay remote new --ide none --notify-on-ready --repo=mint --workspace=pay-server)

	if [[ $fe -eq 1 ]]; then
		cmd+=(--graph dashboard-fe-srv/default)
	fi

	cmd+=(-y "$name")

	echo "${cmd[@]}"
	"${cmd[@]}" || return 1

	copy_devbox_creds "$name"
	pay remote ssh "$name" --tmux
}

_pick_devbox() {
	local status_filter="${1:-}"
	local jq_filter='.[] | select(.type == "remotedevbox" or .type == "remotemydata")'
	if [[ -n "$status_filter" ]]; then
		jq_filter+=" | select(.status == \"$status_filter\")"
	fi
	pay remote list --raw | jq -r "$jq_filter | .name" | fzf
}

restart_devbox() {
	local name=""
	local ssh=0
	local tmux=0

	for arg in "$@"; do
		case "$arg" in
		--ssh) ssh=1 ;;
		--tmux) tmux=1 ;;
		-*) echo "Unknown option: $arg" && return 1 ;;
		*) name="$arg" ;;
		esac
	done

	if [[ -z "$name" ]]; then
		name=$(_pick_devbox)
	fi

	if [[ -z "$name" ]]; then
		return 1
	fi

	local box_status
	box_status=$(pay remote list --raw | jq -r --arg name "$name" '.[] | select(.name == $name) | .status')

	if [[ "$box_status" == "running" ]]; then
		echo "Stopping devbox $name..."
		pay remote stop "$name" || return 1
	else
		echo "Devbox $name is $box_status, skipping stop."
	fi

	echo "Starting devbox $name..."
	local max_attempts=30
	local attempt=0
	while [[ $attempt -lt $max_attempts ]]; do
		if pay remote start "$name" 2>/dev/null; then
			echo "Devbox $name is running."
			break
		fi
		attempt=$((attempt + 1))
		echo "  [$attempt/$max_attempts] not ready yet, retrying in 10s..."
		sleep 10
	done

	if [[ $attempt -eq $max_attempts ]]; then
		echo "Timed out waiting for devbox $name to start."
		return 1
	fi

	if [[ $tmux -eq 1 ]]; then
		pay remote ssh "$name" --tmux
	elif [[ $ssh -eq 1 ]]; then
		pay remote ssh "$name"
	fi
}

copy_devbox_creds() {
	local name="$1"
	if [[ -z "$name" ]]; then
		name=$(_pick_devbox running)
	fi

	if [[ -z "$name" ]]; then
		return 1
	fi

	echo "Copying copilot credentials to $name..."
	pay remote ssh "$name" -- "mkdir -p ~/.config/github-copilot"
	for file in ~/.config/github-copilot/auth.*; do
		[[ -f "$file" ]] || continue
		pay remote copy "$name" "$file" "remote:~/.config/github-copilot/$(basename "$file")"
	done
}
