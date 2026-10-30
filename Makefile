HOME = /home/dbotelho
MARIADB_DATA = $(HOME)/data/mariadb
WORDPRESS_DATA = $(HOME)/data/wordpress
NGINX_DATA = $(HOME)/data/nginx

all: mariadb-up wordpress-up nginx-up
	@echo -e "\033[32mApplication succesfully started!\033[0m"

down: nginx-down wordpress-down mariadb-down
	@echo -e "\033[32mApplication succesfully shutdown...\033[0m"

mariadb-up:
	mkdir -p $(MARIADB_DATA)
	cd srcs/requirements/mariadb && docker compose up

mariadb-down:
	cd srcs/requirements/mariadb && docker compose down

wordpress-up:
	mkdir -p $(WORDPRESS_DATA)
	cd srcs/requirements/wordpress && docker compose up

wordpress-down:
	cd srcs/requirements/wordpress && docker compose down

nginx-up:
	mkdir -p $(NGINX_DATA)
	cd srcs/requirements/nginx && docker compose up

nginx-down:
	cd srcs/requirements/nginx && docker compose down


.PHONY: mariadb-up mariadb-down wordpress-up wordpress-down nginx-up nginx-down