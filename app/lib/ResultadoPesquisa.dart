import 'package:flutter/material.dart';
import 'package:navigation_drawer_menu/navigation_drawer_state.dart';

class ResultadosBusca extends StatefulWidget {
  String valor;
  bool? salgado;
  bool? doce;
  bool? cafeDaManha;
  bool? almoco;
  bool? jantar;
  ResultadosBusca({required this.valor, required this.salgado, required this.doce, required this.cafeDaManha, required this.almoco, required this.jantar});

  @override
  State<ResultadosBusca> createState() => _ResultadosBusca();
}

class _ResultadosBusca extends State<ResultadosBusca> {
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
              Text( "Salgado: " +
                  (widget.salgado == true ? "True" : "False")
                 + "\nDoce: " + (widget.doce == true ? "True" : "False")
                 + "\nCafe: " + (widget.cafeDaManha == true ? "True" : "False")
                 + "\nAlmoço: " + (widget.almoco == true ? "True" : "False")
                 + "\nJantar: " + (widget.jantar == true ? "True\n" : "False\n"),
                style: TextStyle(
                  color: Colors.black,
                ),
            ),
              Text(
                widget.valor,
                style: TextStyle(
                  color: Colors.black,
                ),
            ),
           ],
          ),
        ),
    );
  }
}