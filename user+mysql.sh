#!/usr/bin/bash

COUNTER=0
while [ "$COUNTER" -eq 0 ]; do
	echo -n "Enter user name: "
	read name

	if ! [ -z "$name" ]
  		then
    		let COUNTER=COUNTER+1 
	fi

	if [ "$COUNTER" -eq 0 ]
  		then
    		echo "Name input cannot be left blank. Please re-enter the name." 
	fi	
done


COUNTER=0
while [ "$COUNTER" -eq 0 ]; do
    echo "Enter password for the new user: "
	read -s passwd
	
	if ! [ -z "$passwd" ]
  		then
    		let COUNTER=COUNTER+1 
	fi

	if [ "$COUNTER" -eq 0 ]
  		then
    		echo "Password input cannot be left blank. Please enter a valid password." 
	fi	
done


COUNTER=0
while [ "$COUNTER" -eq 0 ]; do
    echo -n "Create a database account?(Y/n): "
	read database
	
	if [ -z "$database" ] || [ "$database" == "Y" ] || [ "$database" == "n" ]
  		then
    		let COUNTER=COUNTER+1 
	fi

	if [ "$COUNTER" -eq 0 ]
  		then
    		echo "Sorry! Wrong input. Please Enter again" 
	fi	
done


if ! which whois > /dev/null; then
    sudo apt-get update
    sudo apt-get install whois
fi

out=$(mkpasswd $passwd)
sudo useradd -m $name -p $out

echo -n "Enter amdin's mysql username: "
read mysqlusr

echo "Enter the admin's Mysql Password: "
read -s mysqlpw

if [ -z "$database" ] || ["$database" == "Y" ]
	then
    	mysql -u $mysqlusr -p$mysqlpw -e "CREATE USER '$name'@'localhost' IDENTIFIED BY '$passwd';"
fi
