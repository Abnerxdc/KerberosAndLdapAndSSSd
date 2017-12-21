#ldap  slave moshi


service slapd stop
rm -rf /etc/openldap/slapd.d/*
mkdir /etc/openldap/slapd.d
slaptest -f /etc/openldap/slapd.conf -F /etc/openldap/slapd.d
chown ldap.ldap /etc/openldap/slapd.d
chown ldap.ldap /etc/openldap/slapd.d/* -R
chmod 700 /etc/openldap/slapd.d
service slapd start

