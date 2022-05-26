# aliases for venv (python-venv)
alias create-venv='python3 -m venv /home/${USER}/.config/venv/${PWD##*/}'
alias remove-venv='rm -rf /home/${USER}/.config/venv/${PWD##*/}'
alias activate-venv='source /home/${USER}/.config/venv/${PWD##*/}/bin/activate'