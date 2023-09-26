# build image

docker build -t $USERNAME/$IMAGE:$version .
docker image tag $USERNAME/$IMAGE:$version $USERNAME/$IMAGE:latest
# push it to docker
docker push $USERNAME/$IMAGE:latest
docker push $USERNAME/$IMAGE:$version
