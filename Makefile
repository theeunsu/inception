# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: eahn <eahn@student.42.fr>                  +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/12/03 22:12:08 by eahn              #+#    #+#              #
#    Updated: 2025/01/16 12:13:20 by eahn             ###   ########.fr        #
#                                                                              #
# **************************************************************************** #


NAME = inception

COMPOSE_FILE = ./srcs/docker-compose.yml

all: build

up:
	docker-compose -f $(COMPOSE_FILE) up -d

build:
	docker-compose -f $(COMPOSE_FILE) up -d --build

stop:
	docker-compose -f $(COMPOSE_FILE) stop

start:
	docker-compose -f $(COMPOSE_FILE) start

status:
	docker-compose -f $(COMPOSE_FILE) ps

down:
	docker-compose -f $(COMPOSE_FILE) down

clean:
	docker system prune -af

fclean: clean
	docker-compose -f $(COMPOSE_FILE) down -v --rmi all

re: fclean all

network:
	docker network inspect $(NAME)

volumes:
	docker volume ls

logs:
	docker logs -f nginx

.PHONY: all up build stop start status down clean fclean re network volumes logs
