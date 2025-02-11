# Base image
FROM openjdk:17-jdk-slim

# Add a volume pointing to /tmp
VOLUME /tmp

# 환경변수 설정
ENV APP_HOME=/app
WORKDIR $APP_HOME

# JAR 파일 복사
COPY target/*.jar app.jar

# Expose the application port (18080)
EXPOSE 18080

# Run the jar file
ENTRYPOINT ["java", "-jar", "/app.jar"]
