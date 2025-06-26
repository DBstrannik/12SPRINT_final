FROM golang:1.24-alpine AS builder
WORKDIR /app
COPY . .
RUN go build -o /parcel-tracker

FROM alpine:latest
COPY --from=builder /parcel-tracker /parcel-tracker
CMD ["/parcel-tracker"]
