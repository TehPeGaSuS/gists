### Useful shell scripts to automate your certificate deployment with UnrealIRCd servers, ideal for one server only setups

You need to do some minor changes to your listen block, depending on how you plan to deploy the certs.

If you're using the [cerbot_global.sh](https://github.com/TehPeGaSuS/gists/blob/main/UnrealIRCd/certbot_global.sh), your listen block needs to be similar to this:
```
listen {
	ip <ip address>;
	port 6697;
	options {
		tls;
		clientsonly;
	}
	tls-options {
		certificate "/etc/letsencrypt/live/your.subdomain.tld/fullchain.pem";
		key "/etc/letsencrypt/live/your.subdomain.tld/privkey.pem";
	}
}
```

If you're using the [certbot_user.sh](https://github.com/TehPeGaSuS/gists/blob/main/UnrealIRCd/certbot_user.sh) script, your listen block must be something like this:
```
listen {
	ip <ip address>;
	port 6697;
	options {
		tls;
		clientsonly;
	}
	tls-options {
		certificate "tls/fullchain.pem";
		key "tls/privkey.pem";
	}
}
```
