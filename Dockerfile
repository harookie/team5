# Base image
FROM openjdk:17-jdk-slim

# Add a volume pointing to /tmp
VOLUME /tmp

# Copy the application JAR to the container
ARG JAR_FILE=build/libs/hello-api.jar
COPY ${JAR_FILE} app.jar

# Expose the application port (18080)
EXPOSE 18080

# Run the jar file
ENTRYPOINT ["java", "-jar", "/app.jar"]