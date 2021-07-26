# php:8.0-alpine3.14

<p align="center">
	<img alt="logo-docker" class="avatar rounded-2" height="150" src="https://avatars2.githubusercontent.com/u/35675959?s=400&u=b1f9ebca6fa8e5be55cb524e16f38b52f2f1dd58&v=4" width="160">
	<br>
	Travis-CI<br>
	<a href="https://travis-ci.org/docker-sources/php">
		<img src="https://travis-ci.org/docker-sources/php.svg?branch=master" alt="Build Status">
	</a>
</p>

*Projetei essa imagem de modo que ela seja leve, flexível e versátil no contexto de ambientes de desenvolvimento, ou seja, você NÃO DEVE em hipótese alguma utilizar essa imagem em ambientes produtivos ou pré-produção.*

As palavras-chave "DEVE", "NÃO DEVE", "REQUER", "DEVERIA", "NÃO DEVERIA", "PODERIA", "NÃO PODERIA", "RECOMENDÁVEL", "PODE", e "OPCIONAL" presentes em qualquer parte deste repositório devem ser interpretadas como descritas no [RFC 2119](http://tools.ietf.org/html/rfc2119). Tradução livre [RFC 2119 pt-br](http://rfc.pt.webiwg.org/rfc2119).

## :link: Imagens disponíveis

Caso deseje utilizar essa mesma abordagem mas com outra versão do PHP, consulte meu catalogo de [Tags](https://hub.docker.com/r/fabiojanio/php/tags) no Docker Hub.

## :white_check_mark: Componentes principais

 - PHP 8.0.*
 - Composer 2.*
 - curl
 - unzip

## :white_check_mark: Módulos PHP ativos

Lista de módulos ativos presentes na imagem:

- bcmath
- Core
- ctype
- curl
- date
- dom
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
- mysqlnd
- openssl
- pcre
- PDO
- pdo_mysql
- pdo_pgsql
- pdo_sqlite
- Phar
- posix
- readline
- Reflection
- session
- SimpleXML
- sodium
- SPL
- sqlite3
- standard
- tokenizer
- xml
- xmlreader
- xmlwriter
- zlib

## :exclamation: Pontos de atenção

 - Porta **80** exposta
 - **php.ini** de desenvolvimento alocado em `/usr/local/etc/php/php.ini`

**Sugestão**: utilize como exemplo o [**docker-compose.yml**](https://github.com/docker-sources/php/blob/master/docker-compose.yml) para simplificar o start de um ambiente. Este contêiner utiliza "America/Sao_Paulo" como timezone default.

## :computer: Iniciar container

Execute essa instrução para montar um volume compartilhado entre *host* e *container*:

```
docker run --name nome_do_container -v $(pwd):/app -d -p 80:80 --user www-data fabiojanio/php:8.0-alpine3.14
```

**Obs**: no exemplo acima optei por utilizar o `$(pwd)` para capturar o caminho absoluto. Note ainda que fiz uso `--user` para subir o container utilizando um usuário não ROOT, isso não é obrigatório, porém, é mais seguro.

Por padrão essa imagem considera o `/app` como seu *document root*. Vamos supor que você instalou o Laravel, este por sua vez considera o subdiretório `/public` como seu *document root*, neste caso PODEMOS contornar este problema de forma muito simples. Veja:

```
docker run --name nome_do_container -d -v $(pwd):/app -p 80:80 --user www-data fabiojanio/php:8.0-alpine3.14 php -S 0.0.0.0:80 -t /app/public
```

Após a criação do container é possível se conectar a ele desta forma:

```
docker exec -it nome_do_container sh
```

### :bulb: Outros exemplos de uso

Os exemplos abaixo representam algumas das possibilidades e facilidades providas por essa imagem.

#### :cloud: Baixando e instalando Projetos

Para baixar e instalar o Laravel Framework:
```
docker run --rm -v $(pwd):/app fabiojanio/php:8.0-alpine3.14 composer create-project --prefer-dist laravel/laravel laravel_example
```

Para baixar e instalar o Yii Framework:
```
docker run --rm --name php -v $(pwd):/app fabiojanio/php:8.0-alpine3.14 composer create-project --prefer-dist yiisoft/yii2-app-basic yii_example
```

#### :arrow_forward: Executar projeto/código PHP

Para subir o Laravel Framework:
```
docker run -d --name nome_do_container -v $(pwd):/app -p 8080:80 --user www-data fabiojanio/php:8.0-alpine3.14 php artisan serve --host=0.0.0.0 --port 80
```

Para subir o Yii Framework:
```
docker run -d --name nome_do_container -v $(pwd):/app -p 8080:80 --user www-data fabiojanio/php:8.0-alpine3.14 php yii serve 0.0.0.0:80
```

Caso você tenha um index.php na raiz do seu projeto, basta executar:
```
docker run -d --name nome_do_container -v $(pwd):/app -p 8080:80 --user www-data fabiojanio/php:8.0-alpine3.14
```

Caso seu *Document Root* for um subdiretório, exemplo /minha_app/public, você pode fazer assim:
```
docker run -d --name nome_do_container -v $(pwd):/app -p 8080:80 --user www-data fabiojanio/php:8.0-alpine3.14 php -S 0.0.0.0:80 -t /app/public
```

## :tada: Dica

Para maior agilidade e comodidade consulte o [**docker-compose.yml**](https://github.com/docker-sources/php/blob/master/docker-compose.yml) que deixei de exemplo para você. Observe que você pode sobrescrever a propriedade `command` de modo a executar N tarefas no start do container, bem como substituir ou adicionar definições para outros containers. Boa diversão :)

## :page_with_curl: Licença MIT

Para maiores informações, leia o arquivo de [licença](https://github.com/docker-sources/php/blob/master/LICENSE) disponível neste repositório.
