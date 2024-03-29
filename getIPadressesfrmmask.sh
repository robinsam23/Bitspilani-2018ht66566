#!/bin/bash

printsubnet() {
        local OLDIFS="$IFS"
        local SUB=${1/\/*/}
        local MASK=$(( 1 << ( 32 - ${1/*\//} )))

        IFS="."
                set -- $SUB
                IPS=$((0x$(printf "%02x%02x%02x%02x\n" $1 $2 $3 $4)))
        IFS="$OLDIFS"

        for ((N=0; N<MASK; N++))
        {
                VAL=$((IPS|N))

                printf "%d.%d.%d.%d\n"                  \
                        $(( (VAL >> 24) & 255 ))        \
                        $(( (VAL >> 16) & 255 ))        \
                        $(( (VAL >> 8 ) & 255 ))        \
                        $(( (VAL)       & 255 ))
        }
}

printsubnet 172.16.0.0/16