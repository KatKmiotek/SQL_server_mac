FROM mcr.microsoft.com/azure-sql-edge:latest
ENV DB_PASSWORD=MyPassword123
ENV ACCEPT_EULA=1 \
    DB_NAME=AdventureWorks2017 \
    MSSQL_SA_PASSWORD=$DB_PASSWORD \
    MSSQL_PID=Developer \
    MSSQL_USER=SA

# temp assume root to install tools
USER root
RUN apt-get update -y \
    && apt-get install -y sudo curl git gnupg2 software-properties-common \
    && curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
    && add-apt-repository "$(wget -qO- https://packages.microsoft.com/config/ubuntu/20.04/prod.list)" \
    && apt-get update -y \
    && apt-get install -y sqlcmd
USER mssql

COPY ${DB_NAME}.bak /var/opt/mssql/backup/${DB_NAME}.bak

EXPOSE 1433

COPY entrypoint.sh /usr/src/app/entrypoint.sh

ENTRYPOINT ["/usr/src/app/entrypoint.sh"]
