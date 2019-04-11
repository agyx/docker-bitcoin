# docker-bitcoin

## Build

```
docker build git@github.com:agyx/docker-bitcoin.git -t <TAG>
```

## Run

```
docker run --name bitcoin-node -d -v blockchain:/bitcoin/.bitcoin -p 8333:8333 <TAG>
```

## Stop

```
docker exec <CONTAINER_NAME> ./bitcoin-cli stop
