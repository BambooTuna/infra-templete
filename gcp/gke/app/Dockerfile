FROM golang:1.15 as builder

ENV PORT 8080

ENV CGO_ENABLED=0
ENV GOOS=linux
ENV GOARCH=amd64

WORKDIR /go/src/application
COPY . .
RUN make setup && make build
#EXPOSE ${PORT}
#ENTRYPOINT ["/go/src/application/bin/server"]

FROM scratch
# 軽量のalpineには必要ファイルがないため注意
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
COPY --from=builder /usr/share/zoneinfo /usr/share/zoneinfo
COPY --from=builder /go/src/application/bin/server /app
EXPOSE ${PORT}
ENTRYPOINT ["/app"]
