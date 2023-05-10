FROM openjdk:8-slim-buster as builder

COPY . .

RUN chmod +x ./mvnw && ./mvnw -B package

FROM ghcr.io/inspireso/docker/java:8-jdk-alpine

USER root
RUN mkdir -p /app
# copy jar from the first stage
COPY --chown=app:app --from=builder target/bootstrap.jar /app/bootstrap.jar
USER app