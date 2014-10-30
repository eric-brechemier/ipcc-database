#!/bin/sh
# Convert TSV to CSV
# by replacing tabs with commas
# after quoting the fields which contain commas or double-quotes
# (double quotes inside quoted fields are doubled for escaping)
#
# Usage:
#   tsv2csv.sh < input.tsv > output.csv
#
# Input:
#   lines separated with tabs, on the standard input
#
# Output:
#   lines separated with commas, with fields quoted when needed,
#   on the standard output

# a TAB character
tab='	'

# a comma character
comma=','

# a double quote character
quote='"'

# Convert one line of TSV to CSV
#
# Parameter:
#   $1 - string, the line of TSV to convert
#
# Output:
#   the line converted to CSV, printed to standard output
convertLine()
{
  fields="$1"
  result=''
  separator=''

  # loop over fields in each line, using TAB a separator
  oldIFS="$IFS"
  IFS="$tab"
  for field in $fields
  do
    case "$field" in
      *$quote*)
        # fields which contain a double-quote must be quoted
        # with each double-quote doubled from " to "" for escaping
        escapedField=$(echo "$field" | sed -e "s/$quote/$quote$quote/g")
        result="$result$separator$quote$escapedField$quote"
      ;;
      *$comma*)
        # fields which contain a comma must be quoted
        result="$result$separator$quote$field$quote"
      ;;
      *|'')
        # fields without comma are left unquoted
        result="$result$separator$field"
    esac
    separator="$comma"
  done
  IFS="$oldIFS"

  if test -z "$result"
  then
    # replace tabs with commas in empty lines
    # (which contain no field, but only separators)
    echo "$fields" | tr "$tab" "$comma"
  else
    # print converted line to output
    echo "$result"
  fi
}

# read file line by line, without expanding fields
# (we want to preserve lines made only of field separators)
IFS=''
while read -r line
do
  convertLine "$line"
done
unset IFS
