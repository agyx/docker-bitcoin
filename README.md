# docker-bitcoin

## Build

```
docker build git@github.com:agyx/docker-bitcoin.git -t <TAG>
docker build git@github.com:agyx/docker-bitcoin.git -t <TAG> --build-arg VERSION=0.17.1
```

## Run

```
docker run --name bitcoin-node -d -v blockchain:/bitcoin/.bitcoin -p 8333:8333 <TAG>
```

## Stop

```
docker exec bitcoin-node ./bitcoin-cli stop
