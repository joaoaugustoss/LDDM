
class Ingrediente {
  int quantidade = 0;
  String ingrediente = "";
}

class Receitas {
  int id = 0;
  String titulo = "";
  String descricao = "";
  String linkImagem = "";
  int numeroDePorcoes = 0;
  int quantidadeLikes = 0;
  var listaComentarios = [];
  List<Ingrediente> ingredientes = [];

  Receitas(int id, String titulo, String descricao, String linkImagem, int numeroDePorcoes, int quantidadeLikes, var listaComentarios, List<Ingrediente> ingredientes) {
    this.id = id;
    this.titulo = titulo;
    this.descricao = descricao;
    this.linkImagem = linkImagem;
    this.numeroDePorcoes = numeroDePorcoes;
    this.quantidadeLikes = quantidadeLikes;
    this.listaComentarios = listaComentarios;
    this.ingredientes = ingredientes;
  }
}