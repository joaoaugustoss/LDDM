import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:navigation_drawer_menu/navigation_drawer_state.dart';
import 'package:google_fonts/google_fonts.dart';

class DadosConta extends StatefulWidget {
  @override
  State<DadosConta> createState() => _DadosConta();
}

class _DadosConta extends State<DadosConta> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  final _formKey = GlobalKey<FormState>();
  bool _showPassword = false;
  bool _showConfirmPassword = false;

  TextEditingController _textEditingControllerNome = TextEditingController();
  TextEditingController _textEditingControllerEmail = TextEditingController();
  TextEditingController _textEditingControllerSenha = TextEditingController();
  TextEditingController _textEditingControllerConfirmSenha =
      TextEditingController();

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
                  margin: EdgeInsets.only(left: 32, top: 50, right: 32),
                child: Row(
                  children: [
                    Text(
                      "Name:",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                            letterSpacing: .5,
                            fontSize: 25,
                            color: Color.fromARGB(250, 0, 0, 0)),
                      ),
                    ),
                    Container(
                      child:TextFormField(
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
                    )
                  ],
                )
              ),

              Container(
                  margin: EdgeInsets.only(left: 32, top: 50, right: 32),
                  child: Row(
                    children: [
                      Text(
                        "Name:",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                          textStyle: TextStyle(
                              letterSpacing: .5,
                              fontSize: 25,
                              color: Color.fromARGB(250, 0, 0, 0)),
                        ),
                      ),
                    ],
                  )
              )

              /*Container(
                child:TextFormField(
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
              )*/
            ]),
      ),
    );
  }
}
