import 'package:flutter/material.dart';
import 'package:image_card/image_card.dart';
import 'package:navigation_drawer_menu/navigation_drawer_state.dart';
import 'Receita.dart';
import 'objetoReceita.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ResultadosBusca extends StatefulWidget {
  String valor;
  bool? salgado;
  bool? doce;
  bool? cafeDaManha;
  bool? almoco;
  bool? jantar;
  List<String> ingredientes;

  ResultadosBusca(
      {required this.valor,
      required this.salgado,
      required this.doce,
      required this.cafeDaManha,
      required this.almoco,
      required this.jantar,
      required this.ingredientes,
      });

  @override
  State<ResultadosBusca> createState() => _ResultadosBusca();
}

class _ResultadosBusca extends State<ResultadosBusca> {
  final NavigationDrawerState state = NavigationDrawerState();
  List<Receitas> receitas = [];

  _recuperaReceita() async {
    String type = getType();
    var uri = Uri.parse("https://api.spoonacular.com/recipes/complexSearch?apiKey=c757f25b6b004ac09faef6bba5c1d00a&query=${widget.valor}&type=${type}&instructionsRequired=true&number=5");
    http.Response response;
    response = await http.get(uri);
    //print(json.decode(response.body));
    Map<String, dynamic> receita = new Map<String, dynamic>();
    Receitas receitinha;
    int size = json.decode(response.body)["results"].length;
    List<int> ids = [];

    for(int i = 0; i < size; i++){
      receita = json.decode(response.body)["results"][i];
      ids.add(receita["id"]);
    }


    for (int i = 0; i < ids.length; i++) {
      uri = Uri.parse("https://api.spoonacular.com/recipes/${ids[i]}/information?apiKey=c757f25b6b004ac09faef6bba5c1d00a");
      response = await http.get(uri);
      receita = json.decode(response.body);
      receitinha = Receitas(
          receita["id"],
          receita["title"],
          "summary",
          receita["image"],
          receita["servings"],
          receita["aggregateLikes"],
          [],
          getIngredients(receita),
          removeTags(receita["instructions"]),
          receita["readyInMinutes"]);
      receitas.add(receitinha);
    }
  }

  String getType(){
    List<String> aux = [];
    String resp = "";
    widget.salgado == true ? aux.add("snack") : resp;
    (widget.doce == true ? aux.add("dessert") : resp);
    (widget.cafeDaManha == true ? aux.add("breakfast") : resp);
    (widget.almoco == true ? aux.add("main course") : resp);
    (widget.jantar == true ? aux.add("snack") : resp);
    for(int i = 0; i < aux.length; i++){
      resp += aux[i];
      if(i != aux.length-1)
        resp += ",";
    }
    return resp;
  }

  String removeTags(String line){
    String resp = "";
    int i = 0;
    while(i < line.length){ //enquanto i for menor que o tamanho da String linha
      if(line[i] == '<'){ // é testado para verificar se o contador i ainda está dentro das tags
        i++;
        while(line[i] != '>') i++; //ao encontrar o sinal de fechamento das tags o laço de repetição é encerrado
      } else if(line[i] == '&'){ //mesmo tratamento de cima mas para outras exceções presentes em alguns outros arquivos
        i++;
        while(line[i] != ';') i++;
      } else { //o que estiver fora das tags é concatenado a String resp a ser retornada
        resp += line[i];
      }
      i++;
    }
    return resp;
  }

  List<String> getIngredients(Map<String, dynamic> obj){
    List<String> resp = [];

    for(int i = 0; i < obj["extendedIngredients"].length; i++){
      resp.add(obj["extendedIngredients"][i]["original"]);
    }

    return resp;
  }

  FutureBuilder vasco(BuildContext context) {
    return FutureBuilder(
        future: _recuperaReceita(),
        builder: (context, AsyncSnapshot snapshot) {
          if (receitas.isEmpty) {
            print("vasco");
            return Center(child: CircularProgressIndicator());
          } else {
            print("da Gama");
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Flexible(
                          child: ListView.builder(
                            itemCount: receitas.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  FillImageCard(
                                    width: 300,
                                    heightImage: 140,
                                    imageProvider:
                                    NetworkImage(receitas[index].linkImagem),
                                    tags: [
                                      _tag(("${receitas[index].timeSpent} min"), () {}),
                                      _tag(receitas[index].descricao, () {})
                                    ],
                                    title: _title(context, receitas[index]),
                                    description: _content(),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        });
  }

  Widget _content({Color? color}) {
    return Text(
      '',
      style: TextStyle(color: Colors.black),
    );
  }

  Widget _title(BuildContext context, Receitas receita) {
    return InkWell(
      child: Text(
        receita.titulo,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => Receita(receita: receita)));
      },
    );
  }

  Widget _tag(String tag, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6), color: Colors.green),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        child: Text(
          tag,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Resquitem"),
      ),
      body: vasco(context),/*Container(
        child: Column(
          children: [
            Container(
              child: Expanded(
                child: Row(
                  children: [
                    Flexible(
                      child: ListView.builder(
                        itemCount: widget.ingredientes.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                              title: Text(widget.ingredientes[index],
                              style: TextStyle(color: Colors.black)),
                          );
                        },
                      ),
                    )

                  ],
                ),
              ),
            ),
          ],
        ),
      ),*/
    );
  }
}
