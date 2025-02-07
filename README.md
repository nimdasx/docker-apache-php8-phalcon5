# docker apache php-8 phalcon-5

## catatan
- phalcon 5.8 maksimal di php 8.3
- bookworm : gagal arm64, berhasil amd64
- bullseye : berhasil arm64, amd64

## command
````
# run
docker run -d -p 81:80 -v /Users/sofyan/Dev/php:/var/www/html --name dinosaurus nimdasx/apache-php8-phalcon5

# build
docker build --tag nimdasx/apache-php8-phalcon5 . 

# push ke docker hub
docker image push nimdasx/apache-php8-phalcon5

# create buildx
# docker buildx create --name jangkrik --use --bootstrap 
docker buildx create --name jangkrik --use

# jika error pas buildx, jalankan ini
docker run --rm --privileged multiarch/qemu-user-static --reset -p yes

# buildx dan push ke github
docker buildx build --platform linux/amd64,linux/arm64 --tag ghcr.io/nimdasx/apache-php8-phalcon5 --push .

# buildx dan push ke docker hub
docker buildx build --platform linux/amd64,linux/arm64 --tag nimdasx/apache-php8-phalcon5 --push .


````