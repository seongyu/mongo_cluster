#! /bin/bash
apt-get update
apt-get upgrade -y

# set mongodb keystore
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927

# add repository for mongodb3.2
# if want to change version, just do it
echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-3.2.list

apt-get update

# install mongodb3.2 latest version
apt-get install -y mongodb-org=3.2.19 mongodb-org-server=3.2.19 mongodb-org-shell=3.2.19 mongodb-org-mongos=3.2.19 mongodb-org-tools=3.2.19

# create default db path
mkdir -p /data/db

# restart mongodb service
mongod --shutdown
mongod --fork --dbpath /data/db --logpath /var/log/mongodb/mongodb.log