#!/usr/bin/env bash

case $1 in
    install)
        INSTDIR="${HOME}"
        BASHRC="${INSTDIR}/.bashrc"
        echo "Checking for .bashrc in your home directory."
        if [ -e "${BASHRC}" ]; then
            echo "Found .bashrc, moving to a backup file."
            mv "$BASHRC" "${BASHRC}".bak
        fi
        echo "Creating symbolic link to this configs .bashrc file in your home directory."
        eval "$(ln -s "${PWD}/.bashrc" "${INSTDIR}")"
        eval "$(ln -s "${PWD}/mbc.sh" "$HOME/.local/bin/")"
        echo "Activating new bash environment."
        source "${BASHRC}"
    ;;

    remove)
        echo "Removing link to current .bashrc script"
        unlink "${BASHRC}"
        unlink "/usr/bin/${0##*/}"
        if [ -e "${INSTDIR}"/.bashrc.bak ]; then
            echo "Found backup of original .bashrc script."
            echo "Making that the new .bashrc script."
            mv "${INSTDIR}"/.bashrc.bak "${BASHRC}"
            echo "Sourcing backed up .bashrc script."
            source "${BASHRC}"
        fi
        echo "Removed Mike's Bash Config"
    ;;

    *)
        echo "
        ${0##*/} install            Install bash scripts.
        ${0##*/} remove             Remove bash scripts and revert to original system
        "
    ;;

esac