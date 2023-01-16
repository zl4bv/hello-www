FROM golang:1.19 AS builder

ENV CGO_ENABLED=0
ENV USER=appuser
ENV UID=10001

WORKDIR /usr/src/app

COPY go.mod ./
RUN go mod download && go mod verify

COPY . .
RUN go build -ldflags="-w -s -extldflags '-static'" -o hello-www .

RUN adduser \    
    --disabled-password \    
    --gecos "" \    
    --home "/nonexistent" \    
    --shell "/sbin/nologin" \    
    --no-create-home \    
    --uid "${UID}" \    
    "${USER}"

FROM scratch

COPY --from=builder /etc/passwd /etc/passwd
COPY --from=builder /etc/group /etc/group
COPY --from=builder /usr/src/app/hello-www /hello-www

EXPOSE 8080
USER ${APPUSER}:${APPUSER}
ENTRYPOINT ["/hello-www"]
