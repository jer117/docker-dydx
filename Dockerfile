FROM alpine:edge

# renovate: datasource=github-releases versioning=docker depName=dydxprotocol/v4-chain
ARG VERSION=v2.0.0

# Fetch dYdX binary
RUN apk add --no-cache --update --virtual .build-deps curl && \
    apk add --update ca-certificates && \
    mkdir -p /dydx && \
    curl -sSL -o "dydxprotocold-${VERSION}-linux-amd64.tar.gz" \
        https://github.com/dydxprotocol/v4-chain/releases/download/protocol%2F${VERSION}/dydxprotocold-${VERSION}-linux-amd64.tar.gz && \
    tar -C / -xzf "dydxprotocold-${VERSION}-linux-amd64.tar.gz" && \
    mv "/build/dydxprotocold-${VERSION}-linux-amd64" \
        /usr/local/bin/dydxprotocold && \
    rm -f "dydxprotocold-${VERSION}-linux-amd64.tar.gz" && \
    rm -rf /build/ && \
    apk del .build-deps

# Run dydxprotocold by default
CMD ["/usr/local/bin/dydxprotocold"]
