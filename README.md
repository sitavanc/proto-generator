# How to use?

The main purpose of **proto-generator** tool is to provide data structure and gRPC client/server generation for Go, ensuring a consistent version of the generated files across the dev team.

Tool supports both ARM and AMD platform.

Usage:

```bash
docker run --rm -v $(pwd):/app proto-generator protoc --go_out=. --go_opt=paths=source_relative --go-grpc_out=. --go-grpc_opt=paths=source_relative ./**/*.proto
```
