# Etherpad-Lite Dockerfile
#
# https://github.com/ether/etherpad-docker
#
# Developed from a version by Evan Hazlett at https://github.com/arcus-io/docker-etherpad 
#
# Version 1.0

# Use Docker's nodejs, which is based on ubuntu
FROM iojs
MAINTAINER John E. Arnold, iohannes.eduardus.arnold@gmail.com

# Get Etherpad-lite's other dependencies
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y gzip git-core curl python libssl-dev pkg-config build-essential 
RUN npm install -g forever

# Grab the latest Git version
RUN cd /opt && git clone git://github.com/ether/etherpad-lite.git etherpad
WORKDIR /opt/etherpad
RUN git checkout development
RUN make

# Install node dependencies
RUN /opt/etherpad/bin/installDeps.sh

EXPOSE 9001
CMD ["forever", "-c", "/etc/supervisor/supervisor.conf", "-n"]
