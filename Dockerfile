FROM golang:alpine as build
ADD . /go/src/github.com/gvalkov/tailon/
RUN apk add --upgrade git upx binutils
RUN cd /go/src/github.com/gvalkov/tailon && go get && go build && strip tailon && upx tailon

FROM alpine:3.7
WORKDIR /tailon
COPY . /usr/local/bin/tailon

CMD        ["--help"]
ENTRYPOINT ["/usr/local/bin/tailon"]
EXPOSE 8080
