FROM golang:1.24-alpine AS builder
WORKDIR /app
COPY . .
RUN go build -o /parcel-tracker

FROM alpine:latest
RUN apk add --no-cache sqlite
COPY --from=builder /parcel-tracker /parcel-tracker
COPY tracker.db /data/  # Копируем базу с таблицей
WORKDIR /data
CMD ["/parcel-tracker"]
