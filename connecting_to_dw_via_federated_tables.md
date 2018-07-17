## What is a Federated Table?

## Why Would I use a federated table?
You may want to use Maghub's Data Warehouse with other external data. One way to do this would be with ELT software, but if you need real time data from other sources, you can use federated tables to bring one or more Data Warehouse tables into a local mysql database, where you can JOIN Data Warehouse tables with local tables.

One example would be to provide statistics against tickets, if you use a self-hosted ad server, such as Revive. I was able to add a ticket dynamic attribute to Maghub and store a banner or campaign ID to digital ad tickets, and merge this data with Revive's own MySql Database. By adding Maghub's Data Warehouse into Revive's database via federated tables, this can be done directly in MySQL without any extra programming knowledge.

Another example would be to use MySql's own stored prodecures and event scheduler to do summarization in custom tables without an extra software.

Yet another example of Federated table's usefulness for Data Warehouse is to be able to access Data Warehouse through more services that don't support Mysql over SSH, without adding additional IPs to your account.

## Server Setup

## Maghub DW Setup
