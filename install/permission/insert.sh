
ldap_root_passwd=`awk -F = '/ldap_root_passwd/{print $2}' application.properties`
ldap_domain=`awk -F = '/ldap_domain/{print $2}' application.properties`

ldapadd -x -D "cn=Manager,dc=$ldap_domain,dc=com" -w $ldap_root_passwd -f ./permission/cloudera.ldif
ldapadd -x -D "cn=Manager,dc=$ldap_domain,dc=com" -w $ldap_root_passwd -f ./permission/hbase.ldif
ldapadd -x -D "cn=Manager,dc=$ldap_domain,dc=com" -w $ldap_root_passwd -f ./permission/hive.ldif
ldapadd -x -D "cn=Manager,dc=$ldap_domain,dc=com" -w $ldap_root_passwd -f ./permission/impala.ldif
ldapadd -x -D "cn=Manager,dc=$ldap_domain,dc=com" -w $ldap_root_passwd -f ./permission/hdfs.ldif
ldapadd -x -D "cn=Manager,dc=$ldap_domain,dc=com" -w $ldap_root_passwd -f ./permission/kafka.ldif
kadmin.local -q "addprinc -pw $ldap_root_passwd hbase_all"
kadmin.local -q "addprinc -pw $ldap_root_passwd hive_all"
kadmin.local -q "addprinc -pw $ldap_root_passwd impala_all"
kadmin.local -q "addprinc -pw $ldap_root_passwd hdfs_all"
kadmin.local -q "addprinc -pw $ldap_root_passwd kafka_all"
