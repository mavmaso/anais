FROM elixir:latest

RUN apt-get update
RUN apt-get install -y postgresql-client wkhtmltopdf

RUN mkdir /app
COPY . /app
WORKDIR /app

RUN mix local.hex --force && mix local.rebar --force
# RUN mix do deps.get, deps.compile
# CMD ["/app/run.sh"]