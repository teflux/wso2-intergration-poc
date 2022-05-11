FROM debian:bullseye-slim
RUN apt update

RUN apt install curl iputils-ping telnet vim -y

RUN curl -L https://apim.docs.wso2.com/en/4.1.0/assets/attachments/learn/api-controller/apictl-4.1.0-linux-x64.tar.gz -o /tmp/apictl-4.1.0-linux-x64.tar.gz
RUN tar xfvz /tmp/apictl-4.1.0-linux-x64.tar.gz -C /tmp
RUN mv /tmp/apictl/apictl /usr/local/bin/


