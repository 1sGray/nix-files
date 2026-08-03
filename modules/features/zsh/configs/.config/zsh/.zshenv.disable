# ~/.config/zsh/.zshenv (on non nix)

#=======================================================
# XDG Base Directories
#=======================================================

# Centralizes config/cashe/data locations (works whether XDG vars are already
# set by the system, e.g. Nix, or not, e.g. a fresh non-Nix machine)

: "${XDG_CONFIG_HOME:=$HOME/.config}"
: "${XDG_CACHE_HOME:=$HOME/.cache}"
: "${XDG_DATA_HOME:=$HOME/.local/share}"
: "${XDG_STATE_HOME:=$HOME/.local/state}"

export XDG_CONFIG_HOME XDG_CACHE_HOME XDG_DATA_HOME XDG_STATE_HOME

mkdir -p "$XDG_STATE_HOME/zsh" "$XDG_CACHE_HOME/zsh"

#=======================================================
# Editor
#=======================================================

# Default editor used by commands

export EDITOR="nvim"
export VISUAL="nvim"

#=======================================================
# GPG
#=======================================================

export GPG_TTY=$(tty)

#=======================================================
# PATH
#=======================================================

# Personal binaries/scripts

export PATH="$HOME/.local/bin:$PATH"
