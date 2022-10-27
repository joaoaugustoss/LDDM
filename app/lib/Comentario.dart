class Comentario {
  int _id = 0;
  String _comentario = "";
  int _idUsuario = 0;
  int _idReceita = 0;

  Comentario(
      int id,
      String comentario,
      int idUsuario,
      int idReceita,
      ) {
    this._id = id;
    this._comentario = comentario;
    this._idUsuario = idUsuario;
    this._idReceita = idReceita;
  }

  int getID() {
    return this._id;
  }

  String getComentario() {
    return this._comentario;
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

  void setIdUsuario(int idUs) {
    this._idUsuario = idUs;
  }

  void setIdReceita(int idRe) {
    this._idReceita = idRe;
  }

  String toString() {
    return "Comentario: id:${_id} - comentario: ${_comentario} - IDUsuario: ${_idUsuario} - IDReceita: ${_idReceita}";
  }
}
