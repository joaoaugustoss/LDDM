import 'package:flutter/material.dart';
import 'package:navigation_drawer_menu/navigation_drawer_state.dart';
import 'package:google_fonts/google_fonts.dart';
import 'objetoReceita.dart';

class Receita extends StatefulWidget {
  Receitas receita;

  Receita({required this.receita});

  @override
  State<Receita> createState() => _Receita();
}

class _Receita extends State<Receita> {
  final NavigationDrawerState state = NavigationDrawerState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Resquitem"),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 32, top: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    widget.receita.titulo,
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
              padding: EdgeInsets.only(left: 32, top: 32, right: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Material(
                      elevation: 2.0,
                      child: Image.asset(widget.receita.linkImagem),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    //padding: EdgeInsets.only(left: 32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                          icon:
                              Icon(Icons.favorite, size: 40, color: Colors.red),
                          onPressed: () {},
                        ),
                        Text(widget.receita.quantidadeLikes.toString(),
                            style: TextStyle(
                              color: Colors.black,
                            )),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(Icons.speaker_notes_outlined,
                              size: 40, color: Colors.grey),
                          onPressed: () {},
                        ),
                        Text(widget.receita.listaComentarios.length.toString(),
                            style: TextStyle(
                              color: Colors.black,
                            )),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(Icons.restaurant_rounded,
                              size: 40, color: Colors.green),
                          onPressed: () {},
                        ),
                        Text(widget.receita.numeroDePorcoes.toString(),
                            style: TextStyle(
                              color: Colors.black,
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 32, top: 35),
              child: Row(children: [
                Text(
                  "Ingredients:",
                  textAlign: TextAlign.left,
                  style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                        letterSpacing: .5,
                        fontSize: 25,
                        color: Color.fromARGB(250, 0, 0, 0)),
                  ),
                ),
              ]),
            ),
            Container (
                padding: EdgeInsets.only(left: 32, top: 10),
              child: Row (
                children: [
                  Text("\u2022 ", style: TextStyle(fontSize: 30, color: Colors.black)),
                  Text("Teste ingrediente", style: TextStyle(fontSize: 20, color: Colors.black)),
                ],
              )
            ),
          ],
        ),
      ),
    );
  }
}
