#!/bin/bash

# This script will run a dig command against your grid members
# so you can easily compare results between them.  You can specify
# dig options for forward and reverse lookups as well as IPv4 and
# IPv6 lookups.  Actually, you can use this to compare between any
# DNS servers, not just Infoblox appliances.  Added the time function
# in order to get the actual response time to the client.

# Define your Infoblox grid members here
# Data format is GRID_MEMBER_DISPLAY_NAME and IP_ADDRESS separated with a colon
# Each data pair is separated with a space
INTERFACE="ATL:10.11.12.21 BOS:10.11.12.18 DAL:10.11.12.7 DEN:10.11.12.114 SED:10.11.12.39 PORT:10.11.12.72 "


# Define regular expressions to validate IPv4 and IPv6 address format
IPv4_REGEX='^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$'
IPv6_REGEX='^([0-9a-fA-F]{0,4}:){1,7}[0-9a-fA-F]{0,4}$'

echo
echo
echo
echo
echo

echo -n "Enter the name or IP address of the host to query:  "
read QUERY

# Assume QUERY string is not an IP address until verified as such
# Old options were too brief
# OPTIONS="+noall +comments +question +answer +tries=1"
# Set forward query options here
OPTIONS="+tries=1"

# See if QUERY string is IPv4
# Set query options here
if [[ $QUERY =~ $IPv4_REGEX ]]; then
   # QUERY is a valid IPv4 address
   # Use the -x option in the dig command
   OPTIONS="+tries=1 -x"
fi

# See if QUERY string is IPv6
# Set query options here
if [[ $QUERY =~ $IPv6_REGEX ]]; then
   # QUERY is a valid IPv6 address
   # Use the -x option in the dig command
   OPTIONS="+tries=1 -x"
fi

echo
echo
echo
echo
echo

# Loop through all the grid members and run the dig command
for DATA in $INTERFACE; do
   NAME=`echo $DATA | cut -d":" -f1`
   IP=`echo $DATA | cut -d":" -f2`
   echo "*****************************************"
   echo "* RESULTS FOR INFOBLOX APPLIANCE AT $NAME"
   echo "*****************************************"
   echo "Response time:"
   echo -n "----------------"
   RESULT=`time dig $OPTIONS $QUERY @$IP`
   echo
   echo "$RESULT"
   echo
   echo
   echo
   echo
   echo
done

exit