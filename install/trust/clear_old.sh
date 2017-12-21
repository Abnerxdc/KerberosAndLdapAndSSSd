ipNames=`cat linux_hosts.txt`
for ipName in $ipNames
do
	echo "#######clear krb5.conf : $ipName ########"
	ssh $ipName "sed -i ''"
done
