import 'package:flutter/material.dart';
import 'package:navigation_drawer_menu/navigation_drawer.dart';
import 'package:navigation_drawer_menu/navigation_drawer_menu.dart';
import 'package:navigation_drawer_menu/navigation_drawer_menu_frame.dart';
import 'package:navigation_drawer_menu/navigation_drawer_state.dart';
import 'package:image_card/image_card.dart';
import 'package:google_fonts/google_fonts.dart';
import 'ResultadoPesquisa.dart';
import 'Receita.dart';
import 'objetoReceita.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const searchValueKey = ValueKey('Search');
const listsValueKey = ValueKey('Lists');
const sobreValueKey = ValueKey('Sobre');

final Map<Key, MenuItemContent> menuItems = {
  searchValueKey: MenuItemContent(
      menuItem: MenuItemDefinition("Search", searchValueKey,
          iconData: Icons.shopping_basket)),
  listsValueKey: MenuItemContent(
      menuItem:
          MenuItemDefinition("Lists", listsValueKey, iconData: Icons.rule)),
  sobreValueKey: MenuItemContent(
      menuItem:
          MenuItemDefinition("About", sobreValueKey, iconData: Icons.info)),
};

Map<int, Color> color = {
  50: Color.fromRGBO(4, 131, 184, .1),
  100: Color.fromRGBO(4, 131, 184, .2),
  200: Color.fromRGBO(4, 131, 184, .3),
  300: Color.fromRGBO(4, 131, 184, .4),
  400: Color.fromRGBO(4, 131, 184, .5),
  500: Color.fromRGBO(4, 131, 184, .6),
  600: Color.fromRGBO(4, 131, 184, .7),
  700: Color.fromRGBO(4, 131, 184, .8),
  800: Color.fromRGBO(4, 131, 184, .9),
  900: Color.fromRGBO(4, 131, 184, 1),
};

const title = 'Resquitem';
MaterialColor menuColor = MaterialColor(0xFFE5E5E5, color);
MaterialColor sltColor = MaterialColor(0XFFFFFF, color);

final themeMenu = ThemeData(
  brightness: Brightness.light,
  textTheme: const TextTheme(bodyText2: TextStyle(color: Colors.white)),
  primaryColor: Color.fromARGB(250, 0, 0, 0),
  backgroundColor: Color.fromARGB(250, 0, 0, 0),
);

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final NavigationDrawerState state = NavigationDrawerState();

  @override
  Widget build(BuildContext materialAppContext) => MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      theme: themeMenu,
      home: Builder(
          builder: (context) => Scaffold(
              appBar: AppBar(
                  title: const Text(title),
                  leading: Builder(
                    builder: (iconButtonBuilderContext) => IconButton(
                      icon: const Icon(Icons.menu),
                      onPressed: () {
                        state.toggle(iconButtonBuilderContext);
                        setState(() {});
                      },
                      tooltip: 'Menu',
                    ),
                  )),
              drawer: NavigationDrawer(
                menuBuilder: Builder(builder: getMenu),
                menuMode: state.menuMode(context),
              ),
              body: NavigationDrawerMenuFrame(
                body: Builder(
                    builder: (c) => Center(
                        child: state.selectedMenuKey == null
                            ? ShowNull()
                            : state.selectedMenuKey == sobreValueKey
                                ? ShowAbout()
                                : state.selectedMenuKey == searchValueKey
                                    ? showSearch()
                                    : state.selectedMenuKey == listsValueKey
                                        ? ShowList()
                                        : const Text('Not selected'))),
                menuBackgroundColor: menuColor,
                menuBuilder: Builder(builder: getMenu),
                menuMode: state.menuMode(context),
              ))));

  Widget getMenu(BuildContext context) =>
      Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        NavigationDrawerMenu(
            highlightColor: Theme.of(context).indicatorColor,
            onSelectionChanged: (c, key) {
              state.selectedMenuKey = key;
              state.closeDrawer(c);
              setState(() {});
            },
            menuItems: menuItems.values.toList(),
            selectedMenuKey: state.selectedMenuKey,
            itemPadding: const EdgeInsets.only(left: 5, right: 5),
            buildMenuButtonContent: (menuItemDefinition, isSelected,
                    buildContentContext) =>
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Icon(menuItemDefinition.iconData,
                      color: isSelected
                          ? Theme.of(buildContentContext).backgroundColor
                          : Theme.of(buildContentContext)
                              .textTheme
                              .bodyText2!
                              .color),
                  if (state.menuMode(context) != MenuMode.Thin)
                    const SizedBox(
                      width: 10,
                    ),
                  if (state.menuMode(context) != MenuMode.Thin)
                    Text(menuItemDefinition.text,
                        style: isSelected
                            ? Theme.of(context).textTheme.bodyText2!.copyWith(
                                color: Theme.of(buildContentContext)
                                    .backgroundColor)
                            : Theme.of(buildContentContext).textTheme.bodyText2)
                ])),
      ]);
}

class ShowNull extends StatelessWidget {
  List<Receitas> receitas = [
    Receitas(1, "Rice", "Good rice", "assets/images/comida2.jpg", 5, 120, [], [], [
      "Preheat the oven to 200 degrees F.",
      "Whisk together the flour, pecans, granulated sugar, light brown sugar, baking powder, baking soda, and salt in a medium bowl.",
      "Whisk together the eggs, buttermilk, butter and vanilla extract and vanilla bean in a small bowl."
    ]),
    Receitas(2, "Bean", "Good bean", "assets/images/comida2.jpg", 5, 120, [],
        [], ["step 1", "step 2"]),
    Receitas(3, "Potato", "Good potato", "assets/images/comida2.jpg", 5, 120,
        [], [], []),
    Receitas(4, "Orange", "Good orange", "assets/images/comida3.jpg", 5, 120,
        [], [], []),
    Receitas(5, "Lemon", "Good lemon", "assets/images/comida3.jpg", 5, 120, [],
        [], []),
    Receitas(6, "Chicken", "Good chicken", "assets/images/comida3.jpg", 5, 120,
        [], [], [])
  ];

  _recuperaReceita() async {
    print("entrei");
    var uri = Uri.parse(
        "https://api.spoonacular.com/recipes/random/?apiKey=88c955d192cc4d43a20b78ade34db952&instructionsRequired=true&number=5");
    http.Response response;
    response = await http.get(uri);
    print(json.decode(response.body));
    Map<String, dynamic> receita = new Map<String, dynamic>();
    List<Map<String, dynamic>> retorno = [];
    for (int i = 0; i < json.decode(response.body).length - 1; i++) {
      // "'id' : 665469"
      receita = json.decode(response.body)[i];
      receitas.add(Receitas(
          receita["id"],
          receita["name"],
          "summary",
          receita["image"],
          receita["servings"],
          receita["aggregateLikes"],
          [],
          ["ingedients"],
          receita["instructions"]));
    }
  }

  /*@override
  void initState() {
    Future.delayed(Duration.zero, () => _recuperaReceita);
  }*/

  /*Widget vasco(BuildContext context) {
    return FutureBuilder<Container>(
        future: _recuperaReceita(),
        builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
          if (snapshot.hasData) {
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
                                        AssetImage(receitas[index].linkImagem),
                                    tags: [
                                      _tag(receitas[index].titulo, () {}),
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
          return Container(child: CircularProgressIndicator());
        });
  }*/

  @override
  Widget build(BuildContext context) {
    //vasco(context);
    //print(receitas.length);
    return /*vasco(context);*/Container(
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
                                AssetImage(receitas[index].linkImagem),
                            tags: [
                              _tag(receitas[index].titulo, () {}),
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

Widget _content({Color? color}) {
  return Text(
    '',
    style: TextStyle(color: Colors.black),
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

class EntradaCheckBox extends StatefulWidget {
  _EntradaCheckBoxState st = new _EntradaCheckBoxState();

  @override
  _EntradaCheckBoxState createState() {
    return st;
  }
}

bool? salgado = false;
bool? doce = false;
bool? cafeDaManha = false;
bool? almoco = false;
bool? jantar = false;
List<String> ingredientes = [];
List<DynamicWidget> listDynamic = [];

class _EntradaCheckBoxState extends State<EntradaCheckBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 17),
      child: Column(
        children: <Widget>[
          CheckboxListTile(
              title: Text("Savory"),
              value: salgado,
              onChanged: (bool? valor) {
                setState(() {
                  salgado = valor;
                });
              }),
          CheckboxListTile(
              title: Text("Sweet"),
              value: doce,
              onChanged: (bool? valor) {
                setState(() {
                  doce = valor;
                });
              }),
          CheckboxListTile(
              title: Text("Breakfast"),
              value: cafeDaManha,
              onChanged: (bool? valor) {
                setState(() {
                  cafeDaManha = valor;
                });
              }),
          CheckboxListTile(
              title: Text("Lunch"),
              value: almoco,
              onChanged: (bool? valor) {
                setState(() {
                  almoco = valor;
                });
              }),
          CheckboxListTile(
            title: Text("Dinner"),
            value: jantar,
            onChanged: (bool? valor) {
              setState(() {
                jantar = valor;
              });
            },
          ),
        ],
      ),
    );
  }
}

class ShowAbout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 32, top: 30, right: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Resquitem",
                  style: GoogleFonts.comfortaa(
                    textStyle: TextStyle(
                        letterSpacing: .5,
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(250, 8, 110, 167)),
                  ),
                ),
              ],
            ),
          ),
          Container(
              padding: EdgeInsets.only(left: 32, top: 15, right: 32),
              child: Column(children: [
                Text(
                    "This application was created in order to make it easier to choose recipes with the ingredients that are in your house.",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 23,
                      letterSpacing: 0.5,
                      color: Colors.black,
                    ))
              ])),
          Container(
            padding: EdgeInsets.only(left: 32, top: 35, bottom: 10, right: 32),
            child: Row(children: [
              Text(
                "Functionalities:",
                textAlign: TextAlign.left,
                style: TextStyle(
                    letterSpacing: .5,
                    fontSize: 23,
                    color: Color.fromARGB(250, 0, 0, 0)),
              ),
            ]),
          ),
          Container(
              margin: EdgeInsets.only(left: 25, right: 32),
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                IconButton(
                    icon: Icon(Icons.search, size: 30, color: Colors.blue),
                    onPressed: () {}),
                Text("Search recipes by name",
                    style: TextStyle(
                        letterSpacing: .5, fontSize: 20, color: Colors.black)),
              ])),
          Container(
              margin: EdgeInsets.only(left: 25, right: 32),
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                IconButton(
                    icon: Icon(Icons.search, size: 30, color: Colors.blue),
                    onPressed: () {}),
                Text("Search recipes by filters",
                    style: TextStyle(
                        letterSpacing: .5, fontSize: 20, color: Colors.black)),
              ])),
          Container(
              margin: EdgeInsets.only(left: 25, right: 32),
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                IconButton(
                    icon: Icon(Icons.search, size: 30, color: Colors.blue),
                    onPressed: () {}),
                Text("Search recipes by ingredients",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        letterSpacing: .5, fontSize: 20, color: Colors.black)),
              ])),
          Container(
              margin: EdgeInsets.only(left: 25, right: 32),
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                IconButton(
                    icon:
                        Icon(Icons.mode_comment, size: 30, color: Colors.grey),
                    onPressed: () {}),
                Text("Comment recipes with tips",
                    style: TextStyle(
                        letterSpacing: .5, fontSize: 20, color: Colors.black)),
              ])),
          Container(
              margin: EdgeInsets.only(left: 25, right: 32),
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                IconButton(
                    icon: Icon(Icons.favorite, size: 30, color: Colors.red),
                    onPressed: () {}),
                Text("Discover new recipes",
                    style: TextStyle(
                        letterSpacing: .5, fontSize: 20, color: Colors.black)),
              ])),
          Container(
            padding: EdgeInsets.only(left: 32, top: 30, bottom: 10, right: 32),
            child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Text(
                "Creators:",
                textAlign: TextAlign.center,
                style: TextStyle(
                    letterSpacing: .5,
                    fontSize: 23,
                    color: Color.fromARGB(250, 0, 0, 0)),
              ),
            ]),
          ),
          Container(
            padding: EdgeInsets.only(left: 32, bottom: 10, right: 32),
            child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Text(
                "Cecília Capurucho",
                textAlign: TextAlign.left,
                style: TextStyle(
                    letterSpacing: .5,
                    fontSize: 23,
                    color: Color.fromARGB(250, 0, 0, 0)),
              ),
            ]),
          ),
          Container(
            padding: EdgeInsets.only(left: 32, bottom: 10, right: 32),
            child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Text(
                "Danielle Dias",
                textAlign: TextAlign.left,
                style: TextStyle(
                    letterSpacing: .5,
                    fontSize: 23,
                    color: Color.fromARGB(250, 0, 0, 0)),
              ),
            ]),
          ),
          Container(
            padding: EdgeInsets.only(left: 32, bottom: 10, right: 32),
            child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Text(
                "João Augusto",
                textAlign: TextAlign.left,
                style: TextStyle(
                    letterSpacing: .5,
                    fontSize: 23,
                    color: Color.fromARGB(250, 0, 0, 0)),
              ),
            ]),
          ),
          Container(
            padding: EdgeInsets.only(left: 32, bottom: 30, right: 32),
            child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Text(
                "Thiago de Campos",
                textAlign: TextAlign.left,
                style: TextStyle(
                    letterSpacing: .5,
                    fontSize: 23,
                    color: Color.fromARGB(250, 0, 0, 0)),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}

class showSearch extends StatelessWidget {
  TextEditingController _textEditingController =
      TextEditingController(); //instanciar o objeto para controlar o campo de texto

  EntradaCheckBox entrada = new EntradaCheckBox();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 30),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Search recipes",
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
                margin: EdgeInsets.only(left: 32, top: 30),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Text("Filter:",
                      textAlign: TextAlign.left,
                      style: GoogleFonts.roboto(
                          textStyle: TextStyle(
                              letterSpacing: .5,
                              fontSize: 25,
                              color: Color.fromARGB(250, 0, 0, 0))))
                ])),
            Padding(
              padding:
                  EdgeInsets.only(left: 32, top: 25, right: 32, bottom: 32),
              child: TextField(
                controller: _textEditingController,
                //controlador do nosso campo de texto
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                decoration:
                    InputDecoration(hintText: "Search by recipe name: "),
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
                onSubmitted: null,
              ),
            ),
            Container(
              child: Column(
                children: [
                  Container(
                      child: Column(
                    children: [
                      entrada,
                    ],
                  )),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(right: 25, top: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    child: Text("Filter",
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
                      if (salgado == true ||
                          doce == true ||
                          cafeDaManha == true ||
                          almoco == true ||
                          jantar == true ||
                          _textEditingController.text != "")
                        {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ResultadosBusca(
                                      valor: _textEditingController.text,
                                      salgado: salgado,
                                      doce: doce,
                                      cafeDaManha: cafeDaManha,
                                      almoco: almoco,
                                      jantar: jantar,
                                      ingredientes: [""],
                                    )),
                          ),
                        },
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
}

class ShowList extends StatefulWidget {
  @override
  _ShowList createState() => _ShowList();
}

class _ShowList extends State<ShowList> {
  initState() {
    limparList();
  }

  TextEditingController _textEditingController =
      TextEditingController(); //instanciar o objeto para controlar o campo de texto

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 32, top: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Search recipes",
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
              margin: EdgeInsets.only(left: 32, top: 30),
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Text("Ingredients:",
                    textAlign: TextAlign.left,
                    style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                            letterSpacing: .5,
                            fontSize: 25,
                            color: Color.fromARGB(250, 0, 0, 0))))
              ])),
          Padding(
            padding: EdgeInsets.only(left: 32, top: 25, right: 32, bottom: 10),
            child: TextField(
              controller: _textEditingController,
              //controlador do nosso campo de texto
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              decoration:
                  InputDecoration(hintText: "Enter the ingredient name: "),
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
              onSubmitted: null,
            ),
          ),
          Container(
              margin: EdgeInsets.only(right: 32),
              child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                IconButton(
                    icon: Icon(Icons.add_circle, size: 40, color: Colors.blue),
                    onPressed: () {
                      if (_textEditingController.text != "") {
                        ingredientes.add(_textEditingController.text);
                        addDynamic();
                      }
                      print(ingredientes);
                    }),
              ])),
          Container(
            child: Expanded(
              child: Column(
                children: [
                  Flexible(
                    child: ListView.builder(
                        itemCount: listDynamic.length,
                        itemBuilder: (_, index) => listDynamic[index]),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: 25, top: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  child: Text("Filter",
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
                    if (ingredientes.length > 0)
                      {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ResultadosBusca(
                                    valor: "",
                                    salgado: false,
                                    doce: false,
                                    cafeDaManha: false,
                                    almoco: false,
                                    jantar: false,
                                    ingredientes: ingredientes,
                                  )),
                        ),
                      },
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  addDynamic() {
    setState(() {
      listDynamic.add(
          new DynamicWidget(removeElement, index: ingredientes.length - 1));
    });
  }

  removeElement(element) {
    print(element.index);
    setState(() {
      ingredientes.removeAt(element.index);
      listDynamic.remove(element);
      updateElements(element.index);
    });
  }

  updateElements(pos) {
    for (int i = pos; i < listDynamic.length; i++) {
      listDynamic[i].index--;
    }
  }

  limparList() {
    ingredientes.clear();
    listDynamic.clear();
  }
}

class DynamicWidget extends StatelessWidget {
  int index;
  final Function(DynamicWidget) removeElement;

  DynamicWidget(this.removeElement, {Key? key, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 17),
      child: Row(
        children: [
          IconButton(
              icon: Icon(Icons.close_rounded, size: 25, color: Colors.red),
              onPressed: () {
                removeElement(this);
              }),
          Text(
            "${ingredientes[index]}",
            style: TextStyle(
              color: Colors.black,
              fontSize: 19.0,
            ),
          ),
        ],
      ),
    );
  }
}
