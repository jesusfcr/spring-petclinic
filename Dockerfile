# syntax=docker/dockerfile:1

FROM openjdk:16-alpine3.13 as src

WORKDIR /app

COPY .mvn/ .mvn
COPY mvnw pom.xml ./
RUN ./mvnw dependency:go-offline

COPY src ./src

RUN ./mvnw install

CMD ["./mvnw", "spring-boot:run"]

FROM openjdk:16-alpine3.13

WORKDIR /app

COPY --from=src /app/target/spring-petclinic-2.6.0-SNAPSHOT.jar /app/app.jar

CMD ["java", "-jar", "/app/app.jar"]
