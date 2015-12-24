FROM java:8

RUN curl -o /usr/local/bin/docker https://get.docker.com/builds/Linux/x86_64/docker-1.8.2
RUN chmod +x /usr/local/bin/docker
RUN curl -o /usr/local/bin/docker-compose https://github.com/docker/compose/releases/download/1.4.0/docker-compose-Linux-x86_64
RUN chmod +x /usr/local/bin/docker-compose
RUN groupadd docker

RUN apt-get update
RUN apt-get install -y unzip iptables lxc fontconfig

ENV LANG       en_US.UTF-8
ENV LC_ALL     en_US.UTF-8

EXPOSE 9090

VOLUME /var/lib/docker
VOLUME /data

# Install sbt and node.js build repositories
RUN echo "deb https://dl.bintray.com/sbt/debian /" | sudo tee -a /etc/apt/sources.list.d/sbt.list
RUN apt-add-repository ppa:chris-lea/node.js
RUN sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 642AC823
RUN apt-get update

# Install node / sbt environment
RUN apt-get install -y nodejs git sbt
RUN npm install -g bower grunt-cli

ADD service /etc/service
