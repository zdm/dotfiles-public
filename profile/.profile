# ~/.profile: executed by Bourne-compatible login shells.

[ :$PATH: == *":$(realpath ~)/.bin:"* ] || PATH="$(realpath ~)/.bin:$PATH"

if [ "$BASH" ]; then
    if [ -f ~/.bashrc ]; then
        . ~/.bashrc
    fi
fi

mesg n 2> /dev/null || true
