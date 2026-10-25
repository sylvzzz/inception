# Como o Compose liga serviços a Dockerfiles (Inception)

## Ideia central

O nome do serviço (`mariadb`, `wordpress`, `nginx`) é uma etiqueta que **tu escolhes**. A ligação ao Dockerfile é feita pela chave `build:`, que aponta para a pasta onde ele está.

## Estrutura de pastas

```
Makefile
secrets/
srcs/
├── docker-compose.yml
├── .env
└── requirements/
    ├── mariadb/
    │   └── Dockerfile
    ├── wordpress/
    │   └── Dockerfile
    └── nginx/
        └── Dockerfile
```

## docker-compose.yml (esqueleto)

```yaml
services:
  mariadb:
    build: ./requirements/mariadb
    image: mariadb
    restart: always
    networks:
      - inception

  wordpress:
    build: ./requirements/wordpress
    image: wordpress
    restart: always
    depends_on:
      - mariadb
    networks:
      - inception

  nginx:
    build: ./requirements/nginx
    image: nginx
    restart: always
    depends_on:
      - wordpress
    ports:
      - "443:443"
    networks:
      - inception

networks:
  inception:
```

## Regras a lembrar

| Chave | O que faz |
|-------|-----------|
| `build:` | Pasta onde está o Dockerfile (caminho relativo ao `docker-compose.yml`) |
| `image:` | Nome que a imagem construída vai ter (igual ao serviço, como o subject exige) |
| `restart: always` | Reinicia o container se crashar |
| `networks:` | Liga o serviço à rede definida no fim do ficheiro |
| `ports:` | Só o nginx expõe, e só `443` |

## Diferenças face ao exemplo do Flask

- **Não uses** `image: redis:alpine` sozinho: isso faz pull de uma imagem pronta, o que é proibido. Todos os serviços têm `build:`.
- **Não uses** `network: host` nem `links:`.
- **Não uses** a tag `latest`.
- Só o `nginx` tem `ports:`. MariaDB (3306) e php-fpm (9000) comunicam apenas dentro da rede Docker.

## Como os serviços se encontram

Dentro da rede, cada serviço é alcançável **pelo nome**:

- O WordPress liga-se à base de dados em `mariadb:3306`
- O nginx passa pedidos PHP para `wordpress:9000`

É por isso que o nome do serviço importa: é também o hostname na rede.

## Falta ainda (próximos passos)

- Secção `volumes:` com named volumes (dados em `/home/login/data`)
- `env_file: .env` e `secrets:` nos serviços
- Makefile que chama `docker compose -f srcs/docker-compose.yml up --build`