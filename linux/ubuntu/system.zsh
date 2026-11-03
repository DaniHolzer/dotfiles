#------------------------------------------------------------------------------
#----- System Health and Updates (Ubuntu)
#
# system_check runs in every new terminal and only prints something when the
# system needs attention. `update` updates everything in one go.

system_check() {
    local issues=()

    # Packages left half-installed (e.g. a failed driver build during an update):
    [ -n "$(dpkg --audit 2>/dev/null)" ] && issues+=("Halb installierte Pakete -> 'update' ausführen ('dpkg --audit' zeigt welche)")

    # A kernel or library update waits for a reboot:
    [ -f /var/run/reboot-required ] && issues+=("Neustart nötig ($(sort -u /var/run/reboot-required.pkgs 2>/dev/null | tr '\n' ' '))")

    # Pending updates, as counted by Ubuntu's update-notifier:
    local pending=$(command grep -oE '^[0-9]+ updates? can be applied' /var/lib/update-notifier/updates-available 2>/dev/null | command grep -oE '^[0-9]+')
    [ "${pending:-0}" -ge 20 ] && issues+=("$pending Updates offen -> 'update' ausführen")

    # Last automatic update run failed:
    local log=/var/log/unattended-upgrades/unattended-upgrades.log
    [ -r "$log" ] && awk '/Starting unattended upgrades script/ {err=0} / ERROR / {err=1} END {exit !err}' "$log" \
        && issues+=("Letztes automatisches Update fehlgeschlagen -> $log")

    [ ${#issues} -eq 0 ] && return 0
    print -P "%F{red}%B⚠ System braucht Aufmerksamkeit:%b%f"
    local issue
    for issue in $issues; do print -P "%F{red}  • $issue%f"; done
}

update() {                                                                   # Update apt, snap, Neovim plugins/tools and the tree-sitter CLI.
    print -P "%F{blue}%B== apt%b%f"
    sudo apt update && sudo apt full-upgrade -y && sudo apt autoremove -y && sudo apt clean || return 1

    print -P "%F{blue}%B== snap%b%f"
    # snap refuses to refresh apps that are open; close them and run `sudo snap refresh` again.
    sudo snap refresh || print -P "%F{yellow}Some snaps were skipped because they are open -> close them, then 'sudo snap refresh'%f"

    print -P "%F{blue}%B== Neovim plugins and Mason tools%b%f"
    nvim --headless "+Lazy! sync" "+Lazy! load mason.nvim" "+MasonToolsUpdateSync" +qa >/dev/null 2>&1 \
        && echo "ok (commit lazy-lock.json in ~/personal/github/nvim when it changed)" \
        || echo "failed, run ':Lazy sync' in Neovim to see why"

    print -P "%F{blue}%B== tree-sitter CLI%b%f"
    cargo install --locked tree-sitter-cli 2>&1 | tail -1

    echo
    system_check || true
    [ -f /var/run/reboot-required ] || print -P "%F{green}Alles aktuell.%f"
}

[[ -o interactive ]] && system_check
