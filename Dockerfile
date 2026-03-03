# jdk image pull
    # Window
FROM eclipse-temurin:17-jre-alpine
    # MAC
# FROM --platform=linux/amd64 eclipse-temurin:17-jre-alpine

# jar
ARG JAR_FILE=build/libs/*.jar

# copy
COPY ${JAR_FILE} ./backend.jar

# run
ENTRYPOINT ["java", "-jar", "./backend.jar"]