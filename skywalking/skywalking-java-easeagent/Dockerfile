FROM megaease/easeagent-initializer:latest

ENV JAVA_TOOL_OPTIONS="-javaagent:/skywalking/agent/skywalking-agent.jar -Deaseagent.config.path=/skywalking/agent/agent.properties --Deaseagent.name=${}"

RUN mkdir -p /skywalking && mv /easeagent-volume /skywalking/agent && mv /skywalking/agent/easeagent.jar /skywalking/agent/skywalking-agent.jar

ADD agent.properties /skywalking/agent/agent.properties

WORKDIR /skywalking