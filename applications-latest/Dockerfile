FROM paterczm/docker-fedora20-jbossas7
MAINTAINER Marek Paterczyk <paterczm@users.noreply.github.com>

ENV METADATA_APP_VERSION 1.2.0-SNAPSHOT
ENV DATA_APP_VERSION 1.2.0-SNAPSHOT
ENV JBOSS_HOME=/opt/jbossas7

RUN curl -o $JBOSS_HOME/standalone/deployments/metadata.war $(curl https://oss.sonatype.org/content/repositories/snapshots/com/redhat/lightblue/applications/lightblue-applications-metadata-mgmt/$METADATA_APP_VERSION/ | grep -o -E "https://.*?war\"" | sed s/\"//)
RUN curl -o $JBOSS_HOME/standalone/deployments/data.war $(curl https://oss.sonatype.org/content/repositories/snapshots/com/redhat/lightblue/applications/lightblue-applications-data-mgmt/$DATA_APP_VERSION/ | grep -o -E "https://.*?war\"" | sed s/\"//)

RUN mkdir -p $JBOSS_HOME/modules/com/redhat/lightblue/main
ADD lightblue_config $JBOSS_HOME/modules/com/redhat/lightblue/main/
