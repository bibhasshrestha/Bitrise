FROM ubuntu:18.04
RUN apt-get update && apt-get install -y dos2unix curl 
ADD buddy-integration.sh /home/buddy-integration.sh
RUN chmod +x /home/buddy-integration.sh
RUN dos2unix /home/buddy-integration.sh
RUN bash /home/buddy-integration.sh
