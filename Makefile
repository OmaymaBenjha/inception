USER = oben-jha

all:
	@mkdir -p /home/$(USER)/data/mariadb
	@mkdir -p /home/$(USER)/data/wordpress
	@docker compose -f srcs/docker-compose.yml up -d --build

clean:
	@docker compose -f srcs/docker-compose.yml down

fclean: clean
	@sudo rm -rf /home/$(USER)/data/mariadb/*
	@sudo rm -rf /home/$(USER)/data/wordpress/*
	@docker system prune -af --volumes

re: fclean all

.PHONY: all clean fclean re