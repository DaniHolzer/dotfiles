#------------------------------------------------------------------------------
#----- Shared SSH-Agent
#
# One agent per login on a fixed socket, so every terminal (and tools like
# Claude Code) share the keys unlocked once with `sshup`.

export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR:-/tmp}/ssh-agent.socket"

# ssh-add exits with 2 when no agent is listening on the socket:
ssh-add -l >/dev/null 2>&1
if [ $? -eq 2 ]; then
    rm -f "$SSH_AUTH_SOCK"
    ssh-agent -a "$SSH_AUTH_SOCK" >/dev/null
fi

# Git keys, unlocked with their passphrases from the GNOME keyring (stored once
# with `sshstore`). The keyring itself is unlocked by the login.
SSH_GIT_KEYS=(personal-github personal-gitlab fitcrew-ssh-key-github fitcrew-ssh-key-gitlab)

ssh_load_keys() {
    command -v secret-tool >/dev/null || return 1
    local key
    for key in $SSH_GIT_KEYS; do
        SSH_ASKPASS="$HOME/dotfiles/ssh/ssh-askpass-keyring.sh" SSH_ASKPASS_REQUIRE=force \
            ssh-add "$HOME/.ssh/$key" </dev/null >/dev/null 2>&1
    done
}

# ssh-add exits with 1 when the agent has no keys yet (first shell after login):
ssh-add -l >/dev/null 2>&1
[ $? -eq 1 ] && ssh_load_keys
