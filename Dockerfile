# Build stage
FROM maven:3.9.9-eclipse-temurin-21-alpine AS build

# Set the working directory
WORKDIR /build

# Copy only pom.xml first to leverage Docker layer caching
COPY pom.xml .

# Download project dependencies
RUN mvn dependency:go-offline

# Copy application source code separately
COPY src ./src

# Build the application
RUN mvn clean package

# Runtime stage
FROM eclipse-temurin:21-jre-alpine

# Set the working directory
WORKDIR /app

# Define an argument to accept the JAR file name
ARG JAR_FILE=/build/target/webapp-0.0.1-SNAPSHOT.jar

# Copy the packaged Spring Boot JAR file from the build stage to the working directory
COPY --from=build ${JAR_FILE} /app/app.jar

# Expose the application's port
EXPOSE 8080

# Start the Spring Boot application
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
