#!/bin/sh
# Import data from CSV files in data folder
# to the `ipcc` database in MySQL server
#
# USAGE:
# import-from-csv-to-mysql.sh [user] [host] [password]
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
auth="--host $host --user $user $passwordParam"

# Function: import()
# Import a CSV file into a table of the same name (removing extension)
# in the database
#
# Parameters:
#   $1 - string, name of the table (also CSV file name without extension)
#   $2 - optional, string, list of column names to import,
#        separated with commas
import()
{
  if test -z "$2"
  then
    columns=''
  else
    columns="--columns=$2"
  fi

  echo "Import CSV file data/$1.csv to table $database.$1"
  mysqlimport $auth \
    --default-character-set=utf8 \
    --delete \
    --fields-terminated-by=',' \
    --fields-optionally-enclosed-by='"' \
    --lines-terminated-by='\n' \
    --ignore-lines=1 \
    --local \
    $columns \
    $database \
    "data/$1.csv"
}

# change to the script's directory
cd $(dirname $0)

echo 'Delete existing version of IPCC Database'
mysql $auth < scripts/delete-ipcc-database.sql

echo 'Create IPCC Database with empty tables'
mysql $auth < scripts/create-ipcc-database.sql

echo 'Import CSV from data folder to database tables'

import authors id,first_name,last_name
import author_aliases alias,author_id,@skip

import institution_types id,name,symbol
import institutions id,name,institution_type_id,@skip
import institution_aliases alias,institution_id,@skip

import countries id,name
import country_aliases alias,country_id,@skip

import groups id,symbol,name,type
import groupings id,symbol,@skip,country_id,@skip

import institution_countries \
  id,institution_id,@skip,country_id,@skip

import author_institutions author_id,@skip,institution_id,@skip,@skip

import departments id,name,institution_id,@skip
import author_departments author_id,@skip,department_id,@skip

import chairman_offices \
  id,ar,wg,role,rank,author_id,@skip,institution_id,@skip,department_id,@skip

import assessment_reports id,year
import working_groups id,number,title,assessment_report_id
import chapters \
  id,number,title,wg,ar,assessment_report_id,working_group_id
import chapter_types id,symbol,name
import chapter_chapter_types \
  chapter_id,@skip,@skip,@skip,chapter_type_id,@skip

import roles id,symbol,name,rank

import participations \
  id,ar,wg,chapter,role,author_id,@skip,institution_country_id,@skip,@skip,department_id,@skip

echo 'Import complete.'
