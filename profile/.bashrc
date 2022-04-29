[ -z "$DEBIAN_FRONTEND" ] && [ -z "$PS1" ] && export DEBIAN_FRONTEND=noninteractive

export LANGUAGE=C.UTF-8
export LANG=C.UTF-8
export LC_ALL=C.UTF-8

shopt -s dotglob extglob nocaseglob

# if not running interactively, don't do anything
[ -z "$PS1" ] && return

[ -z "$DEBIAN_FRONTEND" ] && export DEBIAN_FRONTEND=teletype

export TERM=putty-256color
export CLICOLOR=1
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
alias g="git"
alias gce="gcloud compute"
alias gcp="gcloud config configurations"
alias s="softvisio-cli"

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

function update() {
    apt update
    apt full-upgrade -y
    apt autoremove -y

    if [[ -x "$(command -v update-core)" ]]; then
        update-core
    fi
}

function update-dotfiles() {
    source <(curl -fsSL https://raw.githubusercontent.com/softvisio/scripts/main/update-dotfiles.sh)
}
