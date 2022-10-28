# catatan pribadi
````
docker run -d -p 81:80 -v /Users/sofyan/Dev/php:/var/www/html --name terserah nimdasx/docker-apache-php8-phalcon5  
docker rm -f terserah 
````

# build dan push ke hub docker 
````
#docker build --tag nimdasx/docker-apache-php8-phalcon5 .   
#docker push nimdasx/docker-apache-php8-phalcon5  

#amd64
docker buildx build --push --platform linux/amd64 --tag nimdasx/apache-php8-phalcon5 .

#arm64
docker buildx build --push --platform linux/arm64 --tag nimdasx/apache-php8-phalcon5 .
 
````

# build dan push ke github
````
#docker build --tag ghcr.io/nimdasx/apache-php8-phalcon5 .
#docker push ghcr.io/nimdasx/apache-php8-phalcon5

#amd64
docker buildx build --push --platform linux/amd64 --tag ghcr.io/nimdasx/apache-php8-phalcon5 .

````
