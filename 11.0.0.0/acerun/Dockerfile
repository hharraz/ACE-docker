# © Copyright IBM Corporation 2018.
#
# All rights reserved. This program and the accompanying materials
# are made available under the terms of the Eclipse Public License v1.0
# which accompanies this distribution, and is available at
# http://www.eclipse.org/legal/epl-v10.html

FROM acev11base

LABEL maintainer "Hany Harraz <h.harraz@gmail.com>"

LABEL "ProductID"="447aefb5fd1342d5b893f3934dfded77" \
      "ProductName"="IBM App Connect Enterprise" \
      "ProductVersion"="11.0.0.0"

# Copy in script files
#COPY *.sh /usr/local/bin/
COPY ace_manage.sh /usr/local/bin/
COPY ace-license-check.sh /usr/local/bin/
COPY ace_env.sh /usr/local/bin/
#COPY ./bars/*.bar /tmp/bars
RUN chmod +rx /usr/local/bin/*.sh

# Set BASH_ENV to source mqsiprofile when using docker exec bash -c
ENV BASH_ENV=/usr/local/bin/ace_env.sh
ENV MQSI_MQTT_LOCAL_HOSTNAME=127.0.0.1
ENV ODBCINI=/opt/ibm/ace-11.0.0.0//server/ODBC/unixodbc/odbc.ini

# Expose default admin port, http port and Web user interface
EXPOSE 7800 7600

#USER iibuser

# Set entrypoint to run management script
ENTRYPOINT ["ace_manage.sh"]
