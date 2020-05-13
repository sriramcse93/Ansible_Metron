#!/bin/bash
#!/bin/bash
temp_pass="`grep 'temporary password' /var/log/mysqld.log | awk '{print $11}'`"
systemctl stop mysqld
systemctl set-environment MYSQLD_OPTS="--skip-grant-tables"
systemctl start mysqld
mysql -u root <<MYSQL_QUERY
FLUSH PRIVILEGES;
ALTER USER 'root'@'localhost' IDENTIFIED BY 'root123';
FLUSH PRIVILEGES;
quit
MYSQL_QUERY
systemctl stop mysqld
systemctl unset-environment MYSQLD_OPTS
systemctl start mysqld
