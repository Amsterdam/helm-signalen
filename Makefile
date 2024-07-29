VERSION ?= 0.0.0
HELM_UNITTEST_VERSION ?= 0.3.3
REPOSITORY ?= amsterdam

UID:=$(shell id --user)
GID:=$(shell id --group)
PWD:=$(shell pwd)

CHARTS_DIR ?= charts

clean:
	pwd

docs:
	npm install @bitnami/readme-generator-for-helm@2.5.0 ./node_modules/.bin/readme-generator readme-generator \
                -v values.docs.yaml \
                -r README.md

build: clean
	@for chart in $(wildcard ${CHARTS_DIR}/*); do \
		echo $$chart; \
		helm dependency update $$chart; \
		helm package $$chart --version ${VERSION}; \
	done

push: build
	find . ;\
	@for chart in $(wildcard ${CHARTS_DIR}/*); do \
		helm push ./$(PWD)/$$chart-${VERSION}.tgz oci://${REGISTRY}/${REPOSITORY}; \
	done

helm-unittest-plugin:
	pwd

lint:
	pwd

test: lint helm-unittest-plugin
	pwd
