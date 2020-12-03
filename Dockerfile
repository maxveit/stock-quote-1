#       Copyright 2017-2020 IBM Corp All Rights Reserved

#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at

#       http://www.apache.org/licenses/LICENSE-2.0

#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.

#FROM maven:3.6-jdk-11-slim AS build
#COPY . /usr/
#RUN mvn -f /usr/pom.xml clean package

FROM openliberty/open-liberty:kernel-java11-openj9-ubi

# Following line is a workaround for an issue where sometimes the server somehow loads the built-in server.xml,
# rather than the one I copy into the image.  That shouldn't be possible, but alas, it appears to be some Docker bug.
RUN rm /opt/ol/wlp/usr/servers/defaultServer/server.xml

USER root
COPY src/main/liberty/config /opt/ol/wlp/usr/servers/defaultServer/
#COPY --from=build /usr/target/stock-quote-1.0-SNAPSHOT.war /opt/ol/wlp/usr/servers/defaultServer/apps/StockQuote.war
COPY target/stock-quote-1.0-SNAPSHOT.war /opt/ol/wlp/usr/servers/defaultServer/apps/StockQuote.war
RUN chown -R 1001:0 config/
USER 1001
RUN configure.sh
