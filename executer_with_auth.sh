#! /bin/bash

# input admin account
read -p "Input user name : " ADMIN
read -p "Input password : " PWD

if [ -z "$ADMIN" ]; then
  echo "You should input user name. Try again."
  exit 1
fi
if [ -z "$PWD" ]; then
  echo "You should input password. Try again."
  exit 1
fi

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

# restart mongodb service as daemon
mongod --shutdown
mongod --fork --logpath /var/log/mongodb/mongodb.log

# create mongo script
echo "
use admin

db.create({
user:'${ADMIN}',
pwd:'${PWD}',
roles:[role:{role:'userAdminAnyDatabase',db:'admin'}]
})
" > mongo_script.js

# registrate mongo script
mongo < mongo_script.js

# restart mongodb service with auth as daemon
mongod --shutdown
mongod --fork --auth --logpath /var/log/mongodb/mongodb.log
