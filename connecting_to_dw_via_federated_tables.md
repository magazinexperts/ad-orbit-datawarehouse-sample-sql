## What is a Federated Table?
The Federated storage engine allow remote access of a mysql tables in a local database. In the case of Maghub's Data Warehouse, Federated tables can allow you to access the read only database locally on a MySql server, bypassing the access restrictions and allowing for customization of the Data Warehouse data.

## Why Would I use a federated table?
You may want to use Maghub's Data Warehouse with other external data. One way to do this would be with ELT software, but if you need real time data from other sources, you can use federated tables to bring one or more Data Warehouse tables into a local mysql database, where you can JOIN Data Warehouse tables with local tables.

One example would be to provide statistics against tickets, if you use a self-hosted ad server, such as Revive. I was able to add a ticket dynamic attribute to Maghub and store a banner or campaign ID to digital ad tickets, and merge this data with Revive's own MySql Database. By adding Maghub's Data Warehouse into Revive's database via federated tables, this can be done directly in MySQL without any extra programming knowledge.

Another example would be to use MySql's own stored prodecures and event scheduler to do summarization in custom tables without an extra software.

You may also consier a Federated table when you want to create custom views, as Data Warehouse does not allow creation of custom views.

Yet another example of Federated table's usefulness for Data Warehouse is to be able to access Data Warehouse through more services that don't support Mysql over SSH, without adding additional IPs to your account.

## Server Setup
For recent verson of mysql, editing my.cnf as described [here](https://stackoverflow.com/questions/5210309/how-can-i-enable-federated-engine-in-mysql-after-installation), will enable Federated tables to be used.

Then restart your MySQL service/server.

You need to be able to access mysql on port 3306, so you may have to open an outgoing connection on your MySql server's firewall.

## Maghub DW Setup
