# Construir imagem com python 3.12
FROM python:3.12-alpine

# Diretorio de runtime 
WORKDIR /code

# variaveis ambiente

ENV FLASK_APP=app.python
ENV FLASK_RUN_HOST=0.0.0.0

# instalar dependencias de linux

RUN apk add --no-cache gcc musl-dev linux-headers

# pegar requirements.txt
COPY requirements.txt .

# instalar deps do python
RUN pip install -r requirements.txt

# copiar o dir atual para o workdir da image
COPY . .

EXPOSE 5000

CMD ["flask", "run", "--debug"]