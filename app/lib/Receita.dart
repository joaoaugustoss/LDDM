import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:navigation_drawer_menu/navigation_drawer_state.dart';
import 'package:google_fonts/google_fonts.dart';
import 'objetoReceita.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'Usuario.dart';
import 'DAO.dart';

class Receita extends StatefulWidget {
  Receitas receita;

  Receita({required this.receita});

  @override
  State<Receita> createState() => _Receita();
}

class _Receita extends State<Receita> {
  final NavigationDrawerState state = NavigationDrawerState();
  double value = 3.5;
  int logado = -1;
  String comentario = "";
  final TextEditingController _textEditingController = TextEditingController();
  final controller = ScrollController();
  DAO dao = new DAO();
  Usuario usr = new Usuario(-1, "", "", "");
  String _errorMessage = "";
  var comentarios;
  List<String> items = List.generate(15, (index) => 'Item ${index + 1}');

  void initState() {
    super.initState();
    isLogado();
  }

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
              margin: EdgeInsets.only(left: 32, top: 30, right: 32),
              child: Wrap(
                //mainAxisAlignment: MainAxisAlignment.start,
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
                      child: Image.network(widget.receita.linkImagem),
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
                        Container(
                            padding: EdgeInsets.only(left: 15, top: 5),
                            child: Center(
                              child: Text(
                                  widget.receita.quantidadeLikes.toString(),
                                  style: TextStyle(
                                    color: Colors.black,
                                  )),
                            ))
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
                        Container(
                            padding: EdgeInsets.only(left: 15, top: 5),
                            child: Center(
                              child: Text(
                                  widget.receita.listaComentarios.length
                                      .toString(),
                                  style: TextStyle(
                                    color: Colors.black,
                                  )),
                            ))
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
                        Container(
                            padding: EdgeInsets.only(left: 15, top: 5),
                            child: Center(
                              child: Text(
                                  widget.receita.numeroDePorcoes.toString(),
                                  style: TextStyle(
                                    color: Colors.black,
                                  )),
                            ))
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
                  "Summary:",
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

            Container(
              padding: EdgeInsets.only(left: 32, top: 10, right: 32),
              child: Column(
                children: [
                  Text(widget.receita.descricao,
                      textAlign: TextAlign.justify,
                      style: TextStyle(fontSize: 20, color: Colors.black)),
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

            Container(
              padding: EdgeInsets.only(left: 32, top: 10),
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    //itemCount: widget.receita.ingredientes.length,
                    itemCount: widget.receita.ingredientes.length,
                    itemBuilder: (context, index) {
                      return Wrap(
                        children: [
                          /*Text("\u2022 ",
                              style:
                                  TextStyle(fontSize: 30, color: Colors.black)),*/
                          Text("\u2022 ${widget.receita.ingredientes[index]}",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black)),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),

            Container(
              padding: EdgeInsets.only(left: 32, top: 35),
              child: Row(children: [
                Text(
                  "Instructions:",
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

            Container(
              padding: EdgeInsets.only(left: 32, top: 10, right: 32),
              child: Column(
                children: [
                  Text(widget.receita.modoDePreparo,
                      textAlign: TextAlign.justify,
                      style: TextStyle(fontSize: 20, color: Colors.black)),
                ],
              ),
            ),

            //Formulário Comentários

            SingleChildScrollView(
                child: Column(children: [
              Container(
                margin: const EdgeInsets.only(left: 32, top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Comments",
                      textAlign: TextAlign.left,
                      style: GoogleFonts.comfortaa(
                        textStyle: const TextStyle(
                          letterSpacing: .5,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(250, 8, 110, 167),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 32, top: 15, right: 32, bottom: 10),
                child: TextField(
                  controller: _textEditingController,

                  /// controlador do nosso campo de texto
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  maxLines: 5,
                  minLines: 1,
                  decoration: const InputDecoration(
                    hintText: "Write your comment: (Max 150 characters)",
                    counterText: '',
                  ),
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                  onSubmitted: null,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(150),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 32, top: 25, right: 32, bottom: 32),
                child: RatingStars(
                  value: value,
                  onValueChanged: (v) {
                    //
                    setState(() {
                      value = v;
                    });
                  },
                  starBuilder: (index, color) => Icon(
                    Icons.restaurant_menu,
                    color: color,
                  ),
                  starCount: 5,
                  starSize: 20,
                  valueLabelColor: const Color(0xff9b9b9b),
                  valueLabelTextStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 12.0),
                  valueLabelRadius: 10,
                  maxValue: 5,
                  starSpacing: 2,
                  maxValueVisibility: true,
                  valueLabelVisibility: true,
                  animationDuration: const Duration(milliseconds: 1000),
                  valueLabelPadding:
                      const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
                  valueLabelMargin: const EdgeInsets.only(right: 8),
                  starOffColor: const Color(0xffe7e8ea),
                  starColor: Colors.yellow,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Text(
                  _errorMessage,
                  style: TextStyle(color: Colors.red),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 32),
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromARGB(250, 8, 110, 167)),
                      minimumSize:
                          MaterialStateProperty.all(const Size(70, 40))),
                  onPressed: () async => {
                    // Logado
                    if (logado != -1)
                      {
                        // Escrito algo
                        if (_textEditingController.text != "")
                          {
                            comentario = _textEditingController.text,
                            usr = await dao.listarUnicoUsuarioByID(logado),
                            await dao.salvarDadosComentario(
                                comentario,
                                widget.receita.getID(),
                                logado,
                                usr.getNome(),
                                value),
                            print("OPA :)"),
                            comentarios = await dao.listarComentariosByReceita(
                                widget.receita.getID()),
                            widget.receita.setComentarios(comentarios),
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Receita(receita: widget.receita))),
                          }
                        else
                          {
                            setState(() {
                              _errorMessage = "Comment can not be empty.";
                            }),
                          }
                      }
                    else
                      {
                        setState(() {
                          _errorMessage = "You must be logged in to comment.";
                        }),
                      }
                  },
                  child: Text("Comment",
                      style: GoogleFonts.roboto(
                          textStyle: const TextStyle(
                              letterSpacing: .5,
                              fontSize: 20,
                              fontWeight: FontWeight.normal,
                              color: Color.fromARGB(250, 250, 250, 250)))),
                ),
              ),
            ])),

            Container(
              padding:
                  EdgeInsets.only(left: 32, top: 10, bottom: 32, right: 32),
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget.receita.listaComentarios.length,
                    itemBuilder: (context, index) {
                      if (widget.receita.listaComentarios.length > 0) {
                        return Wrap(
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 5),
                              child: ListTile(
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      width: 2,
                                      color: Color.fromARGB(250, 8, 110, 167)),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                title: Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(left: 5),
                                        child: Text(
                                          "${widget.receita.listaComentarios[index].getNomeUsuario()}",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Container(
                                        padding:
                                            EdgeInsets.only(top: 5, bottom: 5),
                                        child: RatingBar.builder(
                                          initialRating: widget
                                              .receita.listaComentarios[index]
                                              .getNota(),
                                          minRating: 1,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemSize: 25,
                                          itemCount: 5,
                                          itemPadding: EdgeInsets.symmetric(
                                              horizontal: 4.0),
                                          itemBuilder: (context, _) => Icon(
                                            Icons.restaurant_menu,
                                            color: Colors.yellow,
                                          ),
                                          unratedColor: const Color(0xffe7e8ea),
                                          onRatingUpdate: (rating) {},
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                subtitle: Container(
                                  padding: EdgeInsets.only(left: 5),
                                  child: Text(
                                      "${widget.receita.listaComentarios[index].getComentario()}",
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.black)),
                                ),
                              ),
                            ),
                          ],
                        );
                      } else {
                        print("ELSE");
                        return Wrap(children: [
                          Text("\u2022 PORRA",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black))
                        ]);
                      }
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

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  void isLogado() async {
    logado = await _prefs.then((SharedPreferences prefs) {
      return prefs.getInt('isLogged') ?? -1;
    });

    print("Operação recuperar: $logado");
  }
}
