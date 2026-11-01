# Register completion and function directories before Oh My Zsh runs compinit.
fpath=(
	"$HOME/.config/zsh/completions"
	"$HOME/.config/zsh/functions"
	$fpath
)

# Ordinary functions need autoload registration; compinit discovers completions.
for function_file in "$HOME/.config/zsh/functions"/*(N-.); do
	autoload -Uz "${function_file:t}"
done
unset function_file
