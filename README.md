# Payfi

## Backend Challenge
Nesse desafio, você vai ter que criar uma API REST para um sistema de sorteios

## Descrição da Aplicação
Nesse app você vai criar uma RESTful API, aonde os usuarios podem se registrar com um nome e email e participar de sorteios.

Regras de negócio a serem implementadas
* deve ser implementado em elixir
* usuários não devem poder entrar em sorteios após a data do sorteio
* cada usuário só pode participar uma unica vez do sorteio
* deve-se considerar que devido a api ser publica, pode ser que tenhamos muitos sorteios sendo criados concorrentementes
* deve-se considerar que pessoas famosas porem criar sorteios muito populares aonde teriam muitos usuários se cadastrando ao mesmo tempo e participando do sistema. O sistema não pode cair nesses casos, ou falhar em respeitar as regras acima.
* o sistema deve sortear um ganhador na data definida na criação do sorteio

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

Para inicializar o projeto, execute:

* `mix setup` to install e configurar depenencias;
* inicie a aplicacao com `mix phx.server` ou `iex -S mix phx.server`

* documentacao das rotas/endpoints: http://localhost:4002/swagger
* documentacao simplificada: http://localhost:4002/openapi.yaml
* existe um job do Oban que roda diriamente as 0h procurando por todos os sorteios cadastrados pra aquela data e sorteia seu respectivo ganhador
* para executar um determinado sorteio manualmente execute dentro do iex> `Payfi.Draws.run(<id_do_sorteio>)`
* para rodar o job manualmente execute dentro do iex> `Payfi.Workers.DailyDrawRun.perform(%Oban.Job{args: %{}})`
* obs: foram utilizadas portas customizadas(4002 para aplicacao e 5500 para o banco) - se quiser alterar, altere no arquivos `config/dev.exs, config/test.exs` e `config/runtime.exs`
* para verificar a cobertura de testes execute: MIX_ENV=test mix coveralls.html - relatorio html salvo dentro da pasta /cover

## setup utilizado
* erlang-otp-27
* elixir-1.18.2
