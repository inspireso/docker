FROM megaease/easeagent-initializer:latest

ENV JAVA_TOOL_OPTIONS=-javaagent:/skywalking/agent/easeagent.jar

RUN mkdir -p /skywalking && mv /easeagent-volume /skywalking/agent

WORKDIR /skywalking