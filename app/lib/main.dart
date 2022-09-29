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
import 'package:page_transition/page_transition.dart';
import 'Menu.dart';
import 'ResultadoPesquisa.dart';
import 'package:navigation_drawer_menu/navigation_drawer.dart';
import 'package:navigation_drawer_menu/navigation_drawer_menu.dart';
import 'package:navigation_drawer_menu/navigation_drawer_menu_frame.dart';
import 'package:navigation_drawer_menu/navigation_drawer_state.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:google_fonts/google_fonts.dart';
//import '../home.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

void main(){
  runApp(MaterialApp(
    initialRoute: "/",
    routes: {
      "/segunda": (context) => MyApp(),
    },
    home: teste(),
  ));
}

class teste extends StatelessWidget {
  const teste({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget> [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: new AssetImage("assets/images/comida3.jpg"),
                  fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            //height: double.infinity,
            width: double.infinity,
            margin: EdgeInsets.only(top: 100),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget> [
                Text(
                  "Resquitem",
                  style:  GoogleFonts.comfortaa(
                    textStyle: TextStyle(letterSpacing: .5, fontSize: 50, fontWeight: FontWeight.bold,),
                  ),
                ),
                Text(
                  ""
                ),
                Text(
                  "Recipes with food from your fridge",
                  textAlign: TextAlign.center,
                  style:  GoogleFonts.comfortaa(
                    textStyle: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            )
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16),
              child: Column (
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget> [
                  ElevatedButton(
                    child: Text(
                      'Enter',
                      style: TextStyle(fontSize: 25),
                    ),
                    onPressed: () => {
                      Navigator.pushNamed(context, "/segunda"),
                    },
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(Size(150,60))
                    ),
                  )
                ],
              ),
          )
        ],
      )
    );


    /*
    return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => {
            Navigator.pushNamed(context, "/segunda")
          },
          child: Image.asset("assets/images/comida3.jpg", fit: BoxFit.cover),
        )
    );
    */

    /*return Scaffold(
    body: Container(



        child: Row(
          children: <Widget> [
            Expanded(
              child: SizedBox(
                child: Image.asset("assets/images/comida3.jpg", fit: BoxFit.cover),
              ),

            ),
            ElevatedButton (
                child: Text('Foo'),
                onPressed: () => {
                  Navigator.pushNamed(context, "/segunda")
                }
            ),
          ],

        ),


      ),
    );

     */
  }

}
