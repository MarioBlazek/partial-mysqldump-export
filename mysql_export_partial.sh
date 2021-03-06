#!/bin/bash

EXPORT_FILENAME='symfony_tables.sql'
STRING_START='ez%'

while getopts ":u:p:h:d:f:s:" opt; do
  case $opt in
    u)
      USER=$OPTARG
      echo "User selected, Parameter: $USER" >&2
      ;;
    p)
      PASSWORD=$OPTARG
      echo "Password set, Parameter: $PASSWORD" >&2
      ;;
    h)
      HOST=$OPTARG
      echo "Database hostname set, Parameter: $HOST" >&2
      ;;
    d)
      DATABASE=$OPTARG
      echo "Database selected, Parameter: $DATABASE" >&2
      ;;
    f)
      EXPORT_FILENAME=$OPTARG
      echo "Export file set, Parameter: $EXPORT_FILENAME" >&2
      ;;
    s)
      STRING_START=$OPTARG
      echo "NOT LIKE set with parameter: $STRING_START" >&2
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
      ;;
  esac
done

SQL="SELECT GROUP_CONCAT(table_name separator ' ')"
SQL="${SQL} FROM information_schema.tables"
SQL="${SQL} WHERE table_schema = '${DATABASE}'"
SQL="${SQL} AND table_name NOT LIKE '${STRING_START}%';"
TABLES=`mysql -u ${USER} -p${PASSWORD} -h${HOST} -AN -e"${SQL}"`
echo "Tables to export: $TABLES"
mysqldump -u ${USER} -p${PASSWORD} -h${HOST} ${DATABASE} ${TABLES} > ${EXPORT_FILENAME}
