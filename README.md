# php:7.4-alpine

<p align="center">
	<img alt="logo-docker" class="avatar rounded-2" height="150" src="https://avatars2.githubusercontent.com/u/35675959?s=400&u=b1f9ebca6fa8e5be55cb524e16f38b52f2f1dd58&v=4" width="160">
	<br>
	Travis-CI<br>
	<a href="https://travis-ci.org/docker-sources/php">
		<img src="https://travis-ci.org/docker-sources/php.svg?branch=master" alt="Build Status">
	</a>
</p>

Essa imagem **Docker** foi criada de modo a permitir um start simplificado de um *ambiente de desenvolvimento e/ou testes* PHP com servidor web embutido.


As palavras-chave "DEVE", "NÃO DEVE", "REQUER", "DEVERIA", "NÃO DEVERIA", "PODERIA", "NÃO PODERIA", "RECOMENDÁVEL", "PODE", e "OPCIONAL" presentes em qualquer parte deste repositório devem ser interpretadas como descritas no [RFC 2119](http://tools.ietf.org/html/rfc2119). Tradução livre [RFC 2119 pt-br](http://rfc.pt.webiwg.org/rfc2119).

## :link: Imagens disponíveis

Consulte a guia [Tags](https://hub.docker.com/r/fabiojanio/) no repositório deste projeto no **Docker Hub** para ter acesso a outras versões.

## :white_check_mark: Componentes principais

 - PHP 7.4.*
 - Composer
 - curl
 - unzip

## :white_check_mark: Módulos PHP ativos

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
- zip

## :exclamation: Considerações relevantes

 - Porta **80** exposta
 - **php.ini** enxuto e alocado em `/usr/local/etc/php/php.ini`

**Sugestão**: utilize como exemplo o [**docker-compose.yml**](https://github.com/docker-sources/php/blob/master/docker-compose.yml) para simplificar o start de um ambiente.

## :computer: Iniciar container

Execute essa instrução para montar um volume compartilhado entre *host* e *container*:

```
docker run -v /projeto:/app -d -p 80:80 --name nome_do_container fabiojanio/php:7.4-alpine
```

**Obs**: no lugar de */projeto* você DEVE informar o caminho absoluto do diretório a ser compartilhado com o container. Caso seu *document root* sejá diferente de `/app`, por exemplo, no Laravel o *document root* tem que apontar para o diretório `public`, neste caso você PODE fazer assim:

```
docker run -v /projeto:/app -d -p 80:80 --name nome_do_container fabiojanio/php:7.4-alpine php -S 0.0.0.0:80 -t /app/projeto/public
```

Após a criação do container é possível se conectar a ele desta forma:

```
docker exec -it nome_do_container sh
```

## :fire: Build (opcional)

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
docker exec -it nome_do_container sh
```

## :page_with_curl: Licença MIT

Para maiores informações, leia o arquivo de [licença](https://github.com/docker-sources/php/blob/master/LICENSE) disponível neste repositório.
