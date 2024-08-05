from golang:1.15-alpine3.12 AS gobuilder-stage

maintainer kevin.lee <hylee@dshub.cloud>
label = "purpose"="Service Deployment using Multi-stage builds."

workdir /usr/src/goapp

copy goapp.go .

run CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o /usr/local/bin/gostart

from scratch as runtime-stage

copy --from=gobuilder-state /usr/local/bin/gostart /usr/local/bin/gostart

cmd ["/usr/local/bin/gostart"]
