#!/bin/bash
# get latest transmart.war from gitlab.gwdg.de and deploy in tomcat
echo get latest transmart.war from gitlab.gwdg.de and deploy in tomcat

#Private Token from GitLab with API permissions
PTOKEN=KZNc-5yza6A_4P6GBPBx
PID=3879
BRANCH=$WAR_BRANCH
JOB=build
OUTPUT_DIR=/root
FILE=artifacts.zip
WEBAPPS=/usr/local/tomcat/webapps

if [ -f "/usr/local/tomcat/noSuccessOld.txt" ];
then
	echo "Local WAR found."
else
	echo "0" > noSuccessOld.txt
fi

#get number of jobs in this project that were successful
curl --header "PRIVATE-TOKEN: $PTOKEN" "https://gitlab.gwdg.de/api/v4/projects/$PID/jobs" | jq ".[]|select(.status==\"success\")" | jq ".|length" | wc -l > noSuccess.txt
successNew=$(<noSuccess.txt)
successOld=$(<noSuccessOld.txt)

#compare number of jobs to number when downloaded last time
if [[ $successNew > $successOld ]]; then
	echo "Old or no version of WAR. Start downloading."

        #get war from gitlab with personal key (portal.tbender)
        curl --header "PRIVATE-TOKEN: $PTOKEN" "https://gitlab.gwdg.de/api/v4/projects/$PID/jobs/artifacts/$BRANCH/download?job=$JOB" -o $OUTPUT_DIR/$FILE

        #move to webapps
        cd $OUTPUT_DIR
        unzip -o $FILE
        cp  target/transmart.war $WEBAPPS/transmart.war
	rm -R $WEBAPPS/transmart
else
	echo "WAR already up-to-date. Moving on."
fi

#save new no of jobs
echo $successNew > /usr/local/tomcat/noSuccessOld.txt
