#!/usr/bin/env bash

#		NOTE:
#		This script was made to work with certbot. I don't guarantee it will
#		work with other ACME clients.
#
#		This was tested in Ubuntu 20.04 and higher. This should work as it is on
#		any Debian/Ubuntu based distros. For other distros please check Certbot
#		documentation.
#
#
#		USAGE:
#		Create a folder named `scripts` inside `/etc/letsencrypt` with:
#			mkdir -p /etc/letsencrypt/scripts
#
#		Place this script inside `/etc/letsencrypt/scripts` and name it `deploy_irc.sh`
#
#		Make the script executable with:
#			chmod +x /etc/letsencrypt/scripts/deploy_irc.sh
#
#		Request the certificate with one of the following commands:
#		- Normal:
#			certbot -d irc.domain.tld --deploy-hook /etc/letsencrypt/scripts/deploy_irc.sh
#
#		- SAN certificate:
#			certbot -d irc.domain.tld -d servername.domain.tld --deploy-hook /etc/letsencrypt/scripts/deploy_irc.sh
#
#
#		ATTENTION:
#		The SAN certificate and private key will be saved on /etc/letsencrypt/live/irc.domain.tld and not /etc/letsencrypt/live/servername.domain.tld
#
#
#		Edit the domain/subdomain, user and paths to fit your installation
#		Enjoy!

# What's your IRC domain/subdomain?
ircDomain=irc.domain.tld

# What is the shell user running UnrealIRCd?
ircUser=ircd

# What is the shell group of the user running UnrealIRCd?
# Usually it's the same as the user specified above.
ircGroup=ircd

# Complete path to UnrealIRCd install directory
# Usually "/home/<user>/unrealircd" when installed normally
ircDir=/home/ircd/unrealircd

# Complete path to the UnrealIRCd tls folder
# Usually `/home/<user>/unrealircd/conf/tls' when installed normally
ircTLS=/home/ircd/unrealircd/conf/tls

# Don't edit anything below unless you know exactly what you're doing.
# If you touch the code below and then complain the script "suddenly stopped working" I'll touch you at night.

case $RENEWED_LINEAGE in
	*/"$ircDomain")
        cp -f -- "$RENEWED_LINEAGE"/fullchain.pem "$RENEWED_LINEAGE"/privkey.pem "$ircTLS" &&
        chown -- "$ircUser":"$ircGroup" "$ircTLS"/fullchain.pem "$ircTLS"/privkey.pem &&
        "$ircDir"/unrealircd reloadtls
esac
