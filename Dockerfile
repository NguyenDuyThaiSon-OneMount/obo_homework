FROM maven:3.8-openjdk-17-slim AS build
COPY src /usr/src/app/src
COPY pom.xml /usr/src/app
COPY obo.sql /usr/src/app
RUN mvn -e -f /usr/src/app/pom.xml clean package

FROM openjdk:17.0.1-slim-buster
COPY --from=build /usr/src/app/target/obo-stadium-0.0.1-SNAPSHOT.jar /usr/app/obo-stadium-0.0.1-SNAPSHOT.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/usr/app/obo-stadium-0.0.1-SNAPSHOT.jar"]
CMD ["spring-boot:run"]

#FROM maven:3.8-openjdk-17-slim
#RUN mkdir /obo
#WORKDIR /obo
#COPY . .
#EXPOSE 8080
#CMD ["mvn", "spring-boot:run"]