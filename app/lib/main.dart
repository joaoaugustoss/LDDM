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
    home:porra(),
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
  /*Widget build(BuildContext context) {

    return AnimatedSplashScreen(
          splash: 'assets/images/comida3.jpg',
          splashIconSize: (MediaQuery.of(context).size.height),
          nextScreen: const MyApp(),
          //splashTransition: SplashTransition.rotationTransition,
          //pageTransitionType: PageTransitionType.scale,
    );
  }*/




}

class teste extends StatelessWidget {
  const teste ({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
        child: SizedBox.expand(

        )
      ),
    );
  }

}



class porra extends StatelessWidget {
  const porra({super.key});
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        color:Colors.white,
        //duration: const Duration(seconds: 5),
        body: Container(
          child: SizedBox.expand(
            child: Image.asset("assets/images/comida3.jpg", fit: BoxFit.cover),


          ),
          child: (
            children: <Widget>[
              ElevatedButton(
                child: Text("Entrar"),
                onPressed: () {
                  Navigator.pushNamed(context, "/segunda");
                }
              ),
            ],
          )
          //onEnd: _foo(),
        ),
    );
  }

  /*_foo(){
    const MyApp();
  }*/

}