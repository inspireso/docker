#!/bin/sh

RESERVED_MEGABYTES=768
limit_in_bytes=$(cat /sys/fs/cgroup/memory/memory.limit_in_bytes)
heap_size=$(echo $JAVA_OPTS | grep Xmx)

# If not default limit_in_bytes in cgroup
if [ "$limit_in_bytes" -ne "9223372036854771712"  ] && [ -z $heap_size ]
then
    limit_in_megabytes=$(expr $limit_in_bytes \/ 1048576)
    heap_size=$(expr $limit_in_megabytes - $RESERVED_MEGABYTES)
    export JAVA_OPTS="-Xmx${heap_size}m -Xms${heap_size}m $JAVA_OPTS"
    echo JAVA_OPTS=$JAVA_OPTS
fi

cd /app

export JAVA_OPTS="$JAVA_OPTS \
  -XshowSettings:vm \
  -Djava.security.egd=file:/dev/./urandom \
  -Djava.awt.headless=true \
  -Djava.net.preferIPv4Stack=true \
  -Dfile.encoding=UTF-8 \
  -Duser.timezone=GMT+08"

echo "Starting App"

exec java $JAVA_AGENT $JAVA_OPTS -jar /app/bootstrap.jar "$@"
