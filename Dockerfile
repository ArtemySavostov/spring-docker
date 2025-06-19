FROM maven as builder

WORKDIR /build
COPY mvnw pom.xml ./
COPY ./ ./
RUN mvn clean package -DskipTests

FROM openjdk
EXPOSE 8080
COPY --from=builder /build/target/spring-petclinic-3.4.0-SNAPSHOT.jar app.jar
ENTRYPOINT ["java", "-Dspring.profiles.active=mysql", "-jar", "app.jar"]
