# docker apache php-8 phalcon-5

## catatan
- phalcon 5.8 maksimal di php 8.3
- multibuilder lokal dan remote cek https://github.com/nimdasx/gits/blob/main/docker.md#lokal-builder-for-amd64-remote-builder-for-arm64

## command
````
# buildx dan push ke github
docker buildx build --platform linux/amd64,linux/arm64 --tag ghcr.io/nimdasx/apache-php8-phalcon5 --push .

# buildx dan push ke docker hub
docker buildx build --platform linux/amd64,linux/arm64 --tag nimdasx/apache-php8-phalcon5 --push .
````