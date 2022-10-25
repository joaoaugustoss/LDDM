import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:navigation_drawer_menu/navigation_drawer_state.dart';
import 'package:google_fonts/google_fonts.dart';

class DadosCadastro extends StatefulWidget {

  @override
  State<DadosCadastro> createState() => _DadosCadastro();
}

class _DadosCadastro extends State<DadosCadastro> {
  final NavigationDrawerState state = NavigationDrawerState();
  double value = 3.5;
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 32, top: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Dados da Conta",
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
           ],
        ),
      ),
    );
  }
}