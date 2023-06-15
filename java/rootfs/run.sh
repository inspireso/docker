#!/bin/sh

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
