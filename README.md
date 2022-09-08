# desafio_starta_flutter

#OBJETIVO

Utilizando a API do The Movie DB, você deverá implementar uma tela com as informações de algum filme da sua escolha. Não é necessário mais do que esta tela principal.

#Layout

Você deve replicar o layout da tela de detalhe dos filmes do app TodoMovies4.
Se você reparar, a imagem do filme possui um efeito. Não é obrigatório implementar este efeito, mas se for feito nós ficaremos felizes :)

#Requisitos

Usar Clean architecture.
Usar algum package de gerenciamento de estado, como: Getx, Bloc, MobX, Provider etc.(Se possível utilizar Getx).
As informações do filme devem vir do endpoint /movie.
Usar o "vote_count" que é retornado pelo endpoint acima para representar o número de likes.
Substituir o texto "3 of 10 watched" (ver tela de exemplo no tópico "Layout") por "<popularity> view". O "popularity" a ser usado é o campo retornado pelo endpoint /movie. Mantenha o ícone que já está na tela de exemplo.
O ícone de like (coração) deve mudar quando clicado, alternando entre preenchido e vazio.
Deve haver uma lista de filmes abaixo dos detalhes.
O projeto deve ser disponibilizado em um repositório aberto no GitHub. Envie a URL assim que possível.

#Dicas

A lista de filmes abaixo do detalhe do filme pode ser o retorno do endpoint
/movie/{movie_id}/similar.
Para fazer as requisições HTTP pode ser usado o package Dio.
Testes são sempre bem vindos.
Vamos olhar tudo, inclusive commits, branches, organização de pastas, etc.
Um código limpo e organizado pode ser mais importante do que o app todo pronto.
Vamos ler o seu README, caso você queira deixar alguma mensagem para nós.

## MobX

flutter packages pub run build_runner build --delete-conflicting-outputs

## Run App

flutter run lib/main.dart

## Build APK

flutter build apk lib/main.dart --release
