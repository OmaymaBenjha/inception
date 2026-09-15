USER = $(shell whoami)

all:
	@mkdir -p /home/$(USER)/data/mariadb
	@mkdir -p /home/$(USER)/data/wordpress
	@mkdir -p /home/$(USER)/data/portainer
	@docker compose -f srcs/docker-compose.yml up -d --build 

stop:
	@docker compose -f srcs/docker-compose.yml stop
	
start:
	@docker compose -f srcs/docker-compose.yml start

clean:
	@docker compose -f srcs/docker-compose.yml down

fclean: clean
	@sudo rm -rf /home/$(USER)/data/mariadb/*
	@sudo rm -rf /home/$(USER)/data/wordpress/*
	@sudo rm -rf /home/$(USER)/data/portainer/*
	@docker system prune -af --volumes

re: fclean all

.PHONY: all clean fclean re