import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:email_validator/email_validator.dart';
import 'package:navigation_drawer_menu/navigation_drawer_state.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Menu.dart';
import 'Login.dart';
import 'DAO.dart';
import 'Usuario.dart';

class Cadastro extends StatefulWidget {
  @override
  State<Cadastro> createState() => _Cadastro();
}

class _Cadastro extends State<Cadastro> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  final _formKey = GlobalKey<FormState>();
  bool _showPassword = false;
  bool _showConfirmPassword = false;
  String _errorMessage = "";
  int idUsuario = 0;
  Usuario userFromBD = new Usuario(-1, "", "", "");

  DAO dao = new DAO();

  TextEditingController _textEditingControllerNome = TextEditingController();
  TextEditingController _textEditingControllerEmail = TextEditingController();
  TextEditingController _textEditingControllerSenha = TextEditingController();
  TextEditingController _textEditingControllerConfirmSenha =
      TextEditingController();

  _salvarDados(int id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(
        "isLogged", id); // a chave será usada para recuperar dados
    print("Operação salvar: ${id}");
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 32, top: 0, right: 32),
              child: Row(
                children: [
                  Text(
                    "Sign up",
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
                validator: (value) {
                  if (value == "") {
                    return 'Please enter some text';
                  }
                  return null;
                },
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
                validator: (value) {
                  if (value == "") {
                    return 'Please enter valid password';
                  }
                  return null;
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 32, top: 30, right: 32, bottom: 50),
              child: TextFormField(
                controller: _textEditingControllerConfirmSenha,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  icon: const Icon(Icons.lock),
                  hintText: 'Confirm your password',
                  labelText: 'Confirm Password',
                  suffixIcon: GestureDetector(
                      child: Icon(
                          _showConfirmPassword == false
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.black38),
                      onTap: () {
                        setState(() {
                          _showConfirmPassword = !_showConfirmPassword;
                        });
                      }),
                ),
                obscureText: _showConfirmPassword == false ? true : false,
                validator: (value) {
                  if (value == "") {
                    return 'Please enter valid password';
                  }
                  return null;
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: Text(
                _errorMessage,
                style: TextStyle(color: Colors.red),
              ),
            ),

            ElevatedButton(
              child: Text("Create",
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
              onPressed: () async => {
                if (_textEditingControllerNome.text != "" &&
                    _textEditingControllerEmail.text != "" &&
                    _textEditingControllerSenha.text != "" &&
                    _textEditingControllerConfirmSenha.text != "")
                  {
                    if (_textEditingControllerSenha.text ==
                            _textEditingControllerConfirmSenha.text &&
                        EmailValidator.validate(
                            _textEditingControllerEmail.text, true))
                      {
                        userFromBD = await dao.listarUnicoUsuario(
                          _textEditingControllerEmail.text),
                        if ( userFromBD.getID() == -1)
                          {
                            // Salvar usuário no banco de dados
                            idUsuario = await dao.salvarDadosUsuario(
                                _textEditingControllerNome.text,
                                _textEditingControllerEmail.text,
                                _textEditingControllerSenha.text),
                            // Salvar ID do usuário criado no shared preferences e logar usuário
                            await _salvarDados(idUsuario),
                            // Mostrar todos os usuários criados no banco até o momento
                            await dao.listarUsuarios(),

                            // Redirecionar para tela de início
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => MyApp()),
                            ),
                          }
                        else
                          {
                            print("Entrei no error message"),
                            setState(() {
                              _errorMessage = "Email already exists.";
                            }),
                          }
                      }
                  }
              },
            ),


            InkWell(
              child: Container(
                margin: EdgeInsets.only(right: 32, left: 32, top: 30),
                child: Text(
                  "Already have an account?",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Login()));
              },
            ),
          ],
        ),
      ),
    );
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
