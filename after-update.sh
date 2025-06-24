#!/usr/bin/env bash

function _after-update() {
    source $DOTFILES_DESTINATION/.bashrc

    # postgresql
    # mkdir -p /etc/postgresql-common
    # \cp $DOTFILES_SOURCE/.psqlrc /etc/postgresql-common/psqlrc
}

_after-update
