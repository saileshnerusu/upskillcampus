FROM tomcat:9.0

# remove default apps
RUN rm -rf /usr/local/tomcat/webapps/*

# copy your web app
COPY src/main/webapp/ /usr/local/tomcat/webapps/ROOT/

EXPOSE 8080

CMD ["catalina.sh", "run"]
