# Stage 1: Build
FROM golang:1.26-alpine AS builder

WORKDIR /app

# separate dependency cache layer
COPY go.mod go.sum ./  

RUN go mod download

COPY main.go ./
COPY database ./database
COPY handlers ./handlers
COPY models ./models

RUN CGO_ENABLED=0 GOOS=linux go build -o skillpulse .

# Stage 2: Run
FROM alpine:3.23

RUN apk --no-cache add ca-certificates

WORKDIR /app

COPY --from=builder /app/skillpulse .

EXPOSE 8080

CMD ["./skillpulse"]
