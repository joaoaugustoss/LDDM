class Usuario {
  int _id = 0;
  String _nome = "";
  String _email = "";
  String _senha = "";

  Usuario(
      int id,
      String nome,
      String email,
      String senha,
      ) {
    this._id = id;
    this._nome = nome;
    this._email = email;
    this._senha = senha;
  }

  int getID() {
    return this._id;
  }

  String getNome() {
    return this._nome;
  }

  String getEmail() {
    return this._email;
  }

  String getSenha() {
    return this._senha;
  }

  void setID(int id) {
    this._id = id;
  }

  void setNome(String nome) {
    this._nome = nome;
  }

  void setEmail(String email) {
    this._email = email;
  }

  void setSenha(String senha) {
    this._senha = senha;
  }

  String toString() {
    return "Usuario: id:${_id} - nome: ${_nome} - email: ${_email} - senha: ${_senha}";
  }
}
