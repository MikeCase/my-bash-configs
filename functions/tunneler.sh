#!/usr/bin/env bash

make_tunnel() {
    ## Create an SSH tunnel.

    read -p "Local tunnel port [2500]: " lport
    if [ -z $lport ]; then
        lport='2500'
    fi

    read -p "Remote service port [80]: " rport
    if [ -z $rport ]; then
        rport='80'
    fi

    read -p "Remote service local IP address [127.0.0.1]: " r_ip
    if [ -z $r_ip ]; then
        r_ip='127.0.0.1'
    fi


    read -p "SSH Connection [user@host]: " constring
    if [ -z $constring ]; then
        echo 'You must provide a connection string (user@host)'
        exit 1
    fi

    echo "To access your tunneled service goto https://127.0.0.1:$lport"

    ssh -L "$lport:$r_ip:$rport" "$constring"
}