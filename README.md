build:
docker build -t azure-sql-edge .   

run:
docker run --name sql-bak -p 1433:1433 -d azure-sql-edge

port allocated error:
docker container ls
docker rm -f <container-name>

## Setup SQL Server on Mac with db restored from .bak file

This project provides a docker solution allowing running SQL Server on Mac (M1, M2, M3).  
It setups SQL Server with database restored from local .bak file.

This is common scenario for setting up local database.

Allows connection from Azure Data Studio.

### Prerequisites
Project requires Docker to be installed [download link](https://docs.docker.com/desktop/install/mac-install/)  
To connect to Server Azure Data Studio needs to be installed [download link](https://learn.microsoft.com/en-us/azure-data-studio/download-azure-data-studio)  

### Run server

In the root of the project run:  
```sh
docker-compose up
```
or without logs in detached mode:  
```sh
docker-compose up -d
```
At this point your server is running and you can connect to it from Azure Data Studio:

click new connection > complete form:    
Connection type: Microsoft SQL Server  
Server: **localhost**  
Authentication Type: SQL Login  
User name: **SA**  
Password: **MyPassword123**  
Trust Server Certificate: True  
(other inputs can stay as defaults)

You should see on the left hand side connection to localhost and when expand Databases be able to see AdventureWorks2017  
To close SQL Server run:  
```sh
docker-compose down
```

### Customize
**Make it your own!**  
Replace .bak file in the root of this project to database backup you want to restore.  
Update env variables in .env to your backup name and password you want to use.  

### Solution
you can separately build and run Docker:  
```sh
docker build -t my-sqlserver . 
```
```sh
docker run --name sql-bak -p 1433:1433 -d my-sqlserver
```

or if you want to override env variables:  
```sh
docker run --name sql-bak -p 1433:1433 -e DB_PASSWORD=<YourStrongPassword> -e DB_NAME=<YourBakDBName> -d my-sqlserver
```

### Note
To run database restore command ( executed in entrypoint.sh ) you will need logical file names from .bak ( they might be different depending on snapshot ) see logger comment in entrypoint.sh with instruction how to log logical file names.   
