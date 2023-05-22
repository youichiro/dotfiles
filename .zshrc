# You need to execute these commands:
# - brew install zsh-completions
# - brew install zsh-autosuggestions
# - brew install zplug
# - brew install fzy
# - zplug install

zstyle ":completion:*:commands" rehash 1

# paths
export PATH="$PATH:/opt/homebrew/bin"
export PATH="$PATH:$HOME/.pyenv/bin"
export PATH="$PATH:$HOME/.nodenv/shims"
export PATH="/Users/youichiro/.local/bin:$PATH"

# evals
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
eval "$(nodenv init -)"
eval "$(direnv hook zsh)"

# colors
autoload -Uz colors && colors


# prompt
# PROMPT="%{${fg[green]}%}▶︎ %~ %{${reset_color}%}
# $ "

# functions
## cdしたらlsする
function cd(){ builtin cd $@ && ls; }

## コマンド実行後に改行する
add_newline() {
  if [[ -z $PS1_NEWLINE_LOGIN ]]; then
    PS1_NEWLINE_LOGIN=true
  else
    printf '\n'
  fi
}
precmd() {
  add_newline
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
alias ls='ls -G'
alias la='ls -a'
alias ll='ls -l'
alias lla='ls -la'
alias c='clear'
alias h='history'
alias hs=peco-history-selection
alias v='vim'
alias t='tmux'

# docker alias
alias dockerps='docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"'
alias dockerpsa='docker ps -a --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"'
alias dockerimages="docker images --format \"table {{.Size}}\t{{.Repository}}:{{.Tag}}\t{{.ID}}\" | sed -e '1d' | sort -h -r"
alias dc='docker compose'

# git alias
alias gs='git status'
alias ga='git add'
alias gd='git diff'
alias gds='git diff --staged'
alias gc='git checkout'
alias gcm='git commit -m'
alias gl='git log --oneline --graph --decorate'
alias gp='git push origin HEAD'
alias gf='git fetch'
alias fix-push='git add . && git commit -m "fix" && git push'

# zsh-cimpletions, zsh-autosuggestions
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
  source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
  autoload -Uz compinit && compinit
fi

# zplug
export ZPLUG_HOME=/opt/homebrew/opt/zplug
source $ZPLUG_HOME/init.zsh

# enhancd
zplug "b4b4r07/enhancd", use:init.sh
export ENHANCD_ENABLE_DOUBLE_DOT=false  # ..は普通に..する
export ENHANCD_HOOK_AFTER_CD=ls  # cdした後に実行するコマンドを指定
export ENHANCD_FILTER=fzy

# git-prompt
zplug "woefe/git-prompt.zsh"

zplug load

