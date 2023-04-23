FROM tomcat:8.5.88-jre8-temurin

LABEL maintainer=goutham@gmail.com

ADD ./target/petclinic.war /usr/local/tomcat/webapps/

EXPOSE 8080

CMD ["catalina.sh", "run"]
