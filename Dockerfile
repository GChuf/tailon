FROM golang:alpine as build

WORKDIR /tailon

ADD . .

RUN apk add --upgrade binutils

RUN cd /tailon && \
    go get
RUN go build -tags dev
RUN strip tailon

RUN apk del binutils

FROM alpine:latest

RUN apk add gawk grep sed

#COPY --from=build /tailon/tailon /usr/local/bin/tailon
COPY --from=build /tailon/tailon /tailon/tailon
COPY --from=build /tailon/frontend/ /tailon/frontend/

CMD        ["--help"]
#CMD ["tail", "-f", "/dev/null"]
WORKDIR /tailon
ENTRYPOINT ["./tailon"]
EXPOSE 8080
