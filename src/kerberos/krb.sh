# edit by xdc
kdc_A=`awk -F = '/kdc_hostname_A/{print $2}' application.properties`
kdc_B=`awk -F = '/kdc_hostname_B/{print $2}' application.properties`
domainB=`awk -F = '/krb_domain_B/{print $2}' application.properties`
domainS=`awk -F = '/krb_domain_S/{print $2}' application.properties`
echo "========kdc===$kdc_A================"
yum -y install krb5*
cp /etc/krb5.conf /etc/krb5.conf.bak
sed -i "s/EXAMPLE.COM/$domainB/g" /etc/krb5.conf
sed -i "s/example.com/$domainS/g" /etc/krb5.conf
sed -i "16s/kdc =.*/kdc = $kdc_A/g" /etc/krb5.conf
sed -i "17s/admin_server =.*/admin_server = $kdc_A/g" /etc/krb5.conf
sed -i "18i kdc = $kdc_B" /etc/krb5.conf
sed -i "19i admin_server = $kdc_B" /etc/krb5.conf
#如果需要，请加入default值，这里加入，不需要请删除
#default_domain = hadoop.com
sed -i "20i default_domain = $domainS " /etc/krb5.conf

sed -i "s/EXAMPLE.COM/$domainB/g" /var/kerberos/krb5kdc/kadm5.acl
sed -i "s/EXAMPLE.COM/$domainB/g" /var/kerberos/krb5kdc/kdc.conf
sed -i "12i max_renewable_life = 7d" /var/kerberos/krb5kdc/kdc.conf


