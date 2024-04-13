
# Use an official Maven runtime as a parent image
FROM maven:3.8.1-jdk-11-slim AS build

# Set the working directory in the container
WORKDIR /app

# Copy the Maven configuration file and download dependencies
COPY pom.xml .
RUN mvn dependency:go-offline

# Copy the source code
COPY src ./src

# Package the application
RUN mvn package -DskipTests

# Use an official Tomcat runtime as a parent image
FROM tomcat:9.0-jdk11-openjdk-slim

# Copy the WAR file from the build stage to the Tomcat webapps directory
COPY --from=build /target/*.war /usr/local/tomcat/webapps/helloworld.war

# Copy the index.jsp file to the Tomcat webapps directory (Optional: if index.jsp is in src/main/webapp)
# COPY --from=build /app/src/main/webapp/index.jsp /usr/local/tomcat/webapps/ROOT/index.jsp

# Set environment variables (Optional: if needed)
# ENV SOME_ENV_VARIABLE value

# Expose port 8080
EXPOSE 8080

# Command to run on container start
CMD ["catalina.sh", "run"]
