# ==========================================
# History
# ==========================================

HISTFILE="$XDG_STATE_HOME/zsh/history"

HISTSIZE=100000

SAVEHIST=100000


setopt APPEND_HISTORY          # 

setopt SHARE_HISTORY           #

setopt HIST_IGNORE_DUPS        # Ignore duplicates

setopt HIST_IGNORE_SPACE       # Ignore spaces

setopt HIST_EXPIRE_DUPS_FIRST  # Expire old duplicates first

setopt HIST_FIND_NO_DUPS       # Show no dublicates when searching history

# ==========================================
# Shell Behaviour
# ==========================================

setopt AUTOCD             # Change directory by just typing the path without cd command

setopt NOBEEP             # Disable beeping sound on terminal error

setopt NUMERIC_GLOB_SORT  # Sort numbers intuitivly (i.e 10 is after 9, not 1)

# ==========================================
# Modular Config Files
# ==========================================

local this_dir="${0:A:h}"

source "$this_dir/aliases.zsh"

source "$this_dir/bindings.zsh"

source "$this_dir/plugins.zsh"

source "$this_dir/yazi.zsh"

source "$this_dir/fzf.zsh"

source "$this_dir/prompt.zsh"

source "$this_dir/devenv.zsh"

# ==========================================
# Smart Directory Navigation
# ==========================================

eval "$(zoxide init zsh)" # Initialzing Zoxide

# ==========================================
# Completion
# ==========================================

# autoload -Uz compinit                                   # Load completion system DISABLED: using zsh-autocomlete plugin.
# compinit -d "$XDG_CACHE_HOME/zsh/zcompdump"             # Initalizing completion with cached metadata file DISABLED: using zsh-autocomlete plugin.

zstyle ':completion:*' menu select                      # Enable interactive completion menu selection

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'  # Make completion case-insensitive
