import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:navigation_drawer_menu/navigation_drawer_state.dart';
import 'package:google_fonts/google_fonts.dart';
import 'objetoReceita.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';

class Receita extends StatefulWidget {
  Receitas receita;

  Receita({required this.receita});

  @override
  State<Receita> createState() => _Receita();
}

class _Receita extends State<Receita> {
  final NavigationDrawerState state = NavigationDrawerState();
  double value = 3.5;
  final TextEditingController _textEditingController = TextEditingController();

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

            Container(
              padding: EdgeInsets.only(left: 32, top: 10),
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget.receita.ingredientes.length,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          Text("\u2022 ",
                              style:
                              TextStyle(fontSize: 30, color: Colors.black)),
                          /*Text(
                              widget.receita.ingredientes[index].quantidade
                                  .toString(),
                              style:
                              TextStyle(fontSize: 20, color: Colors.black)),*/
                          Text(" ",
                              style:
                              TextStyle(fontSize: 20, color: Colors.black)),
                          /*Text(widget.receita.ingredientes[index].ingrediente,
                              style:
                              TextStyle(fontSize: 20, color: Colors.black)),*/
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
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget.receita.modoDePreparo.length,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          Flexible(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(top:5, bottom: 2),
                                      child: Text("Step ${index +1}:",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold)
                                      ),
                                    ),
                                    Text(widget.receita.modoDePreparo[index],
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.black)),
                                  ]))
                        ],
                      );
                    },
                  ),
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
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      minLines: 1,
                      maxLines: 2,
                      decoration:
                      const InputDecoration(hintText: "Write your name: "),
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                      onSubmitted: null,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(50),

                        /// here char limit is 50
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
                      starBuilder: (index, color) =>
                          Icon(
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
                    padding: const EdgeInsets.only(bottom: 32),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color.fromARGB(250, 8, 110, 167)),
                          minimumSize:
                          MaterialStateProperty.all(const Size(70, 40))),
                      onPressed: null,
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
          ],
        ),
      ),
    );
  }
}