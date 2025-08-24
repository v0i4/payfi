# Payfi

## Backend Challenge

## Descricao - Sistema de sorteios
* os usuarios podem se registrar com um nome e email e participar de sorteios.
* usuários não devem poder entrar em sorteios após a data do sorteio
* cada usuário só pode participar uma unica vez do sorteio
* o sistema deve sortear um ganhador na data definida na criação do sorteio

## Funcionalidades obrigatórias
* rota registrar usuário, recebe um nome e email e retorna um id;
* rota criar um sorteio, recebe o nome do sorteio e data do sorteio e retorna um id;
* rota para participar de um sorteio, recebe um id de usuário e um id de sorteio e retorna ok;
* rota para consultar o resultado de um sorteio, recebe um id de sorteio e retorna o id, nome e email do usuário que ganhou, ou o erro apropriado caso o sorteio não tenha sido encerrado;

To start your Phoenix server:

* Run `mix setup` to install and setup dependencies
* Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

* Official website: https://www.phoenixframework.org/
* Guides: https://hexdocs.pm/phoenix/overview.html
* Docs: https://hexdocs.pm/phoenix
* Forum: https://elixirforum.com/c/phoenix-forum
* Source: https://github.com/phoenixframework/phoenix
