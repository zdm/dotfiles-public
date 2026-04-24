#!/usr/bin/env bash

set -Eeuo pipefail
trap 'echo "⚠  Error ($0:$LINENO): $BASH_COMMAND" && return 3 2> /dev/null || exit 3' ERR

source $DOTFILES_DESTINATION/.bashrc

# postgresql
# mkdir -p /etc/postgresql-common
# \cp $DOTFILES_SOURCE/.psqlrc /etc/postgresql-common/psqlrc
