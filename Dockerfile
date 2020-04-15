FROM openshift/origin-release:golang-1.13 as build

COPY . /go/src/github.com/square/ghostunnel

RUN CGO_ENABLED=0 go build -tags nopkcs11 -o /usr/bin/ghostunnel github.com/square/ghostunnel

FROM openshift/origin-base

COPY --from=build /usr/bin/ghostunnel /usr/bin/ghostunnel

ENTRYPOINT ["/usr/bin/ghostunnel"]
