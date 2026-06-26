#!/bin/bash

DATA=$(date +"%Y%m%d%H%M%S")

mysqldump -u root -p petvida > backups/petvida$DATA.sql

echo "Backup criado: backups/petvida_$DATA.sql"