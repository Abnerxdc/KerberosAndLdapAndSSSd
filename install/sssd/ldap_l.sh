# if you want to jicheng ldap with linux 
ipNames=`cat linux_hosts.txt`
./sssd/linux_ldap.sh
for ipName in $ipNames
do
	echo "#######current host $ipName is jicheng ldap+linux########"
	#安装kerberos文件，配置域名	
	ssh $ipName "bash"<sssd/linux_ldap.sh
done
