#!/usr/bin/env bash

set -Eeuo pipefail
trap 'echo "⚠  Error ($0:$LINENO, exit code: $?): $BASH_COMMAND" >&2' ERR

source $DOTFILES_DESTINATION/.bashrc

# postgresql
# mkdir -p /etc/postgresql-common
# \cp $DOTFILES_SOURCE/.psqlrc /etc/postgresql-common/psqlrc
