#------------------------------------------------------------------------------
#----- SSH Aliases
#
# Keys are added to the shared agent from ssh_agent.zsh, so they work in every
# terminal until logout.

alias sshup='ssh-add ~/.ssh/personal-github ~/.ssh/personal-gitlab ~/.ssh/fitcrew-ssh-key-github ~/.ssh/fitcrew-ssh-key-gitlab' # Unlock all Git SSH keys.
alias sshls='ssh-add -l'                                     # List unlocked keys.
alias sshdown='ssh-add -D'                                   # Lock (remove) all keys from the agent.
alias sshpgh='ssh-add ~/.ssh/personal-github'                # Activate personal GitHub SSH.
alias sshpgl='ssh-add ~/.ssh/personal-gitlab'                # Activate personal GitLab SSH.
alias sshfgl='ssh-add ~/.ssh/fitcrew-ssh-key-gitlab'         # Activate fitcrew GitLab SSH.
alias sshfgh='ssh-add ~/.ssh/fitcrew-ssh-key-github'         # Activate fitcrew GitHub SSH.
