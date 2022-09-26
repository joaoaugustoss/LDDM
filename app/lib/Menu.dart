import 'package:flutter/material.dart';
import 'package:navigation_drawer_menu/navigation_drawer.dart';
import 'package:navigation_drawer_menu/navigation_drawer_menu.dart';
import 'package:navigation_drawer_menu/navigation_drawer_menu_frame.dart';
import 'package:navigation_drawer_menu/navigation_drawer_state.dart';

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

final theme = ThemeData(
    brightness: Brightness.light,
    textTheme: const TextTheme(bodyText2: TextStyle(color: Colors.black54)),
    primaryColor: Colors.white,
    backgroundColor: menuColor);

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
      theme: theme,
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
                ]))
      ]);


}
class ShowNull extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(child: Text(""));
  }
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

        child: Text(""),
    );
  }
}
class ShowList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(child: Text("List"));
  }
}