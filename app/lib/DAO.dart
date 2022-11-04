import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'Usuario.dart';
import 'Comentario.dart';

class DAO {

  Future<Database>_recuperarBancoDados() async {
    final path = await getDatabasesPath();
    final localBD = join(path, "ResquitemBanco.db");

    var retorno = await openDatabase(
        localBD,
        version: 3,
        onCreate: (db, dbVersaoRecente) {
          String sql = "CREATE TABLE usuarios (id INTEGER PRIMARY KEY AUTOINCREMENT, nome VARCHAR, email VARCHAR, senha VARCHAR)";
          db.execute(sql);
          String sql1 = "CREATE TABLE comentarios (id INTEGER PRIMARY KEY AUTOINCREMENT, comentario VARCHAR, nota REAL, nomeusuario VARCHAR, idreceita INTEGER, idusuario INTEGER, FOREIGN KEY(idusuario) REFERENCES usuarios(id))";
          // , FOREIGN KEY(idusuario) REFERENCES usuarios(id);
          db.execute(sql1); // tirei o fone rapidao
        },
        onConfigure: (db) async {
          await db.execute('PRAGMA foreign_keys = ON');
        },
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

  Future<int> salvarDadosComentario(String comentario, int IDReceita, int IDUsuario, String nomeUsuario, double nota) async {
    Database db = await _recuperarBancoDados();
    Map<String, dynamic> dadosComentario  = {
      "comentario" : comentario,
      "nota" : nota,
      "nomeusuario" : nomeUsuario,
      "idreceita": IDReceita,
      "idusuario" : IDUsuario,
    };

    print("AAAAAAAAA");
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

  Future<Usuario>listarUnicoUsuario(String email) async {
    Database db = await _recuperarBancoDados();
    Usuario user = new Usuario(-1, "", "", "");
    List usuario = await db.query(
      "usuarios",
      columns: ["id", "nome", "email", "senha"],
      where: "email = ?",
      whereArgs: [email]
    );

    if(!usuario.isEmpty) {
      user = new Usuario(
          usuario[0]["id"], usuario[0]["nome"], usuario[0]["email"],
          usuario[0]["senha"]);
    }

    print("user = ${user.toString()}");

    await db.close();
    return user;
  }

  Future<Usuario>listarUnicoUsuarioByID(int id) async {
    Database db = await _recuperarBancoDados();
    Usuario user = new Usuario(-1, "", "", "");
    List usuario = await db.query(
        "usuarios",
        columns: ["id", "nome", "email", "senha"],
        where: "id = ?",
        whereArgs: [id]
    );

    if(!usuario.isEmpty) {
      user = new Usuario(
          usuario[0]["id"], usuario[0]["nome"], usuario[0]["email"],
          usuario[0]["senha"]);
    }

    print("user = ${user.toString()}");

    await db.close();
    return user;
  }


  listarComentarios() async {
    Database db = await _recuperarBancoDados();
    String sql = "SELECT * FROM comentarios";

    List comentarios = await db.rawQuery(sql);

    for(var elm in comentarios) {
      print(" id: ${elm["id"]}   comentario: ${elm["comentario"]}   IDReceita: ${elm["idreceita"]} NomeUsuario: ${elm["nomeusuario"]} Nota: ${elm["nota"]}   IDUsuario: ${elm["idusuario"]}");
    }
    await db.close();
  } // to sem fone dnv - ok

  Future<List<dynamic>>listarComentariosByReceita(int idReceita) async {
    Database db = await _recuperarBancoDados();
    List comentariosFinal = [];
    List comentarios = await db.query(
        "comentarios",
        columns: ["id", "comentario", "nota" , "nomeusuario", "idreceita", "idusuario"],
        where: "idreceita = ?",
        whereArgs: [idReceita]
    );

    for(var elem in comentarios) {
      comentariosFinal.add(new Comentario(
          elem["id"], elem["nomeusuario"], elem["comentario"], elem["nota"],
        elem["idusuario"], elem["idreceita"]));
    }

    for(Comentario elem in comentariosFinal) {
      print("Comentario = ${elem.toString()}");
    }
    await db.close();
    return comentariosFinal;
  }

  updateUsuario(int id, String nome, String email, String senha) async {
    // CRIPTOGRAFIA DA SENHA:
    var bytesToHash = utf8.encode(senha);
    var converted = md5.convert(bytesToHash);

    Database db = await _recuperarBancoDados();
    Map<String, dynamic> dadosUsuario  = {
      "nome" : nome,
      "email" : email,
      "senha" : converted.toString()
    };

    int retorno = await db.update(
      "usuarios", dadosUsuario,
      where: "id = ?",
      whereArgs: [id],
    );

    print("UPDATEUsuario: ${retorno}");
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

    print("Excluir user: ${id}");
    Database db = await _recuperarBancoDados();
    int retorno = await db.delete(
        "usuarios",
        where: "id = ?",
        whereArgs: [id],
    );
    print("Item excluido: ${retorno}");
    await db.close();
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