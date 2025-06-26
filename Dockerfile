FROM golang:1.24-alpine AS builder
WORKDIR /app
COPY . .
RUN go build -o /parcel-tracker

FROM alpine:latest
RUN apk add --no-cache sqlite
COPY --from=builder /parcel-tracker /parcel-tracker
CMD ["sh", "-c", "sqlite3 /data/tracker.db 'CREATE TABLE IF NOT EXISTS parcel(number INTEGER PRIMARY KEY AUTOINCREMENT, client INTEGER NOT NULL, status TEXT NOT NULL, address TEXT NOT NULL, created_at TEXT NOT NULL)' && /parcel-tracker"]
