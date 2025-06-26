# Этап сборки
FROM golang:1.21-alpine AS builder
WORKDIR /app
COPY . .
RUN go build -o parcel-tracker .

# Этап запуска
FROM alpine:latest
WORKDIR /app
COPY --from=builder /app/parcel-tracker .
COPY --from=builder /app/tracker.db .
CMD ["./parcel-tracker"]
