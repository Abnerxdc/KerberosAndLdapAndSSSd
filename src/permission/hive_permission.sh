# create a role 
create role hive_admin;
# gei role permission  
grant all on server server1 to role hive_admin;
# role fuyu group permission
grant role hive_admin to group hive_all;


create role db2_admin;
grant all on database db2 to role db2_admin;
grant role db2_admin to group abner;
