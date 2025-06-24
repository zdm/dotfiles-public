#!/usr/bin/env bash

set -Eeuo pipefail
trap 'echo -e "⚠  Error ($0:$LINENO): $(sed -n "${LINENO}p" "$0" 2> /dev/null | grep -oE "\S.*\S|\S" || true)" >&2; return 3 2> /dev/null || exit 3' ERR

source $DOTFILES_DESTINATION/.bashrc

# postgresql
# mkdir -p /etc/postgresql-common
# \cp $DOTFILES_SOURCE/.psqlrc /etc/postgresql-common/psqlrc
