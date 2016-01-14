FROM paterczm/docker-fedora20-jbossas7
MAINTAINER Luan Cestari <lcestari@redhat.com>

ENV LIGHTBLUE_VERSION_MAJOR 1
ENV LIGHTBLUE_VERSION_MINOR 10
ENV LIGHTBLUE_VERSION_MICRO 0
ENV LIGHTBLUE_VERSION $LIGHTBLUE_VERSION_MAJOR.$LIGHTBLUE_VERSION_MINOR.$LIGHTBLUE_VERSION_MICRO
ENV JBOSS_HOME=/opt/jbossas7

RUN curl -o $JBOSS_HOME/standalone/deployments/crud.war https://repo1.maven.org/maven2/com/redhat/lightblue/rest/lightblue-rest-crud/$LIGHTBLUE_VERSION/lightblue-rest-crud-$LIGHTBLUE_VERSION.war
RUN curl -o $JBOSS_HOME/standalone/deployments/metadata.war https://repo1.maven.org/maven2/com/redhat/lightblue/rest/lightblue-rest-metadata/$LIGHTBLUE_VERSION/lightblue-rest-metadata-$LIGHTBLUE_VERSION.war
RUN mkdir -p $JBOSS_HOME/modules/com/redhat/lightblue/main

ADD lightblue_config $JBOSS_HOME/modules/com/redhat/lightblue/main/

#the image based already start the JBOSS, so I'm shut it down to the changes take place
#RUN pkill -9 java
