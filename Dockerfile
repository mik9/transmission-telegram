FROM golang:alpine AS builder
RUN apk add --no-cache git
WORKDIR /go/src/transmission-telegram
COPY . .
RUN go get -v ./...
RUN go install -v ./...

#final stage
FROM alpine:latest
RUN apk --no-cache add ca-certificates
COPY --from=builder /go/bin/transmission-telegram /app

ENTRYPOINT ["/app"]
