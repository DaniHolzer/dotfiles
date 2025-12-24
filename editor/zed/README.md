# Zed Editor Setup

Configuration files for the Zed editor with vim mode and MannyDark theme.

## Files

- `settings.json` - Main configuration
- `keymap.json` - Vim-style keybindings
- `themes/mannydark.json` - Custom dark theme

## Installation

### macOS / Linux

Run the symlink script:

```bash
./create_zed_symlinks.sh
```

Or manually create symlinks:

```bash
# Config directory
mkdir -p ~/.config/zed/themes

# Symlinks for maxOS
ln -sf /path/to/dotfiles/editors/zed/settings.json ~/.config/zed/settings.json
ln -sf /path/to/dotfiles/editors/zed/keymap.json ~/.config/zed/keymap.json
ln -sf /path/to/dotfiles/editors/zed/themes/mannydark.json ~/.config/zed/themes/mannydark.json

# Symlinks for Linux
ln -sf /relative/path/to/dotfiles/editors/zed/settings.json "$HOME/.config/zed/settings.json"
ln -sf /relative/path/to/dotfiles/editors/zed/keymap.json "$HOME/.config/zed/keymap.json"
ln -sf /relative/path/to/dotfiles/editors/zed/themes/mannydark.json "$HOME/.config/zed/themes/mannydark.json"
```

### Windows

Zed config location: `%APPDATA%\Zed\`
(Usually `C:\Users\<username>\AppData\Roaming\Zed\`)

**Option 1: Copy files (simple)**

```powershell
# Create directories
mkdir "$env:APPDATA\Zed\themes" -Force

# Copy files
copy settings.json "$env:APPDATA\Zed\settings.json"
copy keymap.json "$env:APPDATA\Zed\keymap.json"
copy themes\mannydark.json "$env:APPDATA\Zed\themes\mannydark.json"
```

**Option 2: Symlinks (requires admin)**

Run PowerShell as Administrator:

```powershell
# Create directories
mkdir "$env:APPDATA\Zed\themes" -Force

# Create symlinks (adjust path to your dotfiles location)
$dotfiles = "C:\path\to\dotfiles\editors\zed"

New-Item -ItemType SymbolicLink -Path "$env:APPDATA\Zed\settings.json" -Target "$dotfiles\settings.json" -Force
New-Item -ItemType SymbolicLink -Path "$env:APPDATA\Zed\keymap.json" -Target "$dotfiles\keymap.json" -Force
New-Item -ItemType SymbolicLink -Path "$env:APPDATA\Zed\themes\mannydark.json" -Target "$dotfiles\themes\mannydark.json" -Force
```

Or with CMD (as Administrator):

```cmd
mklink "%APPDATA%\Zed\settings.json" "C:\path\to\dotfiles\editors\zed\settings.json"
mklink "%APPDATA%\Zed\keymap.json" "C:\path\to\dotfiles\editors\zed\keymap.json"
mklink "%APPDATA%\Zed\themes\mannydark.json" "C:\path\to\dotfiles\editors\zed\themes\mannydark.json"
```

## Key Bindings

Leader key is `Space`.

| Binding | Action |
|---------|--------|
| `Space f f` | Find files |
| `Space f t` | Search in files |
| `Space f r` | Recent projects |
| `Space f b` | Buffer/tab switcher |
| `Space /` | Toggle comments |
| `Space \|` | Split right |
| `Space -` | Split down |
| `H` | Go to left split |
| `L` | Go to right split |
| `Space m` | Toggle zoom |
| `Space e t` | Focus file tree |
| `Space t t` | Toggle left dock |
| `Space c a` | Code actions |
| `Space r n` | Rename symbol |
| `Space d` | Hover documentation |
| `Space m p` | Format |
| `Space g h` | Toggle git hunks |
| `Space n t` | New file |
| `Space q t` | Close tab |
| `Space r s` | Restart LSP |
| `Shift-U` | Redo |
| `Ctrl-Space` | Show completions (insert mode) |
| `Ctrl-\`` | Toggle terminal |

### Project Panel

| Binding | Action |
|---------|--------|
| `Enter` | Open file and focus editor |
| `o` | Open file permanently |
| `\|` | Open in vertical split |
| `a` | New file |
| `A` | New directory |
| `r` | Rename |
| `d` | Delete |
| `x` | Cut |
| `c` | Copy |
| `p` | Paste |
| `y` | Copy path |
| `Y` | Copy relative path |

### Menu Navigation

| Binding | Action |
|---------|--------|
| `Ctrl-j` | Select next |
| `Ctrl-k` | Select previous |
