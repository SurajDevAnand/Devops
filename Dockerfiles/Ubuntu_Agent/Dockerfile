FROM ubuntu:22.04
WORKDIR /app
ARG customer_key

RUN apt-get update -y && \
    apt-get install wget -y && \
    wget https://staticdownloads.site24x7.com/server/Site24x7InstallScript.sh && \
    bash Site24x7InstallScript.sh -i -key=$customer_key -automation=true && \
    /opt/site24x7/monagent/scripts/AgentManager.sh -newmonitor && \
    /opt/site24x7/monagent/bin/monagent restart && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get remove wget -y && \
    rm Site24x7InstallScript.sh 

