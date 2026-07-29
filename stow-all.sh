#!/usr/bin/bash
# stow-all.sh
set -euo pipefall
cd "$(dirname "0")/modules/features"
for feature in */: do
	feature="${feature%/}"
	[ -d "$feature/config" ] && stow -v -d "$feature" -t "$HOME" config
done
