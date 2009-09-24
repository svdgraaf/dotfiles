# Determine OS -----------------------------------------------------------------
if [ -f ~/.dotfiles_lib/bash/detect_os.sh ]; then
  . ~/.dotfiles_lib/bash/detect_os.sh
fi

# Paths ------------------------------------------------------------------------
export PATH=$PATH:~/.dotfiles_lib/bin

# MacPorts
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
export MANPATH=/opt/local/share/man:$MANPATH

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

