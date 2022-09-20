/*import 'package:flutter/material.dart';
import 'LoggedOut.dart';

void main() {
  runApp(MyApp(
    home:LoggedOut(),
    mainMenu:Home(), // MENU > BUCAR RECEITA >

  ));
}
// https://www.figma.com/file/kOWQ66hKUXHCjsMDZ5WPXZ/Sprint-1---LDDM
class MyApp extends StatelessWidget {

}*/

import 'package:flutter/material.dart';
import 'package:navigation_drawer_menu/navigation_drawer.dart';
import 'package:navigation_drawer_menu/navigation_drawer_menu.dart';
import 'package:navigation_drawer_menu/navigation_drawer_menu_frame.dart';
import 'package:navigation_drawer_menu/navigation_drawer_state.dart';

const likedValueKey = ValueKey('Alarm');
const ingredientsValueKey = ValueKey('Todo');
const listsValueKey = ValueKey('Photo');

final Map<Key, MenuItemContent> menuItems = {
  likedValueKey: MenuItemContent(
      menuItem: MenuItemDefinition("Liked", likedValueKey,
          iconData: Icons.favorite)),
  ingredientsValueKey: MenuItemContent(
      menuItem: MenuItemDefinition("Ingredients", ingredientsValueKey,
          iconData: Icons.shopping_basket)),
  listsValueKey: MenuItemContent(
      menuItem: MenuItemDefinition("Lists", listsValueKey,
          iconData: Icons.rule))
};

const title = 'Resquitem';
const menuColor = Color(0xFF424242);

final theme = ThemeData(
    brightness: Brightness.dark,
    textTheme: const TextTheme(bodyText2: TextStyle(color: Color(0xFFFFFFFF))),
    primaryColor: Colors.white,
    backgroundColor: Colors.black);

void main() {
  runApp(const MyApp());
}

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
                      // TODO abrir telinha pra pesquisa dos filtros
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
                            ? const Text('Not selected')
                            : Icon(menuItems[state.selectedMenuKey]!
                            .menuItem!
                            .iconData))),
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