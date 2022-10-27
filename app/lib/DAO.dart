import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

class DAO {

  Future<Database>_recuperarBancoDados() async {
    final path = await getDatabasesPath();
    final localBD = join(path, "ResquitemBanco.db");

    var retorno = await openDatabase(
        localBD,
        version: 1,
        onCreate: (db, dbVersaoRecente) {
          String sql = "CREATE TABLE usuarios (id INTEGER PRIMARY KEY AUTOINCREMENT, nome VARCHAR, email VARCHAR, senha VARCHAR); CREATE TABLE comentarios (id INTEGER PRIMARY KEY AUTOINCREMENT, comentario VARCHAR, idreceita INTEGER, idsuario INTEGER, FOREIGN KEY(idsuario) REFERENCES usuarios(id));";
          db.execute(sql);
        }
    );

    print("Aberto " + retorno.isOpen.toString());
    return retorno;
  }

  Future<int> salvarDadosUsuario(String nome, String email, String senha) async {
    // CRIPTOGRAFIA DA SENHA:
    var bytesToHash = utf8.encode(senha);
    var converted = md5.convert(bytesToHash);

    print("MD5 SENHA: ${converted}");

    Database db = await _recuperarBancoDados();
    Map<String, dynamic> dadosUsuario  = {
      "nome" : nome,
      "email": email,
      "senha" : converted.toString(),
    };

    int id = await db.insert("usuarios", dadosUsuario);
    print("IDUser: ${id}");
    await db.close();
    return id;
  }

  Future<int> salvarDadosComentario(String comentario, int IDReceita, int IDUsuario) async {
    Database db = await _recuperarBancoDados();
    Map<String, dynamic> dadosComentario  = {
      "comentario" : comentario,
      "idreceita": IDReceita,
      "idusuario" : IDUsuario,
    };

    int id = await db.insert("comentarios", dadosComentario);
    print("IDComentario: ${id}");

    await db.close();
    return id;
  }

  listarUsuarios() async {
    Database db = await _recuperarBancoDados();
    String sql = "SELECT * FROM usuarios";

    List usuarios = await db.rawQuery(sql);

    for(var elm in usuarios) {
      print(" id: ${elm["id"]}   nome: ${elm["nome"]}   email: ${elm["email"]}   senha: ${elm["senha"]}");
    }
    await db.close();
  }

  listarComentarios() async {
    Database db = await _recuperarBancoDados();
    String sql = "SELECT * FROM comentarios";

    List comentarios = await db.rawQuery(sql);

    for(var elm in comentarios) {
      print(" id: ${elm["id"]}   comentario: ${elm["comentario"]}   IDReceita: ${elm["idreceita"]}   IDUsuario: ${elm["idusuario"]}");
    }
    await db.close();
  }

  updateUsuarioNome(int id, String nome) async {
    Database db = await _recuperarBancoDados();
    Map<String, dynamic> dadosUsuario  = {
      "nome" : nome,
    };

    int retorno = await db.update(
      "usuarios", dadosUsuario,
      where: "id = ?",
      whereArgs: [id],
    );

    print("UPDATENomeUsuario: ${retorno}");
    await db.close();
  }

  updateUsuarioEmail(int id, String email) async {
    Database db = await _recuperarBancoDados();
    Map<String, dynamic> dadosUsuario  = {
      "email" : email,
    };

    int retorno = await db.update(
      "usuarios", dadosUsuario,
      where: "id = ?",
      whereArgs: [id],
    );
    await db.close();
    print("UPDATEEmailUsuario: ${retorno}");
  }

  updateUsuarioSenha(int id, String senha) async {
    // CRIPTOGRAFIA DA SENHA:
    var bytesToHash = utf8.encode(senha);
    var converted = md5.convert(bytesToHash);

    Database db = await _recuperarBancoDados();
    Map<String, dynamic> dadosUsuario  = {
      "senha" : converted,
    };

    int retorno = await db.update(
      "usuarios", dadosUsuario,
      where: "id = ?",
      whereArgs: [id],
    );
    await db.close();
    print("UPDATESenhaUsuario: ${retorno}");
  }

  excluirUsuario(int id) async {
    Database db = await _recuperarBancoDados();
    int retorno = await db.delete(
        "usuarios",
        where: "id = ?",
        whereArgs: [id],
    );
    await db.close();
    print("Item excluido: ${retorno}");
  }

  excluirComentario(int id) async {
    Database db = await _recuperarBancoDados();
    int retorno = await db.delete(
      "comentarios",
      where: "id = ?",
      whereArgs: [id],
    );
    await db.close();
    print("Item excluido: ${retorno}");
  }
}