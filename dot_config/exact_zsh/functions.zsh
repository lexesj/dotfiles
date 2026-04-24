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
		echo "Usage: new_devbox <name> [--fe]"
		return 1
	fi

	local cmd=(pay remote new --ide none --notify-on-ready --ssh --tmux --repo=mint --workspace=pay-server)

	if [[ $fe -eq 1 ]]; then
		cmd+=(--graph dashboard-fe-srv/default)
	fi

	cmd+=(-y "$name")

	echo "${cmd[@]}"

	"${cmd[@]}"
}
