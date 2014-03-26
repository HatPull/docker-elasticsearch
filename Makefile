ELASTIC_TAG_NAME ?= xela7/hatpull-elasticsearch
ELASTIC_CONTAINER_NAME ?= elasticsearch

ELASTIC_BASE_PATH := $(abspath $(lastword $(MAKEFILE_LIST)))
ELASTIC_BASE_DIR := $(abspath $(patsubst %/,%,$(dir $(ELASTIC_BASE_PATH))))

#All names should be prefixed with elastic
elastic-build:
	cd ${ELASTIC_BASE_DIR} && docker build -t ${ELASTIC_TAG_NAME} .

elastic-clean: elastic-stop
	-@docker rm ${ELASTIC_CONTAINER_NAME} 2>/dev/null || true

elastic-run: elastic-clean
	sudo mkdir -p /opt/data/elasticsearch
	docker run -d --name ${ELASTIC_CONTAINER_NAME} -p ${ELASTICSEARCH_PORT}:9200 -v /opt/data/elasticsearch:/var/lib/elasticsearch ${ELASTIC_TAG_NAME}

elastic-stop:
	-@docker stop ${ELASTIC_CONTAINER_NAME} 2>/dev/null || true