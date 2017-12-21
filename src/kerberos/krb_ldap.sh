#xian zhixing krb.sh
ldap_hostname_A=`awk -F = '/ldap_hostname_A/{print $2}' application.properties`
krb_domain_B=`awk -F = '/krb_domain_B/{print $2}' application.properties`
ldap_domain=`awk -F = '/ldap_domain/{print $2}' application.properties`
ldap_root_passwd=`awk -F = '/ldap_root_passwd/{print $2}' application.properties`
ldap_hostname_B=`awk -F = '/ldap_hostname_B/{print $2}' application.properties`
sed -i "19i database_module = openldap_ldapconf" /etc/krb5.conf
sed -i "s/ldap_servers = ldap:\/\/.*/ldap_servers = ldap:\/\/$ldap_hostname_A,ldap:\/\/$ldap_hostname_B/g" kerberos/ldap_kdc.txt
cat kerberos/ldap_kdc.txt >> /etc/krb5.conf
#kdb5_ldap_util -D cn=Manager,dc=$ldap_domain,dc=com stashsrvpw -f /etc/krb5.ldap cn=kdc-srv,ou=krb5,dc=$ldap_domain,dc=com -w $ldap_root_passwd
#kdb5_ldap_util -D cn=Manager,dc=$ldap_domain,dc=com stashsrvpw -f /etc/krb5.ldap cn=kdc-adm,ou=krb5,dc=$ldap_domain,dc=com -w $ldap_root_passwd
kdb5_ldap_util -D cn=Manager,dc=$ldap_domain,dc=com stashsrvpw -f /etc/krb5.ldap cn=Manager,dc=$ldap_domain,dc=com -w $ldap_root_passwd
kdb5_ldap_util -D cn=Manager,dc=$ldap_domain,dc=com create -r $krb_domain_B -s -w $ldap_root_passwd
