# ! build stage (JDK + gradle) -> jar
# jdk image pull
    # Window
# FROM eclipse-temurin:17-jdk-alpine as builder
    # MAC
FROM --platform=linux/amd64 eclipse-temurin:17-jdk-alpine as builder
WORKDIR /app

COPY gradlew .
COPY gradle gradle
COPY build.gradle settings.gradle ./

RUN chmod +x gradlew
RUN ./gradlew dependencies

COPY src src
RUN ./gradlew bootJar

# ! runtime stage (jre) -> jar
FROM --platform=linux/amd64 eclipse-temurin:17-jre-alpine
WORKDIR /app

COPY --from=builder /app/build/libs/*.jar app.jar
ENTRYPOINT ["java", "-jar", "app.jar"]