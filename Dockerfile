FROM golang:1.24-alpine AS builder
WORKDIR /app
COPY . .
RUN go build -o parcel-tracker .

FROM alpine:latest
WORKDIR /app
COPY --from=builder /app/parcel-tracker .
COPY tracker.db .
CMD ["./parcel-tracker"]