ipcc-database
=============

A database of authors who contributed to the IPCC Assessment Reports,
including contributions chapter per chapter (participations) with roles,
institutions and countries.

## Usage

### Import from CSV to MySQL

Run `import-from-csv-to-mysql.sh`.

The import script creates a new database named `ipcc` (deleting
the previous database of the same name, if any) and loads data
from the CSV files in the folder `data` into tables. Extra columns
are included in the CSV files with names to explicit the identifiers;
these columns, which include "(info)" in their names, are skipped
at import; they are absent from created tables.

### Export from MySQL to CSV

Run `export-from-mysql-to-csv.sh`.

The export script exports tables of the database `ipcc` to CSV files
in the folder `data`, adding extra columns with names to explicit
identifiers: author name for author id, institution and country names
for institution-country id, etc.

### Note

Both scripts connect by default to a local MySQL database
as root user; a different user and host can be provided as
parameters (see details at the start of each script file).

## Attribution

[MEDEA Project][MEDEA]
[CC-BY][] [Arts Déco][Arts Deco] & [Sciences Po][Medialab]

[MEDEA]: http://www.projetmedea.fr/
[CC-BY]: https://creativecommons.org/licenses/by/4.0/
         "Creative Commons Attribution 4.0 International"
[Arts Deco]: http://www.ensad.fr/en
             "École Nationale Supérieure des Arts Décoratifs"
[Medialab]: http://www.medialab.sciences-po.fr/
               "Sciences Po Médialab"
