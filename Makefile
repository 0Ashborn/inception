all: build up

build:
	docker-compose -f srcs/docker-compose.yml build

up:
	docker-compose -f srcs/docker-compose.yml up -d

down:
	docker-compose -f srcs/docker-compose.yml down

clean:
	docker-compose -f srcs/docker-compose.yml down --rmi all --volumes --remove-orphans

logs:
	docker-compose -f srcs/docker-compose.yml logs -f

.PHONY: all build up down clean logs
