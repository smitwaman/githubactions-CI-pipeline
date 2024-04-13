# Use an official Tomcat runtime as a parent image
FROM tomcat:9.0-jdk11-openjdk-slim

# Set the working directory in the container
WORKDIR /usr/local/tomcat/webapps/ROOT

# Copy the index.jsp file to the ROOT directory
COPY index.jsp .

# Expose port 8080
EXPOSE 8080

# Command to run on container start
CMD ["catalina.sh", "run"]
