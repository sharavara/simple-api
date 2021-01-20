# simple-api

Simple REST API for tests purposes

## Docker build

```bash
make build
make push
```

## Run container

```bash
docker run --rm -it \
    -e POSTGRES_USER=cats \
    -e POSTGRES_PASSWORD=12345678 \
    -e POSTGRES_DB=cats \
    -e POSTGRES_HOST=192.168.1.115 \
    -e POSTGRES_PORT=5432 \
    -p 8080:8080 \
    vincentvega/simple-api:dev
```

## Migrations

```bash
export POSTGRESQL_URL="postgres://$POSTGRES_USER:$POSTGRES_PASSWORD@$POSTGRES_HOST:$POSTGRES_PORT/$POSTGRES_DB?sslmode=disable"
migrate -database ${POSTGRESQL_URL} -path db/migrations up
```

```bash
export POSTGRESQL_URL="postgres://cats:12345678@localhost:5432/cats?sslmode=disable"
migrate -database ${POSTGRESQL_URL} -path db/migrations up
```
