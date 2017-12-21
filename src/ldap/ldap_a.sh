# edit by abner
# bash 
low_passwd=`awk -F = '/ldap_root_passwd/{print $2}' application.properties`
passwd=`slappasswd -s $low_passwd`
domain=`awk -F = '/ldap_domain/{print $2}' application.properties`
echo "new passwd is : $passwd"
sed -i "18i include \t/etc/openldap/schema/kerberos.schema" /etc/openldap/slapd.conf 
sed -i "92i access to dn.base="" by * read" /etc/openldap/slapd.conf 
sed -i "93i access to dn.base=\"cn=Subschema\" by * read" /etc/openldap/slapd.conf 
sed -i "94i access to * attrs=userPassword" /etc/openldap/slapd.conf 
sed -i "95i \\\tby self write" /etc/openldap/slapd.conf 
sed -i "96i \\\tby * auth" /etc/openldap/slapd.conf 
sed -i "97i access to *" /etc/openldap/slapd.conf 
sed -i "98i \\\tby * read" /etc/openldap/slapd.conf 
echo "kerberos tree"
sed -i "99i access to dn.subtree=\"ou=krb5,dc=$domain,dc=com\"" /etc/openldap/slapd.conf 
sed -i "100i \\\tby dn=\"cn=Manager,dc=$domain,dc=com\" write" /etc/openldap/slapd.conf 
sed -i "101i \\\tby dn=\"cn=kdc-srv,ou=krb5,dc=$domain,dc=com\" read" /etc/openldap/slapd.conf 
sed -i "102i \\\tby dn=\"cn=kdc-adm,ou=krb5,dc=$domain,dc=com\" write" /etc/openldap/slapd.conf 
sed -i "103i \\\tby * none" /etc/openldap/slapd.conf 
sed -i "s/my-domain/$domain/g" /etc/openldap/slapd.conf
sed -i "136i rootpw\t$passwd" /etc/openldap/slapd.conf
sed -i "149i index krbprincipalName \teq,pres,sub" /etc/openldap/slapd.conf



