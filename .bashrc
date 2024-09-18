#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ linux ]] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
    exec tmux
fi

set -o vi

HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000
shopt -s histappend
shopt -s checkwinsize

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias xbindkeys="xbindkeys -fg $XDG_CONFIG_HOME/xbindkeys/config.scm"
PS1='[\u@\h \W]\$ '



export MANPATH="$MANPATH:/usr/local/texlive/2024/texmf-dist/doc/man"
export INFOPATH="$INFOPATH:/usr/local/texlive/2024/texmf-dist/doc/info"
export PATH="$PATH:/usr/local/texlive/2024/bin/x86_64-linux"

export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.locale/state
export XDG_RUNTIME_DIR=/run/user/$UID

export CUDA_CACHE_PATH="$XDG_CACHE_HOME"/nv

export XAUTHORITY="$XDG_RUNTIME_DIR"/Xauthority
export XINITRC="$XDG_CONFIG_HOME"/X11/xinitrc

