# fargate-test-app

Aplicação pra teste de deploy com ciclo de vida gerenciado pelo travis

## Porquê ?

- AWS ECS Fargate está em fase de testes e precisamos demonstrar vários modelos de deploy da aplicação usando esse exemplo

## What ?

This is a simple application. What is does:

- Show an index with a random string to test red/blue deployment;
- Generate load to test autoscaling;
- Health-check routes to test liveness/readiness

### Endpoints

| Endpoint | Description |
|----------|-------------|
| `/`      | Will output a app version, from `SHATTERDOME_APP_VERSION` env var and `hostname` |
| `/load/:interval` | Generates CPU load for the following `interval` seconds (default: 20) |
| `/health/live` | Returns `200` when runtime is less than `600` seconds |
| `/health/ready` | Returns `200` when runtime is greater than `15` seconds |
| `/health/uptime` | Returns application runtime |

## Running

```
$ docker run --rm -ti -p 3000:3000 -e SHATTERDOME_APP_VERSION=1 pagarme/shatterdome-test-app

> shatterdome-test-app@0.0.0-master start /usr/src/app
> node ./lib/index.js

Server listening on port 3000
```
