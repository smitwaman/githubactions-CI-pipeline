Deploy helloworld webapplication to apache tomacat server

Steps-
1. Write source code and pom.xml file for project
2. Write WEB-INF/web.xml file  
3. build package using
   ```
   mvn clean package

   ```
4. cp helloworld.war artifact from target folder to opt/tomcat9/webapps/

   ```
   sudo cp helloworld.jar /opt/tomcat9/webapps/

   ```
5. Run tomcat
   ```
   cd /opt/tomcat9/bin
   sudo ./startup.sh
   ```
6. go to browser and paste

   ```http://localhost:8080/helloworld```
   ![]()
