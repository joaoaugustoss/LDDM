<h1>Resquitem</h1> 

<p align="center">
  <img src="https://img.shields.io/static/v1?label=Flutter&message=framework&color=blue&style=for-the-badge&logo=FLUTTER"/>
  <img src="https://img.shields.io/static/v1?label=Google Play Store&message=deploy&color=blue&style=for-the-badge&logo=Google Play Store"/>
  <img src="http://img.shields.io/static/v1?label=License&message=MIT&color=green&style=for-the-badge"/>
  <img src="http://img.shields.io/static/v1?label=Dart&message=2.18.2&color=red&style=for-the-badge&logo=Dart"/>
  <img src="http://img.shields.io/static/v1?label=TESTES&message=%3E100&color=GREEN&style=for-the-badge"/>
   <img src="http://img.shields.io/static/v1?label=STATUS&message=EM%20DESENVOLVIMENTO&color=RED&style=for-the-badge"/>
</p>

> Status do Projeto: :warning: 🚧 Projeto em construção...🚧 :warning:

### Tópicos 

:small_blue_diamond: [Descrição do projeto](#descrição-do-projeto)

:small_blue_diamond: [Funcionalidades](#funcionalidades)

:small_blue_diamond: [Telas da Aplicação](#telas-da-aplicação)

:small_blue_diamond: [Pré-requisitos](#pré-requisitos)

:small_blue_diamond: [Como rodar a aplicação](#como-rodar-a-aplicação)

:small_blue_diamond: [Casos de Uso](#casos-de-uso)

:small_blue_diamond: [API Spoonacular](#api-spoonacular)

:small_blue_diamond: [Banco de dados](#banco-de-dados)

:small_blue_diamond: [Dependências e libs utilizadas](#dependências-e-libs-utilizadas)

:small_blue_diamond: [Licença](#licença)


## :pencil2: Descrição do projeto 

<p align="justify">
  É um aplicativo para a matéria de Laboratório de Desenvolvimento de Dispositivos Móveis. Separado em quatro sprints onde é trabalhado o front-end, back-end e integração com API externa.

Este aplicativo irá auxiliar em receitas culinárias, onde o usuário informa quais ingredientes tem em casa e o aplicativo mostra possíveis receitas com os ingredientes disponíveis - é daí que vem o nome Resquitem. Tem como um dos objetivos reduzir o número de alimentos desperdiçados por falta de o que fazer com eles.  
</p>

## :receipt: Funcionalidades 

:heavy_check_mark: Cadastro, login e alteração de dados da conta do usuário

:heavy_check_mark: Pesquisar por nome da receita ou por filtros como doce, salgado ou qual seria a refeição do dia.  

:heavy_check_mark: Pesquisar por ingredientes disponíveis

:heavy_check_mark: Comentar receita informando, por exemplo, uma dica de modo de preparo



## :iphone: Telas da Aplicação 



## 🛠 Pré-requisitos

- [AndroidStudio](https://developer.android.com/)
- [Flutter](https://flutter.dev/)
- [Dart](https://dart.dev/)


## :arrow_forward: Como rodar a aplicação 

**1° passo:** Abra o terminal e entre na pasta desejada onde você quer que esteja este projeto.

**2° passo:** No terminal, clone o projeto com o comando: 

```
git clone https://github.com/joaoaugustoss/LDDM.git
```

**3° passo:** Abra o projeto no Android Studio, clique no menu File, depois em Open e procure pela pasta onde clonou este repositório, selecione esta pasta e clique em "OK".

**4° passo:** Para rodar o aplicativo no emulador ou no seu dispositivo, siga o passo a passo neste [site](https://developer.android.com/training/basics/firstapp/running-app?hl=pt-br#:~:text=No%20Android%20Studio%2C%20crie%20um,voc%C3%AA%20quer%20executar%20o%20app.).



## :bulb: Casos de Uso

- Cadastrar uma conta para poder comentar uma receita.
- Fazer login em uma conta já criada.
- Alterar os dados da conta já criada.
- Pesquisar uma receita com ingredientes específicos.
- Pesquisar uma receita pelo seu nome e filtros.
- Comentar uma receita após já ter uma conta e nela estar logado.

## :link: API Spoonacular

Para mostrar as receitas pesquisadas pelo usuário, utilizamos a API Spoonacular. Nela conseguimos buscar receitas pelo seu id, filtros, ingredientes e pelo seu nome, ou seja, o que é necessário para o funcionamento do nosso aplicativo. Para ter acesso a esta API acesse este [site](https://react-pdf.org/](https://spoonacular.com/food-api/console#Dashboard)) e crie sua conta para ter acesso a uma API Key.

## :floppy_disk: Banco de Dados 

Para criar e armazenar as informações no banco de dados utilizamos o [SQLite](https://pub.dev/packages/sqflite).

No banco de dados é armazenado os usuários cadastrados no aplicativo. A primary key é o id. 

Ao criar uma nova conta os dados do novo usuário são inseridos no banco, e antes de criar primeiro é verificado se não há nenhum e-mail igual guardado no banco, visto que ele é necessário para login. 

Ao logar na conta criada, é consultado no banco se existe um usuário com o e-mail informado, se existir os dados do usuário são recuperados e retornados nesta consulta. 

Ao alterar os dados do usuário logado, os dados são atualizados no banco e antes de alterar também é verificado se o e-mail alterado já existe no banco e se a senha for alterada ela também é criptografada antes de salvar. 

Ao deletar a conta, ela é excluída do banco. 
Para logar é necessário e-mail e senha. No comentário é utilizado o nome do usuário para identificar quem comentou. A senha é criptografada utilizando o algoritmo MD5. 

A tabela para esta entidade e suas colunas com seus respecitivos dados são:

### Usuários: 

|id (INTEGER)|nome (VARCHAR)|email (VARCHAR)|senha (VARCHAR)|
| -------- |-------- |-------- |-------- |
|1|Roberta Vasconcelos Silva|roberta@gmail.com||
|2|Jorge Ribeiro Souza|jorge@hotmail.com||

Também é armazenado no banco os comentários em cada receita adicionados pelo usuário logado. A Primary key é o id e o idusuario é uma Foreign key da tabela usuário. 

É possível apenas inserir o comentário. Nesta tabela é armazenado o comentário escrito pelo usuário, o id da receita que veio da API Spoonacular em que foi feito o comentário e o id do usuário que comentou. 

A tabela com suas respectivas colunas e tipos segue abaixo:

### Comentários: 

|id (INTEGER)|comentario (VARCHAR)|idreceita (INTEGER) |idusuario (INTEGER)|
| -------- |-------- |-------- |-------- |
|1|Esta receita ficou muito gostosa.|7589|1|
|2|Adicionei raspas de limão e ficou maravilhoso!|325|2|

Para verificar se o usuário já está logado em sua conta é utilizado o [Shared Preferences](https://pub.dev/packages/shared_preferences). Se o id do usuário estiver guardado no Shared Preferences então o usuário está logado, caso contrário não. Assim é possível controlar as telas que irão aparecer caso esteja ou não logado. 


## :books: Dependências e libs utilizadas 

- [navigation_drawer_menu](https://pub.dev/packages/navigation_drawer_menu)
- [easy_splash_screen](https://pub.dev/packages/easy_splash_screen)
- [animated_splash_screen](https://pub.dev/packages/animated_splash_screen)
- [page_transition](https://pub.dev/packages/page_transition)
- [google_fonts](https://pub.dev/packages/google_fonts)
- [image_card](https://pub.dev/packages/image_card)
- [http](https://pub.dev/packages/http)
- [shared_preferences](https://pub.dev/packages/shared_preferences)
- [email_validator](https://pub.dev/packages/email_validator)
- [sqflite](https://pub.dev/packages/sqflite)
- [crypto](https://pub.dev/packages/crypto)


## :exclamation: Resolvendo Problemas 

Em [issues]() foram abertos alguns problemas gerados durante o desenvolvimento desse projeto e como foram resolvidos. 

## :gear: Tarefas em aberto

:memo: Sprint 4


## :lock: Licença 

The [MIT License]() (MIT)

Copyright :copyright: 2022 - Resquitem
