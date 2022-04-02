#!/usr/bin/env bash

[ -z "${DEBIAN_FRONTEND:-}" ] && [ -z "${PS1:-}" ] && export DEBIAN_FRONTEND=noninteractive

if [ $(uname) = "Darwin" ]; then
    export LANGUAGE=en_GB.UTF-8
    export LANG=en_GB.UTF-8
    export LC_ALL=en_GB.UTF-8
else
    export LANGUAGE=C.UTF-8
    export LANG=C.UTF-8
    export LC_ALL=C.UTF-8
fi

# if not running interactively, don't do anything
[ -z "${PS1:-}" ] && return

shopt -s histappend no_empty_cmd_completion

[ -z "${DEBIAN_FRONTEND:-}" ] && export DEBIAN_FRONTEND=teletype

export TERM=xterm-256color
export CLICOLOR=1
export EDITOR=nvim
export HISTSIZE=1000
export HISTFILESIZE=2000
export HISTCONTROL=ignoreboth:erasedups
export PROMPT_COMMAND="history -n; history -w; history -c; history -r"

# gpg
GPG_TTY=$(tty)
export GPG_TTY

# postgresql
[ -z "${PGUSER:-}" ] && export PGUSER=postgres

# root user
if [ "$(id -u)" == "0" ]; then
    export PS1="[\[\e[1;31m\]\u\[\e[0;31m\]@\[\e[1;31m\]\H\[\e[0m\]\w]\[\e[1;33m\]\043\[\e[0m\] "

# non-root user
else
    export PS1="[\[\e[1;32m\]\u\[\e[0;32m\]@\[\e[1;32m\]\H\[\e[0m\]\w]\[\e[1;33m\]\044\[\e[0m\] "
fi

bind "set completion-ignore-case on" 2> /dev/null

# bash completion
COMP_CONFIGURE_HINTS=1
COMP_TAR_INTERNAL_PATHS=1
[[ -f /etc/bash_completion ]] && . /etc/bash_completion

# aliases
# to override the alias instruction use a `\` before
# ie: `\rm` will call the real `rm` not the alias
alias ls="ls -hFv --color=auto --group-directories-first"
alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i"
alias grep="grep --color=auto"
alias egrep="egrep --color=auto"
alias fgrep="fgrep --color=auto"
alias less="less --no-init --raw-control-chars --ignore-case --quit-on-intr --squeeze-blank-lines --quit-if-one-screen"
alias autossh="autossh -M 0 -o 'ServerAliveInterval 30' -o 'ServerAliveCountMax 3'"
alias df="df -h"
alias du="du -h"
alias d="docker"
alias g="git"
alias gc="gcloud"
alias gce="gcloud compute"
alias gcp="gcloud config configurations"
alias s="softvisio-cli"
alias sapi="softvisio-api"

[[ -f ~/.bash_aliases ]] && . ~/.bash_aliases

function update() {

    # Msys
    if [ $(uname -o) = "Msys" ]; then

        echo
        echo "#### Sync package list and perform system upgrade"
        pacman -S --noconfirm --needed --refresh --sysupgrade

        echo
        echo "#### Remove unused packages"
        pacman -Qqdt | pacman --noconfirm -Rns -

        echo
        echo "#### Cleanup cache"
        pacman --noconfirm -S --clean --clean

    # Darwin
    elif [ $(uname) = "Darwin" ]; then
        brew update

        # update brew packages to the latest varions
        brew upgrade

        # update cocoapods repositories
        pod repo update

        # update global node packages
        npm ou -g
        npm up -g

    # Debian / Ubuntu
    elif [ $(source /etc/os-release && echo $ID_LIKE) = "debian" ]; then

        # apt
        echo "### Updating: apt"
        apt-get update
        apt-get full-upgrade -y
        apt-get autoremove -y

        # update resources
        if [[ -x "$(command -v softvisio-cli)" ]]; then

            echo
            echo "### Updating: resources"
            softvisio-cli workspace update-resources
        fi

        # npm
        if [[ -x "$(command -v npm)" ]]; then

            echo
            echo "### Updating: npm global packages"
            # npm ou -g
            npm up -g

            echo
            echo "### Clearing npm cache"
            npm cache clear --force
        fi
    fi
}

function update-dotfiles() {

    # Msys
    if [ $(uname -o) = "Msys" ]; then
        echo Msys is not supported

        return 1

    # other OS
    else
        local script
        script=$(curl -fsS "https://raw.githubusercontent.com/softvisio/scripts/main/update-dotfiles.sh")
        source <(echo "$script")
    fi
}

function ssh-crypt() {
    local script
    script=$(curl -fsS "https://raw.githubusercontent.com/softvisio/scripts/main/ssh-crypt.sh")
    bash <(echo "$script") "$@"
}

function unlock-gpg() {
    local script
    script=$(curl -fsS "https://raw.githubusercontent.com/softvisio/scripts/main/unlock-gpg.sh")
    bash <(echo "$script") "$@"
}
