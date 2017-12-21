passwd=`awk -F = '/ldap_root_passwd/{print $2}' application.properties`
ldap_hostname_B=`awk -F = '/ldap_hostname_B/{print $2}' application.properties`
ldap_hostname_A=`awk -F = '/ldap_hostname_A/{print $2}' application.properties`

sed -i "4s/ldap:.*/ldap:\/\/$ldap_hostname_A/g" ldap/slave_config_repl.ldif
sed -i "5s/ldap:.*/ldap:\/\/$ldap_hostname_B/g" ldap/slave_config_repl.ldif

sed -i "21s/provider=ldap:.*/provider=ldap:\/\/$ldap_hostname_A/g" ldap/slave_config_repl.ldif
sed -i "30s/provider=ldap:.*/provider=ldap:\/\/$ldap_hostname_B/g" ldap/slave_config_repl.ldif
sed -i "s/credentials=.*/credentials=$passwd/g" ldap/slave_config_repl.ldif

ldapadd -x -D "cn=admin,cn=config" -w $passwd -f ldap/slave_config_repl.ldif -h $ldap_hostname_A
ldapadd -x -D "cn=admin,cn=config" -w $passwd -f ldap/slave_config_repl.ldif -h $ldap_hostname_B

