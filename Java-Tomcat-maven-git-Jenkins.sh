#Java-maven-Git-Tomcat-Jenkins Configuration

#login to root
echo login to root
sudo -i

#install wget downloaded.
echo install wget downloaded.
 yum install wget -y
 

#===========================GIT INSTALLATION START===========================================

#Git Setup:
echo Git Setup:
#Git Installation
echo Git Installation
 yum install git -y

#GitHome: /usr/bin/git  ( find  /  -name "git" -- to search with command)
echo GitHome: /usr/bin/git  ( find  /  -name "git" -- to search with command)

#Git Version
echo Git Version
git --version


#===========================GIT INSTALLATION END========================================================


#===========================JAVA INSTALLATION START==========================================

#JAVA Setup
echo JAVA Setup

sudo yum install -y java-1.8.0-openjdk-devel # you can choose any methond to install JAVA but make sure you setup the JDK path, other wise builds will be failed with compilation errors.

find / -name "tools*" # find the JDK path where the <JDKpath>/libs/tools.jar is available, copy the <JDKpath>

echo' Maual step
export JAVA_HOME=<JDKpath>

# ex: export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.242.b08-0.el8_1.x86_64
'
export PATH=$JAVA_HOME/bin:$PATH

java -version

#Java Home path: /usr/java/jdk1.8.0_131
echo Java Home path: $JAVA_HOME

#===========================JAVA INSTALLATION END=========================================

#===========================MAVEN SETUP START========================================================

#Maven Setup:
echo Maven Setup:

export MAVEN_VERSION=3.6.3
#Download maven:
echo Download maven:
 wget http://mirror.cogentco.com/pub/apache/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz

#Unzip tar file
echo Unzip tar file
 tar zxpvf apache-maven-${MAVEN_VERSION}-bin.tar.gz

#maven home path depedns on the user: here we are running from root user. /home/ec2-user/apache-maven-${MAVEN_VERSION}
echo maven home: /root/apache-maven-${MAVEN_VERSION}

#Setup Maven
export MAVEN_HOME=/root/apache-maven-${MAVEN_VERSION}

export M3=$MAVEN_HOME/bin

export PATH=$M3:$PATH

#check maven: mvn -v
echo check maven: mvn -v
mvn -v

#vi /root/apache-maven-3.5.4/conf/settings.xml: update this settings file with below nexus credentials.
echo'
	<server>
		<id>deployment</id>
		<username>deployment</username>
		<password>deployment123</password>
	</server>
'

#===========================MAVEN SETUP END========================================================

#===========================TOMCAT SETUP START========================================================

#Tomcat Setup:
echo Tomcat Setup:
export TOMCAT_VERSION=7.0.103 # Everytime you setup this tomcat, verify this URL to get the latest version - http://ftp.cixug.es/apache/tomcat/tomcat-7/

#Download Tomcat
echo Download Tomcat
wget http://ftp.cixug.es/apache/tomcat/tomcat-7/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz

#Unzip tar file
echo Unzip tar file
tar zxpvf apache-tomcat-${TOMCAT_VERSION}.tar.gz

#Move to folder
echo Move to folder
mv apache-tomcat-${TOMCAT_VERSION} tomcat7

#Update tomcat-users.xml file: vi tomcat7/conf/tomcat-users.xml
echo'
<role rolename="manager-gui"/>
<user username="tomcat" password="s3cret" roles="manager-gui"/>
'

#Check whether its updated properly or not: cat tomcat7/conf/tomcat-users.xml

#Startup the server: ./tomcat7/bin/startup.sh
#Shutdown the server: ./tomcat7/bin/shutdown.sh

#Startup the tomcat server and then launch the URL in any browser: http://<PublicIP>:8080

#===========================TOMCAT SETUP END=================================================


#===========================JENKINS SETUP START=================================================

#Jenkins Setup:
echo Jenkins Setup:

#Download Jenkins
echo Download Jenkins
wget http://updates.jenkins-ci.org/download/war/2.230/jenkins.war

#Deploy war to tomcat
echo Deploy war to tomcat
mv jenkins.war tomcat7/webapps/

#Restart the server if required.
#Shutdown the server: ./tomcat7/bin/shutdown.sh
#Startup the server: ./tomcat7/bin/startup.sh

#launch the tomcat URL and start jenkins.
#Access the URL: http://publicIP:8080/ in browser

#Login to "Manager webapp" --> click on "jenkins" --> http://18.218.88.137:8088/jenkins/

#While Jenkins is starting up, it will ask you to enter pwd from the below location.

#Run the command: cat /root/.jenkins/secrets/initialAdminPassword

#Copy the pwd and paste it on jenkins.

#Install plugins (first option)

#Uname/pwd/email setup OR continue as admin. Recommend to signup & continue as user.

#Manage Jenkins --> Global Tool Configuration 

#--> Add JDK home path : 
#		Name: jdk1.8.0_181
#		Path: /usr/java/jdk1.8.0_181-amd64
#--> Add Git home path :  
#		Name: GitExePath
#		Path: /usr/bin/git
#--> Add Mvn home path :  
#		Name: maven-3.5.4
#		Path: /root/apache-maven-3.5.4


#===========================JENKINS SETUP END=================================================
