function docker-rm-all() {
    docker rm $(docker ps -a -q)
}

function docker-rmi-all() {
    docker rmi $(docker images -q)
}

function docker-rmn-all() {
    docker network rm $(docker network ls -q)
}

function docker-stop-all() {
    docker stop $(docker ps -a -q)
}

function docker-network-all() {
    docker network inspect $( docker network ls -q )
}

function docker-build-local() {
    docker build --pull --file Dockerfile --tag "${PWD##*/}":local "$@"
}

function docker-service-update() {
    docker service update --force "${DOCKER_STACK_NAME}_${PWD##*/}"
}

function docker-build-and-update-service() {
    docker-build-local . && docker-service-update
}
