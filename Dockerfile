FROM tomgruner/globallometree-ubuntu-base

MAINTAINER Thomas Gruner "tom.gruner@gmail.com"

# elasticsearch
RUN curl http://packages.elasticsearch.org/GPG-KEY-elasticsearch | apt-key add -
RUN echo "deb http://packages.elasticsearch.org/elasticsearch/1.0/debian stable main" >> /etc/apt/sources.list
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y openjdk-6-jre elasticsearch

ADD startup.sh /home/docker/startup.sh
RUN chmod +x /home/docker/startup.sh
CMD ["/home/docker/startup.sh"]
