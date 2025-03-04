FROM eclipse-temurin:17-jre-alpine

WORKDIR /opt/app

ARG artifact=target/demo-0.0.1-SNAPSHOT.jar

COPY ${artifact} app.jar

EXPOSE 8080

ENTRYPOINT [ "java", "-jar", "app.jar" ]
# FROM maven:3.8.4-openjdk-17-slim AS maven_cache

# # Set the working directory in the container
# WORKDIR /app

# COPY pom.xml .

# COPY src ./src

# COPY target/demo-0.0.1-SNAPSHOT.jar .
# # Expose the port that the Spring Boot application will run on
# EXPOSE 8080

# # Define the command to run the Spring Boot application when the container starts
# CMD ["java", "-jar", "demo-0.0.1-SNAPSHOT.jar"]