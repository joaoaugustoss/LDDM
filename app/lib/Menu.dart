import 'package:app/auth/secure.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:navigation_drawer_menu/navigation_drawer.dart';
import 'package:navigation_drawer_menu/navigation_drawer_menu.dart';
import 'package:navigation_drawer_menu/navigation_drawer_menu_frame.dart';
import 'package:navigation_drawer_menu/navigation_drawer_state.dart';
import 'package:image_card/image_card.dart';
import 'package:google_fonts/google_fonts.dart';
import 'ResultadoPesquisa.dart';
import 'Receita.dart';
import 'DadosConta.dart';
import 'Cadastro.dart';
import 'objetoReceita.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
//import '/auth/secure.dart';

const searchValueKey = ValueKey('Search');
const listsValueKey = ValueKey('Lists');
const loginValueKey = ValueKey('Login');
const sobreValueKey = ValueKey('Sobre');

final Map<Key, MenuItemContent> menuItems = {
  searchValueKey: MenuItemContent(
      menuItem: MenuItemDefinition("Search", searchValueKey,
          iconData: Icons.shopping_basket)),
  listsValueKey: MenuItemContent(
      menuItem:
          MenuItemDefinition("Lists", listsValueKey, iconData: Icons.rule)),
  loginValueKey: MenuItemContent(
      menuItem:
          MenuItemDefinition("Login", loginValueKey, iconData: Icons.login)),
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
int logado = -1;
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

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  void isLogado() async {
    logado = await _prefs.then((SharedPreferences prefs) {
      return prefs.getInt('isLogged') ?? -1;
    });

    print("Operação recuperar: $logado");
  }

  void initState() {
    super.initState();
    isLogado();
  }

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
                                        : state.selectedMenuKey == loginValueKey
                                            ? ShowLogin()
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
  int code = 200;
  List<Receitas> receitas = [];

  _recuperaReceita() async {
    var uri = Uri.parse(
        "https://api.spoonacular.com/recipes/random/?apiKey=${spoon_Key5}&instructionsRequired=true&number=5");
    http.Response response;
    response = await http.get(uri);
    code = response.statusCode;
    Map<String, dynamic> receita = new Map<String, dynamic>();
    Receitas receitinha;
    int size = json.decode(response.body)["recipes"].length; //list tags
    for (int i = 0; i < size; i++) {
      receita = json.decode(response.body)["recipes"][i];
      receitinha = Receitas(
          receita["id"],
          receita["title"],
          removeTags(receita["summary"]),
          receita["image"],
          receita["servings"],
          receita["aggregateLikes"],
          [],
          getIngredients(receita),
          removeTags(receita["instructions"]),
          receita["readyInMinutes"],
          receita["vegan"],
          receita["vegetarian"]);
      receitas.add(receitinha);
    }
  }

  String removeTags(String line) {
    String resp = "";
    int i = 0;
    while (i < line.length) {
      //enquanto i for menor que o tamanho da String linha
      if (line[i] == '<') {
        // é testado para verificar se o contador i ainda está dentro das tags
        i++;
        while (line[i] != '>')
          i++; //ao encontrar o sinal de fechamento das tags o laço de repetição é encerrado
      } else {
        //o que estiver fora das tags é concatenado a String resp a ser retornada
        resp += line[i];
      }
      i++;
    }
    return resp;
  }

  List<String> getIngredients(Map<String, dynamic> obj) {
    List<String> resp = [];

    for (int i = 0; i < obj["extendedIngredients"].length; i++) {
      resp.add(obj["extendedIngredients"][i]["original"]);
    }

    return resp;
  }

  FutureBuilder vasco(BuildContext context) {
    return FutureBuilder(
        future: _recuperaReceita(),
        builder: (context, AsyncSnapshot snapshot) {
          if (code != 200) {
            print("da colina");
            return Container(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 40),
                      child: Text(
                        "Could not find any recipe.",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    ElevatedButton(
                      child: Text(
                        'Back',
                        style: TextStyle(fontSize: 25),
                      ),
                      onPressed: () => {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => MyApp())),
                      },
                      style: ButtonStyle(
                          minimumSize:
                              MaterialStateProperty.all(Size(150, 60))),
                    )
                  ],
                ),
              ),
            );
          } else if (receitas.isEmpty) {
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
                                    imageProvider: NetworkImage(
                                        receitas[index].linkImagem),
                                    tags: [
                                      _tag(("${receitas[index].timeSpent} min"),
                                          () {}),
                                      _tag(
                                          (receitas[index].vegan == true
                                              ? "Vegan"
                                              : "Not Vegan"),
                                          () {}),
                                      _tag(
                                          (receitas[index].vegetarian == true
                                              ? "Vegetarian"
                                              : "Not Vegetarian"),
                                          () {}),
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

  @override
  Widget build(BuildContext context) {
    return vasco(context);
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

class ShowLogin extends StatefulWidget {
  @override
  _ShowLogin createState() => _ShowLogin();
}

class _ShowLogin extends State<ShowLogin>{


  @override
  Widget build(BuildContext context) {
      print("Logado: ${logado}");
      if (logado != -1 || logado == null) {
        return DadosConta(logado: logado);
      } else {
        return Cadastro();
      }
  }

  /*_recuperarDados() async {
    final prefs = await SharedPreferences.getInstance();
    logado = prefs.getInt("isLogged") ?? -1;
    print("Operação recuperar: $logado");
  }*/
}
