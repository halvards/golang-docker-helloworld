# Copyright 2018 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

FROM golang:1.11-alpine as build

COPY . $GOPATH/src/github.com/halvards/golang-docker-helloworld/
WORKDIR $GOPATH/src/github.com/halvards/golang-docker-helloworld/

RUN adduser -D -g '' helloworld && \
    go get -d -v && \
    CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -a -installsuffix cgo -ldflags="-w -s" -o /go/bin/helloworld

FROM scratch

COPY --from=build /etc/passwd /etc/passwd
COPY --from=build /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt

COPY --from=build /go/bin/helloworld /go/bin/helloworld

USER helloworld

ENTRYPOINT ["/go/bin/helloworld"]
