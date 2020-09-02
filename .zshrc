# setup
# brew install fzf
# brew install peco
# brew install tig


# PATH


# history
export LANG=ja_JP.UTF-8
export HISTFILE=~/.zsh_history
export HISTSIZE=10000
export SAVEHIST=1000000
export HISTFILESIZE=10000
setopt hist_ignore_dups
setopt hist_reduce_blanks
setopt hist_no_store
setopt hist_expand
setopt inc_append_history


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


# complement
autoload -Uz compinit
compinit


# functions
function cd(){ builtin cd $@ && ls; } # cdしたらlsする

function fvim() {
  files=$(git ls-files) &&
  selected_files=$(echo "$files" | fzf -m --preview 'head -100 {}') &&
  vim $selected_files
}

function peco-history-selection() {
  BUFFER=`history -n 1 | tail -r  | awk '!a[$0]++' | peco`
  eval $BUFFER
}


# vals
export EDITOR='vim'


# alias
alias -g L='| less'
alias -g G='| grep'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias reload='exec $SHELL -l'
alias zshrc='vim ~/.zshrc'
alias vimrc='vim ~/.vimrc'
alias tmuxconf='vim ~/.tmux.conf'
alias la='ls -a'
alias ll='ls -l'
alias lla='ls -la'
alias h='history'
alias hs=peco-history-selection


# alias for git
alias gs='git status'
alias ga='git add'
alias gd='git diff'
alias gds='git diff --staged'
alias gcm='git commit -m'
alias gl='git log --oneline --graph --decorate'

