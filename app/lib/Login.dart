import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:navigation_drawer_menu/navigation_drawer_state.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _Login();
}

class _Login extends State<Login> {
  bool _showPassword = false;
  final NavigationDrawerState state = NavigationDrawerState();
  TextEditingController _textEditingControllerEmail = TextEditingController();
  TextEditingController _textEditingControllerSenha = TextEditingController();

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
                      onPressed: () => {
                        //if (ingredientes.length > 0)
                        //{
                        /*
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyApp()),
                ),*/
                        // },
                      },
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
