Target : MongoDB setting by docker & mongodb3.0


Environment
- Ubuntu 16.04
- Docker 18.03
- docker-compose 1.20 


Composition
- 3 of config-server
- 3 of replica for 1 set
- 2 of broker-server (27017,27018)


Process for create Cluster with shard at first time
1. install docker by apt-get
2. install docker-compose
3. git clone https://github.com/seongyu/mongo_cluster.git
4. cd /mongo_cluster
5. docker-compose up
6. exit docker
7. docker start mongos1 mongos2 mconfig1 mconfig2 mconfig3 shard1n1 shard1n2 shard1n3
8. ./initialize_mongo.sh
9. check status


Process for add shard on sharded Cluster
1. install docker by apt-get
2. install docker-compose
3. git clone https://github.com/seongyu/mongo_cluster.git
4. cd /mongo_cluster/add_shard
5. docker-compose up
 5-1. if it need to external access, bind external port to local primary shard node port
6. ./initialize_shard.sh
 6-1. need to change the parameters in shell if changed any parameter or environment in while process 5
7. check status


Process for stand-alone MongoDB
1. git clone -b stand-alone https://github.com/seongyu/mongo_cluster.git
2. cd /mongo_cluster
3. ./executer.sh


Careful
- This MongoCluster has no authization. Recommend to give access authority to reliable users on the vm.
- All process require root account.
