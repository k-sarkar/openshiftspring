FROM maven:3.8.2-jdk-8 AS build
COPY src /home/app/src
COPY pom.xml /home/app
RUN mvn -f /home/app/pom.xml clean install && ls -l /home/app/target/


FROM openjdk:8u302-jdk
COPY --from=build /home/app/target/OpenShift*.jar /usr/local/lib/OpenShift.jar
EXPOSE 8080
RUN java -version
ENTRYPOINT ["java","-jar","/usr/local/lib/OpenShift.jar"]