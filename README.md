# catatan pribadi
````
docker run -d -p 81:80 -v /Users/sofyan/Dev/php:/var/www/html --name terserah nimdasx/apache-php8-phalcon5
docker rm -f terserah
````
# build dan push ke github
````
#docker build --tag ghcr.io/nimdasx/apache-php8-phalcon5 .
#docker push ghcr.io/nimdasx/apache-php8-phalcon5
````
# build dan push ke docker hub
````
docker buildx create --name jangkrik --use --bootstrap
docker buildx build --push --platform linux/amd64,linux/arm64 --tag nimdasx/apache-php8-phalcon5 .
````