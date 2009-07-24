alias reloadbash='source ~/.bash_profile'

# Determine OS -----------------------------------------------------------------
if [ "$OS" = "" ] && [ -f ~/.dotfiles_lib/bash/detect_os.sh ]; then
  . ~/.dotfiles_lib/bash/detect_os.sh
fi

# Colors -----------------------------------------------------------------------
export TERM=xterm-color
export GREP_OPTIONS='--color=auto' GREP_COLOR='1;32'
export CLICOLOR=1

if [ "$OS" = "linux" ] ; then
  alias ls='ls --color=auto' # For linux, etc
  # ls colors, see: http://www.linux-sxs.org/housekeeping/lscolors.html
  export LS_COLORS='di=1:fi=0:ln=31:pi=5:so=5:bd=5:cd=5:or=31:mi=0:ex=35:*.rb=90' #LS_COLORS is not supported by the default ls command in OS-X
else
  alias ls='ls -G' # OS-X SPECIFIC - the -G command in OS-X is for colors, in Linux it's no groups
fi

# Setup some colors to use later in interactive shell or scripts
export COLOR_NC='\e[0m' # No Color
export COLOR_WHITE='\e[1;37m'
export COLOR_BLACK='\e[0;30m'
export COLOR_BLUE='\e[0;34m'
export COLOR_LIGHT_BLUE='\e[1;34m'
export COLOR_GREEN='\e[0;32m'
export COLOR_LIGHT_GREEN='\e[1;32m'
export COLOR_CYAN='\e[0;36m'
export COLOR_LIGHT_CYAN='\e[1;36m'
export COLOR_RED='\e[0;31m'
export COLOR_LIGHT_RED='\e[1;31m'
export COLOR_PURPLE='\e[0;35m'
export COLOR_LIGHT_PURPLE='\e[1;35m'
export COLOR_BROWN='\e[0;33m'
export COLOR_YELLOW='\e[1;33m'
export COLOR_GRAY='\e[1;30m'
export COLOR_LIGHT_GRAY='\e[0;37m'
alias colorslist="set | egrep 'COLOR_\w*'" # lists all the colors

# History ----------------------------------------------------------------------
export HISTCONTROL=ignoredups
export HISTFILESIZE=3000
export HISTIGNORE="ls:[bf]g:exit:l:sl:ll:llg"

# Aliases ----------------------------------------------------------------------
# general shortcuts
alias mv='mv -i'
alias rm='rm -i'

# alias ":" => "cd ../", "::" => "cd ../../", etc
for (( i = 1 ; i <= 10 ; i++ )); do
  dots=""; dirs="";
  for (( j = 1 ; j <= $i ; j++ )); do dots="$dots"":"; dirs="$dirs""../"; done
  alias "$dots"="cd $dirs"
done

# listing files
alias sl='ls'
alias l='ls -al'
alias ll='ls -al'
alias llg='ls -al | grep'

# tailing files
alias tf='tail -f -n 0'
alias t100='tail -n 100'
alias t500='tail -n 500'
alias t1000='tail -n 1000'
alias t2000='tail -n 2000'

# ignore svn metadata - pipe this into xargs to do stuff
alias no_svn="find . -path '*/.svn' -prune -o -type f -print"

# grep for a process
function psg {
  ps aux | grep "$1"
}

# tarball
function tgz {
  tar cfz "$1.tar.gz" $1
}

# Awk shortcuts
# Creates col1 .. col20
for (( i = 0 ; i <= 20 ; i++ )); do alias "col$i"="awk '{print \$$i}'"; done

# Ruby on Rails
alias rp='touch tmp/restart.txt'
alias devlog='tail -f log/development.log'
alias sc='script/console'
alias ss='script/server'
alias jsc='jruby script/console'
alias jss='jruby script/server'
alias ri='ri -f ansi' # colored ri
alias rdm='rake db:migrate'
alias rdmt='rake db:migrate RAILS_ENV=test'

# SSH
if [ -f '~/.ssh/id_rsa.pub' ]; then
  function add_ssh_key_to_host {
    cat ~/.ssh/id_rsa.pub | ssh $1 'cat >> ~/.ssh/authorized_keys'
  }
fi

# Subversion
alias sup='svn up'
alias sst='svn st'
alias sstu='svn st -u'
alias sci='svn ci -m'
alias sdiff='svn diff | colordiff'
alias sadd="sst | grep '?' | col2 | xargs svn add"
alias sdel="sst | grep '!' | col2 | xargs svn delete"
alias sclean="sadd; sdel"
alias srevert='svn st | col2 | xargs svn revert'

# search in history
alias h?="history | grep "

# display battery info on your Mac
# see http://blog.justingreer.com/post/45839440/a-tale-of-two-batteries
alias battery='ioreg -w0 -l | grep Capacity | cut -d " " -f 17-50'

# OS specific aliases/functions
if [ "$OS" = "darwin" ] ; then
  function ssh_proxy {
    ssh -t -D 8081 localhost "ssh -nNT -R 8080:127.0.0.1:8081 $1"
  }

  # Attempt to use MacPorts findutils instead of defaults
  if which gsed &> /dev/null; then alias sed='gsed'; fi
  if which gfind &> /dev/null; then alias find='gfind'; fi

  # Apache control
  alias htstart='sudo /opt/local/apache2/bin/apachectl start'
  alias htreload='sudo /opt/local/apache2/bin/apachectl graceful'
  alias htrestart='sudo /opt/local/apache2/bin/apachectl restart'
  alias htstop='sudo /opt/local/apache2/bin/apachectl stop'
  alias htstatus='sudo /opt/local/apache2/bin/apachectl status'
  alias htalog='tail -f /opt/local/apache2/logs/error_log'
  alias htelog='tail -f /opt/local/apache2/logs/access_log'

  # MySQL control
  alias mysqlstart='sudo -b /opt/local/bin/mysqld_safe5'
  alias mysqlstop='sudo /opt/local/bin/mysqladmin5 -u root -p shutdown'
  alias mysqlstatus='sudo /opt/local/bin/mysqladmin5 -u root -p status'

  # Misc
  alias dusort='du -d 1 | sort -nr'
  if [ -f '/usr/libexec/locate.updatedb' ]; then alias updatedb='sudo /usr/libexec/locate.updatedb'; fi
  function macports_update {
      sudo port selfupdate
      sudo port upgrade installed
  }
elif [ "$OS" = "linux" ] ; then
  alias ls='ls --color=always -A'
  alias dusort='du --max-depth=1 | sort -nr'
fi

# Projects autocompletion ------------------------------------------------------
PROJECT_PARENT_DIRS[0]="$HOME/Projects"
for PARENT_DIR in ${PROJECT_PARENT_DIRS[@]} ; do
  if [ -d "$PARENT_DIR" ]; then
    for PROJECT_DIR in $(/bin/ls $PARENT_DIR); do
      if [ ! -z `which $PROJECT_DIR` ]; then
        continue # don't set alias if there is something already a command on the path with the same name
      fi
      if [ -d "$PARENT_DIR/$PROJECT_DIR" ]; then
        alias "$PROJECT_DIR"="cd $PARENT_DIR/$PROJECT_DIR"
      fi
    done
  fi
done

# SSH hosts autocompletion -----------------------------------------------------
SSH_KNOWN_HOSTS=( $(cat ~/.ssh/known_hosts | \
  cut -f 1 -d ' ' | \
  sed -e s/,.*//g | \
  uniq | \
  egrep -v [0123456789]) )
SSH_CONFIG_HOSTS=( $(cat ~/.ssh/config | grep "Host " | grep -v "*" | cut -f 2 -d ' ') )
complete -o default -W "${SSH_KNOWN_HOSTS[*]} ${SSH_CONFIG_HOSTS[*]}" ssh

# Colored man pages ------------------------------------------------------------
export LESS_TERMCAP_mb=$'\e[01;31m'
export LESS_TERMCAP_md=$'\e[01;31m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;44;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[01;32m'

# VCS colored prompt -----------------------------------------------------------
# OLD:
#_bold=$(tput bold)
#_normal=$(tput sgr0)

__prompt_command() {
  local vcs base_dir sub_dir ref last_command
  sub_dir() {
    local sub_dir
    sub_dir=$(stat -f "${PWD}")
    sub_dir=${sub_dir#$1}
    echo ${sub_dir#/}
  }

  # http://github.com/blog/297-dirty-git-state-in-your-prompt
  function parse_git_dirty {
    [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "*"
  }

  function parse_git_branch {
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1$(parse_git_dirty)/"
  }

  git_dir() {
    base_dir=$(git rev-parse --show-cdup 2>/dev/null) || return 1
    if [ -n "$base_dir" ]; then
      base_dir=`cd $base_dir; pwd`
    else
      base_dir=$PWD
    fi
    sub_dir=$(git rev-parse --show-prefix)
    sub_dir="/${sub_dir%/}"
    ref=$(parse_git_branch)
    vcs="git"
    alias pull="git pull"
    alias commit="git commit -v -a"
    alias push="commit ; git push"
    alias revert="git checkout"
  }

  svn_dir() {
    [ -d ".svn" ] || return 1
    base_dir="."
    while [ -d "$base_dir/../.svn" ]; do base_dir="$base_dir/.."; done
    base_dir=`cd $base_dir; pwd`
    sub_dir="/$(sub_dir "${base_dir}")"
    ref=`svnversion`
    vcs="svn"
    alias pull="svn up"
    alias commit="svn commit"
    alias push="svn ci"
    alias revert="svn revert"
  }

  bzr_dir() {
    base_dir=$(bzr root 2>/dev/null) || return 1
    if [ -n "$base_dir" ]; then
      base_dir=`cd $base_dir; pwd`
    else
      base_dir=$PWD
    fi
    sub_dir="/$(sub_dir "${base_dir}")"
    ref=$(bzr revno 2>/dev/null)
    vcs="bzr"
    alias pull="bzr pull"
    alias commit="bzr commit"
    alias push="bzr push"
    alias revert="bzr revert"
  }

  git_dir || svn_dir || bzr_dir

  if [ -n "$vcs" ]; then
    alias st="$vcs status"
    alias d="$vcs diff"
    alias up="pull"
    alias cdb="cd $base_dir"
    base_dir="$(basename "${base_dir}")"
    working_on="$base_dir:"
    __vcs_prefix="($vcs)"
    __vcs_ref="[$ref]"
    __vcs_sub_dir="${sub_dir}"
    __vcs_base_dir="${base_dir/$HOME/~}"
  else
    __vcs_prefix=':'
    __vcs_base_dir="${PWD/$HOME/~}"
    __vcs_ref=''
    __vcs_sub_dir=''
    working_on=""
  fi

  last_command=$(history 1 | sed -e "s/^[ ]*[0-9]*[ ]*//g")
  __tab_title="$working_on[$last_command]"
  __pretty_pwd="${PWD/$HOME/~}"
}

PROMPT_COMMAND=__prompt_command

# OLD:
#PS1='\[\e]2;\h::$__pretty_pwd\a\e]1;$__tab_title\a\]\u:$__vcs_prefix\[${_bold}\]${__vcs_base_dir}\[${_normal}\]${__vcs_ref}\[${_bold}\]${__vcs_sub_dir}\[${_normal}\]\$ '
#PS1="\[${COLOR_GREEN}\]\u\[${COLOR_NC}\]@\[${COLOR_YELLOW}\]\h\[${COLOR_NC}\]:\[${COLOR_BLUE}\]\w\[${COLOR_NC}\]$ \[${COLOR_NC}\]"  # Primary prompt with user, host, and path 

if [ "`id -u`" = "0" ]; then
  export PS1='\[\e[0;31m\]\u\[\e[0m\]@\[\e[1;33m\]\h\[\e[0m\]\[\e[0;35m\]$__vcs_prefix\[\e[0m\]\[\e[0;34m\]${__vcs_base_dir}\[\e[0m\]\[\e[1;33m\]${__vcs_ref}\[\e[0m\]\[\e[0;34m\]${__vcs_sub_dir}\[\e[0m\]\$ '
else
  export PS1='\[\e[0;32m\]\u\[\e[0m\]@\[\e[1;33m\]\h\[\e[0m\]\[\e[0;35m\]$__vcs_prefix\[\e[0m\]\[\e[0;34m\]${__vcs_base_dir}\[\e[0m\]\[\e[1;33m\]${__vcs_ref}\[\e[0m\]\[\e[0;34m\]${__vcs_sub_dir}\[\e[0m\]\$ '
fi

# Misc -------------------------------------------------------------------------
shopt -s checkwinsize # After each command, checks the windows size and changes lines and columns

export EDITOR=vim       # default editor: vim
export PAGER='less -R'  # default pager: less

# bash completion settings (actually, these are readline settings)
bind "set completion-ignore-case on" # note: bind used instead of sticking these in .inputrc
bind "set bell-style none" # no bell
bind "set show-all-if-ambiguous On" # show list automatically, without double tab

# Turn on advanced bash completion if the file exists (get it here: http://www.caliban.org/bash/index.shtml#completion)
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi


#function update_dotfiles {
#    echo "* Updating .dotfiles project"
#    svn update -q $HOME/.dotfiles
#    echo "* Starting installer"
#    $HOME/.dotfiles/install.rb
#    echo "* Sourcing $HOME/.profile"
#    source $HOME/.profile
#    echo "* DONE!"
#}
