# syntax=docker/dockerfile:1
# Dockerfile for combining multiple services
FROM ubuntu:latest
RUN apt-get install -y supervisor wget

# Node Exporter
RUN wget https://github.com/prometheus/node_exporter/releases/download/v1.7.0/node_exporter-1.7.0.linux-amd64.tar.gz
RUN tar -xzf node_exporter-1.7.0.linux-amd64.tar.gz
RUN mv node_exporter-*/node_exporter /bin

# Elasticsearch Exporter
RUN wget https://github.com/prometheus-community/elasticsearch_exporter/releases/download/v1.7.0/elasticsearch_exporter-1.7.0.linux-amd64.tar.gz
RUN tar -xzf elasticsearch_exporter-1.7.0.linux-amd64.tar.gz
RUN mv elasticsearch_exporter-*/elasticsearch_exporter /bin

# Copy supervisord configuration file
COPY supervisord.conf /etc/supervisor/conf.d/

EXPOSE 3000/tcp

# Start supervisord
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]