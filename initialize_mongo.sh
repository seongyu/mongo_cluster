#! /bin/bash
if [ -z "$1" ]; then
  echo "Input Replica Number as parameter..."
  exit 1
fi

echo "Start initialization..."

# 구성한 Replica를 Config 서버에 등록
REPLICA_NUM=$1
for (( rs = 1; rs <= $REPLICA_NUM; rs++ )); do
  echo "Initializing replica ${rs}/${REPLICA_NUM}SET..."
  replication="rs.initiate(); sleep(1000); cfg = rs.conf(); cfg.members[0].host = \"shard${rs}n1\"; rs.reconfig(cfg); rs.add(\"shard${rs}n2\"); rs.add(\"shard${rs}n3\"); rs.status();"
  docker exec -it shard${rs}n1 bash -c "echo '${replication}' | mongo"
done

sleep 2

# Broker에 설정완료된 Shard를 등록
docker exec -it mongos1 bash -c "echo \"sh.addShard('shard1/shard1n1:27017');\" | mongo "