rm -rf /var/lib/ldap/*
rm -rf /etc/openldap/slapd.d
service slapd stop
cp /usr/share/openldap-servers/DB_CONFIG.example /var/lib/ldap/DB_CONFIG
cp /usr/share/openldap-servers/slapd.conf.obsolete /etc/openldap/slapd.conf
cp /etc/openldap/ldap.conf.original /etc/openldap/ldap.conf

