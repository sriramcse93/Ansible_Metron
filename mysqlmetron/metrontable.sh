#!/bin/bash
mysql -u root -proot123 <<METRONTABLE
CREATE DATABASE IF NOT EXISTS metronrest;
CREATE USER 'metron' IDENTIFIED BY 'metron'; 
GRANT ALL PRIVILEGES ON metronrest.* TO 'metron';
FLUSH PRIVILEGES;
use metronrest;
create table if not exists users(  
  username varchar(50) not null primary key,  
  password varchar(50) not null,  
  enabled boolean not null 
); 
create table authorities (  
  username varchar(50) not null,  
  authority varchar(50) not null,
  constraint fk_authorities_users foreign key(username) references  
  users(username)
);
create unique index ix_auth_username on authorities (username,authority);
insert into users (username, password, enabled) values ('metron','metron',1);
insert into authorities (username, authority) values ('metron', 'ROLE_USER');
METRONTABLE
