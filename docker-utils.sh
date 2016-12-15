function docker-rm-all() {
	docker rm $(docker ps -a -q)
}

function docker-rmi-all() {
	docker rmi $(docker images -q)
}

function docker-stop-all() {
	docker stop $(docker ps -a -q)
}