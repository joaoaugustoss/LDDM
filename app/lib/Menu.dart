import 'package:flutter/material.dart';
import 'package:navigation_drawer_menu/navigation_drawer.dart';
import 'package:navigation_drawer_menu/navigation_drawer_menu.dart';
import 'package:navigation_drawer_menu/navigation_drawer_menu_frame.dart';
import 'package:navigation_drawer_menu/navigation_drawer_state.dart';
import 'package:image_card/image_card.dart';


const likedValueKey = ValueKey('Liked');
const searchValueKey = ValueKey('Search');
const listsValueKey = ValueKey('Lists');

final Map<Key, MenuItemContent> menuItems = {
  likedValueKey: MenuItemContent(
      menuItem: MenuItemDefinition("Liked", likedValueKey,
          iconData: Icons.favorite)),
  searchValueKey: MenuItemContent(
      menuItem: MenuItemDefinition("Search", searchValueKey,
          iconData: Icons.shopping_basket)),
  listsValueKey: MenuItemContent(
      menuItem: MenuItemDefinition("Lists", listsValueKey,
          iconData: Icons.rule))
};

Map<int, Color> color = {
  50:Color.fromRGBO(4,131,184, .1),
  100:Color.fromRGBO(4,131,184, .2),
  200:Color.fromRGBO(4,131,184, .3),
  300:Color.fromRGBO(4,131,184, .4),
  400:Color.fromRGBO(4,131,184, .5),
  500:Color.fromRGBO(4,131,184, .6),
  600:Color.fromRGBO(4,131,184, .7),
  700:Color.fromRGBO(4,131,184, .8),
  800:Color.fromRGBO(4,131,184, .9),
  900:Color.fromRGBO(4,131,184, 1),
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
                            : state.selectedMenuKey == likedValueKey
                            ? ShowLiked()
                            : state.selectedMenuKey == searchValueKey
                            ? ShowSearch()
                            : state.selectedMenuKey == listsValueKey
                            ? ShowList()
                            : const Text('Not selected'))),
                menuBackgroundColor: menuColor,
                menuBuilder: Builder(builder: getMenu),
                menuMode: state.menuMode(context),
              ))));

  Widget getMenu(BuildContext context) =>
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
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
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column (
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            SingleChildScrollView (
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  FillImageCard(
                    width: 300,
                    heightImage: 140,
                    imageProvider: AssetImage('assets/images/comida3.jpg'),
                    tags: [_tag('Arroz', () {}), _tag('Comida bão', () {})],
                    title: _title(),
                    description: _content(),
                  ),
                  const SizedBox(width: 20),
                  FillImageCard(
                    width: 300,
                    heightImage: 140,
                    imageProvider: AssetImage('assets/images/comida3.jpg'),
                    tags: [_tag('Arroz', () {}), _tag('Comida bão', () {})],
                    title: _title(),
                    description: _content(),
                  ),
                  const SizedBox(width: 12),
                  FillImageCard(
                    width: 300,
                    heightImage: 140,
                    imageProvider: AssetImage('assets/images/comida3.jpg'),
                    tags: [_tag('Arroz', () {}), _tag('Comida bão', () {})],
                    title: _title(),
                    description: _content(),
                  ),
                  const SizedBox(width: 12),
                  FillImageCard(
                    width: 300,
                    heightImage: 140,
                    imageProvider: AssetImage('assets/images/comida3.jpg'),
                    tags: [_tag('Arroz', () {}), _tag('Comida bão', () {})],
                    title: _title(),
                    description: _content(),
                  ),
                  const SizedBox(width: 12),
                  FillImageCard(
                    width: 300,
                    heightImage: 140,
                    imageProvider: AssetImage('assets/images/comida3.jpg'),
                    tags: [_tag('Arroz', () {}), _tag('Comida bão', () {})],
                    title: _title(),
                    description: _content(),
                  ),
                  const SizedBox(width: 12),
                  FillImageCard(
                    width: 300,
                    heightImage: 140,
                    imageProvider: AssetImage('assets/images/comida3.jpg'),
                    tags: [_tag('Arroz', () {}), _tag('Comida bão', () {})],
                    title: _title(),
                    description: _content(),
                  ),

                ]
              )
            ),
          ]
        )
      ),
    );
  }
}



Widget _title({Color? color}) {
  return Text(
    'Arroz',
    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: color),
  );
}

Widget _content({Color? color}) {
  return Text(
    'Arroz bão',
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


class ShowLiked extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(child: Text("Liked"));
  }
}
class ShowSearch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(

        child: Row(
          children: <Widget>[
            Text("Receita1"),
            Text("Receita2"),
            Text("Receita3"),
          ]
        ),
    );
  }
}
class ShowList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(child: Text("List"));
  }
}