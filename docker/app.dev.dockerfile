# File: docker_phx/Dockerfile
FROM elixir:1.11-alpine as build

RUN apk add --update git build-base nodejs npm py-pip inotify-tools
RUN mix do local.hex --force, local.rebar --force

ENV APP_HOME /app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

CMD ["mix", "phx.server"]
