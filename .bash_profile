# .bash_profile
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


# We begin by getting the aliases and functions from user's
# .bashrc. That will test if it is an interactive environment and fall
# out if it isn't. 

# Ok check to see if system bash_profile have been sourced.
if [ -f /etc/profile ]; then
       . /etc/profile
fi

# Get the aliases and functions
if [ -f "${HOME}/.bashrc" ]; then
    source "${HOME}/.bashrc"
fi

# Because these config files may be used on different systems we need
# to set up additional variables depending on OS (or level of setup).

# Determine if we have a local bin directories to use.
# In the old days we would stick our scripts in binaries in ~/bin but
# a lot of systems see that as noisy if your desktop is your home
# directory. This means that they want these scripts to be in
# ~/.local/bin so they aren't distracting. We need to look for both
# and set up the shell PATH appropriately

for pathlet in "${HOME}/bin" "${HOME}/.local/bin"; do
    # Check to see if the path exists
    if [ -d ${pathlet} ]; then
	# Now check to see if the directory is already in the path. Hat
	# tip to
	# https://stackoverflow.com/questions/1396066/detect-if-users-path-has-a-specific-directory-in-it 
	if [[ ":$PATH:" != *":${pathlet}:"* ]]; then
	    PATH=${PATH}:${pathlet}
	fi
    fi
done

# After we have set this, let the child shells and environment get it.
export PATH

## Do the same now for man pages
for pathlet in "${HOME}/man" "${HOME}/.local/man"; do
    # Check to see if the path exists
    if [ -d ${pathlet} ]; then
	# Now check to see if the directory is already in the path. Hat
	# tip to
	# https://stackoverflow.com/questions/1396066/detect-if-users-path-has-a-specific-directory-in-it 
	if [[ ":$MANPATH:" != *":${pathlet}:"* ]]; then
	    MANPATH=${MANPATH}:${pathlet}
	fi
    fi
done

# User specific environment and startup programs
export GPG_TTY=$(tty)

## End of File
