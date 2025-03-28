# Start from Maven to build the app
FROM maven:3.9.9-eclipse-temurin-17 AS builder

# Set working directory
WORKDIR /app

# Copy source code
COPY . .

# Build WAR file
RUN mvn clean package

# Use official Tomcat base image
FROM tomcat:10.1.18-jdk17

# Remove default ROOT webapp
RUN rm -rf /usr/local/tomcat/webapps/ROOT

# Copy the built WAR file into Tomcat
COPY --from=builder /app/target/*.war /usr/local/tomcat/webapps/ROOT.war

# Expose port 9090
RUN sed -i 's/port="8080"/port="9090"/' /usr/local/tomcat/conf/server.xml
EXPOSE 9090

# Start Tomcat
CMD ["catalina.sh", "run"]
