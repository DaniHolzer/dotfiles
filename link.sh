#!/usr/bin/env bash
#
# Creates the symlinks listed in links.txt, so apps find their configs in this
# repo. Safe to run any number of times.
#
#   ./link.sh           create missing links; never touches an existing file
#   ./link.sh --check   only report problems, change nothing
#   ./link.sh --force   also replace what is in the way, after backing it up
#                       to <name>.bak-<timestamp> (typical on a new machine)
#
# Exit code: 0 = everything is fine, 1 = at least one link needs attention.

set -u

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
LIST="$DOTFILES/links.txt"
MODE="link"

case "${1:-}" in
    "")      ;;
    --check) MODE="check" ;;
    --force) MODE="force" ;;
    *)       echo "Usage: $0 [--check | --force]" >&2; exit 2 ;;
esac

if [ ! -r "$LIST" ]; then
    echo "Cannot read $LIST" >&2
    exit 1
fi

ok=0
skipped=0
problems=0

report() { printf '%-8s %s\n' "$1" "$2"; }
problem() { report "$1" "$2"; problems=$((problems + 1)); }

make_link() {
    local source="$1" target="$2" parent
    parent="$(dirname "$target")"
    if [ ! -d "$parent" ]; then
        mkdir -p "$parent" || { problem "FAILED" "$target (cannot create folder)"; return; }
        # ssh expects its folder to be private to the user.
        [ "$parent" = "$HOME/.ssh" ] && chmod 700 "$parent"
    fi
    if ln -s "$source" "$target"; then
        report "LINKED" "$target -> $source"
        ok=$((ok + 1))
    else
        problem "FAILED" "$target"
    fi
}

while read -r source target extra; do
    case "$source" in ""|\#*) continue ;; esac

    if [ -z "$target" ] || [ -n "$extra" ]; then
        problem "INVALID" "links.txt line: $source $target $extra"
        continue
    fi

    optional=false
    case "$source" in \?*) optional=true; source="${source#\?}" ;; esac

    case "$source" in
        "~/"*) source="$HOME/${source#\~/}" ;;
        *)     source="$DOTFILES/$source" ;;
    esac
    target="$HOME/$target"

    # Already correct, whatever kind of entry the source is.
    if [ -L "$target" ] && [ "$(readlink "$target")" = "$source" ] && [ -e "$source" ]; then
        ok=$((ok + 1))
        continue
    fi

    if [ ! -e "$source" ]; then
        if $optional; then
            report "SKIPPED" "$target (not there yet: $source)"
            skipped=$((skipped + 1))
        else
            problem "MISSING" "$source (needed for $target)"
        fi
        continue
    fi

    if $optional && [ ! -d "$(dirname "$target")" ]; then
        report "SKIPPED" "$target (folder not there yet: $(dirname "$target"))"
        skipped=$((skipped + 1))
        continue
    fi

    # -L as well: a broken symlink is "in the way" although -e says it is absent.
    if [ -e "$target" ] || [ -L "$target" ]; then
        if [ -L "$target" ]; then
            what="links to $(readlink "$target")"
        else
            what="is a real file or folder"
        fi

        if [ "$MODE" != "force" ]; then
            problem "CONFLICT" "$target $what (should link to $source)"
            continue
        fi

        backup="$target.bak-$(date +%Y%m%d-%H%M%S)"
        if ! mv "$target" "$backup"; then
            problem "FAILED" "$target (cannot back up)"
            continue
        fi
        report "BACKUP" "$target -> $backup"
    elif [ "$MODE" = "check" ]; then
        problem "NOLINK" "$target (should link to $source)"
        continue
    fi

    make_link "$source" "$target"
done < "$LIST"

echo
echo "$ok ok, $skipped skipped, $problems need attention"

if [ "$problems" -gt 0 ]; then
    [ "$MODE" = "force" ] || echo "Fix them by hand, or run './link.sh --force' to replace them (with a backup)."
    exit 1
fi
