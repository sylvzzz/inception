HOME = /home/dbotelho
MARIADB_DATA = $(HOME)/data/mariadb
WORDPRESS_DATA = $(HOME)/data/wordpress
NGINX_DATA = $(HOME)/data/nginx

all:
	mkdir -p $(MARIADB_DATA)
	mkdir -p $(WORDPRESS_DATA)
	mkdir -p $(NGINX_DATA)
	cd srcs && docker compose up -d
	@echo "\033[32mApplication succesfully started!\033[0m"

down:
	cd srcs && docker compose down
	@echo "\033[32mApplication succesfully shutdown...\033[0m"

clean:
	rm -rf $(NGINX_DATA)
	rm -rf $(WORDPRESS_DATA)
	rm -rf $(MARIADB_DATA)

.PHONY: all down