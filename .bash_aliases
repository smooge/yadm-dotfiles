# -*- mode: sh -*-
#
# When I first started system administration in 1990 or so, it was
# seen as a sign of weakness to use interactive mode for certain
# commands. Thankfully I am over that and prefer to make sure I have
# interactive turned on.
# 
alias rm='rm -iv'
alias cp='cp -iv'
alias mv='mv -iv'

# In a reverse of the above, if I have to use ftp I want it not to
# have interactive prompting
alias ftp="ftp -i"

# I much prefer my ls to have time in ISO format to make sorting
# easier. 
alias ls='ls -F --time-style=long-iso'

# This is a holdover from where more may actually be a different
# command which would normally be very limited.
alias more='less'

# various aliases to fix the cursor and screen.
alias sane='stty sane; stty erase "^H" kill "^U" intr "^C"'
alias get_cursor='echo -en "\e[?25h"'

# aliases I use for ssh setup
## set up ssh to not try public key. This is needed for systems which
## shut off logins for too many public keys.
alias ssh_sane='ssh -o PreferredAuthentications=password -o PubkeyAuthentication=no'

## Set up the ssh initial environment
alias sshadd='ssh-add ~/.ssh/id_fedora_rsa ~/.ssh/id_redhat_rsa ~/.ssh/id_rsa ~/.ssh/id_github_rsa'
alias sshinit='ssh-agent -s > ${HOME}/SSH-AGENT; source ${HOME}/SSH-AGENT; sshadd'

# a lot of work I have does ip addresses which I need to sort in ip
# order. 
alias ipsort="sort -t\. -n -k1,1 -k2,2 -k3,3 -k4,4"

# I usually have a clean python script which looks for programs to
# remove in the current directory. Sometimes.. you just want to clean
# everything without prompts
alias clean_it_all="find . -type f -name '*~' -o -name '#*#' -print0 | xargs -0 \rm -v"

# Aliases gotten from other people over the years.
alias whence='type -a'                        # where, of a sort
alias capit="python -c 'import sys; map(lambda x: sys.stdout.write(x.capitalize()), sys.stdin)'"
alias clean_space='for f in *\ *; do mv "$f" "${f// /_}"; done'

# Aliases from when I used CSH and X11.
alias startx='startx >& ~/Logfiles/startx.out'
alias unsetenv=unset

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

