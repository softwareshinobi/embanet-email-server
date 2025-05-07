
##

MAIL_LOC=/tmp/volume/intranet/email/

##

sudo mkdir $MAIL_LOC/{data,state,logs,config} -p

sudo chown "$USER":"$USER" $MAIL_LOC -R

##

docker run --rm -e MAIL_USER=wordpress@shinobinet.online -e MAIL_PASS=embanet -it mailserver/docker-mailserver /bin/sh -c 'echo "$MAIL_USER|$(doveadm pw -s SHA512-CRYPT -u $MAIL_USER -p $MAIL_PASS)"' >> $MAIL_LOC/config/postfix-accounts.cf

docker run --rm -e MAIL_USER=shinobi@shinobinet.online -e MAIL_PASS=embanet -it mailserver/docker-mailserver /bin/sh -c 'echo "$MAIL_USER|$(doveadm pw -s SHA512-CRYPT -u $MAIL_USER -p $MAIL_PASS)"' >> $MAIL_LOC/config/postfix-accounts.cf
