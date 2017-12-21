passwd=`awk -F = '/ldap_root_passwd/{print $2}' application.properties`
ldap_hostname_B=`awk -F = '/ldap_hostname_B/{print $2}' application.properties`
ldap_hostname_A=`awk -F = '/ldap_hostname_A/{print $2}' application.properties`

ldapadd -x -D "cn=admin,cn=config" -w $passwd -f ldap/slave_sync.ldif -h $ldap_hostname_A
ldapadd -x -D "cn=admin,cn=config" -w $passwd -f ldap/slave_sync.ldif -h $ldap_hostname_B
