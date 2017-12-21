
krb_domain_B=`awk -F = '/krb_domain_B/{print $2}' application.properties`

kadmin.local -q "addprinc -randkey hbase/admin@$krb_domain_B"
kadmin.local -q "addprinc -randkey hive/admin@$krb_domain_B"
kadmin.local -q "addprinc -randkey impala/admin@$krb_domain_B"
kadmin.local -q "addprinc -randkey hdfs/admin@$krb_domain_B"
kadmin.local -q "addprinc -randkey kafka/admin@$krb_domain_B"
mkdir /etc/hadoopkeytab
kadmin.local "ktadd -k /etc/hadoopkeytab/hbase.keytab hbase/admin"
kadmin.local "ktadd -k /etc/hadoopkeytab/hive.keytab hive/admin"
kadmin.local "ktadd -k /etc/hadoopkeytab/impala.keytab impala/admin"
kadmin.local "ktadd -k /etc/hadoopkeytab/hdfs.keytab hdfs/admin"
kadmin.local "ktadd -k /etc/hadoopkeytab/kafka.keytab kafka/admin"
#chmod 700 /etc/hadoopkeytab
