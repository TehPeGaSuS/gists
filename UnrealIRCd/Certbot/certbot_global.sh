#!/usr/bin/env bash

#		NOTE:
#		Script to be used with Certbot and the `Setting up certbot for use with UnrealIRCd' guide
#		located at https://www.unrealircd.org/docs/Setting_up_certbot_for_use_with_UnrealIRCd
#
#		I can't guarantee that this script will work with other ACME clients
#
#		This script was tested on Ubuntu 20.04 and higher. This should work as it is on
#		any Debian/Ubuntu based distros.
#		For other distros, please check the distro/certbot documentation
#
#
#		USAGE:
#		Create a folder named `scripts` inside `/etc/letsencrypt` with:
#			mkdir -p /etc/letsencrypt/scripts
#
#		Place this script inside `/etc/letsencrypt/scripts` and name it `reload_cert.sh`
#
#		Make the script executable with:
#			chmod +x /etc/letsencrypt/scripts/reload_cert.sh
#
#		Request the certificate with one of the following commands:
#		- Normal:
#			certbot -d irc.domain.tld --deploy-hook /etc/letsencrypt/scripts/reload_cert.sh
#
#		- SAN certificate:
#			certbot -d irc.domain.tld -d servername.domain.tld --deploy-hook /etc/letsencrypt/scripts/reload_cert.sh
#
#
#		ATTENTION:
#		The SAN certificate and private key will be saved on /etc/letsencrypt/live/irc.domain.tldd and not /etc/letsencrypt/live/servername.domain.tld
#
#
#		Edit the domain and paths to fit your installation
#		Enjoy!

# What's your IRC domain/subdomain?
ircDomain=irc.domain.tld

# Complete path to the UnrealIRCd install directory
# Usually "/home/<user>/unrealircd" when installed normally
ircDir=/home/ircd/unrealircd
		
# Don't edit anything below unless you know exactly what you're doing.
# If you touch the code below and then complain the script "suddenly stopped working" I'll touch you at night.

case $RENEWED_LINEAGE in
	*/"$ircDomain")
	"$ircDir"/unrealircd reloadtls
esac
