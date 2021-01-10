# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi


# Add custom aliases
alias c='clear'
alias l='ls -hAl --time-style="+%F %T"'
alias lt='ls -hAlt --time-style="+%F %T"'
alias p='pwd'
alias openPorts='sudo lsof -i | grep LISTEN'
alias grepbashhist='cat ~/.bash_history | grep'

# Customize command prompt
# From: https://bneijt.nl/blog/post/add-a-timestamp-to-your-bash-prompt/
# From: https://www.ibm.com/developerworks/linux/library/l-tip-prompt/
export PS1="\[\e[92;1m\][\D{%F %T}] [\u@\H:\w]\[\e[0m\] $ "
# [2021-01-10 16:05:37] [pi@raspberrypi:~] $ 

# Create a symlink from this file in the repo on the Pi to the .profile file in the user's home directory
# ln -s /home/pi/git/pi/bash-profile/.profile ~/.profile

