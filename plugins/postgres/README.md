PostgreSQL plugin for Dokku
---------------------------

Project: https://github.com/progrium/dokku

**Warning: This plugin is under development and still only tested with the below dependencies**

Requirements
------------
* Docker version `0.7.2` or higher
* Dokku version `0.2.1` or higher

Installation
------------
```
cd /var/lib/dokku/plugins
git clone https://github.com/Kloadut/dokku-pg-plugin postgres
dokku plugins-install
```


Commands
--------
```
$ dokku help
    postgres:console <db>                        Open a PostgreSQL console
    postgres:create <db>                         Create a PostgreSQL container
    postgres:delete <db>                         Delete specified PostgreSQL container
    postgres:dump <db> > dump_file.sql           Dump database data
    postgres:info <db>                           Display database informations
    postgres:link <app> <db>                     Link an app to a PostgreSQL database
    postgres:list                                Display list of PostgreSQL containers
    postgres:logs <db>                           Display last logs from PostgreSQL container
    postgres:restore <db> < dump_file.sql        Restore database data from a previous dump
```

Simple usage
------------

Create a new DB:
```
$ dokku postgres:create foo            # Server side
$ ssh dokku@server postgres:create foo # Client side

-----> PostgreSQL container created: postgresql/foo

       Host: 172.17.42.1
       User: 'root'
       Password: 'RDSBYlUrOYMtndKb'
       Database: 'db'
       Public port: 49187
```

Deploy your app with the same name (client side):
```
$ git remote add dokku git@server:foo
$ git push dokku master

```

Link your app to the database
```bash
dokku postgres:link app_name database_name
```


Advanced usage
--------------

Inititalize the database with SQL statements:
```
cat init.sql | dokku postgres:create foo
```

Open a PostgreSQL console for specified database:
```
dokku postgres:console foo
```

Deleting databases:
```
dokku postgres:delete foo
```

Linking an app to a specific database:
```
dokku postgres:link foo bar
```

PostgreSQL logs (per database):
```
dokku postgres:logs foo
```

Database information:
```
dokku postgres:info foo
```

List of containers:
```
dokku postgres:list
```

Dump a database:
```
dokku postgres:dump foo > foo.sql
```

Restore a database:
```
dokku postgres:restore foo < foo.sql
```

In case Dokku says `pg_dump not found` when dumping or restoring database:
```
sudo apt-get install postgresql-client-9.3
```
