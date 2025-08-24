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

Para inicializar o projeto, execute:

* `mix setup` to install e configurar depenencias;
* inicie a aplicacao com `mix phx.server` ou `iex -S mix phx.server`

* documentacao das rotas/endpoints: http://localhost:4002/swagger
* existe um job do Oban que roda diriamente as 0h procurando por todos os sorteios cadastrados pra aquela data e sorteia um ganhador.
* para executar um determinado sorteio manualmente execute dentro do iex> `Payfi.Draws.run(<id_do_sorteio>)`
* para rodar o job manualmente execute dentro do iex> `Payfi.Workers.DailyDrawRun.perform(%Oban.Job{args: %{}})`
* obs: foram utilizadas portas customizadas(4002 para aplicacao e 5500 para o banco) - se quiser alterar, altere no arquivos `config/dev.exs, config/test.exs` e `config/runtime.exs`
