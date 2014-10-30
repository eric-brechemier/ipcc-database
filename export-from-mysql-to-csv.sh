#!/bin/sh
# Export data from MySQL database
# to CSV files in data folder
#
# USAGE:
# export-from-mysql-to-csv.sh [user] [host] [password]
# with
#   user - optional, string, database user name, defaults to 'root'
#   host - optional, string, database host name, defaults to 'localhost'
#   password - optional, string, database user password,
#              defaults to 'no password' which provides no password;
#              an empty string results in a prompt for password.
user=${1:-'root'}
host=${2:-'localhost'}
password=${3:-'no password'}

if [ "$password" = 'no password' ]
then
  passwordParam=''
else
  passwordParam="--password $password"
fi

database=ipcc
query="mysql --host $host --user $user $passwordParam"

table2csv()
{
  table=$(basename $1 .sql)
  echo "Export table $database.$table to CSV file data/$table.csv"
  $query $database < $1 \
  | awk -f ../tsv2csv.awk > "../../data/$table.csv"
}

# change to the script's directory
cd $(dirname $0)

# change to import scripts directory
cd scripts/import

for script in *.sql
do
  table2csv "$script"
done

echo 'Export done.'
