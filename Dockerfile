FROM eclipse-temurin:17-jre-alpine

WORKDIR /opt/app

ARG artifact=target/demo-0.0.1-SNAPSHOT.jar

COPY ${artifact} app.jar

EXPOSE 8080

ENTRYPOINT [ "java", "-jar", "app.jar" ]