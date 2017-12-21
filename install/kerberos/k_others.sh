ipNames=`cat linux_hosts.txt`
for ipName in $ipNames
do
	echo "#######current execute host ipName is : $ipName ########"
	#安装kerberos文件，配置域名	
	ssh $ipName 'yum -y install krb5-libs krb5-workstation'
done

for ipName in $ipNames
do
	echo "#######current execute host ipName is : $ipName ########"
	#将配置文件分发到各个节点
	scp /etc/krb5.conf root@$ipName:/etc
done
