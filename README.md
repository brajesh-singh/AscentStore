# Hybris B2B Demo Ascent store
This is the source code repository for the Hybris B2B Demo Ascent store.

READ the README.PDF file too, as the preferred way of building and deploying is listed on this document.

## Prerequisites

1. Windows users :

	a. Download and install Oracle Database 11g Express Edition

	b. The remaining steps assume that the system account password was set to oracle

2. Linux and Mac users:

	a. Download and install [VirtualBox](https://www.virtualbox.org/wiki/Downloads)

	b. Download Oracle Developer Day image from Oracle (http://www.oracle.com/technetwork/database/enterprise-edition/databaseappdev-vm-161299.html)

	c. Import Oracle Developer Day image to Virtual Box.

	d. Check on the VM the ip of the Virtual Machine (Console > ip a or ifconfig). Oracle will be accessible in this IP.

3. Download hybris Commerce Suite version 6.2.0.9 (take the latest patch). 

4. Download and install the latest Oracle Java Developer Kit 1.8.x (Java 8)

5. Windows users: Download and install 7zip that is better to unzip the hybris-commerce-suite

6. Make sure the `JAVA_HOME` environment variable is set to the JDK8 install location and your `PATH` environment variable contains `$JAVA_HOME/bin` (or for Windows `%JAVA_HOME%\bin`)

	```
	> java -version  
	#java version "1.8u92"  
	> echo %JAVA_HOME%  
	>echo $JAVA_HOME  
	#C:\Program Files\Java\jdk1.8u92
	```

## Git, Sourcetree and Stash Setup

If you have already configured your Git and/or Sourcetree installations, please skip this step.

1. Configure Git for the first time

	```
	$ git config --global user.name "FirstName LastName"  
	$ git config --global user.email "xxx@xxxx.com"  
	```

# Project Install

1. Checkout the project the first time into your project root from the command line:

	```
	$ git clone 

	$ git checkout --track origin/develop         #if you are not already on the develop branch
	```

	Ensure that you are on the `develop` branch.
	
	If this does not work, consider simply using the git perspective in STS/Eclipse to perform the clone.

2. Install the hybris platform:

	Unzip the platform into the project root directory and run:

	```
	$ .\hybris\bin\platform\setantenv.bat #or .sh for you linux/Mac folks
	$ ant clean all
    ```


3. Create a local Oracle database for the project. Either use SQL Developer (connect using host=localhost, port=1521, user=system and password=manager) or display the SQL command prompt window, for example, on Windows, open a command window and enter `sqlplus`. On Mac, run vagrant ssh then sqlplus system/manager@//localhost:1521/XE
	* Connect as the system user with password oracle
	* Run the following (note that user=ascent and password=ascent for the purposes of this example and in the sample files)

	```SQL
	alter session set container=ORCLPDB1;
	create tablespace ascent_tbsp datafile 'ascent_tbsp01.dbf' size 1g autoextend on;
	create user ascent identified by ascent default tablespace ascent_tbsp temporary tablespace temp; 
	grant connect to ascent;
	grant dba to ascent; 
	grant create session to ascent;
	grant all privileges to ascent;
	exit  
	```

4. Copy the folder `hybris\config-common` into `hybris\config`. 
	
	Copy the folder `hybris\config-local` into `hybris\config`. 
	
	Verify the following lines in `hybris/config/local.properties`  

	```
	# Oracle XE  
	db.url=jdbc:oracle:thin:@localhost:1521/XE
	db.driver=oracle.jdbc.driver.OracleDriver
	db.username=ascent
	db.password=ascent
	db.tableprefix=
	```

5. Run `ant customize clean all initialize`

	If you get the message "] ERROR DbDriverValidator - Database driver - oracle.jdbc.driver.OracleDriver could not be found. Make sure you have it under <HYBRIS_HOME>/hybris/bin/platform/lib/dbdriver", then copy your ojdbc6.jar file from your oraclexe installation into the folder specified.

6. Start the hybris server

