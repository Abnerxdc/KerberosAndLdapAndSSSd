ldap_hostname_B=`awk -F = '/ldap_hostname_B/{print $2}' application.properties`
ldap_hostname_A=`awk -F = '/ldap_hostname_A/{print $2}' application.properties`

#echo "SLAPD_URLS=\"ldap://$ldap_hostname_A:389 ldaps://$ldap_hostname_A:389 ldapi:///\"" >> /etc/sysconfig/ldap

#ssh $ldap_hostname_B "echo 'SLAPD_URLS=\"ldap://$ldap_hostname_B:389 ldaps://$ldap_hostname_B:389 ldapi:///\"' >> /etc/sysconfig/ldap"

service slapd restart
ssh $ldap_hostname_B "service slapd restart"
