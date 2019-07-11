#!/bin/bash


mysql -D r2d4_muta2 -u root -pa48b59! -e "SET SESSION old_alter_table=1"

mysql -D r2d4_muta2 -u root -pa48b59! -e "ALTER IGNORE TABLE datadom ADD UNIQUE INDEX(Nomdom)"

mysql -D r2d4_muta2 -u root -pa48b59! -e "SET SESSION old_alter_table=0"




