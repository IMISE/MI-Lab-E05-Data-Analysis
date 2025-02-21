FROM tomcat:7-jre8
MAINTAINER Christian Bauer <christian.bauer@med.uni-goettingen.de>
MAINTAINER Theresa Bender <theresa.bender@med.uni-goettingen.de>
#Based on https://github.com/dennyverbeeck/transmart-docker by Denny Verbeeck <dverbeec@its.jnj.com>
LABEL TRANSMART_VERSION="TMF16.2"

RUN apt-get update && apt-get install jq -y

# change the random number generator to /dev/urandom, since inside a container there is not a lot of
# entropy to feed /dev/random and it will block for a long time when starting the application
RUN sed -i 's#securerandom.source=file:/dev/random#securerandom.source=file:/dev/urandom#' /usr/lib/jvm/java-8-openjdk-amd64/jre/lib/security/java.security

COPY transmart-app/setenv.sh /usr/share/tomcat7/bin/
RUN echo "export JAVA_OPTS=-Dfile.encoding=UTF-8 -Xms1024m -Xmx4196m -XX:PermSize=1024m -XX:MaxPermSize=4196m" >> /usr/share/tomcat7/bin/setenv.sh

RUN mkdir -p /root/.grails/transmartConfig/
COPY transmart-app/Config.groovy /root/.grails/transmartConfig/
COPY transmart-app/DataSource.groovy /root/.grails/transmartConfig/

COPY transmart-app/getWARfromGITLAB.sh /
COPY transmart-app/entrypoint.sh /
COPY artifacts/artifacts.zip /war/

EXPOSE 8443

ENTRYPOINT ["/bin/bash", "-c", "/entrypoint.sh"]
