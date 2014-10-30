# Convert TSV to CSV
# by replacing tabs with commas
# after quoting the fields which contain commas or double-quotes
# (double quotes inside quoted fields are doubled for escaping)
#
# Usage:
#   awk -f tsv2csv.awk < input.tsv > output.csv
#
# Input:
#   lines separated with tabs, on the standard input
#
# Output:
#   lines separated with commas, with fields quoted when needed,
#   on the standard output

BEGIN {
  # a TAB character
  tab = "	"

  # a comma character
  comma = ","

  # a double quote character
  quote = "\""

  # set field separator
  FS = tab
}

function escapeTsvField(tsvField, escapedTsvField) {
  # double each double quote character for escaping
  escapedTsvField = tsvField
  gsub(quote, quote quote, escapedTsvField)
  return escapedTsvField
}

function convertTsvField(tsvField) {
  if ( index(tsvField,quote) > 0 )
    # fields which contain a double-quote must be quoted
    # with each double-quote doubled from " to "" for escaping
    return quote escapeTsvField(tsvField) quote

  if ( index(tsvField,comma) > 0 )
    # fields which contain a comma must be quoted
    return quote tsvField quote

  # fields without comma or double-quote are left as is
  return tsvField
}

function convertTsvLine() {
  csvLine = ""
  csvSeparator = ""
  for (tsvFieldPosition=1; tsvFieldPosition<=NF; tsvFieldPosition++) {
    csvField = convertTsvField($tsvFieldPosition)
    csvLine = csvLine csvSeparator csvField
    csvSeparator = comma
  }
  print csvLine
}

# for each line read
{
  convertTsvLine()
}
