# Anais

It’s a simple RESTfull API to test my skills using a proposal problem as a guideline for that. Some of the features are more simple than normal because the focus here is
just demonstrate the idea/concept not deliver a final product.

### Proposal Problem

  O seu desafio é desenvolver uma API REST em Elixir, utilizando Phoenix, para geração de anais (proceedings) de artigos científicos submetidos a eventos. Além da geração dos anais, a aplicação deve permitir a inclusão, edição, visualização e exclusão de eventos e artigos.

## Deps for Linux

- `sudo apt update`
- `sudo apt upgrade`
- `sudo apt install -y build-essential libssl-dev zlib1g-dev automake autoconf libncurses5-dev wkhtmltopdf`

## In loco Setup

- Install dependencies with `mix deps.get`
- Create and migrate your database with `mix ecto.setup`
- Start Phoenix endpoint with `mix phx.server`
- Run complete tests `mix test`
- Full setup can be done too usign: `mix setup`

## Database
  PostgreSQL
  ```
  username: postgres
  password: postgres
  ```

## Using

 You can use postman, or a similar app, to send json to this API.The endpoint are below.


### Endpoint

 - Add authors ( post /api/authors )
  ```
  {
    "author": {
      "email": "algo@mail.com",
      "password": "somepassword",
      "name": "Alvoro Silva"
    }
  }
  ```

 - Login ( post /api/login )
  ```
  {
    "email": "algus@mail.com",
    "password": "somepassword"
  }
  ```

 - Create Events ( post /api/events ) [needs jwt]
  ```
  {
    "event": {
      "title": "Event I",
      "description": "Evento realizado ..."
    }
  }
  ```

 - Create Article ( post /api/article ) [needs jwt]
  ```
  {
    "article": {
      "author_id": 1,
      "event_id": 1,
      "title": "Artigo I",
      "abstract": "Lorem ...",
      "keywords": ["teste", "artigo"],
      "co_authors": [1]
    }
  }
  ```

 - List Events ( get /api/events )

 - Generates proceedings ( post /api/events/:event_id/proceedings ) [needs jwt]

## Made by

 - [mavmaso](https://github.com/mavmaso)
