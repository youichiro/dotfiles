alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias ..='cd ..'
alias ...='cd ../..'
alias reload='exec $SHELL -l'
alias bashrc='vim ~/.bashrc'
alias vimrc='vim ~/.vimrc'
alias ls='ls -FG'
alias la='ls -aFG'
alias ll='ls -lFG'
alias h='history'
alias tmuxconf='vim ~/.tmux.conf'

cd ()
{
  builtin cd "$@" && ls
}

# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi
