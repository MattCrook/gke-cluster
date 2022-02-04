FROM golang:1.17.6-alpine3.15

WORKDIR /usr/src/api

COPY go.mod .
COPY go.sum .

RUN go mod download

COPY . .

RUN go build -o ./todolist.go


# ENTRYPOINT go build && ./todolist.go
