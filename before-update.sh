#!/usr/bin/env bash

set -Eeuo pipefail
trap 'echo "⚠  Error ($0:$LINENO): $BASH_COMMAND" && return 3 2> /dev/null || exit 3' ERR

# rm -rf $DOTFILES_DESTINATION/.config/nvim
