# KerberosAndLdapAndSSSd
脚本安装kerberos openldap以及sssd 一键化自动安装


Openldap+Kerberos+sssd自动配置脚本使用说明
1、	最好配置首先域名，更改hostname（方便统一）
域名格式 ： host-11-1.hadoop.com
更改hosts文件
2、	linux_hosts.txt文本中存放当前集群中除了本机以外所有主机的ip或hoststname
3、	application.properties文件内容说明：
kdc_hostname_A=host-11-1.hadoop.com（kdc主机A）
kdc_hostname_B=host-11-2.hadoop.com（kdc主机B  主主高可用模式 非slave-master）

ldap_hostname_A=host-11-1.hadoop.com（ldap主机A）
ldap_hostname_B=host-11-2.hadoop.com （ldap主机B 主主高可用模式）

ldap_domain=hadoop  （ldap的根域名 默认自带com，不要再加com，最好统一）

krb_domain_B=HADOOP.COM （kdc的域名，这个要大写！）
krb_domain_S=hadoop.com （kdc的域名，这个要小写！）

ldap_root_passwd=12345 （ldap root用户密码，脚本使用时候会提示用到）


4、	strust目录下的domain.prooperties文件说明
    集群1 kdc主机A
kdc1_host_A=host-11-1.onlinequery.com
集群1 kdc主机B
kdc1_host_B=host-11-2.onlinequery.com
域名大写
kdc1_domain_B=ONLINEQUERY.COM
域名小写
kdc1_domain_S=onlinequery.com
集群2
kdc2_host_A=host-22-1.struct.com
kdc2_host_B=host-22-2.struct.com
kdc2_domain_B=STRUCT.COM
kdc2_domain_S=struct.com
集群3
kdc3_host_A=host-33-1.preprocess.com
kdc3_host-B=host-33-2.preprocess.com
kdc3_domain_B=PREPROCESS.COM
kdc3_domain_S=preprocess.com
5、	执行脚本start.sh（需要手动输入！）
执行到创建kerberos数据库的时候提示需要密码，前面两个密码是application.properties配置文件中 ldap_root_passwd的值 后面两个密码是创建的kerberos数据库密码，这个自己定义
 

6、	仔细说明一下start.sh中内容，可以按照需求安装
#给配置文件权限 用于脚本读取（必须）
chmod 777 application.properties
#openldap安装、备份脚本（不可重复执行，否则会破坏备份）
chmod 777 ./ldap/ldapinstall.sh
./ldap/ldapinstall.sh
#配置openldap的配置文件
chmod 777 ./ldap/ldap_a.sh
./ldap/ldap_a.sh
#创建openldap必要用户
chmod 777 ./ldap/ldap_b.sh
./ldap/ldap_b.sh
#集成sssd脚本，使用后将统一集群linux登陆用户（不推荐使用，sssd稳性考虑）
#chmod 777 ./sssd/linux_run.sh
#./sssd/linux_run.sh
# Kerberos安装、配置脚本
chmod 777 ./kerberos/krb.sh
./kerberos/krb.sh
#kerberos集成openldap脚本（可选，不选择的话需要自己创建kerberos数据库）
chmod 777 ./kerberos/krb_ldap.sh
./kerberos/krb_ldap.sh
#其他节点提供kerberos client服务
chmod 777 ./kerberos/k_others.sh
./kerberos/k_others.sh
#启动kerberos服务
chmod 777 ./kerberos/k_run.sh
./kerberos/k_run.sh
#kerberos主主模式配置（自己摸索出，已验证可用）
chmod 777 ./kerberos/k_slave.sh
./kerberos/k_slave.sh

#ldap进行主主模式配置
chmod 777 ./ldap/slave_run.sh
./ldap/slave_run.sh
chmod 777 ./ldap/slave_b.sh
./ldap/slave_b.sh
chmod 777 ./ldap/slave_c.sh
./ldap/slave_c.sh
chmod 777 ./ldap/slave_e.sh
./ldap/slave_e.sh
#还有建立超级管理员用户的脚本 在permission目录下，尚未测试未放进去
#还有三集群互信脚本在trust目录下，尚未测试，未放进来
7、	文件夹中诸多文件
文件夹中有诸多.ldif、 .txt格式的文件，脚本使用，请勿人为修改（加个空格都不行！）
文件夹中ldap/ clear_ldap_db.sh 脚本用于清空openldap配置、数据，一般人员不可使用。
