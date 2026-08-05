local this_dir="${0:A:h}"
local plugin_dir="${XDG_DATA_HOME:-$HOME/.local/share}/zsh/plugins"

mkdir -p "$plugin_dir"

_clone_if_missing() {
	[[ -d "$plugin_dir/$2" ]] || git clone --depth=1 -q "$1" "$plugin_dir/$2"
}

_clone_if_missing "https://github.com/zsh-users/zsh-completions" "zsh-completions"
_clone_if_missing "https://github.com/marlonrichert/zsh-autocomplete" "zsh-autocomplete"
_clone_if_missing "https://github.com/zsh-users/zsh-syntax-highlighting" "zsh-syntax-highlighting"

# 1. zsh-comletions:
# Adds completion functions to fpath.
# Appended, not prepended - prepending has been reported to shadow 
# and break some built-in system completions (e.g. vim's).
# Must happen before compinit runs.
fpath+=("$plugin_dir/zsh-completions/src")

# 2. zsh-autocomplete:
# Runs its own compinit internally.
# DO NOT call compinit yourself anywhere else in .zshrc.
source "$plugin_dir/zsh-autocomplete/zsh-autocomplete.plugin.zsh"

# 3. zsh-syntax-highlighting:
# Must always be sourced last.
source "$plugin_dir/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
