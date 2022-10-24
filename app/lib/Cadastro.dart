import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:navigation_drawer_menu/navigation_drawer_state.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Menu.dart';
import 'Login.dart';

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

  TextEditingController _textEditingControllerNome = TextEditingController();
  TextEditingController _textEditingControllerEmail = TextEditingController();
  TextEditingController _textEditingControllerSenha = TextEditingController();
  TextEditingController _textEditingControllerConfirmSenha = TextEditingController();

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

            Container (
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
            Container (
              margin: EdgeInsets.only(left: 32, top: 30, right: 32),
              child: TextFormField(
                controller: _textEditingControllerEmail,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  icon: const Icon(Icons.email),
                  hintText: 'Enter your e-mail for login',
                  labelText: 'E-mail',
                ),
                validator: (value) {
                  if (value == "") {
                    return 'Please enter valid e-mail';
                  }
                  return null;
                },
              ),
            ),

            Container (
              margin: EdgeInsets.only(left: 32, top: 30, right: 32),
              child: TextFormField(
                controller: _textEditingControllerSenha,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  icon: const Icon(Icons.lock),
                  hintText: 'Enter your password',
                  labelText: 'Password',
                  suffixIcon: GestureDetector(
                    child: Icon(_showPassword == false ? Icons.visibility_off : Icons.visibility, color: Colors.black38),
                    onTap: () {
                      setState(() {
                        _showPassword = !_showPassword;
                      });
                    }
                  ),
                ),
                obscureText: _showPassword == false ? true: false,
                validator: (value) {
                  if (value == "") {
                    return 'Please enter valid password';
                  }
                  return null;
                },
              ),
            ),

            Container (
              margin: EdgeInsets.only(left: 32, top: 30, right: 32),
              child: TextFormField(
                controller: _textEditingControllerConfirmSenha,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  icon: const Icon(Icons.lock),
                  hintText: 'Confirm your password',
                  labelText: 'Confirm Password',
                  suffixIcon: GestureDetector(
                      child: Icon(_showConfirmPassword == false ? Icons.visibility_off : Icons.visibility, color: Colors.black38),
                      onTap: () {
                        setState(() {
                          _showConfirmPassword = !_showConfirmPassword;
                        });
                      }
                  ),
                ),
                obscureText: _showConfirmPassword == false ? true: false,
                validator: (value) {
                  if (value == "") {
                    return 'Please enter valid password';
                  }
                  return null;
                },
              ),
            ),

            Container (
              margin: EdgeInsets.only(left: 32, top: 50, right: 32),
              child: Row (
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    child: Container (
                      margin: EdgeInsets.only(right: 50),
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
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Login()));
                    },
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
                    onPressed: () => {
                      //if (ingredientes.length > 0)
                      //{
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ShowNull()),
                      ),
                      // },
                    },
                  ),
                ],
              ),
              ),
          ],
        ),
      ),
    );
  }
}
