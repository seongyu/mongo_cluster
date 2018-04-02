Target : MongoDB setting by docker & mongodb3.0

Environment
- Ubuntu 16.04
- Docker 18.03
- docker-compose 1.20 

Composition
- 3 of config-server
- 3 of replica for 1 set
- 2 of broker-server (27017,27018)

Process
1. install docker by apt-get
2. install docker-compose
3. git clone this project
4. cd /mongo_cluster
5. docker-compose up
6. exit docker
7. docker start mongos1 mongos2 mconfig1 mconfig2 mconfig3 shard1n1 shard1n2 shard1n3
8. ./initialize_mongo.sh
9. check status

Careful
- This MongoCluster has no authization. Recommend to give access authority to reliable users on the vm.