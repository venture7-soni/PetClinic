FROM tomcat:8.5.88-jre8-temurin

LABEL maintainer=goutham@gmail.com

ADD ./target/spring-petclinic-4.2.5.war /usr/local/tomcat/webapps/

EXPOSE 8080

CMD ["catalina.sh", "run"]
