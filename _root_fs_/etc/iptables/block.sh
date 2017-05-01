#!/usr/bin/env bash

# Rules
export EMERGING_FWRULES='http://rules.emergingthreats.net/fwrules/emerging-Block-IPs.txt'
export FLAGGED=FLAGGED
export ETLOGDROP=ETLOGDROP


# Bins
export IPTABLES=$(which iptables)
export WGET=$(which wget)
export SED=$(which sed)
export RM=$(which srm)

# DIRS
export TEMPDIR='/tmp/'
export WALLDIR=$TEMPDIR'emerging-blocklists/'
export RULEDOC=$WALLDIR'emerging_iptables.txt'


## Functionality
# Make directory
function dir_setup(){
	$RM -rf $WALLDIR
	mkdir $WALLDIR
}

# Create chains
function iptables_setup(){
    if ( ! $IPTABLES -L $FLAGGED 2>&1 > /dev/null );then
        $IPTABLES -N $FLAGGED
    fi
    if ( ! $IPTABLES -L $ETLOGDROP 2>&1 > /dev/null );then
        $IPTABLES -N $ETLOGDROP
    fi
    $IPTABLES -F $FLAGGED&&\
        $IPTABLES -F $ETLOGDROP&&\
        $IPTABLES -I FORWARD 1 -j $FLAGGED&&\
        $IPTABLES -I INPUT 1 -j $FLAGGED&&\
        $IPTABLES -I OUTPUT 1 -j $FLAGGED&&\
        $IPTABLES -A $ETLOGDROP -j LOG --log-prefix 'ET BLOCK: '&&\
        $IPTABLES -A $ETLOGDROP -j DROP
}

function iptables_enforce(){
    $WGET -qO $RULEDOC $EMERGING_FWRULES
    $SED -i "/^#/d;/^ *$/d" $RULEDOC
    for RULE in `cat $RULEDOC`;do
        $IPTABLES -A $FLAGGED -p ALL --src $RULE -j $ETLOGDROP
    done
}

# Execute
dir_setup;\
iptables_setup&&\
iptables_enforce

# Have a grand experience.
