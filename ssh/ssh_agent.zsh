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
