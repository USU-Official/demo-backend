# Build stage
FROM maven:3.8.4-openjdk-17 AS builder
WORKDIR ./app
COPY . ./
RUN mvn --batch-mode --update-snapshots verify -DskipTests

# Package stage
FROM openjdk:17-alpine

RUN apk add tzdata
RUN cp /usr/share/zoneinfo/Asia/Jakarta /etc/localtime

WORKDIR ./app
COPY --from=builder ./app/target/sikeu-0.0.1-SNAPSHOT.jar /usr/local/lib/sikeu.jar

EXPOSE 8180
CMD ["java", "-jar", "/usr/local/lib/sikeu.jar","&"]
