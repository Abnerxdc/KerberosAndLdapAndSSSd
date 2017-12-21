kinit -kt /etc/hadoopkeytab/hbase.keytab hbase/admin

hbase shell < ./installldap/hbase_permission.sh

kdestroy
