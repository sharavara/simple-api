FROM golang:1.15.6-alpine3.13 as builder

COPY go.mod go.sum /go/src/sharavara/simple-api/
WORKDIR /go/src/sharavara/simple-api
RUN go mod download
COPY . /go/src/sharavara/simple-api
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o build/main sharavara/simple-api


FROM alpine:3.13

RUN apk add --no-cache ca-certificates && update-ca-certificates
COPY --from=builder /go/src/sharavara/simple-api/build/main /usr/bin/main

ENV VERSION=$VERSION
ENV POSTGRES_USER="cats"
ENV POSTGRES_PASSWORD="12345678"
ENV POSTGRES_DB="cats"
ENV POSTGRES_HOST="scorpion.local"
ENV POSTGRES_PORT="5432"

EXPOSE 8080

ENTRYPOINT ["/usr/bin/main"]
