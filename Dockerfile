# 1. Maven kullanarak projeyi build et
FROM maven:3.9.6-amazoncorretto-8-debian-bookworm AS build
WORKDIR /build
COPY pom.xml .
COPY src ./src
RUN mvn clean package

# 2. Tomcat ile projeyi çalıştır
FROM tomcat:10-jre8-openjdk-buster
COPY --from=build /build/target/ROOT.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080
CMD ["catalina.sh", "run"]
