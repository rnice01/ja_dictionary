#/bin/bash

docker-compose -f docker/docker-compose.dev.yml run app mix ecto.reset
docker-compose -f docker/docker-compose.dev.yml up