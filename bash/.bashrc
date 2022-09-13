# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

parse_git_branch() {
git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    export PS1='\[\033[01;32m\]\u\[\033[01;33m\]@\h\[\033[00m\]: \[\033[01;34m\]\w\[\033[00m\] $(parse_git_branch) \n\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# avitale added
bind '"\C-H":backward-kill-word'
alias darth-rm-pa='rm -rf ~/prj/pa-share-web/pa-share-web/src/app/core/resources && rm -rf ~/prj/pa-share-web/pa-share-web/src/app/core/http'
alias darth-cp-pa='cp -r /mnt/c/dev/prj/pa-share/pa-share-web/pa-share-web/src/app/core/http/ ~/prj/pa-share-web/pa-share-web/src/app/core/ && cp -r /mnt/c/dev/prj/pa-share/pa-share-web/pa-share-web/src/app/core/resources/ ~/prj/pa-share-web/pa-share-web/src/app/core/'
alias darth-pa='darth-rm-pa && darth-cp-pa'
alias darth-surveyor="rm -rf ~/prj/surveyor/libs/util/types/src/lib/darth && cp -r /mnt/c/dev/prj/pa-share/pa-share-web/pa-share-web/src/app/core/resources/ ~/prj/surveyor/libs/util/types/src/lib/darth"

devopsClone() {
    echo -e "Running command:\n   git clone https://git:$1@vhbdev.visualstudio.com/$2\n"
    git clone "https://git:$1@vhbdev.visualstudio.com/$2";
}

devopsUpdateRemote() {
    echo -e "Running command:\n   git remote set-url origin https://git:$1@vhbdev.visualstudio.com/$2\n"
    git remote set-url origin "https://git:$1@vhbdev.visualstudio.com/$2"
}

# dotnet certs
export ASPNETCORE_Kestrel__Certificates__Default__Password="trust-me"
export ASPNETCORE_Kestrel__Certificates__Default__Path=/mnt/c/Users/avitale/.aspnet/https/aspnetapp.pfx

# dotnet projects
alias dotnet-launch-pa='cd ~/prj/pa-share-web-api/pa-share-web-api && dotnet watch run --urls=https://localhost:44330 --launch-profile local'


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# automatically apply .nvmrc configs
# https://stackoverflow.com/a/50378304/2264081
enter_directory() {
  if [[ $PWD == $PREV_PWD ]]; then
    return
  fi

  if [[ "$PWD" =~ "$PREV_PWD" && ! -f ".nvmrc" ]]; then
    return
  fi

  PREV_PWD=$PWD
  if [[ -f ".nvmrc" ]]; then
    nvm use
    NVM_DIRTY=true
  elif [[ $NVM_DIRTY = true ]]; then
    nvm use default
    NVM_DIRTY=false
  fi
}
export PROMPT_COMMAND=enter_directory
. "$HOME/.cargo/env"

## Oh My Posh: https://ohmyposh.dev/
eval "$(oh-my-posh --init --shell bash --config ~/.poshthemes/nordtron.omp.json)"
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$HOME/prj/qrest/target/release/:$HOME/.local/bin:$PATH"

export COLORTERM="truecolor"


# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

alias tmux='TERM=xterm-256color tmux'
alias vim='nvim'

if [[ -z $STOW_FOLDERS ]]; then
    export STOW_FOLDERS="bash,nvim,tmux"
fi

if [[ -z $DOTFILES ]]; then
    export DOTFILES=$HOME/dotfiles
fi

export CHROME="/mnt/c/Program Files/Google/Chrome/Application/chrome.exe"
export EDGE="/mnt/c/Program Files (x86)/Microsoft/Edge/Application/msedge.exe"
export BROWSER=$EDGE
export GCM_CREDENTIAL_STORE="gpg"
GPG_TTY=$(tty)
export GPG_TTY

# MS is creepin
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export FUNCTIONS_CORE_TOOLS_TELEMETRY_OPTOUT=1

# based on: https://stackoverflow.com/a/66398613/2264081
# set DISPLAY to use X terminal in WSL
# in WSL2 the localhost and network interfaces are not the same than windows
# if grep -q WSL2 /proc/version; then
#     # execute route.exe in the windows to determine its IP address
#     DISPLAY=$(route.exe print | grep 0.0.0.0 | head -1 | awk '{print $4}'):0.0
#
# else
#     # In WSL1 the DISPLAY can be the localhost address
#     if grep -q icrosoft /proc/version; then
#         DISPLAY=127.0.0.1:0.0
#     fi
#
# fi
