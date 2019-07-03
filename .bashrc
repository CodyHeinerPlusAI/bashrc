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

###############################################################################

# Colors for PS1 prompt

# General Options
ResetColor="\[\033[0m\]"      # Reset
HighColor="\[\033[1m\]"       # High intensity color
Underline="\[\033[4m\]"       # Underline
SwapFgBg="\[\033[7m\]"        # background and foreground

# Regular Colors
Black="\[\033[0;30m\]"        # Black
Red="\[\033[0;31m\]"          # Red
Green="\[\033[0;32m\]"        # Green
Yellow="\[\033[0;33m\]"       # Yellow
Blue="\[\033[0;34m\]"         # Blue
Purple="\[\033[0;35m\]"       # Purple
Cyan="\[\033[0;36m\]"         # Cyan
White="\[\033[0;37m\]"        # White

# Bold
BBlack="\[\033[1;30m\]"       # Black
BRed="\[\033[1;31m\]"         # Red
BGreen="\[\033[1;32m\]"       # Green
BYellow="\[\033[1;33m\]"      # Yellow
BBlue="\[\033[1;34m\]"        # Blue
BPurple="\[\033[1;35m\]"      # Purple
BCyan="\[\033[1;36m\]"        # Cyan
BWhite="\[\033[1;37m\]"       # White

# Underline
UBlack="\[\033[4;30m\]"       # Black
URed="\[\033[4;31m\]"         # Red
UGreen="\[\033[4;32m\]"       # Green
UYellow="\[\033[4;33m\]"      # Yellow
UBlue="\[\033[4;34m\]"        # Blue
UPurple="\[\033[4;35m\]"      # Purple
UCyan="\[\033[4;36m\]"        # Cyan
UWhite="\[\033[4;37m\]"       # White

# Background
OnBlack="\[\033[40m\]"        # Black
OnRed="\[\033[41m\]"          # Red
OnGreen="\[\033[42m\]"        # Green
OnYellow="\[\033[43m\]"       # Yellow
OnBlue="\[\033[44m\]"         # Blue
OnPurple="\[\033[45m\]"       # Purple
OnCyan="\[\033[46m\]"         # Cyan
OnWhite="\[\033[47m\]"        # White

# High Intensty
IBlack="\[\033[0;90m\]"       # Black
IRed="\[\033[0;91m\]"         # Red
IGreen="\[\033[0;92m\]"       # Green
IYellow="\[\033[0;93m\]"      # Yellow
IBlue="\[\033[0;94m\]"        # Blue
IPurple="\[\033[0;95m\]"      # Purple
ICyan="\[\033[0;96m\]"        # Cyan
IWhite="\[\033[0;97m\]"       # White

# Bold High Intensty
BIBlack="\[\033[1;90m\]"      # Black
BIRed="\[\033[1;91m\]"        # Red
BIGreen="\[\033[1;92m\]"      # Green
BIYellow="\[\033[1;93m\]"     # Yellow
BIBlue="\[\033[1;94m\]"       # Blue
BIPurple="\[\033[1;95m\]"     # Purple
BICyan="\[\033[1;96m\]"       # Cyan
BIWhite="\[\033[1;97m\]"      # White

# High Intensty backgrounds
OnIBlack="\[\033[0;100m\]"    # Black
OnIRed="\[\033[0;101m\]"      # Red
OnIGreen="\[\033[0;102m\]"    # Green
OnIYellow="\[\033[0;103m\]"   # Yellow
OnIBlue="\[\033[0;104m\]"     # Blue
OnIPurple="\[\033[10;95m\]"   # Purple
OnICyan="\[\033[0;106m\]"     # Cyan
OnIWhite="\[\033[0;107m\]"    # White

###############################################################################

# Deleted conditional color prompt and xterm stuff here...

# Returns @host_name if host is not this computer, otherwise blank
at_host_short() {
    res="$(hostname)"
    if [ "$res" == "apollys-XPS" ]; then
        res=""
    fi
    echo "$res"
}

# Returns colored [docker] prefix if inside docker, otherwise blank
# (Note: uses variable we set in our docker containers, not general I believe)
docker_prefix() {
    res=""
    if [ -n "$CONTAINER" ]; then
        res="[docker] "
    fi
    echo "$res"
}

# From here: https://coderwall.com/p/fasnya/add-git-branch-name-to-bash-prompt
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

# Returns colored (branch) suffix if in a git repository, otherwise blank
git_branch_suffix() {
    branch="$(parse_git_branch)"
    res=""
    if [ -n "$branch" ]; then
        res=" ${branch}"
    fi
    echo "$res"
}

# All color variables placed directly in PS1 (not inside functions called in PS1)
# so that color substitution happens correctly.
PS1="\
${BPurple}\$(docker_prefix)${ResetColor}\
${debian_chroot:+($debian_chroot)}\
${BGreen}\u$(at_host_short)${ResetColor}: ${BBlue}\w${ResetColor}\
${Green}\$(git_branch_suffix)${ResetColor}\
 ${BPurple}★${ResetColor}  "

# Docker prompt prefix
#if [ -n "$CONTAINER" ]; then
#  PS1_PREFIX="\[\033[01;35m\][docker] \[\033[00m\]"
#else
#  PS1_PREFIX=""
#fi
#PS1="${PS1_PREFIX}${PS1}"

## Git branch suffix
## First, remove the last $ then space ($ is two characters because it's escaped)
## Remove the last character (x3) from PS1 (use regex that matches any character)
#PS1=${PS1%?}
#PS1=${PS1%?}
#PS1=${PS1%?}
## Next, define a function to parse the git branch
#parse_git_branch() {
# git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
#}
#GIT_BRANCH="$(parse_git_branch)"
## Check if git branch is non empty
#if [ -n "$GIT_BRANCH" ]; then
#  GREEN="\[\e[32m\]"
#  WHITE="\[\033[00m\]"
#  PS1="$PS1$GREEN $(parse_git_branch)"
#fi
## Regardless of whether there is a git branch, add the $ surrounded by spaces
#PS1="$PS1$WHITE \$ "



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

# g++ aliases for specific standards
alias g++11='g++ -std=c++11'
alias g++14='g++ -std=c++14'
alias g++17='g++ -std=c++17'
alias g++20='g++ -std=c++20'

# cd followed by ls
cdl() {
    cd $1 && ls
}

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# fmt alias (for formatting text to adhere to max characters per line)
format() {
    cp "$1" "$1.bak"
    fmt --width=100 "$1.bak" > "$1"
}

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

source /opt/ros/kinetic/setup.bash
