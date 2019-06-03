#!/bin/sh
# https://github.com/janakiramm/techtalk
# https://github.com/llSourcell/AI_Supply_Chain/blob/master/Deploy_Microservices_Cloud_Foundry_Docker.md (****)
# https://thenewstack.io/walkthrough-building-serverless-applications-ibm-bluemix/
# https://github.com/janakiramm/techtalk/tree/master/cloud-functions
# https://medium.com/openwhisk/working-with-openwhisk-triggers-734fa9624ae5
# https://www.freeformatter.com/xml-formatter.htm
# https://www.mkyong.com/maven/create-a-fat-jar-file-maven-assembly-plugin/
# https://openwhisk.incubator.apache.org/slack.html

######################## (1)

curl -fsSL https://clis.cloud.ibm.com/install/linux | sh

#ibmcloud login -a cloud.ibm.com -o "ernese@sg.ibm.com" -s "cloudnative-dev" --sso 
ibmcloud login -a https://api.ng.bluemix.net --sso
ibmcloud plugin install cloud-functions
ibmcloud fn namespace list
ibmcloud target -o ernese@sg.ibm.com -s cloudnative-dev
ibmcloud regions

########################3
zip -r helloPY.zip *
ibmcloud fn action create helloPY --kind python:3 --main hello  helloPY.zip
ibmcloud fn action invoke helloPY --blocking --result

########################3
npm install
zip -r hello.zip *
ibmcloud fn action create hello --kind nodejs:10 hello.zip
ibmcloud fn action invoke hello --blocking --result --param name Ernese


########################3
ibmcloud fn action list
ibmcloud fn action create hello hello.js --kind nodejs:10
ibmcloud fn action list
ibmcloud fn action invoke hello --blocking --result
ibmcloud fn action invoke hello --blocking
ibmcloud fn action invoke hello --blocking --result --param name Ernese
ibmcloud fn action invoke hello --result --param name Ernese
ibmcloud fn action invoke hello
ibmcloud fn action invoke hello --param name Ernese
ibmcloud fn activation list
ibmcloud fn activation result <ID>
ibmcloud fn activation list
ibmcloud fn action delete hello
ibmcloud fn action list

ibmcloud fn action create hello hello.js --kind nodejs:10 --web=true

#curl https://us-south.functions.cloud.ibm.com/api/v1/namespaces/ernese%40sg.ibm.com_cloudnative-dev/actions/hello

curl -u 74476abb-312a-4226-9d7c-f1f0ae645255:2UuYA49AudKNkuRpSJWDYsBAiZ84jl8q4vYuLcZU1hzyQwoNTK33tPQMnp0cDbPj -X POST https://us-south.functions.cloud.ibm.com/api/v1/namespaces/ernese%40sg.ibm.com_cloudnative-dev/actions/hello?blocking=true | jq .

ibmcloud fn action list

npm install --save @sendgrid/mail

zip -r action.zip *

ibmcloud fn action create sendMail --kind nodejs:10 action.zip

ibmcloud fn action invoke sendMail -p manager 'Ernese Norelus' -p order 700000 --result --blocking

ibmcloud fn action delete sendMail

ibmcloud fn action create sendMail email.js --kind nodejs:10

ibmcloud fn action invoke sendMail -p manager 'Ernese Norelus' -p order 700000 --result --blocking



npm install

zip -r hello.zip *

ibmcloud fn action create hello --kind nodejs:10 hello.zip

ibmcloud fn action invoke hello --blocking --result --param name Ernese
########################3

# demo-1 (Actions)
ibmcloud login -a https://api.ng.bluemix.net --sso
ibmcloud target --cf

ibmcloud plugin install cloud-functions
ibmcloud plugin list

ibmcloud fn action create hello hello.js --kind nodejs:10
ibmcloud fn action list


ibmcloud fn action invoke hello
ibmcloud fn activation result 13606bb7c96a4469a06bb7c96ae46939

#ibmcloud fn action invoke hello --param name 'Ernese Norelus'
ibmcloud fn action invoke hello -r -b -p name 'Ernese Norelus'

ibmcloud fn action get hello parameters
ibmcloud fn action delete hello

ibmcloud fn action create hello hello.js --kind nodejs:10 --web=true
ibmcloud fn action invoke hello
ibmcloud fn activation result 28bc26f8de244853bc26f8de248853dc
ibmcloud fn activation result 59c89fb39cc64830889fb39cc6d830aa

ibmcloud fn action create hello hello.js --web=true
# how to get endpoint from the tool
#https://us-south.functions.cloud.ibm.com/api/v1/web/ernese%40sg.ibm.com_cloudnative-dev/default/hello.json
curl -u 74476abb-312a-4226-9d7c-f1f0ae645255:2UuYA49AudKNkuRpSJWDYsBAiZ84jl8q4vYuLcZU1hzyQwoNTK33tPQMnp0cDbPj -X POST https://us-south.functions.cloud.ibm.com/api/v1/namespaces/ernese%40sg.ibm.com_cloudnative-dev/actions/hello?blocking=true



# demo-2 (Exploring Packages)
ibmcloud fn package list /whisk.system
ibmcloud fn package get --summary /whisk.system/weather
ibmcloud fn package list
ibmcloud cf create-service weatherinsights Free-v2 myWeather
ibmcloud cf create-service-key myWeather myapp

ibmcloud fn package refresh

ibmcloud fn action invoke Bluemix_myWeather_myapp/forecast -r -p latitude 17.3 -p longitude 78.4 -p timePeriod current | jq .

# demo-3 (Exploring Sequences)
ibmcloud fn package get --summary /whisk.system/utils
ibmcloud fn action invoke --result /whisk.system/utils/split --param payload "The quick brown fox, \njumps over\nthe lazy dog."
ibmcloud fn action invoke --result /whisk.system/utils/split --param payload "The quick brown fox, \njumps over\nthe lazy dog." > lines.json
ibmcloud fn action invoke --result /whisk.system/utils/sort -P lines.json

ibmcloud fn action create sequenceAction --sequence /whisk.system/utils/split,/whisk.system/utils/sort

ibmcloud fn action invoke --result sequenceAction --param payload "quick brown fox, \njumps over\nthe lazy dog."

# demo-4 (Creatting database)
ibmcloud cf create-service cloudantNoSQLDB Lite salesdb 
ibmcloud cf service salesdb
ibmcloud cf create-service-key salesdb myapp

ibmcloud cf service-key salesdb myapp

# Create an instance of the Cloudant NoSQL Database and set your credentials by running the following commands:
# https://github.com/germanattanasio/openwhisk-textbot
ibmcloud cf create-service cloudantNoSQLDB Lite cloudant-openwhisk
ibmcloud cf create-service-key cloudant-openwhisk theKey
ibmcloud cf service-key cloudant-openwhisk theKey

export CLOUDANT="https://75749b9f-50c4-457c-8899-006321e721f2-bluemix:eaa923836dca157f928f0a365524b93b2d61a444b7cf8ccc0520bb3bb7d4e129@75749b9f-50c4-457c-8899-006321e721f2-bluemix.cloudantnosqldb.appdomain.cloud"

curl $CLOUDANT

curl -s -X GET $CLOUDANT | jq .
curl -s -X GET $CLOUDANT/_all_dbs | jq .
curl -s -X PUT $CLOUDANT/sales
curl -s -H "Content-type: application/json" -d "{\"name\":\"Ernese\"}" -X POST $CLOUDANT/sales 
curl -s -X GET $CLOUDANT/sales/_all_docs | jq .
#curl -s -X DELETE $CLOUDANT/sales/<DOC_ID>?rev=<REV> | jq .
curl -s -X DELETE $CLOUDANT/sales/ef2beb760b5d2e505d4761892f8851a2?rev=1-0efe330405bd3c2909b18b972ab12c38

ibmcloud fn package get --summary /whisk.system/cloudant
ibmcloud fn package refresh
ibmcloud fn package list

# Create T-A-R for Order
ibmcloud fn trigger create data-inserted-trigger --feed Bluemix_salesdb_myapp/changes -p dbname sales
ibmcloud fn action create order order.js --kind nodejs:10 
ibmcloud fn action invoke order -p manager 'Ernese Norelus' -p order 700000 --result --blocking
ibmcloud fn action create order-sequence --sequence Bluemix_salesdb_myapp/read,order
ibmcloud fn action list
ibmcloud fn rule create log-order data-inserted-trigger order-sequence
ibmcloud fn rule enable log-order

# open another window and run 
ibmcloud fn activation poll

curl -s -H "Content-type: application/json" -d "{\"order\":\"70000\",\"manager\":\"Ernese Norelus\"}" -X POST $CLOUDANT/sales 
ibmcloud fn activation list
ibmcloud fn activation result <ID>

ibmcloud fn action create high-value-order mail.js --kind nodejs:10
ibmcloud fn action invoke high-value-order -b -r -p order 10000 -p manager 'Ernese Norelus'
ibmcloud fn action create high-value-order-sequence --sequence Bluemix_salesdb_myapp/read,high-value-order
ibmcloud fn rule create log-high-value-order data-inserted-trigger high-value-order-sequence
ibmcloud fn rule enable log-high-value-order
curl -s -H "Content-type: application/json" -d "{\"order\":\"70000\",\"manager\":\"Ernese Norelus\"}" -X POST $CLOUDANT/sales 
ibmcloud fn activation list
ibmcloud fn activation result <ID>
curl -s -H "Content-type: application/json" -d "{\"order\":\"75000\",\"manager\":\"Esther Chen\"}" -X POST $CLOUDANT/sales 

########################3
# Working with OpenWhisk Triggers
ibmcloud fn trigger create ANameHere
ibmcloud fn trigger list
ibmcloud fn trigger fire ANameHere
ibmcloud fn trigger fire ANameHere --param somename somevalue

ibmcloud fn property get

ibmcloud fn property get --auth

wsk -i namespace list



#######################
mvn validate
mvn compile
mvn clean # target delete
mvn test # runs junit
mvn install

# https://maven.apache.org/guides/getting-started/maven-in-five-minutes.html
# https://github.com/pdurbin/maven-hello-world
# https://medium.com/@doh_88292/how-to-develop-functions-as-a-service-with-apache-openwhisk-996a9bf8716b
# https://mvnrepository.com/artifact/com.sendgrid/sendgrid-java/4.4.1
mvn archetype:generate \
 -DgroupId=com.ibm.example \
 -DartifactId=sendMail \
 -DarchetypeArtifactId=maven-archetype-quickstart \
 -Dversion=1.0-SNAPSHOT \
 -DinteractiveMode=false 
 
mvn install:install-file \
 -Dfile=/home/vagrant/artefacts/java/sendgrid-java.jar \
 -DgroupId=com.sendgrid \
 -DartifactId=java-http-client \
 -Dversion=4.4.1 \
 -Dpackaging=jar

mvn deploy:deploy-file \
 -Durl=file:////home/vagrant/artefacts/java/repo/ \
 -Dfile=/home/vagrant/artefacts/java/sendgrid-java.jar \
 -DgroupId=com.sendgrid \
 -DartifactId=java-http-client \
 -Dversion=4.4.1 \
 -Dpackaging=jar
 
#nano src/main/java/com/ibm/example/App.java

cp App.java ~/artefacts/java/sendMail/src/main/java/com/ibm/example/App.java
cp pom.xml.env ./sendMail/pom.xml
#cp manifest.mf ./sendMail/manifest.mf
cp manifest.mf ~/artefacts/java/sendMail/src/main/resources/manifest.mf
#${basedir}/lib/sendgrid-java.jar
mkdir -p ./sendMail/lib
cp sendgrid-java.jar ./sendMail/lib/

cd sendMail

nano pom.xml

#src/main/java/com/ibm/example

ADD_DEP="<dependency>
    <groupId>com.google.code.gson</groupId>
    <artifactId>gson</artifactId>
    <version>2.8.2</version>
  </dependency>
<!-- https://mvnrepository.com/artifact/com.sendgrid/sendgrid-java -->
<dependency>
    <groupId>com.sendgrid</groupId>
    <artifactId>sendgrid-java</artifactId>
    <version>4.4.1</version>
	<scope>system</scope>
  <systemPath>${basedir}/lib/sendgrid-java.jar</systemPath>
</dependency>
"

ADD_REP="<repositories>
    <repository>
        <id>project.local</id>
        <name>project</name>
        <url>file:////home/vagrant/artefacts/java/repo</url>
    </repository>
</repositories>
" 

sed -i "/\<dependencies>\//a $ADD_REP" pom2.xml

sed -i.bak "s/\<dependencies\>/a $ADD_REP/" pom2.xml

#mvn clean package

mvn clean dependency:copy-dependencies package

#mvn assembly:single

jar -cf sendMail.jar *.jar
# ibmcloud fn action list
# ibmcloud fn action delete helloJava9

java -jar ./target/sendMail-jar-with-dependencies.jar com.ibm.example.App
 #ibmcloud fn action create helloJava6 target/sendMail-1.0-SNAPSHOT.jar --main com.ibm.example.App --kind java 
 ibmcloud fn action create helloJava9 target/sendMail-jar-with-dependencies.jar --main com.ibm.example.App --kind java 
 ibmcloud fn action invoke helloJava9 --result --blocking --param from ernesen@icloud.com --param to ernese@sg.ibm.com --param file manifest.mf
 
# Serverless Java Functions with Quarkus and OpenWhisk
http://heidloff.net/article/serverless-java-quarkus-openwhisk

https://openwhisk.apache.org/documentation.html
https://github.com/serverless/serverless-openwhisk#writing-functions---java

######################## Java
mvn clean package
ibmcloud fn action create helloJava target/hello-world-1.0.jar --main HelloWorld --kind java
ibmcloud fn action invoke helloJava --result --blocking --param name ernese