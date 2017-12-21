#anzhuang
chmod 777 application.properties
echo "############install ldap###############"
#chmod 777 ./ldap/ldapinstall.sh
#./ldap/ldapinstall.sh
#peizhi
echo "##############peizhi###################"
#chmod 777 ./ldap/ldap_a.sh
#./ldap/ldap_a.sh
#create user
echo "#############create user###############"
#chmod 777 ./ldap/ldap_b.sh
#./ldap/ldap_b.sh
echo "#############jicheng linux#############"
#chmod 777 ./sssd/linux_run.sh
#./sssd/linux_run.sh
echo "###############kerberos#################"
#chmod 777 ./kerberos/krb.sh
#./kerberos/krb.sh

#chmod 777 ./kerberos/krb_ldap.sh
#./kerberos/krb_ldap.sh

#chmod 777 ./kerberos/k_others.sh
#./kerberos/k_others.sh

#chmod 777 ./kerberos/k_run.sh
#./kerberos/k_run.sh

#chmod 777 ./kerberos/k_slave.sh
#./kerberos/k_slave.sh

echo "#############ldap slave################"
#chmod 777 ./ldap/slave_run.sh
#./ldap/slave_run.sh

#chmod 777 ./ldap/slave_b.sh
#./ldap/slave_b.sh
#chmod 777 ./ldap/slave_c.sh
#./ldap/slave_c.sh
#chmod 777 ./ldap/slave_e.sh
#./ldap/slave_e.sh


echo "################create user###############"
chmod 777 ./permission/insert.sh
./permission/insert.sh

