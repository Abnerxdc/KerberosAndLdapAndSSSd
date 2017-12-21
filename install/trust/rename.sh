chmod 777 ./trust/domain.properties
kdc1_host_A=`awk -F = '/kdc1_host_A/{print $2}' ./trust/domain.properties`
kdc1_host_B=`awk -F = '/kdc1_host_B/{print $2}' ./trust/domain.properties`
kdc2_host_A=`awk -F = '/kdc2_host_A/{print $2}' ./trust/domain.properties`
kdc2_host_B=`awk -F = '/kdc2_host_B/{print $2}' ./trust/domain.properties`
kdc3_host_A=`awk -F = '/kdc3_host_A/{print $2}' ./trust/domain.properties`
kdc3_host_B=`awk -F = '/kdc3_host_B/{print $2}' ./trust/domain.properties`
kdc1_domain_B=`awk -F = '/kdc1_domain_B/{print $2}' ./trust/domain.properties`
kdc1_domain_S=`awk -F = '/kdc1_domain_S/{print $2}' ./trust/domain.properties`
kdc2_domain_B=`awk -F = '/kdc2_domain_B/{print $2}' ./trust/domain.properties`
kdc2_domain_S=`awk -F = '/kdc2_domain_S/{print $2}' ./trust/domain.properties`
kdc3_domain_B=`awk -F = '/kdc3_domain_B/{print $2}' ./trust/domain.properties`
kdc3_domain_S=`awk -F = '/kdc3_domain_S/{print $2}' ./trust/domain.properties`
sed -i "15s/.*/ $kdc1_domain_B = {/g" /etc/krb5.conf
sed -i "16s/.*/ kdc = $kdc1_host_A/g" /etc/krb5.conf
sed -i "17s/.*/ admin_server = $kdc1_host_A/g" /etc/krb5.conf
sed -i "18s/.*/ database_module = openldap_ldapconf/g" /etc/krb5.conf
sed -i "19s/.*/ kdc = $kdc1_host_B/g" /etc/krb5.conf
sed -i "20s/.*/ admin_server = $kdc1_host_B/g" /etc/krb5.conf
sed -i "21s/.*/ default_domain = $kdc1_domain_S/g" /etc/krb5.conf
sed -i "22s/.*/ }/g" /etc/krb5.conf

sed -i "25s/.*/ .$kdc1_domain_S = $kdc1_domain_B/g" /etc/krb5.conf
sed -i "26s/.*/ $kdc1_domain_S = $kdc1_domain_B/g" /etc/krb5.conf

sed -i "27i  .$kdc2_domain_S = $kdc2_domain_B" /etc/krb5.conf
sed -i "28i  $kdc2_domain_S = $kdc2_domain_B" /etc/krb5.conf
sed -i "29i  .$kdc3_domain_S = $kdc3_domain_B" /etc/krb5.conf
sed -i "30i  $kdc3_domain_S = $kdc3_domain_B" /etc/krb5.conf

sed -i "23i $kdc2_domain_B = {" /etc/krb5.conf
sed -i "24i kdc = $kdc2_host_A" /etc/krb5.conf
sed -i "25i admin_server = $kdc2_host_A" /etc/krb5.conf
sed -i "26i database_module = openldap_ldapconf" /etc/krb5.conf
sed -i "27i kdc = $kdc2_host_B" /etc/krb5.conf
sed -i "28i admin_server = $kdc2_host_B" /etc/krb5.conf
sed -i "29i default_domain = $kdc2_domain_S" /etc/krb5.conf
sed -i "30i }" /etc/krb5.conf

sed -i "31i $kdc3_domain_B = {" /etc/krb5.conf
sed -i "32i kdc = $kdc3_host_A" /etc/krb5.conf
sed -i "33i admin_server = $kdc3_host_A" /etc/krb5.conf
sed -i "34i database_module = openldap_ldapconf" /etc/krb5.conf
sed -i "35i kdc = $kdc3_host_B" /etc/krb5.conf
sed -i "36i admin_server = $kdc3_host_B" /etc/krb5.conf
sed -i "37i default_domain = $kdc3_domain_S" /etc/krb5.conf
sed -i "38i }" /etc/krb5.conf

ipNames=`cat linux_hosts.txt`
for ipName in $ipNames
do
	echo "#######is clearing krb5.conf : $ipName ########"
	scp /etc/krb5.conf root@$ipName:/etc
done

service krb5kdc restart
# high passwd
kadmin.local -q "addprinc -pw sa123456 krbtgt/$kdc2_domain_B/$kdc1_domain_B"
kadmin.local -q "addprinc -pw sa123456 krbtgt/$kdc3_domain_B/$kdc1_domain_B"
kadmin.local -q "addprinc -pw sa123456 krbtgt/$kdc1_domain_B/$kdc2_domain_B"
kadmin.local -q "addprinc -pw sa123456 krbtgt/$kdc3_domain_B/$kdc2_domain_B"
kadmin.local -q "addprinc -pw sa123456 krbtgt/$kdc1_domain_B/$kdc3_domain_B"
kadmin.local -q "addprinc -pw sa123456 krbtgt/$kdc2_domain_B/$kdc3_domain_B"
