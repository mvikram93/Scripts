FROM ubuntu:latest

MAINTAINER Vikram M
#Jenkins + JMeter File
RUN  apt-get update 
RUN  apt-get -y upgrade 
RUN	 apt -y install apt-transport-https ca-certificates curl software-properties-common 
#RUN	 add-apt-repository ppa:webupd8team/java 
RUN	 apt update 
RUN	 apt-get install -y openjdk-8-jdk wget git

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/
RUN export JAVA_HOME
ENV PATH ${PATH}:${JAVA_HOME}/bin

RUN cd
RUN wget -c http://ftp.ps.pl/pub/apache//jmeter/binaries/apache-jmeter-5.2.1.tgz
RUN tar -xf apache-jmeter-5.2.1.tgz

RUN apt-get install -y wget 
RUN	wget https://downloads.apache.org/tomcat/tomcat-9/v9.0.37/bin/apache-tomcat-9.0.37.tar.gz -P /tmp
RUN mkdir /opt/tomcat
RUN tar xf /tmp/apache-tomcat-9.0.37.tar.gz -C /opt/tomcat
RUN mkdir /opt/tomcat/latest
RUN ln -s /opt/tomcat/apache-tomcat-9.0.37 /opt/tomcat/latest
RUN chown -RH root: /opt/tomcat/latest/apache-tomcat-9.0.37/bin/catalina.sh
RUN chmod +x /opt/tomcat/latest/apache-tomcat-9.0.37/bin/*.sh
COPY jenkins.war /opt/tomcat/latest/apache-tomcat-9.0.37/webapps/
RUN cd /opt/tomcat/latest/apache-tomcat-9.0.37/webapps/
EXPOSE 8080
CMD /opt/tomcat/latest/apache-tomcat-9.0.37/bin/catalina.sh run
