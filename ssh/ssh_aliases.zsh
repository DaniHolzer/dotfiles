#------------------------------------------------------------------------------
#----- SSH Aliases

alias sshe='eval "$(ssh-agent -s)"'                                            # Start SSH-Agent and set its environment variables.
alias sshpgh='eval "$(ssh-agent -s)" && ssh-add ~/.ssh/personal-github'        # Activate personal GitHub SSH.
alias sshpgl='eval "$(ssh-agent -s)" && ssh-add ~/.ssh/personal-gitlab'        # Activate personal GitLab SSH.
alias sshfgl='eval "$(ssh-agent -s)" && ssh-add ~/.ssh/fitcrew-ssh-key-gitlab' # Activate fitcrew GitLab SSH.
alias sshfgh='eval "$(ssh-agent -s)" && ssh-add ~/.ssh/fitcrew-ssh-key-github' # Activate fitcrew GitHub SSH.
