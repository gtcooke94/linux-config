ZSH_THEME="robbyrussell"
plugins=(git bundler osx rake ruby)
CASE_SENSITIVE="true"
source $ZSH/oh-my-zsh.sh

export HISTFILE=~/.zsh_history
export HISTSIZE=10000
export SAVEHIST=10000

setopt sharehistory
setopt extendedhistory

export EDITOR=vim

bindkey -v

function abcdefg {
    up-history 
    vi-cmd-mode
}

bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^w' backward-kill-word
bindkey '^r' history-incremental-search-backward
bindkey '^s' history-incremental-search-forward
bindkey '^u' backward-kill-line

# http://dougblack.io/words/zsh-vi-mode.html
# http://stackoverflow.com/a/3791786
function zle-line-init zle-keymap-select zle-history-line-set {
    VIM_NORMAL="%{$fg_bold[yellow]%} [% NORMAL]% %{$reset_color%}"
    VIM_INSERT="%{$fg_bold[green]%} [% INSERT]% %{$reset_color%}"
    RPS1="${${KEYMAP/vicmd/$VIM_NORMAL}/(main|viins)/$VIM_INSERT}"
    zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select
zle -N zle-history-line-set
export KEYTIMEOUT=1

#git aliases
alias gs='git status'
alias gf='git fetch'
alias gm='git merge'
alias gms='git merge -S'
alias ga='git add'
alias gcm='git commit'
alias gcms='git commit -S'
alias gco='git checkout'
alias gd='git difftool -y 2> /dev/null'
alias gb='git branch'
alias gh='git help'
alias gl='git log --pretty=format:"%C(yellow)%h %ad %Creset%s %C(red)%d %Cgreen[%an] %Creset" --decorate --date=short -10 --graph'
alias glm='git log --oneline --decorate --graph'
alias gu='git unstage'
compdef __git_branch_names glmb

#other aliases
alias grep='grep --color=auto'
alias find1='find -maxdepth 1 -mindepth 1'
alias CLR='for i in {1..99}; do echo; done; clear'

function git_pull_dirs {

    TEMP_OLDPWD=$OLDPWD

    for d in $(dirname $(find -name "\.git")); do
        cd $d
        git pull
        cd $OLDPWD
    done

    OLDPWD=$TEMP_OLDPWD

}

alias vim="nvim"
alias gitextensions="~/GitExtensions/GitExtensions.exe &"
#alias gvim='gnome-terminal -- nvim -p -cc "cd `pwd`"' 
alias gvim='gnome-terminal -- nvim -c "cd `pwd`"' 
# export NVIM_LISTEN_ADDRESS=/tmp/nvimsocket

# Make v start a new tab with nvim
# Make gvim start a new terminal with nvim
# Both will make the working directory the current directory
if [ -n "$NVIM_LISTEN_ADDRESS" ]; then
    export VISUAL='nvr -cc "cd `pwd`" -cc tabedit --remote-wait +"set bufhidden=wipe"'
  else
      export VISUAL="nvim"
fi
alias v="$VISUAL"

# screenshot to clipboard alias
alias scrotclip= 'scrot -s ~/foo.png && xclip ~/foo.png && rm ~/foo.png'
