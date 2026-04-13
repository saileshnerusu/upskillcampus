FROM tomcat:9.0

COPY . /usr/local/tomcat/webapps/GroceryWebApp

EXPOSE 8080
