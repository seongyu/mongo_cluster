#! /bin/bash
if [ -z "$1" ]; then
  echo "Input Replica Number as parameter..."
  exit 1
fi
REPLICA_NUM=$1
echo "Start initialization..."
echo "Initializing replica${REPLICA_NUM}..."
replication="rs.initiate(); sleep(1000); cfg = rs.conf(); cfg.members[0].host = \"shard${rs}n1\"; rs.reconfig(cfg); rs.add(\"shard${rs}n2\"); rs.add(\"shard${rs}n3\"); rs.status();"
docker exec -it shard${rs}n1 bash -c "echo '${replication}' | mongo"

sleep 2

# add shard to target mongo broker
docker exec -it mongos1 bash -c "echo \"sh.addShard('shard${replication}/shard${replication}n1:27017');\" | mongo "