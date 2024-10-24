FROM golang:1.23.2 AS build

WORKDIR /app
RUN apt-get update && apt-get install -y unzip curl

# protoc by arch
ARG TARGETPLATFORM
RUN if [ "${TARGETPLATFORM}" = "linux/arm64" ]; then \
      curl -OL https://github.com/protocolbuffers/protobuf/releases/latest/download/protoc-28.3-linux-aarch_64.zip && \
      unzip protoc-28.3-linux-aarch_64.zip -d /usr/local && \
      rm protoc-28.3-linux-aarch_64.zip; \
    elif [ "${TARGETPLATFORM}" = "linux/amd64" ]; then \
      curl -OL https://github.com/protocolbuffers/protobuf/releases/latest/download/protoc-28.3-linux-x86_64.zip && \
      unzip protoc-28.3-linux-x86_64.zip -d /usr/local && \
      rm protoc-28.3-linux-x86_64.zip; \
    else \
      echo "Unsupported platform: ${TARGETPLATFORM}"; exit 1; \
    fi

# plugins
RUN go install google.golang.org/protobuf/cmd/protoc-gen-go@v1.35.1 && \
    go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@v1.5.1

ENV PATH="$PATH:/go/bin"

CMD ["protoc", "--version"]
