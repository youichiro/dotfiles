# PATH
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:$HOME/.pyenv/bin
export PATH=$PATH:/tools/env/lib/mecab
export PATH=$PATH:/tools/env/bin/mecab
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"


# export
export LANG=ja_JP.UTF-8
export HISTFILE=~/.zsh_history
export HISTSIZE=10000
export SAVEHIST=1000000


# option
setopt auto_pushd
setopt pushd_ignore_dups
setopt print_eight_bit
setopt no_flow_control
setopt interactive_comments


# color
export LSCOLORS=Exfxcxdxbxegedabagacad
export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
export ZLS_COLORS=$LS_COLORS
export CLICOLOR=true
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}


# PROMPT
autoload colors
colors
PROMPT="%{${fg[yellow]}%}[%n@%m]%{${reset_color}%} %~ %# "


# alias
alias -g L='| less'
alias -g G='| grep'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias reload='exec $SHELL -l'
alias zshrc='vim ~/.zshrc'
alias vimrc='vim ~/.vimrc'
alias la='ls -a'
alias ll='ls -l'
alias lab='cd /lab/ogawa'
alias h='history'
alias tmuxconf='vim ~/.tmux.conf'
alias tmux-a='tmux attach'
alias tmux-k='tmux kill-session'


# show branch name
autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:*' formats "%F{green}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () { vcs_info }
RPROMPT=$RPROMPT'${vcs_info_msg_0_}'


# others
autoload -Uz compinit # 補完機能を有効にする
compinit
function cd(){ builtin cd $@ && ls; } # cdしたらlsする
cd /lab/ogawa

