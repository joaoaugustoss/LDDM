import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:navigation_drawer_menu/navigation_drawer_state.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:email_validator/email_validator.dart';
import 'Menu.dart';
import 'Usuario.dart';
import 'DAO.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

class DadosConta extends StatefulWidget {
  int logado;

  DadosConta({required this.logado});

  @override
  State<DadosConta> createState() => _DadosConta();
}

class _DadosConta extends State<DadosConta> {
  var bytesToHash;
  var converted;
  final _formKey = GlobalKey<FormState>();
  bool _showOldPassword = false;
  bool _showNewPassword = false;
  bool _showConfirmNewPassword = false;
  String _errorMessage = "";
  int logado = -1;
  DAO dao = new DAO();
  Usuario userFromBD = new Usuario(-1, "", "", "");
  String email = "";
  String nome = "";
  TextEditingController _textEditingControllerNome = TextEditingController();
  TextEditingController _textEditingControllerEmail = TextEditingController();
  TextEditingController _textEditingControllerOldSenha =
  TextEditingController();
  TextEditingController _textEditingControllerNewSenha =
  TextEditingController();
  TextEditingController _textEditingControllerConfirmNewSenha =
  TextEditingController();

  void isLogado() async {
    userFromBD = await dao.listarUnicoUsuarioByID(widget.logado);
    nome = userFromBD.getNome();
    email = userFromBD.getEmail();

    _textEditingControllerNome = TextEditingController(text: nome);
    _textEditingControllerEmail = TextEditingController(text: email);
    print("Dados conta: Operação recuperar: ${widget.logado}");
  }

  void initState() {
    super.initState();
    isLogado();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 32, top: 30, right: 32),
              child: Row(
                children: [
                  Text(
                    "My Account",
                    textAlign: TextAlign.left,
                    style: GoogleFonts.comfortaa(
                      textStyle: TextStyle(
                        letterSpacing: .5,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(250, 8, 110, 167),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 32, top: 30, right: 32),
              child: TextFormField(
                controller: _textEditingControllerNome,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  icon: const Icon(Icons.person),
                  hintText: 'Enter your full name',
                  labelText: 'Name',
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 32, top: 30, right: 32),
              child: TextFormField(
                controller: _textEditingControllerEmail,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  icon: const Icon(Icons.email),
                  hintText: 'Enter your e-mail for login',
                  labelText: 'E-mail',
                ),
                onChanged: (val) {
                  validateEmail(val);
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 32, top: 30, right: 32),
              child: TextFormField(
                controller: _textEditingControllerOldSenha,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  icon: const Icon(Icons.lock),
                  hintText: 'Enter your old password',
                  labelText: 'Old password',
                  suffixIcon: GestureDetector(
                      child: Icon(
                          _showOldPassword == false
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.black38),
                      onTap: () {
                        setState(() {
                          _showOldPassword = !_showOldPassword;
                        });
                      }),
                ),
                obscureText: _showOldPassword == false ? true : false,
                validator: (value) {
                  if (value == "") {
                    return 'Please enter valid password';
                  }
                  return null;
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 32, top: 30, right: 32),
              child: TextFormField(
                controller: _textEditingControllerNewSenha,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  icon: const Icon(Icons.lock),
                  hintText: 'Enter your new password',
                  labelText: 'New password',
                  suffixIcon: GestureDetector(
                      child: Icon(
                          _showNewPassword == false
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.black38),
                      onTap: () {
                        setState(() {
                          _showNewPassword = !_showNewPassword;
                        });
                      }),
                ),
                obscureText: _showNewPassword == false ? true : false,
                validator: (value) {
                  if (value == "") {
                    return 'Please enter valid password';
                  }
                  return null;
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 32, top: 30, right: 32),
              child: TextFormField(
                controller: _textEditingControllerConfirmNewSenha,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  icon: const Icon(Icons.lock),
                  hintText: 'Confirm your new password',
                  labelText: 'Confirm your new password',
                  suffixIcon: GestureDetector(
                      child: Icon(
                          _showConfirmNewPassword == false
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.black38),
                      onTap: () {
                        setState(() {
                          _showConfirmNewPassword = !_showConfirmNewPassword;
                        });
                      }),
                ),
                obscureText: _showConfirmNewPassword == false ? true : false,
                validator: (value) {
                  if (value == "") {
                    return 'Please enter valid password';
                  }
                  return null;
                },
              ),
            ),
            Container(
                margin: EdgeInsets.only(left: 32, top: 50, right: 32),
                child:
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Flexible(
                      child: Text(
                          "Observation: To change any data it is necessary to inform the current password.",
                          style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                  letterSpacing: .5,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black))))
                ])),
            Padding(
              padding: const EdgeInsets.only(right: 32, left: 32, top: 50),
              child: Text(
                _errorMessage,
                style: TextStyle(color: Colors.red),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 32, top: 30, right: 32, bottom: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 30),
                    child: ElevatedButton(
                      child: Text("Delete",
                          style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                  letterSpacing: .5,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(250, 250, 250, 250)))),
                      style: ButtonStyle(
                          backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.red),
                          minimumSize: MaterialStateProperty.all(Size(70, 40))),
                      onPressed: () =>
                      {
                        _showSimpleModalDialog(context),
                      },
                    ),
                  ),
                  Container(
                    child: ElevatedButton(
                      child: Text("Edit",
                          style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                  letterSpacing: .5,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(250, 250, 250, 250)))),
                      style: ButtonStyle(
                          backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.green),
                          minimumSize: MaterialStateProperty.all(Size(70, 40))),
                      onPressed: () async =>
                      {
                        // Criptografar senha atual:
                        bytesToHash = utf8.encode(_textEditingControllerOldSenha.text),
                        converted = md5.convert(bytesToHash),

                        // Se senha antiga não é igual a senha guardada no banco, não é permitido alterar os dados
                        if (converted.toString() == userFromBD.getSenha()) {

                          // Se senha, nome e email for diferente de vazio e o email for válido
                          if (_textEditingControllerOldSenha.text != "" &&
                              _textEditingControllerNome.text != "" &&
                              _textEditingControllerEmail.text != "" &&
                              EmailValidator.validate(
                                  _textEditingControllerEmail.text, true))
                            {
                              // Se a nova senha e a confirmação da nova senha forem diferentes de vazio e as duas forem iguais
                              if (_textEditingControllerNewSenha.text != "" &&
                                  _textEditingControllerConfirmNewSenha.text !=
                                      "" && _textEditingControllerNewSenha.text ==
                                  _textEditingControllerConfirmNewSenha.text) {

                                // Enviar para atualizar a nova senha cadastrada e outros dados alterados como nome e email
                                await dao.updateUsuario(widget.logado, _textEditingControllerNome.text, _textEditingControllerEmail.text, _textEditingControllerNewSenha.text),
                                print("Alterei nova senha"),

                                // Mostrar se alterou os dados no banco
                                await dao.listarUsuarios(),

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => MyApp()),
                                ),

                              } else
                                if (_textEditingControllerNewSenha.text == "" &&
                                    _textEditingControllerConfirmNewSenha.text ==
                                        "") {
                                  // Enviar para atualizar os dados alterados como nome e email
                                  await dao.updateUsuario(widget.logado, _textEditingControllerNome.text, _textEditingControllerEmail.text, _textEditingControllerOldSenha.text),
                                  print("Alterar dados nome e email"),

                                  // Mostrar se alterou os dados no banco
                                  await dao.listarUsuarios(),

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => MyApp()),
                                  ),

                                } else
                                  {
                                    setState(() {
                                      _errorMessage =
                                      "New password and confirmation of new password are different.";
                                    }),
                                  }
                            } else
                            {
                              setState(() {
                                _errorMessage = "Invalid data.";
                              }),
                            }
                          // TODO: Verificar o que tá alterando para validar se pode ou não ter uma ação ao apertar Edit
                        } else {
                          setState(() {
                            _errorMessage = "Invalid current password.";
                          }),
                        },
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 50),
              child: IconButton(
                  icon: Icon(Icons.logout, size: 40, color: Colors.blue),
                  onPressed: () {
                    _removerDados();
                    // Redirecionar para tela de início
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyApp()),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }

  _showSimpleModalDialog(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            child: Container(
              constraints: BoxConstraints(maxHeight: 350),
              child: Padding(
                padding: const EdgeInsets.only(right: 20, left: 20, top: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Are you sure you want to delete your account?",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          letterSpacing: .5,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),

                    Container(
                      margin: EdgeInsets.only(top: 30),
                      child: ElevatedButton(
                        child: Text("Delete",
                            style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                    letterSpacing: .5,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(
                                        250, 250, 250, 250)))),
                        style: ButtonStyle(
                            backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.red),
                            minimumSize: MaterialStateProperty.all(Size(
                                70, 40))),
                        onPressed: () async =>
                        {
                          // Excluir conta do usuário do banco
                          await dao.excluirUsuario(widget.logado),
                          // Deslogar usuário retirando id do shared Preferences
                          await _removerDados(),

                          // Listar usuários do banco
                          await dao.listarUsuarios(),

                          // Ir para tela inicial
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MyApp()),
                          ),
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: ElevatedButton(
                        child: Text("Cancel",
                            style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                    letterSpacing: .5,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(
                                        250, 250, 250, 250)))),
                        style: ButtonStyle(
                            backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.green),
                            minimumSize: MaterialStateProperty.all(Size(
                                70, 40))),
                        onPressed: () =>
                        {
                          Navigator.pop(context, false),
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  _removerDados() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("isLogged");
    print("Operação remover");
  }

  void validateEmail(String val) {
    if (val.isEmpty) {
      setState(() {
        _errorMessage = "Email can not be empty.";
      });
    } else if (!EmailValidator.validate(val, true)) {
      setState(() {
        _errorMessage = "Invalid Email Address.";
      });
    } else {
      setState(() {
        _errorMessage = "";
      });
    }
  }
}
