
# aliases for venv (python-venv)
alias create-venv='python3 -m venv /home/${USER}/.config/venv/${PWD##*/}'
alias remove-venv='rm -rf /home/${USER}/.config/venv/${PWD##*/}'
alias activate-venv='source /home/${USER}/.config/venv/${PWD##*/}/bin/activate'
alias cv310='python3.10 -m venv /home/$USER/.config/venv/${PWD##*/}'
alias cv311='python3.11 -m venv /home/$USER/.config/venv/${PWD##*/}'

# Get public IP
alias ipinfo="/usr/bin/whatsmyip"

# Better tail experience.
alias ltail="less +F"
