mv /usr/java/jdk1.8.0_60/jre/lib/security/local_policy.jar /usr/java/jdk1.8.0_60/jre/lib/security/local_policy.jar.old
mv /usr/java/jdk1.8.0_60/jre/lib/security/US_export_policy.jar /usr/java/jdk1.8.0_60/jre/lib/security/US_export_policy.jar.old
cp ./jdk/local_policy.jar /usr/java/jdk1.8.0_60/jre/lib/security/
cp ./jdk/US_export_policy.jar /usr/java/jdk1.8.0_60/jre/lib/security/
