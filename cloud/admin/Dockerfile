FROM openjdk:8-slim-buster as builder

COPY . .

RUN chmod +x ./mvnw && ./mvnw -B package

FROM ghcr.io/inspireso/docker/java:8-ajdk

# copy jar from the first stage
COPY --from=builder target/bootstrap.jar /app/bootstrap.jar