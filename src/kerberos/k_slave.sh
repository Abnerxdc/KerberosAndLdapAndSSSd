kdc_hostname_A=`awk -F = '/kdc_hostname_A/{print $2}' application.properties`
kdc_hostname_B=`awk -F = '/kdc_hostname_B/{print $2}' application.properties`
krb_domain_B=`awk -F = '/krb_domain_B/{print $2}' application.properties`

ssh $kdc_hostname_B 'yum -y install krb*'
scp /var/kerberos/krb5kdc/.k5.$krb_domain_B root@$kdc_hostname_B:/var/kerberos/krb5kdc/
scp /etc/krb5.ldap root@$kdc_hostname_B:/etc/
scp /var/kerberos/krb5kdc/kadm5.acl root@$kdc_hostname_B:/var/kerberos/krb5kdc/
scp /var/kerberos/krb5kdc/kdc.conf root@$kdc_hostname_B:/var/kerberos/krb5kdc/

kadmin.local -q "addprinc -randkey host/$kdc_hostname_A"
kadmin.local -q "xst host/$kdc_hostname_A"

kadmin.local -q "addprinc -randkey host/$kdc_hostname_B"
kadmin.local -q "xst host/$kdc_hostname_B"

kadmin.local -q "addprinc -pw 12345 cloudera-scm/admin"

ssh $kdc_hostname_B "service krb5kdc restart"
ssh $kdc_hostname_B "chkconfig krb5kdc on"
ssh $kdc_hostname_B "service kadmin restart"
ssh $kdc_hostname_B "chkconfig kadmin on"

#touch /var/kerberos/krb5kdc/kpropd.acl
#echo "host/$kdc_hostname_A@$krb_domain_B">> /var/kerberos/krb5kdc/kpropd.acl
#sed -i "1i host/$kdc_hostname_B@$krb_domain_B" /var/kerberos/krb5kdc/kpropd.acl
#scp /var/kerberos/krb5kdc/kpropd.acl root@$kdc_hostname_B:/var/kerberos/krb5kdc/
#rm -f /var/kerberos/krb5kdc/kpropd.acl

