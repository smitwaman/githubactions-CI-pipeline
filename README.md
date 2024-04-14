# CI pipeline using maven for"build-test" and docker for "image-build-publish" in GITHUB ACTIONS



```
name: CI

on:
  release:
    types: [created]
  push:
    branches: [ "main" ]
    tags: [ 'v*.*.*' ]
  pull_request:
    branches: [ "main" ]

env:
  REGISTRY: docker.io
  IMAGE_NAME: helloworld
  IMAGE_TAG: v1

jobs:
  build-test-publish:

    runs-on: ubuntu-latest
    permissions:
      contents: read
      packages: write

    steps:
    - uses: actions/checkout@v3
    - name: Set up JDK 11
      uses: actions/setup-java@v3
      with:
        java-version: '11'
        distribution: 'temurin'
        server-id: github
        settings-path: ${{ github.workspace }}

    - name: Build with Maven
      run: mvn -B package --file pom.xml
    - name: Test with Maven
      run: mvn clean test
    - name: Publish to GitHub Packages Apache Maven
      run: mvn deploy -s $GITHUB_WORKSPACE/settings.xml
      env:
        GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}

  image-build-push:

    runs-on: ubuntu-latest

    steps:
    - uses: actions/checkout@v3
    - name: Login to Docker Hub
      uses: docker/login-action@v1
      with:
        username: ${{ secrets.DOCKER_USERNAME }}
        password: ${{ secrets.DOCKER_PASSWORD }}

    - name: Build the Docker image
      run: docker build . --file Dockerfile --tag ${{ secrets.DOCKER_USERNAME }}/${{ env.IMAGE_NAME }}:${{ env.IMAGE_TAG }}

    - name: Push Docker image to Docker Hub
      run: docker push ${{ secrets.DOCKER_USERNAME }}/${{ env.IMAGE_NAME }}:${{ env.IMAGE_TAG }}


```








# Deploy helloworld webapplication to apache tomacat server

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
   ![](https://github.com/smitwaman/hello-world.war/blob/main/image/Screenshot%202024-04-13%20203823.png)


