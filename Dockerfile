
# Use an official Maven runtime as a parent image
FROM maven:3.8.1-jdk-11-slim AS build

# Set the working directory in the container
WORKDIR /app

COPY * /app
# Package the application
RUN jar -cvf helloworld.war *.jsp WEB-INF


# Copy the WAR file from the build stage to the Tomcat webapps directory
#COPY --from=build /target/*.war /usr/local/tomcat/webapps/helloworld.war


# Expose port 8080
EXPOSE 8080

# Command to run on container start
CMD ["catalina.sh", "run"]
