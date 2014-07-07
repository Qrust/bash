### BEGIN

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups

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
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

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

#------------------------------------------////
# Colors:
#------------------------------------------////
blk='\e[0;30m' # Black - Regular - 
red='\e[0;31m' # Red
grn='\e[0;32m' # Green
ylw='\e[0;33m' # Yellow
blu='\e[0;34m' # Blue
pur='\e[0;35m' # Purple
cyn='\e[0;36m' # Cyan
wht='\e[0;37m' # White
#------------------------------------------////
Bblk='\e[1;30m' # Black - B
Bred='\e[1;31m' # Red
Bgrn='\e[1;32m' # Green
Bylw='\e[1;33m' # Yellow
Bblu='\e[1;34m' # Blue
Bpur='\e[1;35m' # Purple
Bcyn='\e[1;36m' # Cyan
Bwht='\e[1;37m' # White
#------------------------------------------////
Ublk='\e[4;30m' # Black - Underline
Ured='\e[4;31m' # Red
Ugrn='\e[4;32m' # Green
Uylw='\e[4;33m' # Yellow
Ublu='\e[4;34m' # Blue
Upur='\e[4;35m' # Purple
Ucyn='\e[4;36m' # Cyan
Uwht='\e[4;37m' # White
#------------------------------------------////
Gblk='\e[40m'   # Black - Backgroun
Gred='\e[41m'   # Red
Ggrn='\e[42m'   # Green
Gylw='\e[43m'   # Yellow
Gblu='\e[44m'   # Blue
Gpur='\e[45m'   # Purple
Gcyn='\e[46m'   # Cyan
Gwht='\e[47m'   # White
#------------------------------------------////
rst='\e[0m'    # Text Reset 
#------------------------------------------////

if [ "$color_prompt" = yes ]; 
then
	PS1="$Bblu╓─$Bpur[$Bgrn\u$Bpur] [$Bcyn\h$Bpur] [$ylw\w$Bpur]\n\[$Bblu\]╙─>>>\[$rst\] "
else
	PS1='[\u@\h]++[\t]+++[${PWD}]\$\n'
fi
unset color_prompt force_color_prompt
# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias lal='ls -al'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

alias install='sudo apt-get install'
alias update='sudo apt-get update'
alias upgrade='sudo apt-get -u upgrade'
alias agi='sudo apt-get install'
alias agu='sudo apt-get update'
alias agg='sudo apt-get -u upgrade'
alias reload='source ~/.bashrc'

alias ls='ls -hF --color'    # add colors for filetype recognition
alias lx='ls -lXB'        # sort by extension
alias lk='ls -lSr'        # sort by size
alias la='ls -Al'        # show hidden files
alias lr='ls -lR'        # recursice ls
alias lt='ls -ltr'        # sort by date
alias lm='ls -al |more'        # pipe through 'more'
alias ll='ls -l'        # long listing
alias lsize='ls --sort=size -lhr' # list by size
alias lsd='ls -l | grep "^d"'   #list only directories
alias lalf='ls -alF'

alias aptsrc='aptitude search $1'

#Command substitution
alias h='history | grep $1'
alias rm='rm -i'
alias cp='cp -v -i'
alias mv='mv -i'
alias which='type -all'
alias dmt='dmesg|tail'

alias df='df -h'
alias ifc='sudo ifconfig -a'

# Creates an archive from given directory
mktar() { tar cvf  "${1%%/}.tar"     "${1%%/}/"; }
mktgz() { tar cvzf "${1%%/}.tar.gz"  "${1%%/}/"; }
mktbz() { tar cvjf "${1%%/}.tar.bz2" "${1%%/}/"; }

# Easy extract
# uncompress depending on extension...
extract() {    
  if [ -f "$1" ] ; then
    case "$1" in
      *.tar.bz2) tar xvjf "$1"   ;;
      *.tar.gz)  tar xvzf "$1"   ;;
      *.bz2)     bunzip2 "$1"    ;;
      *.rar)     unrar x "$1"    ;;
      *.gz)      gunzip "$1"     ;;
      *.tar)     tar xvf "$1"    ;;
      *.tbz2)    tar xvjf "$1"   ;;
      *.tgz)     tar xvzf "$1"   ;;
      *.zip)     unzip "$1"      ;;
      *.Z)       uncompress "$1" ;;
      *.7z)      7z x "$1"       ;;
      *)
      echo "'$1' cannot be extracted"
      return 1
      ;;
    esac
  else
    echo "'$1' is not a valid file"
    return 1
  fi
  return 0
}

complete -cf sudo

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

### END
