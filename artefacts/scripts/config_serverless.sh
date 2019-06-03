#!/bin/sh

#sudo apt-get update && sudo apt-get upgrade -y

# install github
sudo apt-get install git -y

# jq is a sed-like tool that is specifically built to deal with JSON format.
sudo apt-get install jq -y

sudo apt-get install httpie -y

sudo apt-get install gcc g++ make -y 

sudo apt-get install zip -y

# install nodejs
sudo apt-get install curl python-software-properties -y
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -

sudo apt-get install nodejs -y

curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt-get update && sudo apt-get install yarn -y

# Installing the stand-alone IBM Cloud CLI
curl -fsSL https://clis.cloud.ibm.com/install/linux | sh

#cd ~/artefacts/demo/

# download the binary of OpenWhisk CLI
wget https://github.com/apache/incubator-openwhisk-cli/releases/download/0.10.0-incubating/OpenWhisk_CLI-0.10.0-incubating-linux-386.tgz

tar -xzf OpenWhisk_CLI-0.10.0-incubating-linux-386.tgz

sudo mv wsk /usr/local/bin/wsk

# cd ~/artefacts/nodejs/

sudo chown -R $USER:$(id -gn $USER) /home/vagrant/.config
sudo npm install serverless -g

#Installing pip for Python 3
sudo apt-get install -y  python3 python3-pip
sudo pip3 install virtualenv -y 

sudo pip3 install sendgrid -y

# install docker
curl -sSL https://get.docker.com | sh
sudo usermod -aG docker $USER

#cp /vagrant/jdk-8u211-linux-x64.tar.gz .
sudo mkdir -p /opt/java
sudo tar -xvf jdk-8u211-linux-x64.tar.gz  -C /opt/java

echo "JAVA_HOME=/opt/java/jdk1.8.0_211" | sudo tee -a /etc/profile
echo "PATH=$PATH:$HOME/bin:$JAVA_HOME/bin" | sudo tee -a /etc/profile
echo "export JAVA_HOME" | sudo tee -a /etc/profile
echo "export PATH" | sudo tee -a /etc/profile

sudo update-alternatives --install "/usr/bin/java" "java" "/opt/java/jdk1.8.0_211/bin/java" 1
sudo update-alternatives --install "/usr/bin/javac" "javac" "/opt/java/jdk1.8.0_211/bin/javac" 1
sudo update-alternatives --install "/usr/bin/javaws" "javaws" "/opt/java/jdk1.8.0_211/bin/javaws" 1

sudo update-alternatives --set java /opt/java/jdk1.8.0_211/bin/java
sudo update-alternatives --set javac /opt/java/jdk1.8.0_211/bin/javac
sudo update-alternatives --set javaws /opt/java/jdk1.8.0_211/bin/javaws


# install and configure Maven with the steps below.
sudo apt install maven -y

sudo apt update -y

sudo wget https://www-us.apache.org/dist/maven/maven-3/3.6.0/binaries/apache-maven-3.6.0-bin.tar.gz -P /tmp

sudo tar xf /tmp/apache-maven-3.6.0-bin.tar.gz -C /opt

sudo ln -s /opt/apache-maven-3.6.0 /opt/maven

echo "export JAVA_HOME=/opt/java/jdk1.8.0_211" | sudo tee -a /etc/profile.d/mavenenv.sh
echo "export M2_HOME=/opt/maven" | sudo tee -a /etc/profile.d/mavenenv.sh
echo "export MAVEN_HOME=/opt/maven" | sudo tee -a /etc/profile.d/mavenenv.sh
echo "export PATH=${M2_HOME}/bin:${PATH}" | sudo tee -a /etc/profile.d/mavenenv.sh

sudo chmod +x /etc/profile.d/mavenenv.sh

echo "source /etc/profile.d/mavenenv.sh" | sudo tee -a  ~/.bashrc



#apt-cache search openjdk