#!/bin/bash

if [ "$1" == "generate" ]
then
    if [ -f /var/lib/tor/private_key ]
    then
        echo '[-] You already have an private key, delete it if you want to generate a new key'
        exit -1
    fi
    if [ -z "$2" ]
    then
        echo '[-] You dont provided any mask, please inform an mask to generate your address'
        exit -1
    else
        echo '[+] Generating the address with mask: '$2
        shallot -f /tmp/key $2
        echo '[+] '$(grep Found /tmp/key)
        grep 'BEGIN RSA' -A 99 /tmp/key > /var/lib/tor/private_key
    fi
fi

if [ "$1" == "serve" ]
then
    if [ ! -f /var/lib/tor/private_key ]
    then
        echo '[-] Please run this container with generate argument to initialize your address'
        exit -1
    fi
    echo '[+] Initializing local clock'
    ntpdate -B -q 0.debian.pool.ntp.org
    echo '[+] Starting tor'
    tor -f /etc/tor/torrc &
    echo '[+] Starting inspircd'
    service inspircd start &
    # Monitor logs
    sleep infinity
fi