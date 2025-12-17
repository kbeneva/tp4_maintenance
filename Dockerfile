# STAGE 1 : BUILD
FROM maven:3.9.9-eclipse-temurin-23-alpine AS build
WORKDIR /build
COPY . .
RUN mvn clean package -DskipTests

# STAGE 2 : FINAL
FROM eclipse-temurin:23-jre-alpine AS final
WORKDIR /opt/app
EXPOSE 9090
COPY --from=build /build/target/*.jar app.jar
ENTRYPOINT ["java", "-jar", "app.jar"]
