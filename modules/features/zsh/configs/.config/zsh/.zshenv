# ~/.config/zsh/.zshenv (on non nix)

# -------- XDG Base Directories --------
# Centralizes config/cashe/data locations (mb on non nix)
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/share"

# --------- Editor ---------------------
# Default editor used by commands
export EDITOR="nvim"
export VISUAL="nvim"

# --------- GPG ------------------------
export GPG_TTY=$(tty)

# --------- PATH -----------------------
# Personal binaries/scripts
export PATH="$HOME/.local/bin:$PATH"
