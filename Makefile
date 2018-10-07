# Copyright 2018 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

GOOGLE_CLOUD_PROJECT ?= $(shell gcloud config list --format 'value(core.project)')
PORT ?= 8080
IMAGE_NAME ?= golang-docker-helloworld
IMAGE_TAG ?= latest
IMAGE ?= gcr.io/${GOOGLE_CLOUD_PROJECT}/${IMAGE_NAME}:${IMAGE_TAG}

.PHONY: all build compile local-build local-push local-run

all: build

build:
	gcloud builds submit --tag ${IMAGE}

compile:
	go build -o helloworld

local-build:
	docker build --tag ${IMAGE} .

local-push:
	docker push ${IMAGE}

local-run:
	docker run --rm -p ${PORT}:8080 ${IMAGE}
