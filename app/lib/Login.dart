import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:navigation_drawer_menu/navigation_drawer_state.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:email_validator/email_validator.dart';
import 'DAO.dart';
import 'Menu.dart';
import 'Usuario.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _Login();
}

class _Login extends State<Login> {
  bool _showPassword = false;
  DAO dao = new DAO();
  Usuario userFromBD = new Usuario(-1, "", "", "");
  String _errorMessage = "";
  final NavigationDrawerState state = NavigationDrawerState();
  TextEditingController _textEditingControllerEmail = TextEditingController();
  TextEditingController _textEditingControllerSenha = TextEditingController();
  var bytesToHash;
  var converted;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Resquitem"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 32, top: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Sign in",
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
                controller: _textEditingControllerEmail,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  icon: const Icon(Icons.email),
                  hintText: 'Enter your e-mail',
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
                controller: _textEditingControllerSenha,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  icon: const Icon(Icons.lock),
                  hintText: 'Enter your password',
                  labelText: 'Password',
                  suffixIcon: GestureDetector(
                      child: Icon(
                          _showPassword == false
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.black38),
                      onTap: () {
                        setState(() {
                          _showPassword = !_showPassword;
                        });
                      }),
                ),
                obscureText: _showPassword == false ? true : false,
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Text(
                _errorMessage,
                style: TextStyle(color: Colors.red),
              ),
            ),

            Container(
                margin: EdgeInsets.only(left: 32, top: 30, right: 32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      child: Text("Enter",
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
                        if (_textEditingControllerEmail.text != "" &&
                            _textEditingControllerSenha.text != "" &&
                            EmailValidator.validate(
                                _textEditingControllerEmail.text, true)) {
                          userFromBD = await dao.listarUnicoUsuario(
                              _textEditingControllerEmail.text),

                          if(userFromBD.getID() != -1) {
                            // CRIPTOGRAFIA DA SENHA:
                            bytesToHash = utf8.encode(
                                _textEditingControllerSenha.text),
                            converted = md5.convert(bytesToHash),

                            if (userFromBD.getSenha() == converted.toString()) {
                              // Salvar ID do usuário logado no shared Preferences
                              await _salvarDados(userFromBD.getID()),
                              // Ir para página inicial
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyApp()),
                              ),
                            } else
                              {
                                setState(() {
                                  _errorMessage = "Invalid email or password.";
                                }),
                              }
                          } else
                            {
                              setState(() {
                                _errorMessage = "Invalid email or password.";
                              }),
                            }
                        }
                      },
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  _salvarDados(int id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(
        "isLogged", id); // a chave será usada para recuperar dados
    print("Operação salvar: ${id}");
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
