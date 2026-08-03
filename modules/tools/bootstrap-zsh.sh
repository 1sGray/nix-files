#!/usr/bin/env bash
set -euo pipefail

REPO_URL="https://github.com/1sGray/nix-files.git"
ZDOTDIR_SUBPATH="modules/features/zsh/configs/.config/zsh"

WORKDIR="$(mktemp -d)"
trap 'rm -rf "$WORKDIR"' EXIT

git clone --depth=1 "$REPO_URL" "$WORKDIR/nix-files" -q

export ZDOTDIR="$WORKDIR/nix-files/$ZDOTDIR_SUBPATH"
export XDG_CONFIG_HOME="$WORKDIR/.config"
export XDG_CACHE_HOME="$WORKDIR/.cache"
export XDG_DATA_HOME="$WORKDIR/.local/share"
export XDG_STATE_HOME="$WORKDIR/.local/state"
mkdir -p "$XDG_STATE_HOME/zsh" "$XDG_CACHE_HOME/zsh"

zsh
