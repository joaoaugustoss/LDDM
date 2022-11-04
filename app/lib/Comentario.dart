class Comentario {
  int _id = 0;
  String _comentario = "";
  String _nomeUsuario = "";
  int _idUsuario = 0;
  int _idReceita = 0;
  double _nota = 0.00;

  Comentario(
      int id,
      String nomeUsuario,
      String comentario,
      double nota,
      int idUsuario,
      int idReceita,
      ) {
    this._id = id;
    this._comentario = comentario;
    this._nomeUsuario = nomeUsuario;
    this._nota = nota;
    this._idUsuario = idUsuario;
    this._idReceita = idReceita;
  }

  int getID() {
    return this._id;
  }

  String getComentario() {
    return this._comentario;
  }

  String getNomeUsuario() {
    return this._nomeUsuario;
  }

  int getIDUsuario() {
    return this._idUsuario;
  }

  int getIdReceita() {
    return this._idReceita;
  }

  double getNota() {
    return this._nota ;
  }

  void setID(int id) {
    this._id = id;
  }

  void setComentario(String comentario) {
    this._comentario = comentario;
  }

  void setNomeUsuario(String nomeUsuario) {
    this._nomeUsuario = nomeUsuario;
  }

  void setIdUsuario(int idUs) {
    this._idUsuario = idUs;
  }

  void setIdReceita(int idRe) {
    this._idReceita = idRe;
  }

  void setNota(double nota) {
    this._nota = nota;
  }

  String toString() {
    return "Comentario: id:$_id - Nome: $_nomeUsuario - comentario: $_comentario - IDUsuario: $_idUsuario - IDReceita: $_idReceita - Nota: $_nota" ;
  }
}
