FROM maven:3.8.4-openjdk-17 as builder
WORKDIR /build
COPY . .
RUN mvn clean package -DskipTests

FROM openjdk:17-jre-slim
EXPOSE 8080
COPY --from=builder /build/target/*.jar app.jar
ENTRYPOINT ["java", "-Dspring.profiles.active=mysql", "-jar", "app.jar"]
