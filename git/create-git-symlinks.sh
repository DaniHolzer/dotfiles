#!/usr/bin/env sh

# ~/.config/dotfiles/git/create-git-symlinks.sh


DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"


#-----------------------------------------------------------------------------
#  Git Configs
#-----------------------------------------------------------------------------
# Create symlink:
ln -s /path/to/file /path/to/symlink_file
  # Creates a symbolic link named symlink_file in the current directory,
  # pointing to the file /path/to/file

# Open ~/personal/github, ~/personal/githlab, ~/work/github, ~/work/gitlab
# Create symlink to account-config file in dotfiles:
ln -s home/holze/dotfiles/git/account-config/work/github ./.gitconfig
# By creating the symlink to account-config you can have the .gitconfig files
# stored central in dotfiles and not decentral in your github... directoies




# Delete ~/.gitconfig:
rm -rf $HOME/.gitconfig


#-----------------------------------------------------------------------------
#  Git Ignores
#-----------------------------------------------------------------------------

# Delete ~/.gitignore:
rm -rf $HOME/.gitignore

# Create symlink to ~/.config/dotfiles/git/gitignore:
ln -s ~/.config/dotfiles/git/gitignore $HOME/.gitignore

