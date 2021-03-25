FROM ubuntu:18.04
RUN apt-get update && apt-get install -y dos2unix curl 
ADD teamcity-integration.sh /home/teamcity-integration.sh
RUN chmod +x /home/teamcity-integration.sh
RUN dos2unix /home/teamcity-integration.sh
RUN bash /home/teamcity-integration.sh
