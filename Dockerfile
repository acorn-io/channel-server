FROM golang:1.18 as src
RUN git clone --depth 1 https://github.com/rancher/channelserver
WORKDIR channelserver
RUN git checkout cdef874cc406bdffbd67abe8067e0f76e950c20a
RUN CGO_ENABLED=0 go build -o /channelserver -ldflags "-s -w" .

FROM gcr.io/distroless/static-debian11
COPY --from=src /channelserver /usr/bin/channelserver
CMD ["/usr/bin/channelserver"]
