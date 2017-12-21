ldap_domain=`awk -F = '/ldap_domain/{print $2}' application.properties`
if [ $ldap_domain = "hadoop" ];then
	echo "#########hadoop###########"
else 
sed -i "s/hadoop/$ldap_domain/g" ldap/base.ldif
sed -i "s/hadoop/$ldap_domain/g" ldap/kerberos.ldif
sed -i "s/hadoop/$ldap_domain/g" ldap/ugbase.ldif
sed -i "s/hadoop/$ldap_domain/g" ldap/ldapuser.ldif
fi
