<!-- omit from toc -->
# FIAP - SOAT1 - GRUPO 18

![](https://github.com/pabloldias/soat1-grupo18/actions/workflows/build-and-test.yml/badge.svg)

## Local Environment

Projeto criado para centralizar a configuração do ambiente local de desenvolvimento.

### Como rodar a aplicação completa?

Ao executar o script util-run.sh, todos os repositórios dos microsserviços do projeto são sincronizados como submódulos do Git, e é feito o build e deploy de cada um, disponibilizando os serviços em diferentes portas.

Na mesma script é levantado o LocalStack com os serviços DynamoDB (usado pelo msPagamento), SNS e SQS.

Na pasta `localstack` temos as scripts de inicialização dos tópicos do SNS e das filas do SQS, permitindo o teste de integração de todos os microsserviços localmente.

Para rodar a aplicação completa, execute na pasta raiz:

```bash
./fase5-local-environment/util-run.sh
```

### Como rodar somente o Localstack?

Para rodar somente o Localstack, execute na pasta raiz do projeto fase5-local-environment:

```bash
docker-compose -f localstack/docker-compose-local.yml up --force-recreate --renew-anon-volumes
```

Isso irá levantar o LocalStack com os serviços DynamoDB, SNS e SQS. Dessa forma é possível rodar os microsserviços localmente de forma isolada, porém é necessário levantar manualmente os bancos de dados Postgres para cada um dos serviços (exceto msPagamento), usando o docker-compose-local.yml de cada projeto.


### Alunos

|                                           Nome |     RM     |
|-----------------------------------------------:| :--------: |
|                   Elvis Freitas Lopes Herllain | `rm349139` |
|                           Gisele Mara Leonardi | `rm349242` |
|                  Leandro Gonçalves de Oliveira | `rm348615` |
|                       Marcos Venâncio de Souza | `rm349251` |
|                                Pablo Lima Dias | `rm349149` |

