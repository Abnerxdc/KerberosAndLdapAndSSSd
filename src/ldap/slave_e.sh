ldap_hostname_B=`awk -F = '/ldap_hostname_B/{print $2}' application.properties`
ldap_hostname_A=`awk -F = '/ldap_hostname_A/{print $2}' application.properties`
passwd=`awk -F = '/ldap_root_passwd/{print $2}' application.properties`

sed -i "5s/provider=ldap:.*/provider=ldap:\/\/$ldap_hostname_A/g" ldap/slave_bdb_repl.ldif
sed -i "s/provider=ldap:.*/provider=ldap:\/\/$ldap_hostname_B/g" ldap/slave_bdb_repl.ldif
sed -i "s/credentials=.*/credentials=$passwd/g" ldap/slave_bdb_repl.ldif
ldapadd -x -D "cn=admin,cn=config" -w $passwd -f ldap/slave_bdb_repl.ldif -h $ldap_hostname_A

ssh $ldap_hostname_B "service slapd restart"
service slapd restart
chkconfig slapd on
ssh $ldap_hostname_B "chkconfig slapd on"
