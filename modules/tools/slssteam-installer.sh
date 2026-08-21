#!/usr/bin/env bash
set -euo pipefail

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

log_info()  { echo -e "${GREEN}[INFO]${NC} $1"; }
log_warn()  { echo -e "${YELLOW}[WARN]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; exit 1; }

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

STEAM_DIR="${HOME}/.local/share/Steam"
SLS_CONFIG_DIR="${HOME}/.config/SLSsteam"
CONFIG_SOURCE="${REPO_ROOT}/configs/.config/SLSsteam/config.yaml"

if [ -f "${STEAM_DIR}/SLSsteam.so" ] && [ -f "${STEAM_DIR}/library-inject.so" ]; then
    log_info "SLSsteam already installed. Skipping."
else
    log_info "Installing SLSsteam via official installer..."
    if ! command -v steam-run &>/dev/null; then
        log_error "steam-run missing – enable programs.steam in NixOS."
    fi
    # Use the official install script from AceSLS
    steam-run bash -c "curl -sL https://raw.githubusercontent.com/AceSLS/SLSsteam/main/install.sh | bash"
    log_info "Installation finished."
fi

# Symlink config.yaml
if [ -f "${CONFIG_SOURCE}" ]; then
    mkdir -p "${SLS_CONFIG_DIR}"
    if [ -f "${SLS_CONFIG_DIR}/config.yaml" ] && [ ! -L "${SLS_CONFIG_DIR}/config.yaml" ]; then
        log_warn "config.yaml exists as regular file – won't overwrite."
    else
        rm -f "${SLS_CONFIG_DIR}/config.yaml"
        ln -sf "${CONFIG_SOURCE}" "${SLS_CONFIG_DIR}/config.yaml"
        log_info "Symlinked config."
    fi
else
    log_warn "Config source missing – skipping symlink."
fi

log_info "All done!"
