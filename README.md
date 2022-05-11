#  WSO2 Integration POC

Simple WSO2 POC implemention using APIM, Choreo Connect, Mocked Endpoints with a mixture of authenication and header manipulation

Intention is to have all services auotmatically created and registered via the single docker-compose up command

WSO2 documentation for Choreo Connect 

https://apim.docs.wso2.com/en/latest/deploy-and-publish/deploy-on-gateway/choreo-connect/getting-started/quick-start-guide-docker-with-apim/

## Start



```
$ docker-compose up -d 

Creating network "wso2-intergration-poc_default" with the default driver
Creating wso2-intergration-poc_sample-api-1_1 ... done
Creating wso2-intergration-poc_apim_1         ... done
Creating wso2-intergration-poc_adapter_1      ... done
Creating wso2-intergration-poc_adapter-mgw2_1  ... done
Creating wso2-intergration-poc_enforcer-mgw2_1 ... done
Creating wso2-intergration-poc_enforcer_1      ... done
Creating wso2-intergration-poc_router-mgw2_1   ... done
Creating wso2-intergration-poc_router_1        ... done
$
```


Wait till apim is healthy
```
 docker-compose ps
                Name                               Command                  State                                                              Ports                                                       
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
wso2-intergration-poc_adapter-mgw2_1    /bin/sh -c ./adapter             Up             0.0.0.0:28000->18000/tcp,:::28000->18000/tcp, 0.0.0.0:29843->9843/tcp,:::29843->9843/tcp                           
wso2-intergration-poc_adapter_1         /bin/sh -c ./adapter             Up             0.0.0.0:18000->18000/tcp,:::18000->18000/tcp, 0.0.0.0:9843->9843/tcp,:::9843->9843/tcp                             
wso2-intergration-poc_apim_1            /home/wso2carbon/docker-en ...   Up (healthy)   11111/tcp, 5672/tcp, 8243/tcp, 8280/tcp, 9099/tcp, 9443/tcp, 0.0.0.0:9444->9444/tcp,:::9444->9444/tcp, 9611/tcp,   
                                                                                        9711/tcp, 9763/tcp, 9999/tcp                                                                                       
wso2-intergration-poc_enforcer-mgw2_1   /bin/sh -c java -XX:+HeapD ...   Up             0.0.0.0:28081->8081/tcp,:::28081->8081/tcp, 0.0.0.0:29001->9001/tcp,:::29001->9001/tcp                             
wso2-intergration-poc_enforcer_1        /bin/sh -c java -XX:+HeapD ...   Up             0.0.0.0:8081->8081/tcp,:::8081->8081/tcp, 0.0.0.0:9001->9001/tcp,:::9001->9001/tcp                                 
wso2-intergration-poc_router-mgw2_1     /docker-entrypoint.sh /bin ...   Up             10000/tcp, 0.0.0.0:29000->9000/tcp,:::29000->9000/tcp, 0.0.0.0:29090->9090/tcp,:::29090->9090/tcp,                 
                                                                                        0.0.0.0:29095->9095/tcp,:::29095->9095/tcp                                                                         
wso2-intergration-poc_router_1          /docker-entrypoint.sh /bin ...   Up             10000/tcp, 0.0.0.0:9000->9000/tcp,:::9000->9000/tcp, 0.0.0.0:9090->9090/tcp,:::9090->9090/tcp,                     
                                                                                        0.0.0.0:9095->9095/tcp,:::9095->9095/tcp                                                                           
wso2-intergration-poc_sample-api-1_1    node dist/index.js mock -h ...   Up             0.0.0.0:4010->4010/tcp,:::4010->4010/tcp                                                                           
$ 
```


APIM can be managed locally on  https://apim:9444/publisher/



### Init process

Create env 

```
apictl  add  env   dockerdev  \
--registration https://apim:9444/ \
--admin https://apim:9444/ \
--publisher https://apim:9444/ \
--devportal https://apim:9444/ \
--token https://apim:9444/ 
``` 

Log into env
```
$ apictl -k  login dockerdev -u admin -p admin 
```

Create a new project

``` 
apictl -k init sampleapp1 --oas /tmp/openapi-specs/openapi-core-topology.yaml --force=true
Initializing a new WSO2 API Manager project in /tmp/sampleapp1
Project initialized
Open README file to learn more
```

Edit the api.yaml to update the endpoint location
```
vi sampleapp1/api.yaml 
```

Import the project into apim

```
apictl -k import api -f sampleapp1/ -e dockerdev 
Successfully imported API. 
```