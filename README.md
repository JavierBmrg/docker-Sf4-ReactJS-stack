# docker-dcsan-seed 
Containerized React-Sf4-Postgres-Redis App


## Requirements

#### You need to have installed

  - git
  - docker engine (client and server) >= 17.x.x
  - docker-compose >= 1.8.0
  
  Steps to install docker [on the docker website](https://docs.docker.com/install/#cloud).
  
## Set Up 

All you need to do is run:

```bash
$ git clone REPO_URL && cd REPO_CLONED_DIRECTORY ; chmod u+x ./setup.sh && ./setup.sh
```

## Useful environment information 

Service|Hostname|Port number
------|---------|-----------
react|app-client|[localhost:18080](http://localhost:18080)
nginx|api-nginx|[localhost:18081](http://localhost:18081)
php-fpm|php-backend|9000
postgreSQL|db|15432(default)
redis|redis|16379(default)


## Contributing

Do you find another way to improve the docker build set up?...

...well you should be aware of some docker good 
[practices](https://github.com/Haufe-Lexware/docker-style-guide/blob/master/DockerCompose.md) to contributing
