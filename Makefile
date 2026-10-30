.PHONY: mariadb-up mariadb-down

mariadb-up:
	cd srcs/requirements/mariadb && docker compose up

mariadb-down:
	cd srcs/requirements/mariadb && docker compose down
