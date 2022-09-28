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
import 'package:navigation_drawer_menu/navigation_drawer.dart';
import 'package:navigation_drawer_menu/navigation_drawer_menu.dart';
import 'package:navigation_drawer_menu/navigation_drawer_menu_frame.dart';
import 'package:navigation_drawer_menu/navigation_drawer_state.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';
//import '../home.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

void main(){
  runApp(MaterialApp(
    initialRoute: "/",
    routes: {
      "/segunda": (context) => MyApp(),
    },
    //home:MyApp(),
    home: teste(),
  ));
}

class SplashPage extends StatefulWidget {
  SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      /*logo: Image.network(
          'https://cdn4.iconfinder.com/data/icons/logos-brands-5/24/flutter-512.png'),*/
      logo: Image.asset("assets/images/comida3.jpg"),
      title: const Text(
        "Resquitem",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colors.grey.shade400,
      showLoader: true,
      loadingText: const Text("Loading..."),
      navigator: const MyApp(),
      durationInSeconds: 5,
    );
  }



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
          Center(
            child: ElevatedButton (
                child: Text('Entrar'),
                onPressed: () => {
                  Navigator.pushNamed(context, "/segunda")
                }
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
