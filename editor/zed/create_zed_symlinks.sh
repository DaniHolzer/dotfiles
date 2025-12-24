#!/bin/bash

#------------------------------------------------------------------------------
# Create Zed Editor Symlinks
#------------------------------------------------------------------------------
# This script creates symlinks from the dotfiles repository to ~/.config/zed/
#------------------------------------------------------------------------------

DOTFILES_ZED_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_ZED_DIR="$HOME/.config/zed"
CONFIG_ZED_THEMES_DIR="$CONFIG_ZED_DIR/themes"

# Create config directories if they don't exist
mkdir -p "$CONFIG_ZED_DIR"
mkdir -p "$CONFIG_ZED_THEMES_DIR"

# Remove existing config files (not directories like conversations, prompts)
rm -f "$CONFIG_ZED_DIR/settings.json"
rm -f "$CONFIG_ZED_DIR/keymap.json"
rm -f "$CONFIG_ZED_THEMES_DIR/mannydark.json"

# Create symlinks for config files
ln -s "$DOTFILES_ZED_DIR/settings.json" "$CONFIG_ZED_DIR/settings.json"
ln -s "$DOTFILES_ZED_DIR/keymap.json" "$CONFIG_ZED_DIR/keymap.json"

# Create symlinks for themes
ln -s "$DOTFILES_ZED_DIR/themes/mannydark.json" "$CONFIG_ZED_THEMES_DIR/mannydark.json"

echo "Zed symlinks created successfully:"
echo ""
echo "Config files:"
ls -la "$CONFIG_ZED_DIR"/*.json
echo ""
echo "Themes:"
ls -la "$CONFIG_ZED_THEMES_DIR"/*.json
