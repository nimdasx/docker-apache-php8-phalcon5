# docker apache php-8 phalcon-5
## catatan
````
# run tanpa compose
docker run -d -p 81:80 -v /Users/sofyan/Dev/php:/var/www/html --name dinosaurus nimdasx/apache-php8-phalcon5

# gawe buildx
# docker buildx create --name jangkrik --use --bootstrap 
docker buildx create --name jangkrik --use

# build tanpa buildx
docker build --tag nimdasx/apache-php8-phalcon5 . 

# push image ke dockerhub
docker image push nimdasx/apache-php8-phalcon5

# build dan push ke github
docker buildx build --platform linux/amd64,linux/arm64 --tag ghcr.io/nimdasx/apache-php8-phalcon5 --push .

# build dan push ke docker hub
docker buildx build --platform linux/amd64,linux/arm64 --tag nimdasx/apache-php8-phalcon5 --push .

# jika error pas buildx, jalankan ini
docker run --rm --privileged multiarch/qemu-user-static --reset -p yes
````