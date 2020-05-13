#!/bin/bash
mysql -u root -proot123 <<QUERY
SET GLOBAL validate_password_check_user_name='OFF';
SET GLOBAL validate_password_policy='LOW';
SET GLOBAL validate_password_length=2;
SET GLOBAL validate_password_mixed_case_count=0;
SET GLOBAL validate_password_number_count=0;
SET GLOBAL validate_password_special_char_count=0;
FLUSH PRIVILEGES;
QUERY
