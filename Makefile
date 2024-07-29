VERSION ?= 0.0.0
HELM_UNITTEST_VERSION ?= 0.3.3
REPOSITORY ?= amsterdam

UID:=$(shell id --user)
GID:=$(shell id --group)

CHARTS_DIR ?= charts

clean:
	rm -rf *.tgz

docs:
	npm install @bitnami/readme-generator-for-helm@2.5.0 ./node_modules/.bin/readme-generator readme-generator \
                -v values.docs.yaml \
                -r README.md

build: clean
        @for chart in $(wildcard ${CHARTS_DIR}/*); do \
                helm package $$chart --version ${VERSION}; \
        done

push: build
        @for chart in $(wildcard ${CHARTS_DIR}/*); do \
                helm push ./$$chart-${VERSION}.tgz oci://${REGISTRY}/${REPOSITORY}; \
        done

helm-unittest-plugin:
	helm plugin list unittest | grep "${HELM_UNITTEST_VERSION}" || ( helm plugin remove unittest; helm plugin install https://github.com/helm-unittest/helm-unittest --version ${HELM_UNITTEST_VERSION} )

lint:
	helm lint

test: lint helm-unittest-plugin
	@for chart in $(wildcard ${CHARTS_DIR}/*); do \
		helm unittest $$chart --debug; \
	done
