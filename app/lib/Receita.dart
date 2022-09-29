import 'package:flutter/material.dart';
import 'package:navigation_drawer_menu/navigation_drawer_state.dart';
import 'package:google_fonts/google_fonts.dart';

class Receita extends StatefulWidget {
  int id;

  Receita({required this.id});

  @override
  State<Receita> createState() => _Receita();
}

class _Receita extends State<Receita> {
  final NavigationDrawerState state = NavigationDrawerState();

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(
        title: const Text("Resquitem"),
      ),
      body: Container(
        child: Column(
          children: [
            Text(
              "Receita: " + widget.id.toString(),
              style: TextStyle(
                color: Colors.black,
              )
            ),
          ],
        ),
      ),
    );
  }
}