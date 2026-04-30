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

copy_devbox_creds() {
	local name="$1"
	if [[ -z "$name" ]]; then
		name=$(pay remote list --raw |
			jq '.[] | select(.status == "running") | select(.type == "remotedevbox" or .type == "remotemydata") | "\(.name) \(.host)"' -r |
			fzf --with-nth=1 --accept-nth=2)
	fi

	if [[ -z "$name" ]]; then
		return 1
	fi

	echo "Copying gh credentials to $name..."
	pay remote ssh "$name" -- "echo $(gh auth token -h git.corp.stripe.com) | gh auth login -p ssh -h git.corp.stripe.com --with-token"

	echo "Copying copilot credentials to $name..."
	pay remote ssh "$name" -- "mkdir -p ~/.config/github-copilot"
	pay remote copy "$name" ~/.config/github-copilot/apps.json remote:~/.config/github-copilot/apps.json
}
