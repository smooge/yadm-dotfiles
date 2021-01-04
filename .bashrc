# .bashrc
# This code is based off the base-files bashrc from Debian/Cygwin and
# some other systems. As such the following license is taken verbatum
# for this file.

# To the extent possible under law, the author(s) have dedicated all
# copyright and related and neighboring rights to this software to the
# public domain worldwide. This software is distributed without any warranty.

# Because I don't like to assume people can find links I am changing
# where the license is going to be listed. It is included in the
# my-yadm-dotfiles/Documentation/Licenses directory as a copy of the 
# <http://creativecommons.org/publicdomain/zero/1.0/> from 2021-01-04.

# General rules of these config files is to be explicite versus
# implicit. We will use 'source' versus '.' and we will use variables
# versus like ${HOME} versus ~. The main goal is to be clearer for
# someone else to see what I am trying to do (or have stolen from
# others to be have done.)

# Ok check to see if system bashes have been sourced.


# User dependent .bashrc file

# Check to see if we are running interactively, and if not return to
# the calling .bash_profile without setting anything up.
[[ "$-" != *i* ]] && return

# Now we set up the history data for the user. This is done by
# setting some shell options and environment variables.

# Make sure that we append to the .bash_history file versus
# over-write. man bash for the shopt command
shopt -s histappend

# Now set up environment variables.
# Make the history size larger than normal but manageble
export HISTSIZE=4096
# Ignore duplicates and lines starting with space in the history. The
# [:space:] starting is a hack to try and avoid putting in lines in
# the history you wish to avoid.
export HISTCONTROL=ignoreboth

# Ignore some controlling instructions
# HISTIGNORE is a colon-delimited list of patterns which should be excluded.
# The '&' is a special pattern which suppresses duplicate entries.
# export HISTIGNORE=$'[ \t]*:&:[fb]g:exit'
# export HISTIGNORE=$'[ \t]*:&:[fb]g:exit:ls' # Ignore the ls command as well

# Whenever displaying the prompt, write the previous line to disk
# export PROMPT_COMMAND="history -a"

# Taken from the Ubuntu bashrc.
# Check the window size after each command so that if you resize a
# screen, the LINES and COLUMNS which curses apps use will be correct
# (versus having to do this by hand via resize).
shopt -s checkwinsize

# Uncomment the following line if you don't like systemctl's auto-paging feature:
export SYSTEMD_PAGER=

# User specific aliases and functions
export LC_COLLATE=C
export LC_LANG="en_GB.utf8"
export EDIT='/usr/bin/emacs'
export EDITOR='/usr/bin/emacs'
export VISUAL='/usr/bin/emacs'
export LESS='eFRX'

export CVS_RSH=/usr/bin/ssh
export RSYNC_RSH=/usr/bin/ssh
export PYTHONSTARTUP=~/.pythonrc

# Umask
#
# /etc/profile sets 022, removing write perms to group + others.
# Set a more restrictive umask: i.e. no exec perms for others:
# umask 027
# Paranoid: neither group nor others have any perms:
umask 077

# Aliases
#
# Use a different file for aliases
if [ -f "${HOME}/.bash_aliases" ]; then
   source "${HOME}/.bash_aliases"
fi

# Functions
#
# Some people use a different file for functions
if [ -f "${HOME}/.bash_functions" ]; then
  source "${HOME}/.bash_functions"
fi

## If git prompt is available set it up.
if [ -f /usr/share/git-core/contrib/completion/git-prompt.sh ]; then
   source /usr/share/git-core/contrib/completion/git-prompt.sh
   export PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '
fi

# Check to see if you have an ssh-agent running on the system.
# ToDo: have a way to turn this off on boxes where you don't have
# .ssh/<keys> 
if [ -f ${HOME}/SSH-AGENT ]; then
  source ${HOME}/SSH-AGENT >> /dev/null
  working=`ps $SSH_AGENT_PID`
  if [ "$?" != 0 ]; then
    if [ ${TERM} != "dumb" ]; then
      echo "No ssh-agent running"
      echo "ssh-agent -s > SSH-AGENT; source SSH-AGENT; sshadd"
    fi
  fi
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



###
### EOF
###
