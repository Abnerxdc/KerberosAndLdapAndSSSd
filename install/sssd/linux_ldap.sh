ldapserver1=host-11-1
ldapserver2=host-11-2
domain=hadoop
yum -y install mlocate sssd authconfig oddjob-mkhomedir nss-pam-ldapd
authconfig --enablesssd --enablesssdauth --enablelocauthorize --enableldap --enableldapauth --ldapserver=ldap://$ldapserver1:389,ldap://$ldapserver2:389 --ldapbasedn=dc=$domain,dc=com --disableldaptls --enablerfc2307bis --enablemkhomedir --enablecachecreds --update

service sssd stop
service oddjobd stop
service messagebus stop
service nslcd stop

sed -i "15i ldap_tls_reqcert = never" /etc/sssd/sssd.conf
sed -i "s/pam_sss.so/pam_ldap.so/g" /etc/pam.d/password-auth
sed -i "s/pam_sss.so/pam_ldap.so/g" /etc/pam.d/system-auth

service messagebus start
service oddjobd start
service nslcd start
service sssd start

chkconfig messagebus on
chkconfig oddjobd on
chkconfig nslcd on
chkconfig sssd on

