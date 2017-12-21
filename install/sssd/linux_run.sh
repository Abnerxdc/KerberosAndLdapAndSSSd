ldapserver1=`awk -F = '/ldap_hostname_A/{print $2}' application.properties`
ldapserver2=`awk -F = '/ldap_hostname_B/{print $2}' application.properties`
domain=`awk -F = '/ldap_domain/{print $2}' application.properties`
sed -i "s/ldapserver1=.*/ldapserver1=$ldapserver1/g" sssd/linux_ldap.sh
sed -i "s/ldapserver2=.*/ldapserver2=$ldapserver2/g" sssd/linux_ldap.sh
sed -i "s/domain=.*/domain=$domain/g" sssd/linux_ldap.sh
chmod 777 sssd/ldap_l.sh
./sssd/ldap_l.sh
