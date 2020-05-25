# php:7.4-alpine

<p align="center">
	<img alt="logo-docker" class="avatar rounded-2" height="150" src="https://avatars2.githubusercontent.com/u/35675959?s=400&u=b1f9ebca6fa8e5be55cb524e16f38b52f2f1dd58&v=4" width="160">
	<br>
	Travis-CI<br>
	<a href="https://travis-ci.org/docker-sources/php">
		<img src="https://travis-ci.org/docker-sources/php.svg?branch=master" alt="Build Status">
	</a>
</p>

Essa é uma imagem **docker** criada para start simplificado de container PHP com servidor web embutido.

> Essa imagem Docker foi desenvolvida para auxiliar no desenvolvimento de aplicações. Podendo ser útil para testes ou para demonstrações de aplicações que rodam em ambientes controlado. Essa imagem não foi desenvolvida para ser um web server completo. Ela não deve ser utilizado em uma rede pública.

As palavras-chave "DEVE", "NÃO DEVE", "REQUER", "DEVERIA", "NÃO DEVERIA", "PODERIA", "NÃO PODERIA", "RECOMENDÁVEL", "PODE", e "OPCIONAL" presentes em qualquer parte deste repositório devem ser interpretadas como descritas no [RFC 2119](http://tools.ietf.org/html/rfc2119). Tradução livre [RFC 2119 pt-br](http://rfc.pt.webiwg.org/rfc2119).

## Imagens disponíveis

Consulte a guia [Tags](https://hub.docker.com/r/fabiojanio/php/tags/) no repositório deste projeto no **Docker Hub** para ter acesso a outras versões.

## Pacotes presentes na imagem

 - PHP 7.4.*
 - Composer
 - curl
 - unzip

## Módulos PHP ativos

Lista de módulos ativos presentes na imagem:

- Core
- ctype
- curl
- date
- dom
- exif
- fileinfo
- filter
- ftp
- gd
- hash
- iconv
- intl
- json
- libxml
- mbstring
- mysqli
- mysqlnd
- openssl
- pcre
- PDO
- pdo_mysql
- pdo_pgsql
- pdo_sqlite
- pgsql
- Phar
- posix
- readline
- Reflection
- session
- SimpleXML
- soap
- sockets
- sodium
- SPL
- sqlite3
- standard
- tokenizer
- xml
- xmlreader
- xmlwriter
- Zend OPcache
- zlib

## Considerações relevantes

 - Porta **80** exposta
 - **php.ini** limpo e alocado em `/usr/local/etc/php/php.ini`

**Sugestão**: utilize [**docker-compose.yml**](https://github.com/docker-sources/php/blob/master/docker-compose.yml).

## Start container

Execute essa instrução para montar um volume compartilhado entre *host* e *container*:

```
docker run -v /projeto:/app -d -p 80:80 --name nome_do_container fabiojanio/php:7.4-alpine
```

**Obs**: no lugar de */projeto* você DEVE informar o caminho absoluto do diretório a ser compartilhado com o container. Caso seu *document root* sejá diferente de `/app`, por exemplo, no Laravel o *document root* tem que apontar para o diretório `public`, neste caso você pode fazer assim:

```
docker run -v /projeto:/app -d -p 80:80 --name nome_do_container fabiojanio/php:7.4-alpine php -S 0.0.0.0:80 -t /app/projeto/public
```

Após a criação do container é possível se conectar a ele desta forma:

```
docker exec -it nome_do_container /bin/sh
```

## docker-compose.yml

Para subir o ambiente utilizando o docker-compose, efetue o download do arquivo [**docker-compose.yml**](https://github.com/docker-sources/php/blob/master/docker-compose.yml), acesse o diretório onde o arquivo foi baixado e execute:

```
docker-compose up -d
```

Neste arquivo os containers estão nomeados como **web** e **mysql**. Para se conectar:

```
docker exec -it nome_do_container /bin/sh
```

## Build (opcional)

Os passos anteriores estão configurados para utilizar a imagem já compilada disponível no **Docker Hub**, entretanto, caso queira compilar sua própria imagem, basta efetuar o download do arquivo [**Dockerfile**](https://github.com/docker-sources/php/blob/master/Dockerfile) e executar a instrução:

```
docker build -t nome_da_nova_imagem:nome_da_tag .
```

Posteriormente pode criar o container executando:

```
docker run -v /projeto:/var/www -d -p 80:80 --name nome_do_container nome_da_nova_imagem:nome_da_tag
```

E para conectar ao container executando:

```
docker exec -it nome_do_container /bin/sh
```

## Licença MIT

Para maiores informações, leia o arquivo de [licença](https://github.com/docker-sources/php/blob/master/LICENSE) disponível neste repositório.