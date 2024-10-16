#!/usr/bin/env sh

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"


#-----------------------------------------------------------------------------
#  Tmate Configs
#-----------------------------------------------------------------------------
# Run those 2 commands in a terminal.

# Delete ~/.tmate.conf:
rm -rf $HOME/.tmate.conf

# Create symlink to ~/.tmux.conf:
rm -rf $HOME/.tmate.conf

