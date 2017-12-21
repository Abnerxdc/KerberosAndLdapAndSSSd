
kinit -kt /etc/hadoopkeytab/hive.keytab hive/admin

hive_hostname=`awk -F = '/hive_hostname/{print $2}' application.properties`
krb_domain_B=`awk -F = '/krb_domain_B/{print $2}' application.properties`

beeline -u "jdbc:hive2://$hive_hostname:10000/default;principal=hive/$hive_hostname@$krb_domain_B" < ./permission/hive_permission.sh
