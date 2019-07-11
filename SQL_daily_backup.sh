
#!/bin/bash

DIR="/home/backups/database"
MYSQL_USER="root"
MYSQL_PASSWORD="a48b59!"

databases=`mysql -u$MYSQL_USER -p$MYSQL_PASSWORD -e "SHOW DATABASES;"`

for db in $databases; do
echo "----Sauvegarde de '$db'-----"
mysqldump --force --opt --user=$MYSQL_USER -p$MYSQL_PASSWORD --databases $db > "$DIR/$(date +%Y-%m-%d)_$db.sql"
done

