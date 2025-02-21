#!/bin/bash
#sed -i "s/password.*$/password = '$POSTGRES_PASSWORD'/" /usr/share/tomcat7/.grails/transmartConfig/DataSource.groovy
#service tomcat7 start && R CMD Rserve --save  && tail -f /var/log/tomcat7/transmart.log /var/log/tomcat7/catalina.out
#echo entrypoint.sh for transmart-app

if [ "$GET_CURRENT_WAR" = false ] ; then
# old: get WAR file via script and copy it to tomcat

file="/war/artifacts.zip"
file_target="/usr/local/tomcat/webapps/transmart.war"

if [ ! -f "$file" ]
then
    echo "$0: File '${file}' not found."
else
    echo "$0: File '${file}' found."
    if  [ ! -f "$file_target" ]
    then
       mkdir -p /usr/local/tomcat/webapps/
       unzip "$file" -d /war/
       cp /war/target/transmart.war /usr/local/tomcat/webapps/transmart.war
       echo "'${file}' unzipped and copied to '${file_target}'."
    else
       echo "'${file}' not copied, because '${file_target}' already existed."
    fi
fi

else
# new: get war from gitlab
/getWARfromGITLAB.sh

fi


# read -rsp $'Press enter to continue...\n'

sed -i "s/password.*$/password = '${POSTGRES_PASSWORD}'/" /root/.grails/transmartConfig/DataSource.groovy && \
sed -i "s#def transmartURL.*#def transmartURL = '${PROTOCOL}${DOMAIN}/transmart/'#" /root/.grails/transmartConfig/Config.groovy && \
sed -i "s#.*url = \"http://localhost:8080/transmart\".*#url = '${PROTOCOL}${DOMAIN}:8080/transmart' #" /root/.grails/transmartConfig/Config.groovy && \
sed -i "s/.*com.recomdata.dataUpload.adminEmail.*$/com.recomdata.dataUpload.adminEmail = \'${ADMIN_MAIL}\'/" /root/.grails/transmartConfig/Config.groovy && \
sed -i "s/.*com.recomdata.contactUs.*$/com.recomdata.contactUs = \'${ADMIN_MAIL}\'/" /root/.grails/transmartConfig/Config.groovy && \
sed -i "s/.*com.recomdata.adminEmail.*$/com.recomdata.adminEmail = \'${ADMIN_MAIL}\'/" /root/.grails/transmartConfig/Config.groovy

cd /usr/local/tomcat/bin/
./catalina.sh run && R CMD Rserve --save  && tail -f /var/log/tomcat7/transmart.log /var/log/tomcat7/catalina.out

#service tomcat7 start && R CMD Rserve --save  && tail -f /var/log/tomcat7/transmart.log /var/log/tomcat7/catalina.out


