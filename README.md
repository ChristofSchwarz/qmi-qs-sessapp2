# Qlik Sense Session Applications
## Description
NodeJS webpage that creates Qlik Sense Session Apps on demand

## Purpose
Session applications are not persisted on disk or QMC, instead they are programatically created on request.  This scenario allows you to demonstrate this capability without the knowledge to develop the solution.

| Servername        | Server IP         | 
|-------------------|-------------------|
| qmi-qs-sessapp2   | 192.168.56.102    | 

## URLs
| Name | URL | Purpose
|------|-----|---------
|QMC|http://qmi-qs-sessapp2/qmc | QMC
|hub|http://qmi-qs-sessapp2/hub | hub
|Session Apps|http://qmi-qs-sessapp2:4000 | website

Register your own first user with password, then log on. This will
save the user into MongoDB and use for ticket authentication.

## Users
| Name | Password |
|------|-----|
|.\qlik| Qlik1234|


## What is installed
### Software
1. Qlik Sense Server
2. MS SQL Server Express 2016 (with HeidiSQL Studio)
3. MongoDB
4. NodeJS

### Support Information
| Author | Version | Date Published |
|--------|---------|----------------|
|Christof Schwarz|1.0|29 Oct 2017|
