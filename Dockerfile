FROM ubuntu:18.04
RUN apt-get update && apt-get install -y dos2unix curl 
ADD buddy-integration.sh /home/qualiti-script.sh
RUN chmod +x /home/qualiti-script.sh
RUN dos2unix /home/qualiti-script.sh
RUN bash /home/qualiti-script.sh
