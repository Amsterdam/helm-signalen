VERSION ?= 0.0.0
HELM_UNITTEST_VERSION ?= 0.3.3
REPOSITORY ?= amsterdam

UID:=$(shell id --user)
GID:=$(shell id --group)

CHARTS_DIR ?= charts

clean:
	echo clean

docs:
	npm install @bitnami/readme-generator-for-helm@2.5.0 ./node_modules/.bin/readme-generator readme-generator \
                -v values.docs.yaml \
                -r README.md

build: clean
	@for chart in $(wildcard ${CHARTS_DIR}/*); do \
		echo $$chart; \
		helm dependency update $$chart; \
		helm package $$chart --version ${VERSION}; \
	done ;\
	find ${BUILD_REPOSITORY_LOCALPATH} -iname \*.tgz -exec chmod 666 {} +;

push: build
	@for mychart in $(shell ls -1 ${CHARTS_DIR}); do \
		echo "MyChart: " $${mychart}
	done; \
	helm push "${BUILD_REPOSITORY_LOCALPATH}/frontend-${VERSION}.tgz" oci://${REGISTRY}/${REPOSITORY}; \
	helm push "${BUILD_REPOSITORY_LOCALPATH}/backend-${VERSION}.tgz" oci://${REGISTRY}/${REPOSITORY}; \
	helm push "${BUILD_REPOSITORY_LOCALPATH}/classification-${VERSION}.tgz" oci://${REGISTRY}/${REPOSITORY}; \
	helm push "${BUILD_REPOSITORY_LOCALPATH}/mapserver-${VERSION}.tgz" oci://${REGISTRY}/${REPOSITORY}; \

helm-unittest-plugin:
	echo heml-unittest

lint:
	echo lint
test: lint helm-unittest-plugin
	echo unittest
