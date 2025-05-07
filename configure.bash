#!/bin/bash

##

reset

clear

##

set -e

set -x

##

MAIL_LOC=/volumes/intranet/email

##

sudo mkdir $MAIL_LOC/{data,state,logs,config} -p

sudo chown "$USER":"$USER" $MAIL_LOC -R

##

docker run --rm -e MAIL_USER=shinobi@embanet.online -e MAIL_PASS=embanet -it mailserver/docker-mailserver /bin/sh -c 'echo "$MAIL_USER|$(doveadm pw -s SHA512-CRYPT -u $MAIL_USER -p $MAIL_PASS)"' >> $MAIL_LOC/config/postfix-accounts.cf

docker run --rm -e MAIL_USER=services@embanet.online -e MAIL_PASS=embanet -it mailserver/docker-mailserver /bin/sh -c 'echo "$MAIL_USER|$(doveadm pw -s SHA512-CRYPT -u $MAIL_USER -p $MAIL_PASS)"' >> $MAIL_LOC/config/postfix-accounts.cf
