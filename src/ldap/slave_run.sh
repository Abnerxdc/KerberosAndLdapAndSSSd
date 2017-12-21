#
low_passwd=`awk -F = '/ldap_root_passwd/{print $2}' application.properties`
passwd=`slappasswd -s $low_passwd`
ldap_hostname_B=`awk -F = '/ldap_hostname_B/{print $2}' application.properties`
ldap_hostname_A=`awk -F = '/ldap_hostname_A/{print $2}' application.properties`
sed -i "112i rootdn \"cn=admin,cn=config\"" /etc/openldap/slapd.conf 
sed -i "113i rootpw $passwd" /etc/openldap/slapd.conf
sed -i "116s/none/break/g" /etc/openldap/slapd.conf
sed -i "123i \\\tby dn.exact=\"cn=admin,cn=config\" read" /etc/openldap/slapd.conf

ssh $ldap_hostname_B "yum -y install openldap-servers openldap-clients openldap-devel krb*"
ssh $ldap_hostname_B "cp /usr/share/openldap-servers/DB_CONFIG.example /var/lib/ldap/DB_CONFIG"
ssh $ldap_hostname_B "chown -R ldap:ldap /var/lib/ldap"
ssh $ldap_hostname_B "cp /usr/share/doc/krb5-server-ldap-1.10.3/kerberos.schema /etc/openldap/schema/"

chmod 777 ldap/slave_a.sh
./ldap/slave_a.sh

scp /etc/openldap/slapd.conf root@$ldap_hostname_B:/etc/openldap/
scp ldap/base.ldif root@$ldap_hostname_B:/etc/openldap/
ssh $ldap_hostname_B "slapadd -v -l /etc/openldap/base.ldif"
ssh $ldap_hostname_B "chown -R ldap:ldap /var/lib/ldap"
ssh $ldap_hostname_B "bash"<ldap/slave_a.sh


