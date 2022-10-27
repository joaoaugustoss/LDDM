import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:navigation_drawer_menu/navigation_drawer_state.dart';
import 'package:google_fonts/google_fonts.dart';

class DadosConta extends StatefulWidget {
  @override
  State<DadosConta> createState() => _DadosConta();
}

class _DadosConta extends State<DadosConta> {
  final _formKey = GlobalKey<FormState>();
  bool _showOldPassword = false;
  bool _showNewPassword = false;
  bool _showConfirmNewPassword = false;

  TextEditingController _textEditingControllerNome = TextEditingController();
  TextEditingController _textEditingControllerEmail = TextEditingController();
  TextEditingController _textEditingControllerOldSenha = TextEditingController();
  TextEditingController _textEditingControllerNewSenha = TextEditingController();
  TextEditingController _textEditingControllerConfirmNewSenha = TextEditingController();

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
                validator: (value) {
                  if (value == "") {
                    return 'Please enter valid e-mail';
                  }
                  return null;
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
                              : Icons
                              .visibility, color: Colors.black38),
                      onTap: () {
                        setState(() {
                          _showOldPassword = !_showOldPassword;
                        });
                      }
                  ),
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
                              : Icons
                              .visibility, color: Colors.black38),
                      onTap: () {
                        setState(() {
                          _showNewPassword = !_showNewPassword;
                        });
                      }
                  ),
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
                      child: Icon(_showConfirmNewPassword == false
                          ? Icons.visibility_off
                          : Icons.visibility, color: Colors.black38),
                      onTap: () {
                        setState(() {
                          _showConfirmNewPassword = !_showConfirmNewPassword;
                        });
                      }
                  ),
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
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible (
                        child: Text("Observation: To change the e-mail, enter the current password.",
                            style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                    letterSpacing: .5,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black
                                )
                            )
                        )
                      )
                    ]
                )
            ),

            Container(
              margin: EdgeInsets.only(left: 32, top: 50, right: 32, bottom: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Container (
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
                        //if (ingredientes.length > 0)
                        //{
                        //Navigator.push(
                        context,
                        //MaterialPageRoute(builder: (context) => ShowNull()),
                        //),
                        // },
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
                      onPressed: () =>
                      {
                        //if (ingredientes.length > 0)
                        //{
                        //Navigator.push(
                        context,
                        //MaterialPageRoute(builder: (context) => ShowNull()),
                        //),
                        // },
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
