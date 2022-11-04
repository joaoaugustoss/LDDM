class Comentario {
  int _id = 0;
  String _comentario = "";
  String _nomeUsuario = "";
  int _idUsuario = 0;
  int _idReceita = 0;

  Comentario(
      int id,
      String nomeUsuario,
      String comentario,
      int idUsuario,
      int idReceita,
      ) {
    this._id = id;
    this._comentario = comentario;
    this._nomeUsuario = nomeUsuario;
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

  String toString() {
    return "Comentario: id:$_id - Nome: $_nomeUsuario comentario: $_comentario - IDUsuario: $_idUsuario - IDReceita: $_idReceita";
  }
}
