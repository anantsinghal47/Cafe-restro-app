import 'dart:async';

import 'package:cafe91asm/UI/Registration.dart';
import 'package:cafe91asm/UI/menu.dart';
import 'package:cafe91asm/provider/cart.dart';
import 'package:cafe91asm/provider/orders.dart';
import 'package:cafe91asm/provider/product_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'DB/sharedPreferences.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool userIsLoggedIn = false;
  String id = "";

  @override
  void initState() {
    getLoggedInState();
    super.initState();
  }
  getLoggedInState() async{
    await HelperFunctions.getUserLoggedInSharedPreference().then((val){
      setState(() {
        userIsLoggedIn = val ?? false;
        print(userIsLoggedIn);

      });
    });
    await HelperFunctions.getUserEmailSharedPreference().then((val){
      setState(() {
        id = val ;
        print(id);

      });
    });

  }
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Products(),
        ),
        ChangeNotifierProvider(
          create: (context) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (context) => Orders() ,
        ),
      ],
      child: MaterialApp(

        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.red[300],
          fontFamily: "Nonito",
          backgroundColor: Colors.white,

        ),
        home: MyHomePage(id , userIsLoggedIn),
        routes: {
         MenuScreen.routeName : (context) => MenuScreen(id , 0),
        },
      ),


    );
  }
}

class MyHomePage extends StatefulWidget {
  final String id;
  final bool userIsLoggedIn;
  MyHomePage(this.id , this.userIsLoggedIn);
  @override
  SplashScreenState createState() => SplashScreenState();
}
class SplashScreenState extends State<MyHomePage> {

  @override
  void initState() {
    super.initState();

    Timer(
        Duration(milliseconds: 1500),
            () =>
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder:
                    (context) => widget.userIsLoggedIn ?    MenuScreen(widget.id , 0): Register()
                )
            )
    );
  }
  @override
  Widget build(BuildContext context) {

    return  Stack(
      children: [
        backgroudImage(),
        Positioned(
          top: MediaQuery.of(context).size.height/1.4,
          bottom: MediaQuery.of(context).size.height/5,
          right: MediaQuery.of(context).size.width/8,
          left: MediaQuery.of(context).size.width/2.2,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SafeArea(
              child: Column(
                children: [
                  CircularProgressIndicator(
                    backgroundColor: Colors.orange,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),)
                ],
              ),
            ),
          ),
        )

      ],
    );
  }
}

Widget backgroudImage() {
  return Container(
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/images/splash.jpeg'), /// change this to your  image directory
        fit: BoxFit.cover,
        //colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken),
      ),
    ),
  );
}