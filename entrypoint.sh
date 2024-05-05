#!/bin/bash
# start server
/opt/mssql/bin/sqlservr &

sleep 30s
# logger - use below command to list files included in .bak to get correct logical names for restore command for WITH MOVE part
# sqlcmd -S localhost -U SA -P "${DB_PASSWORD}" -Q "RESTORE FILELISTONLY FROM DISK = '/var/opt/mssql/backup/${DB_NAME}.bak'"


# restore
sqlcmd -S localhost -U SA -P "${DB_PASSWORD}" -Q "RESTORE DATABASE ${DB_NAME} FROM DISK = '/var/opt/mssql/backup/${DB_NAME}.bak' WITH MOVE '${DB_NAME}' TO '/var/opt/mssql/data/${DB_NAME}.mdf', MOVE '${DB_NAME}_log' TO '/var/opt/mssql/data/${DB_NAME}_log.ldf', REPLACE"

# keep running
wait $!
