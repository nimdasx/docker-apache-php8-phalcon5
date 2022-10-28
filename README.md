# catatan pribadi
````
docker run -d -p 81:80 -v /Users/sofyan/Dev/php:/var/www/html --name terserah nimdasx/docker-apache-php8-phalcon5  
docker rm -f terserah 
````

# build dan push ke hub docker 
````
#jalankan ini dulu kalau di linux
docker run --privileged --rm tonistiigi/binfmt --install all
#di mac maupun di server linux
docker buildx create --name sapi --use --bootstrap
#build and push ke hub.docker.com
docker buildx build --push --platform linux/amd64,linux/arm64 --tag nimdasx/apache-php8-phalcon5 . 
````

# build dan push ke github
````
#docker build --tag ghcr.io/nimdasx/apache-php8-phalcon5 .
#docker push ghcr.io/nimdasx/apache-php8-phalcon5

#amd64
docker buildx build --push --platform linux/amd64 --tag ghcr.io/nimdasx/apache-php8-phalcon5 .

````
