# edit by abner
# bash 
passwd=`awk -F = '/ldap_root_passwd/{print $2}' application.properties`
ldap_domain=`awk -F = '/ldap_domain/{print $2}' application.properties`
slapadd -v -l ldap/base.ldif
chown -R ldap:ldap /var/lib/ldap
service slapd start
chkconfig slapd on
ldapadd -x -D "cn=Manager,dc=$ldap_domain,dc=com" -w$passwd -f ldap/ugbase.ldif
ldapadd -x -D "cn=Manager,dc=$ldap_domain,dc=com" -w$passwd -f ldap/ldapuser.ldif
ldapadd -x -D "cn=Manager,dc=$ldap_domain,dc=com" -w$passwd -f ldap/kerberos.ldif
