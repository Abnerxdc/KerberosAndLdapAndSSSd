yum -y install openldap-servers openldap-clients openldap-devel krb*
echo "openldap & kerberos has installed "
cp /usr/share/openldap-servers/slapd.conf.obsolete /etc/openldap/slapd.conf
cp /usr/share/openldap-servers/DB_CONFIG.example /var/lib/ldap/DB_CONFIG
chown -R ldap:ldap /var/lib/ldap
mv /etc/openldap/slapd.d /etc/openldap/slapd.d.original
cp /etc/openldap/ldap.conf /etc/openldap/ldap.conf.original
cp /usr/share/doc/krb5-server-ldap-1.10.3/kerberos.schema /etc/openldap/schema/
cp /etc/krb5.conf /etc/krb5.conf.original

