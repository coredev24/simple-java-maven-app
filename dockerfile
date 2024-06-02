# Base image for building the application
FROM maven:3.8.6-openjdk-18-slim AS build

# Set working directory
WORKDIR /app

# Copy source code and pom.xml
COPY src /app/src
COPY pom.xml.

# Compile the application
RUN mvn clean package

# Final image for running the application
FROM openjdk:18-slim

# Copy the compiled JAR from the build stage
COPY --from=build /app/target/*.jar /app/application.jar

# Set the working directory
WORKDIR /app

# Expose the port the application runs on
EXPOSE 8080

# Specify the entry point
ENTRYPOINT ["java", "-jar", "/app/application.jar"]
