# install following packages at first
# - `brew install fzf`
# - `brew install peco`
# - `brew install zplug`
# - `brew install zsh-autosuggestions`


# PATH
# TODO: export your PATHs here


# color
export LSCOLORS=Exfxcxdxbxegedabagacad
export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
export ZLS_COLORS=$LS_COLORS
export CLICOLOR=true
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}


# PROMPT
autoload colors
colors

## show branch name
autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:*' formats "%F{green}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () { vcs_info }

PROMPT="%{${fg[green]}%}▶︎"'${vcs_info_msg_0_}'"%{${reset_color}%} %~
$ "


# complement
autoload -Uz compinit
compinit


# load fzf config
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


# functions
## ls after cd
function cd(){ builtin cd $@ && ls; } # cdしたらlsする

function f() {
  files=$(git ls-files) &&
  selected_files=$(echo "$files" | fzf -m --preview 'head -100 {}') &&
  vim $selected_files
}

## search command history
function peco-history-selection() {
  BUFFER=`history -nr 1  | awk '!a[$0]++' | peco`
  echo $BUFFER
  echo $BUFFER | perl -pe 'chomp' | pbcopy  # chompで改行を削除する
  echo "copied the command!"
  eval $BUFFER
}

## git checkout
function gcp() {
    git branch -a --sort=-authordate |
    grep -v -e '->' -e '*' |
    perl -pe 's/^\h+//g' |
    perl -pe 's#^remotes/origin/###' |
    perl -nle 'print if !$c{$_}++' |
    peco |
    xargs git checkout
}


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
alias c='clear'
alias h='history'
alias hs=peco-history-selection
alias v='vim'
alias t='tmux'

## docker alias
alias dockerps='docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"'
alias dockerpsa='docker ps -a --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"'
alias dockerimages="docker images --format \"table {{.Size}}\t{{.Repository}}:{{.Tag}}\t{{.ID}}\" | sed -e '1d' | sort -h -r"
alias dc='docker compose'

## vim-plug alias
alias pluginstall='vim +PlugInstall +q +q'
alias plugclean='vim +PlugClean +q +q'

## git alias
alias gs='git status'
alias ga='git add'
alias gd='git diff'
alias gds='git diff --staged'
alias gc='git checkout'
alias gcm='git commit -m'
alias gl='git log --oneline --graph --decorate'
alias gp='git push origin HEAD'
alias gf='git fetch'


# setup zplug
export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh


# enhancd
zplug "b4b4r07/enhancd", use:init.sh
export ENHANCD_DISABLE_DOT=1     # ..は普通に..する
export ENHANCD_HOOK_AFTER_CD=ls  # cdした後に実行するコマンドを指定
export ENHANCD_FILTER=fzy

zplug load


# zsh-autosuggestions
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
