#!/bin/bash

##########
# This is the command line command used to get the protonvpn.conf file.
#
# Feel free to edit it and/or submit corrections.
#
# Tested on Ubuntu 18.04 and higher
#
# You need JQ and CURL: sudo apt install jq curl
##########

##########
# The ban reason to be displayed to ProtonVPN users that didn't identified and have their entry denied
##########
banreason="[x] ProtonVPN can only be used by registered users. Identify via SASL or register your nickname. Info: https://domain.tld/protonvpn [x]"

##########
# If you touch the code below and then complain the script "suddenly stopped working" I'll touch you at night. (THANKS thommey)
##########
echo "/* ProtonVPN Auth Blocks */" > protonvpn.conf &&
curl "https://api.protonmail.ch/vpn/logicals" | jq -r '.LogicalServers[].Servers[].ExitIP' | sed "s/[^.]*$/\?/" | sort --version-sort | uniq | sed "s/^/\nrequire authentication {\n\tmask /; s|$|;\n\treason \"""$banreason\""";\n}|" >> protonvpn.conf
printf "\n/* End of ProtonVPN Auth Blocks */\n" >> protonvpn.conf
