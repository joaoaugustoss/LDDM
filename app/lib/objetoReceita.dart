/*class Ingrediente {
  int quantidade = 0;
  String ingrediente = "";

  Ingrediente(int i, String s) {
    this.quantidade = i;
    this.ingrediente = s;
  }
}*/

class Receitas {
  int id = 0;
  String titulo = "";
  String descricao = "";
  String linkImagem = "";
  int numeroDePorcoes = 0;
  int quantidadeLikes = 0;
  var listaComentarios = [];
  String modoDePreparo = "";
  List<String> ingredientes = [];
  int timeSpent = 0;
  bool vegan = false;
  bool vegetarian = false;

  Receitas(
      int id,
      String titulo,
      String descricao,
      String linkImagem,
      int numeroDePorcoes,
      int quantidadeLikes,
      var listaComentarios,
      List<String> ingredientes,
      String modoDePreparo,
      int timeSpent, bool vegan, bool vegetarian) {
    this.id = id;
    this.titulo = titulo;
    this.descricao = descricao;
    this.linkImagem = linkImagem;
    this.numeroDePorcoes = numeroDePorcoes;
    this.quantidadeLikes = quantidadeLikes;
    this.listaComentarios = listaComentarios;
    this.ingredientes = ingredientes;
    this.modoDePreparo = modoDePreparo;
    this.timeSpent = timeSpent;
    this.vegan = vegan;
    this.vegetarian = vegetarian;
  }
}
