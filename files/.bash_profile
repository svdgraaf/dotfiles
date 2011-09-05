# Determine OS -----------------------------------------------------------------
if [ -f ~/.dotfiles_lib/bash/detect_os.sh ]; then
  . ~/.dotfiles_lib/bash/detect_os.sh
fi

# Paths ------------------------------------------------------------------------

export PATH=/usr/local/bin:/usr/local/sbin:$PATH:~/.dotfiles_lib/bin

# RVM --------------------------------------------------------------------------

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# Load .bashrc -----------------------------------------------------------------

if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi

# Notes: -----------------------------------------------------------------------
# When you start an interactive shell (log in, open terminal or iTerm in OS X,
# or create a new tab in iTerm) the following files are read and run, in this order:
# /etc/profile
# /etc/bashrc
# ~/.bash_profile
# ~/.bashrc (only because this file is run (sourced) in .bash_profile)
#
# When an interactive shell, that is not a login shell, is started
# (when you run "bash" from inside a shell, or when you start a shell in
# xwindows [xterm/gnome-terminal/etc] ) the following files are read and executed,
# in this order:
# /etc/bashrc
# ~/.bashrc

DULL=0
BRIGHT=1

FG_BLACK=30
FG_RED=31
FG_GREEN=32
FG_YELLOW=33
FG_BLUE=34
FG_VIOLET=35
FG_CYAN=36
FG_WHITE=37

FG_NULL=00

BG_BLACK=40
BG_RED=41
BG_GREEN=42
BG_YELLOW=43
BG_BLUE=44
BG_VIOLET=45
BG_CYAN=46
BG_WHITE=47

BG_NULL=00

##
# ANSI Escape Commands
##
ESC="\033"
NORMAL="\[$ESC[m\]"
RESET="\[$ESC[${DULL};${FG_WHITE};${BG_NULL}m\]"

##
# Shortcuts for Colored Text ( Bright and FG Only )
##

# DULL TEXT
BLACK="\[$ESC[${DULL};${FG_BLACK}m\]"
RED="\[$ESC[${DULL};${FG_RED}m\]"
GREEN="\[$ESC[${DULL};${FG_GREEN}m\]"
YELLOW="\[$ESC[${DULL};${FG_YELLOW}m\]"
BLUE="\[$ESC[${DULL};${FG_BLUE}m\]"
VIOLET="\[$ESC[${DULL};${FG_VIOLET}m\]"
CYAN="\[$ESC[${DULL};${FG_CYAN}m\]"
WHITE="\[$ESC[${DULL};${FG_WHITE}m\]"

# BRIGHT TEXT
BRIGHT_BLACK="\[$ESC[${BRIGHT};${FG_BLACK}m\]"
BRIGHT_RED="\[$ESC[${BRIGHT};${FG_RED}m\]"
BRIGHT_GREEN="\[$ESC[${BRIGHT};${FG_GREEN}m\]"
BRIGHT_YELLOW="\[$ESC[${BRIGHT};${FG_YELLOW}m\]"
BRIGHT_BLUE="\[$ESC[${BRIGHT};${FG_BLUE}m\]"
BRIGHT_VIOLET="\[$ESC[${BRIGHT};${FG_VIOLET}m\]"
BRIGHT_CYAN="\[$ESC[${BRIGHT};${FG_CYAN}m\]"
BRIGHT_WHITE="\[$ESC[${BRIGHT};${FG_WHITE}m\]"

# Print hostname
/usr/local/bin/figlet -w 120 `hostname`

# Print IP
OS=`uname`
IO="" # store IP
case $OS in
   Linux) IP=`/sbin/ifconfig | grep 'inet addr:'| grep -v '127.0.0.1' -m 1 | cut -d: -f2 | awk '{ print $1}'`;;
   FreeBSD|OpenBSD|Darwin) IP=`/sbin/ifconfig | grep -E 'inet.[0-9]' | grep -v '127.0.0.1' -m 1 | awk '{ print $2}'` ;;
   SunOS) IP=`/sbin/ifconfig -a | grep inet | grep -v '127.0.0.1' -m 1 | awk '{ print $2} '` ;;
   *) IP="Unknown";;
esac

# set prompt
PS1="\e]2;\u@\H \[\w\]\a\n${BRIGHT_BLUE}\u${WHITE}@${GREEN}\H${WHITE} [${IP}]`tput sgr0`: \w\n\$ "
export PS1

# set editor
EDITOR="vim"

w
