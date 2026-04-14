FROM tomcat:9.0

RUN rm -rf /usr/local/tomcat/webapps/*

COPY src/main/webapp/ /usr/local/tomcat/webapps/ROOT/
COPY src/main/java/ /tmp/java-src/

EXPOSE 8080
