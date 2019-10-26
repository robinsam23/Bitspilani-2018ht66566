#!/bin/bash

filename="foo.txt"

#While loop to read line by line
while read -r line
do
    readLine=$line
    #If the line starts with ST then echo the line
    if [[ $readLine = qwe* ]] ; then
        echo "$readLine"
        read line
        readLine=$line
        if [[ $readLine = ewq* ]] ; then
            echo "$readLine"
        fi
    fi
done < "$filename"
