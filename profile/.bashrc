[ -z "$DEBIAN_FRONTEND" ] && [ -z "$PS1" ] && export DEBIAN_FRONTEND=noninteractive

if [ $(uname) = "Darwin" ]; then
    export LANGUAGE=en_GB.UTF-8
    export LANG=en_GB.UTF-8
    export LC_ALL=en_GB.UTF-8
else
    export LANGUAGE=C.UTF-8
    export LANG=C.UTF-8
    export LC_ALL=C.UTF-8
fi

shopt -s dotglob extglob nocaseglob

# if not running interactively, don't do anything
[ -z "$PS1" ] && return

[ -z "$DEBIAN_FRONTEND" ] && export DEBIAN_FRONTEND=teletype

if [ "$TERM_PROGRAM" = "Apple_Terminal" ]; then
    export TERM=xterm-256color
else
    export TERM=putty-256color
fi

export CLICOLOR=1
export EDITOR=nvim
export HISTSIZE=1000
export HISTFILESIZE=2000
export HISTCONTROL=ignoreboth:erasedups
export PROMPT_COMMAND="history -n; history -w; history -c; history -r"

# postgresql
[ -z "$PGUSER" ] && export PGUSER=postgres

# root user
if [ "$(id -u)" == "0" ]; then
    export PS1="[\[\e[1;31m\]\u\[\e[0;31m\]@\[\e[1;31m\]\H\[\e[0m\]\w]\[\e[1;33m\]#\[\e[0m\] "

# regular user
else
    export PS1="[\[\e[1;32m\]\u\[\e[0;32m\]@\[\e[1;32m\]\H\[\e[0m\]\w]\[\e[1;33m\]>\[\e[0m\] "
fi

shopt -s cdspell checkwinsize cmdhist dirspell histappend no_empty_cmd_completion

bind "set completion-ignore-case on" 2> /dev/null

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias grep='grep --color=auto'
alias less='less --no-init --raw-control-chars --ignore-case --quit-on-intr --squeeze-blank-lines --quit-if-one-screen'
alias autossh="autossh -M 0 -o 'ServerAliveInterval 30' -o 'ServerAliveCountMax 3'"
alias pscp="source <( curl -fsSL https://raw.githubusercontent.com/softvisio/scripts/main/pscp.sh )"
alias d="docker"
# alias dsp="docker system prune -af"
alias g="git"
alias gc="gcloud"
alias gce="gcloud compute"
alias gcp="gcloud config configurations"
alias a="softvisio-api"
alias c="softvisio-cli"

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

function update() {

    # darwin
    if [ $(uname) = "Darwin" ]; then
        brew update

        # update brew packages to the latest varions
        brew upgrade

        # update cocoapods repositories
        pod repo update

        # update global node packages
        npm up -g

    else

        # debian / ubuntu
        apt-get update
        apt-get full-upgrade -y
        apt-get autoremove -y
    fi
}

function update-dotfiles() {
    source <(curl -fsSL https://raw.githubusercontent.com/softvisio/scripts/main/update-dotfiles.sh)
}
