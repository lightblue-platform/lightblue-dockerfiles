FROM docker-registry.usersys.redhat.com/goldmann/jboss-eap:6.3
MAINTAINER Luan Cestari <lcestari@redhat.com> 

ENV LIGHTBLUE_VERSION_MAJOR 1
ENV LIGHTBLUE_VERSION_MINOR 0
ENV LIGHTBLUE_VERSION_MICRO 1
ENV LIGHTBLUE_VERSION $LIGHTBLUE_VERSION_MAJOR.$LIGHTBLUE_VERSION_MINOR.$LIGHTBLUE_VERSION_MICRO

RUN curl -o crud.war      https://repo1.maven.org/maven2/com/redhat/lightblue/rest/rest-crud/$LIGHTBLUE_VERSION/rest-crud-$LIGHTBLUE_VERSION.war         && mv crud.war $JBOSS_HOME/standalone/deployments/
RUN curl -o metadata.war  https://repo1.maven.org/maven2/com/redhat/lightblue/rest/rest-metadata/$LIGHTBLUE_VERSION/rest-metadata-$LIGHTBLUE_VERSION.war && mv metadata.war $JBOSS_HOME/standalone/deployments/
RUN mkdir -p $JBOSS_HOME/modules/com/redhat/lightblue/main

ADD lightblue_config $JBOSS_HOME/modules/com/redhat/lightblue/main/

#the image based already start the JBOSS, so I'm shut it down to the changes take place
#RUN pkill -9 java
