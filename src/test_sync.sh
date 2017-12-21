# chakan  linaggejiedian shifou tongbu
ldap_hostname_A=`awk -F = '/ldap_hostname_A/{print $2}' application.properties`
ldap_hostname_B=`awk -F = '/ldap_hostname_B/{print $2}' application.properties`
kdc_hostname_B=`awk -F = '/kdc_hostname_B/{print $2}' application.properties`
ldap_domain=`awk -F = '/ldap_domain/{print $2}' application.properties`
echo "###################ldap A ########################"
ldapsearch -H ldap://$ldap_hostname_A:389 -b "dc=$ldap_domain,dc=com" -x -LLL contextCSN
echo "###################ldap B ########################"
ldapsearch -H ldap://$ldap_hostname_B:389 -b "dc=$ldap_domain,dc=com" -x -LLL contextCSN

echo "####################kerberos A #####################"
kadmin.local -q "listprincs"
echo "####################kerberos B #####################"
ssh $kdc_hostname_B "kadmin.local -q 'listprincs'"
