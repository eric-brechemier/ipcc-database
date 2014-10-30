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

escapeTsvField()
{
  escapedTsvField=''
  # add a final double-quote to parse all substrings consistently
  tsvFieldWithQuote="$tsvField$quote"
  escapedQuote=''
  until test -z "$tsvFieldWithQuote"
  do
    # substring before next double-quote
    tsvFieldWithoutQuote=${tsvFieldWithQuote%%$quote*}
    # substring after tsvFieldWithoutQuote and quote
    tsvFieldWithQuote=${tsvFieldWithQuote#"$tsvFieldWithoutQuote$quote"}
    escapedTsvField="$escapedTsvField$escapedQuote$tsvFieldWithoutQuote"
    escapedQuote="$quote$quote"
  done
}

convertTsvField()
{
  case "$tsvField" in
    *$quote*)
      # fields which contain a double-quote must be quoted
      # with each double-quote doubled from " to "" for escaping
      escapeTsvField
      csvField="$quote$escapedTsvField$quote"
    ;;
    *$comma*)
      # fields which contain a comma must be quoted
      csvField="$quote$tsvField$quote"
    ;;
    *|'')
      # fields without comma or double-quote are left as is
      csvField="$tsvField"
  esac
}

convertTsvLine()
{
  csvLine=''
  csvSeparator=''
  # add a final tab to have a tab after the last field as well
  tsvLine="$tsvLine$tab"
  until test -z "$tsvLine"
  do
    # substring before next tab
    tsvField=${tsvLine%%$tab*}
    # substring after tsvField and tab
    tsvLine=${tsvLine#"$tsvField$tab"}
    convertTsvField
    csvLine="$csvLine$csvSeparator$csvField"
    csvSeparator="$comma"
  done
  echo "$csvLine"
}

# read file line by line, without expanding fields (to preserve TABs)
IFS=''
while read -r tsvLine
do
  convertTsvLine
done
unset IFS
